USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarMovPtsMonta�a] --Nombre del procedimiento
	--Variables de entrada del SP
	@inPuntosMonta�a INT
	,@inIdIGXEQXCorredor INT
	,@inIdTipoMovPtosMonta�a INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsMonta�a INT OUTPUT
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
			FROM [dbo].TipoMovPtosMonta�a
			WHERE id = @inIdTipoMovPtosMonta�a
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsMonta�a

		INSERT INTO dbo.MovimientoPuntosMonta�a (
			IdIGXEQXCorredor
			,IdTipoMovPtosMonta�a
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdTipoMovPtosMonta�a
			,@inCantidadPuntos
			,@inFecha
			)

		IF (@inIdTipoMovPtosMonta�a = 1)
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosMonta�a = SumaPuntosMonta�a + @inPuntosMonta�a
			WHERE id = @inIdIGXEQXCorredor
		END;
		ELSE
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosMonta�a = SumaPuntosMonta�a - @inPuntosMonta�a
			WHERE id = @inIdIGXEQXCorredor
		END;

		SET @OutIdInsertMovPtsMonta�a = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsMonta�a;--Finaliza la transacci�n
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsMonta�a;

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