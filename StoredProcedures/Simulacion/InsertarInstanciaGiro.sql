USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarInstanciaGiro] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdGiro INT
	,@inCodigoInstancia	VARCHAR(50)
	,@inAño INT
	,@inFechaInicio DATE
	,@inFechaFin DATE
	,@OutIdInsertarInstanciaGiro INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Giro
			WHERE id = @inIdGiro
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un giro con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertInstGiro

		INSERT INTO dbo.InstanciaGiro (
			IdGiro
			,CodigoInstancia
			,Año
			,FechaInicio
			,FechaFinal
			)
		VALUES (
			@inIdGiro
			,@inCodigoInstancia
			,@inAño
			,@inFechaInicio
			,@inFechaFin
			)

		SET @OutIdInsertarInstanciaGiro = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertInstGiro;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertInstGiro;

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