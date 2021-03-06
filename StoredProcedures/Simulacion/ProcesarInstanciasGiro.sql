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
			@IdTipoMovimiento INT = 2, --CREDITO POR TIEMPO DURACION CARRERA
			@CantTiempo INT,	
			@Horas INT,
			@Minutos INT,
			@Segundos INT,
			@CantTiempoStr VARCHAR(100),
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
				@Fecha = C.Fecha,
				@CantTiempo = DATEDIFF(HOUR,@HoraInicio,  @HoraLlegada),
				@IdCorredor = I.IdCorredor,
				@IdIGXEQXCorredor = I.Id
			FROM @TablaFinalCorredoresEnCarrera T
			JOIN Carrera C ON C.CodigoCarrera = T.CodigoCarrera
			JOIN IGXEQXCorredor  I ON I.NumeroCamisa = T.NumeroCamisa
			WHERE Sec = @lo			
		
			--SET @Horas =  DATEDIFF(HOUR, DATEPART(HOUR, @HoraInicio), DATEPART(HOUR, @HoraLlegada))
			--SET @Minutos =  DATEDIFF(HOUR, DATEPART(MINUTE, @HoraInicio), DATEPART(MINUTE, @HoraLlegada))
			--SET @Segundos=  DATEDIFF(HOUR, DATEPART(SECOND, @HoraInicio), DATEPART(SECOND, @HoraLlegada))
			--SET @CantTiempoStr = CONCAT(@Horas,':',@Minutos,':',@Segundos) 
			--SET @CantTiempo = CONVERT (TIME,@CantTiempoStr) 

			EXEC [dbo].[InsertarLlegada]		--SE INSERTA LA LLEGADA.
				@IdCorredor, 
				@IdCarrera, 
				@OutIdInsertarMovTiempo,
				@CodigoCarrera,
				@NumeroCamisa,
				@HoraLlegada, 
				@OutId OUTPUT, 
				@OutResultCode OUTPUT

			EXEC [dbo].[InsertarMovTiempo]		--SE INSERTA EL MOVIMIENTO TIEMPO.
				@IdIGXEQXCorredor, 
				@IdTipoMovimiento, 
				@CantTiempo, 
				@Fecha, 
				@OutIdInsertarMovTiempo OUTPUT, 
				@OutResultCode OUTPUT
			SET @lo = @lo + 1
		END
	
	--SE PROCESAN LAS CARRERAS
	DECLARE @TablaGanadoresPuntos TABLE(Posicion INT,IdCorredor INT)
	DECLARE @IdTipoMovPuntosRegular INT = 1,  --Credito por Puntos Ganados en Carrera
			@IdLlegada INT,
			@CantidadPuntos INT,
			@PuntosEtapa INT,
			@Posicion INT
	SELECT @hi = MAX(Sec),
		@lo = MIN(Sec)
	FROM @TablaFinalCorredoresEnCarrera
	WHILE @lo <= @hi	--ITERO SOBRE LA TABLA FINAL CORREDORES EN CARRERA 
	BEGIN 
		SELECT @NumeroCamisa = T.NumeroCamisa,
			@Corredor = I.IdCorredor,
			@IdIGXEQXCorredor = I.Id,
			@IdLlegada = L.Id,
			@Fecha = C.Fecha,
			@CodigoCarrera = L.CodigoCarrera,
			@PuntosEtapa = E.Puntos
		FROM @TablaFinalCorredoresEnCarrera T
		INNER JOIN IGXEQXCorredor I
			ON I.NumeroCamisa = T.NumeroCamisa --OBTIENE EL ID DEL CORREDOR
		INNER JOIN Carrera C
			ON C.CodigoCarrera = T.CodigoCarrera --OBTIENE LA FECHA DE LA CARRERA
		INNER JOIN Llegada L
			ON L.IdCorredor = I.IdCorredor
				AND C.CodigoCarrera = T.CodigoCarrera --OBTIENE EL ID DE LLEGADA
		INNER JOIN Etapas E
			ON E.Id = C.IdEtapa --OBTIENE LOS PUNTOS DE LA ETAPA
		WHERE T.Sec = @lo
	
		INSERT INTO @TablaGanadoresPuntos (
			Posicion,
			IdCorredor
			)
		SELECT TOP (@PuntosEtapa) Row_Number() OVER (ORDER BY T.HoraLlegada ASC),
			I.IdCorredor
		FROM @TablaFinalCorredoresEnCarrera T
		INNER JOIN IGXEQXCorredor I
			ON I.NumeroCamisa = T.NumeroCamisa --OBTIENE EL ID DEL CORREDOR
		WHERE CodigoCarrera = @CodigoCarrera
		ORDER BY T.HoraLlegada ASC

		
		SET @Posicion = (SELECT TOP(1) T.Posicion FROM @TablaGanadoresPuntos T WHERE IdCorredor = @Corredor)
		IF(@Posicion IS NOT NULL)
			BEGIN 
				SET @CantidadPuntos  = @PuntosEtapa - @Posicion
			END
		ELSE
			BEGIN
				SET @CantidadPuntos = 0
			END
		EXEC [dbo].[InsertarMovPtsRegularidad]
			@IdIGXEQXCorredor,
			@IdLlegada,
			@IdTipoMovPuntosRegular,
			@CantidadPuntos,
			@Fecha,
			@OutId,
			@OutResultCode
			   		 
		SET @lo = @lo + 1
		DELETE @TablaGanadoresPuntos
	END;

	DECLARE @IdPremioMontaña INT,
			@IdTipoMovPtosMontaña INT = 1 --Credito por ganar premio.
	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaGanadorPremioMontanaEnCarrera
			@lo = MIN(Sec)
	FROM @TablaGanadorPremioMontanaEnCarrera
		WHILE @lo <= @hi --SE INSERTAN LOS GANADORES PREMIO MONTAÑA
		BEGIN
			SELECT @IdCarrera = C.Id,
				@IdCorredor = L.IdCorredor,
				@IdPremioMontaña = P.Id,
				@CodigoCarrera = T.CodigoCarrera,
				@NumeroCamisa = T.NumeroCamisa,
				@CantidadPuntos = P.Puntos,
				@Fecha = C.Fecha,
				@IdIGXEQXCorredor = I.Id
			FROM @TablaGanadorPremioMontanaEnCarrera T
			INNER JOIN Carrera C ON C.CodigoCarrera = T.CodigoCarrera
			INNER JOIN Llegada L ON L.NumeroCamisa = T.NumeroCamisa
			INNER JOIN PremiosMontaña P ON P.Nombre = T.NombrePremio
			INNER JOIN IGXEQXCorredor I ON I.NumeroCamisa = T.NumeroCamisa
			WHERE Sec = @lo		
			
			EXEC [dbo].[InsertarGanadorPremioMont]	--Se insertan los ganadores de premiso montaña
				@IdCarrera,
				@IdCorredor,
				@IdPremioMontaña,
				@CodigoCarrera,
				@NumeroCamisa,
				@OutId,
				@OutResultCode

			EXEC [dbo].[InsertarMovPtsMontaña]		--Se inserta el movimiento de puntos montaña.
				@IdIGXEQXCorredor, 
				@IdTipoMovPtosMontaña, 
				@CantidadPuntos, 
				@Fecha, 
				@OutId, 
				@OutResultCode
			SET @lo = @lo + 1 
		END

	SELECT @hi = MAX(Sec), --SE INICIALIZAN LOS CONTADORES DE @TablaSancionCarrera
			@lo = MIN(Sec)
	FROM @TablaSancionCarrera
	WHILE @lo <= @hi --SE INSERTAN LA SANCION CARRERA
		BEGIN
			SELECT @IdCarrera = C.Id,
				@IdCorredor = I.IdCorredor,
				@IdJuez = T.IdJuez,
				@CodigoCarrera = T.CodigoCarrera,
				@NumeroCamisa = T.NumeroCamisa,
				@Descripcion = T.Descripcion,
				@MinutosCastigo = T.MinutosCastigo,
				@IdIGXEQXCorredor = I.Id,
				@IdTipoMovimiento = 1,	--DEBITO POR SANCIÓN
				@Fecha = C.Fecha
			FROM @TablaSancionCarrera T
			INNER JOIN Carrera C ON C.CodigoCarrera = @CodigoCarrera
			INNER JOIN IGXEQXCorredor I ON I.NumeroCamisa = T.NumeroCamisa
			WHERE Sec = @lo		

			EXEC [dbo].[InsertarSancionXCarrera]	--SE INSERTAN LAS SANCIONES EN LA TABLA.
				@IdCarrera,
				@IdCorredor, 
				@IdJuez,
				@CodigoCarrera, 
				@NumeroCamisa,
				@Descripcion,
				@MinutosCastigo,
				@OutID OUTPUT, 
				@OutResultCode OUTPUT

			EXEC [dbo].[InsertarMovTiempo]			--SE HACE UN MOVIMIENTO TIEMPO DE TIPO DEBITO POR SANCIÓN.
				@IdIGXEQXCorredor, 
				@IdTipoMovimiento, 
				@MinutosCastigo, 
				@Fecha, 
				@OutIdInsertarMovTiempo OUTPUT, 
				@OutResultCode OUTPUT

			SET @lo = @lo + 1 
		END

	SET NOCOUNT OFF
END;