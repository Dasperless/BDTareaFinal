USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarDebitoSancion] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdSansionXCarrera INT
	,@OutIdInsertarDebitoSancion INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].SancionXCarrera
			WHERE id = @inIdSansionXCarrera
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe Sancion

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransDebitoSancion

		INSERT INTO dbo.DebitoSancion (IdSansionXCarrera)
		VALUES (@inIdSansionXCarrera)

		SET @OutIdInsertarDebitoSancion = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransDebitoSancion;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransDebitoSancion;

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