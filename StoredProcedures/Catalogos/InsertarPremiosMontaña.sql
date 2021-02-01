USE [ProyectoFinalBD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[InsertarPremiosMontaña]
	@InIdGiro INT,   
	@InIdEtapa VARCHAR(100),
	@InNombre VARCHAR(100),
	@InPuntos INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovPM

		INSERT INTO [dbo].[PremiosMontaña] (IdGiro, IdEtapa, Nombre, Puntos)
		VALUES (@InIdGiro,
				@InIdEtapa,
				@InNombre,
				@InPuntos
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovPM; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovPM;

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