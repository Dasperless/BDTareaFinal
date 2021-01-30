USE [ProyectoFinalBD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[InsertarJuez]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Juez]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del Pa�s ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovJuez

		INSERT INTO [dbo].[Juez] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovJuez; --Finaliza la transacci�n
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovJuez;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;