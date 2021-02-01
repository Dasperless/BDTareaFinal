USE [ProyectoFinalBD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[ProcesarInstanciasGiro]
	@inXML XML,
	@InAñoInicio INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

--SE DECLARAN VARIABLES.

	DECLARE @lo INT, @hi INT

	DECLARE @IdGiro INT,
			@CodigoInstancia VARCHAR(100),
			@FechaInicio DATE,
			@FechaFin DATE

	DECLARE @TablaGiroXEquipo TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		Equipo INT
	) 
	DECLARE @CodigoInstanciaGiro VARCHAR(100),
			@Equipo INT

	DECLARE @TablaCorredoresEnEquipoEnGiro  TABLE (
			Sec INT IDENTITY(1, 1),
			CodigoInstanciaGiro VARCHAR(100),
			Equipo INT,
			Corredor INT,
			NumeroCamisa INT
		) 
	DECLARE @Corredor INT,
			@NumeroCamisa INT

	DECLARE @TablaCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		CodigoCarrera VARCHAR(100),
		IdEtapa INT,
		FechaCarrera DATE,
		HoraInicio TIME
	) 
	DECLARE @CodigoCarrera VARCHAR(100),
			@IdEtapa INT,
			@FechaCarrera DATE,
			@HoraInicio INT

	DECLARE @TablaFinalCorredoresEnCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoCarrera VARCHAR(100),
		NumeroCamisa INT,
		HoraLlegada TIME
	) 
	DECLARE @HoraLlegada TIME

	DECLARE @TablaSancionCarrera TABLE (
		Sec INT IDENTITY(1,1),
		CodigoCarrera VARCHAR(100),
		IdJuez INT,
		NumeroCamisa INT,
		MinutosCastigo INT,
		Descripcion VARCHAR(100)
	)
	DECLARE @IdJuez INT,
			@MinutosCastigo INT,
			@Descripcion VARCHAR(100)

--SE LE ASIGNAN VALORES A LAS TABLAS Y LAS VARIABLES.

	SELECT	@IdGiro = ref.value('@IdGiro', 'INT'),
			@CodigoInstancia = ref.value('@CodigoInstancia', 'VARCHAR(100)'),
			@FechaInicio = ref.value('@FechaInicio', 'DATE'),
			@FechaFin = ref.value('@FechaFin', 'DATE')
	FROM @InXML.nodes('InstanciaGiro') AS InstanciaGiro(ref)

	INSERT INTO @TablaGiroXEquipo (
		CodigoInstanciaGiro,
		Equipo
		)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@Equipo', 'INT')
	FROM @InXML.nodes('InstanciaGiro/GiroXEquipo') AS GIXEQ(ref)

	INSERT INTO @TablaCorredoresEnEquipoEnGiro (
		CodigoInstanciaGiro,
		Equipo,
		Corredor,
		NumeroCamisa
		)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@Equipo', 'INT'),
		ref.value('@Corredor', 'INT'),
		ref.value('@NumeroCamisa', 'INT')
	FROM @InXML.nodes('InstanciaGiro/CorredoresEnEquipoEnGiro ') AS CorredoreEqXGiro(ref)

	INSERT INTO @TablaCarrera(
		CodigoInstanciaGiro ,
		CodigoCarrera,
		IdEtapa,
		FechaCarrera,
		HoraInicio
	)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@CodigoCarrera', 'VARCHAR(100)'),
		ref.value('@IdEtapa', 'INT'),
		ref.value('@FechaCarrera', 'DATE'),
		ref.value('@HoraInicio', 'TIME')
	FROM @InXML.nodes('InstanciaGiro/Carrera') AS Carrera(ref)

	INSERT INTO @TablaFinalCorredoresEnCarrera(
		CodigoCarrera,
		NumeroCamisa,
		HoraLlegada 
	)
	SELECT ref.value('@CodigoCarrera', 'INT'),
		ref.value('@NumeroCamisa', 'INT'),
		ref.value('@HoraLlegada', 'TIME')
	FROM @InXML.nodes('InstanciaGiro/FinalCorredoresEnCarrera ') AS F(ref)

	INSERT INTO @TablaSancionCarrera(
		CodigoCarrera,
		IdJuez,
		NumeroCamisa,
		MinutosCastigo,
		Descripcion
	)
	SELECT ref.value('@CodigoCarrera', 'INT'),
		ref.value('@IdJuez', 'INT'),
		ref.value('@NumeroCamisa', 'INT'),
		ref.value('@MinutosCastigo', 'INT'),
		ref.value('@Descripcion', 'VARCHAR(100)')
	FROM @InXML.nodes('InstanciaGiro/FinalCorredoresEnCarrera ') AS SancionCarrera(ref)
	
	EXEC [dbo].[InsertarInstanciasGiros] -- SE INSERTAN LAS INSTANCIAS DE GIROS.
		@idGiro,
		@CodigoInstancia,
		@FechaInicio,
		@FechaFin,
		@OutResultCode

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE GIROS X EQUIPOS
		@lo = MIN(Sec)
	FROM @TablaGiroXEquipo 
	WHILE @lo <= @hi --SE INSERTAN LOS GIROS X EQUIPOS
		BEGIN 
			SELECT @CodigoInstanciaGiro = CodigoInstanciaGiro,
				@Equipo = Equipo	
			FROM @TablaGiroXEquipo 
			WHERE Sec = @lo

			EXEC [dbo].[InsertarGiroXEquipo]
				@CodigoInstanciaGiro,
				@Equipo, 
				@OutResultCode

			SET @lo = @lo + 1
		END;

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaCorredoresEnEquipoEnGiro
			@lo = MIN(Sec)
	FROM @TablaCorredoresEnEquipoEnGiro
	WHILE @lo <= @hi --SE INSERTAN LOS CORREDORES EN EQUIPO EN GIRO
		BEGIN 
			SELECT @CodigoInstanciaGiro = CodigoInstanciaGiro,
				@Equipo = Equipo,
				@Corredor = Corredor,
				@NumeroCamisa = NumeroCamisa
			FROM @TablaCorredoresEnEquipoEnGiro
			WHERE Sec = @lo

			EXEC [dbo].[InsertarCorredoresEnEquipoEnGiro]
				@CodigoInstanciaGiro,
				@Equipo, 
				@Corredor,
				@NumeroCamisa,
				@OutResultCode 

			SET @lo = @lo + 1
		END;

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaCarrera
			@lo = MIN(Sec)
	FROM @TablaCarrera
	WHILE @lo <= @hi --SE INSERTA LAS CARRERAS
		BEGIN
			SELECT @CodigoInstanciaGiro = CodigoInstanciaGiro,
				@CodigoCarrera = CodigoCarrera,
				@IdEtapa = IdEtapa,
				@FechaCarrera = FechaCarrera,
				@HoraInicio = HoraInicio
			FROM @TablaCarrera
			WHERE Sec = @lo
			
			EXEC [dbo].[InsertarCarrera]
				@CodigoInstanciaGiro,
				@CodigoCarrera, 
				@IdEtapa,
				@FechaCarrera,
				@HoraInicio,
				@OutResultCode 
		END;

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaFinalCorredoresEnCarrera
			@lo = MIN(Sec)
	FROM @TablaFinalCorredoresEnCarrera
	WHILE @lo <= @hi --SE INSERTAN LA FINAL CORREDORES EN CARRERA.
		BEGIN
			SELECT @CodigoCarrera = CodigoCarrera,
				@NumeroCamisa = NumeroCamisa,
				@HoraLlegada = HoraLlegada
			FROM @TablaFinalCorredoresEnCarrera
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarFinalCorredoresEnCarrera]
				@CodigoCarrera,
				@NumeroCamisa, 
				@HoraLlegada,
				@OutResultCode 
		END

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaSancionCarrera
			@lo = MIN(Sec)
	FROM @TablaSancionCarrera
	WHILE @lo <= @hi --SE INSERTAN LA SANCION CARRERA
		BEGIN
			SELECT @CodigoCarrera = CodigoCarrera,
				@IdJuez = IdJuez,
				@NumeroCamisa = NumeroCamisa,
				@MinutosCastigo = MinutosCastigo,
				@Descripcion = Descripcion
			FROM @TablaSancionCarrera
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarSancionCarrera]
				@CodigoCarrera,
				@IdJuez, 
				@NumeroCamisa,
				@MinutosCastigo,
				@Descripcion,
				@OutResultCode 
		END

	SET NOCOUNT OFF
END;