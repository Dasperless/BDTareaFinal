USE [examen2] --Colocar Nombre de la Base de Datos 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[nombre] --Nombre del procedimiento
	@inId INT,   --Variables de entrada del SP
	@OutIdInsertaMovimiento INT OUTPUT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--Se declaran variables
	DECLARE 
			 @idTipoCambioEntidad INT   
	--Validaciones
	IF NOT EXISTS (
		SELECT 1
		FROM [dbo].TipoCambioEntidad
		WHERE id =
		)
		BEGIN
			SET @OutResultCode = 50017 --Codigo de retorno si la cuenta no existe.
			RETURN
		END;
	
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION Transaccion


		SET @OutId = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION Transaccion; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION Transaccion;

		INSERT INTO dbo.Errores    --Tabla de Errores
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