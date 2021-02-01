USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarCarrera] --Nombre del procedimiento
	@inIdEtapa INT
	,--Variables de entrada del SP
	@inFecha DATE
	,@inHoraInicio TIME
	,@OutIdInsertarCarrera INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Etapas
			WHERE id = @inIdEtapa
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe una etapa con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertarCarrera

		INSERT INTO dbo.Carrera (
			IdEtapa
			,Fecha
			,HoraInicio
			)
		VALUES (
			@inIdEtapa
			,@inFecha
			,@inHoraInicio
			)

		SET @OutIdInsertarCarrera = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertarCarrera;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertarCarrera;

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