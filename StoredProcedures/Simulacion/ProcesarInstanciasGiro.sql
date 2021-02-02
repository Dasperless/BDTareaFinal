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
	DECLARE @OutId INT

	DECLARE @IdGiro INT,
			@CodigoInstancia VARCHAR(100),
			@FechaInicio DATE,
			@FechaFin DATE,
			@OutIdInstanciaGiro INT

	DECLARE @TablaGiroXEquipo TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		Equipo INT
	) 
	DECLARE @CodigoInstanciaGiro VARCHAR(100),
			@Equipo INT,
			@OutIdInsertarIGXEquipo INT

	DECLARE @TablaCorredoresEnEquipoEnGiro  TABLE (
			Sec INT IDENTITY(1, 1),
			CodigoInstanciaGiro VARCHAR(100),
			Equipo INT,
			Corredor INT,
			NumeroCamisa INT
		) 
	DECLARE @Corredor INT,
			@NumeroCamisa INT,
			@IdIGXEQ INT,
			@OutIdInsertarIGXEQXCorredor INT

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
			@HoraInicio TIME

	DECLARE @TablaFinalCorredoresEnCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoCarrera VARCHAR(100),
		NumeroCamisa INT,
		HoraLlegada TIME
	) 
	DECLARE @HoraLlegada TIME,
			@IdCarrera INT,
			@IdCorredor INT

	DECLARE @TablaGanadorPremioMontanaEnCarrera  TABLE(
		Sec INT IDENTITY(1, 1),
		CodigoCarrera VARCHAR(100),
		NombrePremio VARCHAR(100),
		NumeroCamisa INT
	)

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
	SELECT ref.value('@CodigoCarrera', 'VARCHAR(100)'),
		ref.value('@NumeroCamisa', 'INT'),
		ref.value('@HoraLlegada', 'TIME')
	FROM @InXML.nodes('InstanciaGiro/FinalCorredoresEnCarrera') AS F(ref)

	INSERT INTO @TablaGanadorPremioMontanaEnCarrera(
		CodigoCarrera,
		NombrePremio,
		NumeroCamisa
	)
	SELECT ref.value('@CodigoCarrera', 'VARCHAR(100)'),
		ref.value('@NombrePremio', 'VARCHAR(100)'),
		ref.value('@NumeroCamisa', 'INT')
	FROM @InXML.nodes('InstanciaGiro/GanadorPremioMontanaEnCarrera ') AS GPremiosMont(ref)

	INSERT INTO @TablaSancionCarrera(
		CodigoCarrera,
		IdJuez,
		NumeroCamisa,
		MinutosCastigo,
		Descripcion
	)
	SELECT ref.value('@CodigoCarrera', 'VARCHAR(100)'),
		ref.value('@IdJuez', 'INT'),
		ref.value('@NumeroCamisa', 'INT'),
		ref.value('@MinutosCastigo', 'INT'),
		ref.value('@Descripcion', 'VARCHAR(100)')
	FROM @InXML.nodes('InstanciaGiro/SancionCarrera') AS SancionCarrera(ref)
	
	EXEC [dbo].[InsertarInstanciaGiro] -- SE INSERTAN LAS INSTANCIAS DE GIROS.
		@IdGiro, 
		@CodigoInstancia, 
		@InAñoInicio, 
		@FechaInicio,
		@FechaFin,
		@OutIdInstanciaGiro OUTPUT, 
		@OutResultCode OUTPUT

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE GIROS X EQUIPOS
		@lo = MIN(Sec)
	FROM @TablaGiroXEquipo 
	DECLARE @OutResultCodeIGXEQ INT
	WHILE @lo <= @hi --SE INSERTAN LOS GIROS X EQUIPOS
		BEGIN 
			SELECT @CodigoInstanciaGiro = CodigoInstanciaGiro,
				@Equipo = Equipo	
			FROM @TablaGiroXEquipo 
			WHERE Sec = @lo

			
			EXEC [dbo].[InsertarIGXEquipo]
				@Equipo,
				@OutIdInstanciaGiro,
				@CodigoInstanciaGiro,
				0,
				0,
				@OutIdInsertarIGXEquipo OUTPUT,
				@OutResultCodeIGXEQ OUTPUT

			SET @lo = @lo + 1
		END;

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaCorredoresEnEquipoEnGiro
			@lo = MIN(Sec)
	FROM @TablaCorredoresEnEquipoEnGiro
	WHILE @lo <= @hi --SE INSERTAN LOS CORREDORES EN EQUIPO EN GIRO
		BEGIN 
			SELECT @CodigoInstanciaGiro = T.CodigoInstanciaGiro,
				@Equipo = Equipo,
				@Corredor = Corredor,
				@NumeroCamisa = NumeroCamisa,
				@IdIGXEQ = IGXEQ.Id
			FROM @TablaCorredoresEnEquipoEnGiro T
			INNER JOIN InstGiroXEquipo IGXEQ
				ON IGXEQ.CodigoInstanciaGiro = @CodigoInstanciaGiro
			WHERE Sec = @lo

			EXEC [dbo].[InsertarIGXEQXCorredor]
				@IdIGXEQ,
				@Corredor,
				@CodigoInstanciaGiro,
				@NumeroCamisa,
				@Equipo,
				0,
				0,
				0,
				@OutIdInsertarIGXEQXCorredor OUTPUT,
				@OutResultCode OUTPUT

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
				@IdEtapa,
				@CodigoInstanciaGiro,
				@CodigoCarrera, 
				@FechaCarrera,
				@HoraInicio,
				@OutId OUTPUT,
				@OutResultCode OUTPUT

			SET @lo = @lo + 1 
		END;

	DECLARE @IdIGXEQXCorredor INT,
			@IdTipoMovimiento INT = 1, --PROVICIONAL
			@CantTiempo INT,		
			@Fecha DATE,
			@OutIdInsertarMovTiempo INT
	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaFinalCorredoresEnCarrera
			@lo = MIN(Sec)
	FROM @TablaFinalCorredoresEnCarrera
	WHILE @lo <= @hi --SE INSERTAN LA FINAL CORREDORES EN CARRERA.
		BEGIN
			SELECT @CodigoCarrera = T.CodigoCarrera,
				@NumeroCamisa = T.NumeroCamisa,
				@HoraLlegada = T.HoraLlegada,
				@IdCarrera = C.Id,
				@CantTiempo = DATEDIFF(HOUR, C.HoraInicio, T.HoraLlegada),
				@Fecha = C.Fecha,
				@IdCorredor = I.IdCorredor,
				@IdIGXEQXCorredor = I.Id
			FROM @TablaFinalCorredoresEnCarrera T
			JOIN Carrera C ON C.CodigoCarrera = T.CodigoCarrera
			JOIN IGXEQXCorredor  I ON I.NumeroCamisa = @NumeroCamisa
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarMovTiempo]
				@IdIGXEQXCorredor, 
				@IdTipoMovimiento, 
				@CantTiempo, 
				@Fecha, 
				@OutIdInsertarMovTiempo OUTPUT, 
				@OutResultCode OUTPUT

			EXEC [dbo].[InsertarLlegada]
				@IdCorredor, 
				@IdCarrera, 
				@OutIdInsertarMovTiempo,
				@CodigoCarrera,
				@NumeroCamisa,
				@HoraLlegada, 
				@OutId OUTPUT, 
				@OutResultCode OUTPUT

			SET @lo = @lo + 1
		END
	
	DECLARE @IdPremioMontaña INT
	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaGanadorPremioMontanaEnCarrera
			@lo = MIN(Sec)
	FROM @TablaFinalCorredoresEnCarrera
		WHILE @lo <= @hi --SE INSERTAN LOS GANADORES PREMIO MONTAÑA
		BEGIN
			SELECT @IdCarrera = C.Id,
				@IdCorredor = L.IdCorredor,
				@IdPremioMontaña = P.Id,
				@CodigoCarrera = T.CodigoCarrera,
				@NumeroCamisa = T.NumeroCamisa	
			FROM @TablaGanadorPremioMontanaEnCarrera T
			INNER JOIN Carrera C ON C.CodigoCarrera = T.CodigoCarrera
			INNER JOIN Llegada L ON L.NumeroCamisa = T.NumeroCamisa
			INNER JOIN PremiosMontaña P ON P.Nombre = T.NombrePremio
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarGanadorPremioMont]
				@IdCarrera,
				@IdCorredor,
				@IdPremioMontaña,
				@CodigoCarrera,
				@NumeroCamisa,
				@OutId,
				@OutResultCode
			SET @lo = @lo + 1 
			PRINT(@OutResultCode)
		END

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaSancionCarrera
			@lo = MIN(Sec)
	FROM @TablaSancionCarrera
	WHILE @lo <= @hi --SE INSERTAN LA SANCION CARRERA
		BEGIN
			SELECT @CodigoCarrera = T.CodigoCarrera,
				@IdJuez = T.IdJuez,
				@NumeroCamisa = T.NumeroCamisa,
				@MinutosCastigo = T.MinutosCastigo,
				@Descripcion = T.Descripcion,
				@IdCarrera = C.Id				
			FROM @TablaSancionCarrera T
			INNER JOIN Carrera C ON C.CodigoCarrera = @CodigoCarrera
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarSancionXCarrera]
				@IdCarrera,
				@IdCorredor, 
				@IdJuez,
				@CodigoCarrera, 
				@NumeroCamisa,
				@Descripcion,
				@MinutosCastigo,
				@OutID OUTPUT, 
				@OutResultCode OUTPUT
			SET @lo = @lo + 1 
		END

	SET NOCOUNT OFF
END;