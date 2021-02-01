USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarIGXEQXCorredor] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQ INT
	,@inIdCorredor INT
	,@inSumaTiempo INT
	,@inSumaPuntosMes INT
	,@inSumaPuntosMontaña INT
	,@OutIdInsertarIGXEQXCorredor INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].InstGiroXEquipo
			WHERE id = @inIdIGXEQ
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe InstGiroXEquipo

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una Corredor con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransIGXEQXCorredor

		INSERT INTO dbo.IGXEQXCorredor (
			IdIGXEQ
			,IdCorredor
			,SumaTiempo
			,SumaPuntosMes
			,SumaPuntosMontaña
			)
		VALUES (
			@inIdIGXEQ
			,@inIdCorredor
			,@inSumaTiempo
			,@inSumaPuntosMes
			,@inSumaPuntosMontaña
			)

		SET @OutIdInsertarIGXEQXCorredor = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransIGXEQXCorredor;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransIGXEQXCorredor;

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