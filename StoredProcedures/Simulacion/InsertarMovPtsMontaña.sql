USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarMovPtsMontaņa] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQXCorredor INT
	,@inIdTipoMovPtosMontaņa INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsMontaņa INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].IGXEQXCorredor
			WHERE id = @inIdIGXEQXCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].TipoMovPtosMontaņa
			WHERE id = @inIdTipoMovPtosMontaņa
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsMontaņa

		INSERT INTO dbo.MovimientoPuntosMontaņa (
			IdIGXEQXCorredor
			,IdTipoMovPtosMontaņa
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdTipoMovPtosMontaņa
			,@inCantidadPuntos
			,@inFecha
			)

		SET @OutIdInsertMovPtsMontaņa = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsMontaņa;--Finaliza la transacciķn
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsMontaņa;

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