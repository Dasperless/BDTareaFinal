USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarMovPtsMontaña] --Nombre del procedimiento
	--Variables de entrada del SP
	@inPuntosMontaña INT
	,@inIdIGXEQXCorredor INT
	,@inIdTipoMovPtosMontaña INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsMontaña INT OUTPUT
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
			FROM [dbo].TipoMovPtosMontaña
			WHERE id = @inIdTipoMovPtosMontaña
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsMontaña

		INSERT INTO dbo.MovimientoPuntosMontaña (
			IdIGXEQXCorredor
			,IdTipoMovPtosMontaña
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdTipoMovPtosMontaña
			,@inCantidadPuntos
			,@inFecha
			)

		IF (@inIdTipoMovPtosMontaña = 1)
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosMontaña = SumaPuntosMontaña + @inPuntosMontaña
			WHERE id = @inIdIGXEQXCorredor
		END;
		ELSE
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosMontaña = SumaPuntosMontaña - @inPuntosMontaña
			WHERE id = @inIdIGXEQXCorredor
		END;

		SET @OutIdInsertMovPtsMontaña = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsMontaña;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsMontaña;

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