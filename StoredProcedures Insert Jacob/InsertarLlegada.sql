USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarLlegada] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCorredor INT
	,@inIdCarrera INT
	,@inHoraFin TIME
	,@OutIdInsertarLlegada INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un corredor con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Carrera
			WHERE id = @inIdCarrera
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una carrera con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertLlegada

		INSERT INTO dbo.Llegada (
			IdCorredor
			,IdCarrera
			,HoraFin
			)
		VALUES (
			@inIdCorredor
			,@inIdCarrera
			,@inHoraFin
			)

		SET @OutIdInsertarLlegada = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertLlegada;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertLlegada;

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