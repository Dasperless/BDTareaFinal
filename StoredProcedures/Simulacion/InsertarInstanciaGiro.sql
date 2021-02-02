USE [ProyectoFinalBD]
GO
/****** Object:  StoredProcedure [dbo].[InsertarInstanciaGiro]    Script Date: 2/1/2021 4:52:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER
	

 PROCEDURE [dbo].[InsertarInstanciaGiro]
	--Variables de entrada del SP
	@inIdGiro INT
	,@InCodigoInstancia VARCHAR(100)
	,@inFechaInicio DATE
	,@inFechaFin DATE
	,@OutIdInsertarInstanciaGiro INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF EXISTS (
			SELECT 1
			FROM [dbo].[InstanciaGiro] IG
			WHERE Ig.CodigoInstancia = @InCodigoInstancia
			)
	BEGIN
		SET @OutResultCode = 5006 --YA EXISTE UN GIRO CON ESE CÓDIGO DE INSTANCIA
		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertInstGiro

		INSERT INTO dbo.InstanciaGiro (
			IdGiro
			,CodigoInstancia
			,FechaInicio
			,FechaFinal
			)
		VALUES (
			@inIdGiro
			,@InCodigoInstancia
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