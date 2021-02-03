USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarMovPtsRegularidad] --Nombre del procedimiento
	--Variables de entrada del SP
	@inPuntosReg INT 
	,@inIdIGXEQXCorredor INT
	,@inIdLlegada INT
	,@inIdTipoMovPuntosRegular INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsRegular INT OUTPUT
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
			FROM [dbo].Llegada
			WHERE id = @inIdLlegada
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].TipoMovPuntosRegular
			WHERE id = @inIdTipoMovPuntosRegular
			)
	BEGIN
		SET @OutResultCode = 5017 --No existe una llegada con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsRegular

		INSERT INTO dbo.MovimientoPuntosRegularidad (
			IdIGXEQXCorredor
			,IdLlegada
			,IdTipoMovPuntosRegular
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdLlegada
			,@inIdTipoMovPuntosRegular
			,@inCantidadPuntos
			,@inFecha
			)
		IF (@inIdTipoMovPuntosRegular = 1)
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosReg = SumaPuntosReg + @inPuntosReg
			WHERE id = @inIdIGXEQXCorredor
		END;
		ELSE
		BEGIN
			UPDATE IGXEQXCorredor
			SET SumaPuntosReg = SumaPuntosReg - @inPuntosReg
			WHERE id = @inIdIGXEQXCorredor
		END;
		SET @OutIdInsertMovPtsRegular = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsRegular;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsRegular;

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