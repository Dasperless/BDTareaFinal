USE [ProyectoFinalBD] --Colocar Nombre de la Base de Datos 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[consulta4] --Nombre del procedimiento
	@inNombreDelGiro VARCHAR(50),   --Variables de entrada del SP
	@inAno INT,
	@OutIdConsulta4 INT OUTPUT,
	@OutResultCode INT OUTPUT
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
			WHERE IdGiro = @idGiro
			)
	
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransCons4

		SELECT TOP (3) eq2.Nombre
			,eq.TotalTiempo
		FROM dbo.InstGiroXEquipo eq
		INNER JOIN dbo.Equipo eq2 ON eq.IdEquipo = eq2.Id
		WHERE eq.IdInstanciaGiro = @idInstanciaGiro
		ORDER BY eq.TotalTiempo DESC

		SET @OutIdConsulta4 = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransCons4; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransCons4;

		INSERT INTO dbo.Errores    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;