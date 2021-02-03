USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--LOS 10 MEJORES CORREDORES EN EL GIRO 
CREATE
	OR

ALTER PROCEDURE [dbo].[consulta1] --Nombre del procedimiento
	@inNombreDelGiro VARCHAR(50)
	,--Variables de entrada del SP
	@inAno INT
	,@OutIdConsulta1 INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Se declaran variables
	DECLARE @idGiro INT
		,@idInstanciaGiro VARCHAR(50)
		,@codigoInstanciaGiro VARCHAR(50)

	--Validaciones
	SET @idGiro = (
			SELECT Id
			FROM [dbo].Giro
			WHERE Nombre = @inNombreDelGiro
			)

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].InstanciaGiro
			WHERE IdGiro = @idGiro
				AND ano = @inAno
			)
	BEGIN
		SET @OutResultCode = 50017 --Codigo de retorno el año no existe.

		RETURN
	END;

	SET @idInstanciaGiro = (
			SELECT id
			FROM dbo.InstanciaGiro
			WHERE IdGiro = @idGiro and ano = @inAno
			)
	SET @codigoInstanciaGiro = (
			SELECT TOP(1) codigoInstanciaGiro
			FROM dbo.InstGiroXEquipo
			WHERE IdInstanciaGiro = @idInstanciaGiro
			)

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransCons1

		SELECT TOP (10) co2.Nombre
			,co.SumaTiempo
		FROM dbo.IGXEQXCorredor co
		INNER JOIN dbo.Corredor co2 ON co.IdCorredor = co2.Id
		WHERE co.CodigoInstanciaGiro = @codigoInstanciaGiro
		ORDER BY co.SumaTiempo ASC

		SET @OutIdConsulta1 = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransCons1;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransCons1;

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