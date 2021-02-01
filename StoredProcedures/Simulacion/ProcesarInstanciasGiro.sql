USE [ProyectoFinalBD]
GO
/****** Object:  StoredProcedure [dbo].[ProcesarInstanciasGiro]    Script Date: 2/1/2021 8:33:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[ProcesarInstanciasGiro]
	@inXML XML,
	@InAñoInicio INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--SE DECLARAN VARIABLES.

	DECLARE @lo INT, @hi INT
	DECLARE @OutResult INT

	--Variables Instancia Giro
	DECLARE @IdGiro INT,
			@CodigoInstancia VARCHAR(100),
			@FechaInicio DATE,
			@FechaFin DATE

	--Tabla Giro X Equipo
	DECLARE @TablaGiroXEquipo TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		Equipo INT
	) 

	--Tabla Corredores en Equipo en Giro
	DECLARE @TablaCorredoresEnEquipoEnGiro  TABLE (
			Sec INT IDENTITY(1, 1),
			CodigoInstanciaGiro VARCHAR(100),
			Equipo INT,
			Corredor INT,
			NumeroCamisa INT
		) 

	--Tabla de Carreras
	DECLARE @TablaCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		CodigoCarrera VARCHAR(100),
		IdEtapa INT,
		FechaCarrera DATE,
		HoraInicio TIME
	) 

	DECLARE @TablaFinalCorredoresEnCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoCarrera VARCHAR(100),
		NumeroCamisa INT,
		HoraLlegada DATE
	) 

	DECLARE @TablaSancionCarrera TABLE (
		Sec INT IDENTITY(1,1),
		CodigoCarrera VARCHAR(100),
		IdJuez INT,
		NumeroCamisa INT,
		MinutosCastigo INT,
		Descripcion VARCHAR(100)
	)

	--SE LE ASIGNAN VALORES A LAS VARIABLES.

	SELECT	@IdGiro = ref.value('@IdGiro', 'INT'),
			@CodigoInstancia = ref.value('@CodigoInstancia', 'VARCHAR(100)'),
			@FechaInicio = ref.value('@FechaInicio', 'DATE'),
			@FechaFin = ref.value('@FechaFin', 'DATE')
	FROM @InXML.nodes('InstanciaGiro') AS InstanciaGiro(ref)

	--Se le asignan valores a la tabla Giro X Equipo
	INSERT INTO @TablaGiroXEquipo (
		CodigoInstanciaGiro,
		Equipo
		)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@Equipo', 'INT')
	FROM @InXML.nodes('InstanciaGiro/GiroXEquipo') AS GIXEQ(ref)

	--Se le asignan valores a la tabla Giro X Corredores X Equipo X Giro
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
	FROM  @InXML.nodes('InstanciaGiro/Carrera') AS CorredoreEqXGiro(ref)

	SELECT *
	FROM @TablaCarrera
	--BEGIN TRY
	--	--SE PROCESAN LAS INSTANCIAS DE GIRO
	--	SELECT @lo = MIN(TablaIG.Sec),
	--		@hi = MAX(TablaIG.Sec)
	--	FROM @TablaInstanciasGiro AS TablaIG

	--	WHILE @lo <= @hi
	--	BEGIN

	--		EXEC [dbo].[InsertarInstanciaGiro]
				
	--	END;
	--END TRY

	--BEGIN CATCH
	--	IF @@TRANCOUNT > 0
	--		ROLLBACK TRANSACTION ProcesarIG;

	--	INSERT INTO [dbo].[Errores]    --Tabla de Errores
	--	VALUES (
	--		SUSER_SNAME(),
	--		ERROR_NUMBER(),
	--		ERROR_STATE(),
	--		ERROR_SEVERITY(),
	--		ERROR_LINE(),
	--		ERROR_PROCEDURE(),
	--		ERROR_MESSAGE(),
	--		GETDATE()
	--		);

	--	SET @OutResultCode = 50005;
	--END CATCH

	SET NOCOUNT OFF
END;