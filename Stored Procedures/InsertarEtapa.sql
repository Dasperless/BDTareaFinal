USE [ProyectoFinalBD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[InsertarEtapa]
	@inId INT,   
	@InIdGiro INT,
	@inNombre VARCHAR(100),
	@InPuntos INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Etapas]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id de la etapa ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovEtapa

		INSERT INTO [dbo].[Etapas] (Id,IdGiro,Nombre,Puntos)
		VALUES (@inID,
				@InIdGiro,
				@inNombre,
				@InPuntos
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovEtapa; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovEtapa;

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