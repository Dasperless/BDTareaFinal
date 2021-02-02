USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarSancionXCarrera] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCarrera INT
	,@inIdCorredor INT
	,@inIdJuez INT
	,@inCodigoCarrera VARCHAR(50)
	,@inNumeroCamisa INT
	,@inDescripcion VARCHAR(100)
	,@inMinutosCastigo INT
	,@OutIdInsertarSancionXCarrera INT OUTPUT
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
		SET @OutResultCode = 5020 --No existe Carrera 

		RETURN
	END;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe Corredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Juez
			WHERE id = @inIdJuez
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un Juez con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransSancionXCarrera

		INSERT INTO dbo.SancionXCarrera(
			IdCarrera
			,IdCorredor
			,IdJuez
			,CodigoCarrera
			,NumeroCamisa
			,Descripcion
			,MinutosCastigo
			)
		VALUES (
			@inIdCarrera
			,@inIdCorredor
			,@inIdJuez
			,@inCodigoCarrera
			,@inNumeroCamisa
			,@inDescripcion
			,@inMinutosCastigo
			)

		SET @OutIdInsertarSancionXCarrera = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransSancionXCarrera;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransSancionXCarrera;

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