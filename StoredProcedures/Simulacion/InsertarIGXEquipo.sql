USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE
	OR

ALTER PROCEDURE [dbo].[InsertarIGXEquipo] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdEquipo INT
	,@inIdInstanciaGiro INT
	,@inCodigoInstanciaGiro VARCHAR(50)
	,@inTotalTiempo INT
	,@inTotalPuntos INT
	,@OutIdInsertarIGXEquipo INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Equipo
			WHERE id = @inIdEquipo
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un Equipo con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].InstanciaGiro
			WHERE id = @inIdInstanciaGiro
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una Intanciagiro con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertIGXEquipo

		INSERT INTO dbo.InstGiroXEquipo (
			IdEquipo
			,IdInstanciaGiro
			,CodigoInstanciaGiro
			,TotalTiempo
			,TotalPuntos
			)
		VALUES (
			@inIdEquipo
			,@inIdInstanciaGiro
			,@inCodigoInstanciaGiro
			,@inTotalTiempo
			,@inTotalPuntos
			)

		SET @OutIdInsertarIGXEquipo = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertIGXEquipo;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertIGXEquipo;

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