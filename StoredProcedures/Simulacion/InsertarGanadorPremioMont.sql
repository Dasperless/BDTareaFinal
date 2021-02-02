USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarGanadorPremioMont] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCarrera INT
	,@inIdCorredor INT
	,@inIdPremioMonta�a INT
	,@inCodigoCarrera VARCHAR(50)
	,@inNumeroCamisa INT 
	,@OutIdInsertarGanadorPremioMont INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Carrera
			WHERE id = @inIdCarrera
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].PremiosMonta�a
			WHERE id = @inIdPremioMonta�a
			)
	BEGIN
		SET @OutResultCode = 5017 --No existe un PremiosMonta�a con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransGanadorPremioMont

		INSERT INTO dbo.GanadorPremioMonta�a (
			IdCarrera
			,IdCorredor
			,IdPremioMonta�a
			,CodigoCarrera
			,NumeroCamisa
			)
		VALUES (
			@inIdCarrera
			,@inIdCorredor
			,@inIdPremioMonta�a
			,@inCodigoCarrera
			,@inNumeroCamisa
			)

		SET @OutIdInsertarGanadorPremioMont = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransGanadorPremioMont;--Finaliza la transacci�n
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransGanadorPremioMont;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;