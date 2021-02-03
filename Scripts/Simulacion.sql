USE ProyectoFinalBD

DECLARE @xmlData XML

-- Path Dar�o C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\FinalDataXML.xml
SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\FinalDataXML.xml', SINGLE_BLOB) AS xmlData
		) 
-- SE DECLARAN VARIABLES.

DECLARE @TablaA�oProcesar TABLE (
	Sec INT IDENTITY(1, 1),
	A�o INT,
	InstanciasGiros XML
	)

DECLARE @A�oInicio INT,
	@A�oFin INT,
	@hi INT,
	@lo INT
DECLARE @InstanciaGiro XML

DECLARE @OutResultCode INT

--SE LE ASIGNAN VALORES A LAS VARIABLES.
INSERT INTO @TablaA�oProcesar (
	A�o,
	InstanciasGiros
	)
SELECT A.value('@Id', 'int'),
	A.query('InstanciaGiro/.')
FROM @xmlData.nodes('Root/Year') AS DataA�o(A)

SELECT @A�oInicio = MIN(A�o),
	@A�oFin = MAX(A�o)
FROM @TablaA�oProcesar

WHILE @A�oInicio <= @A�oFin --SE PROCESAN LOS A�OS. 
	BEGIN
		SELECT @lo = MIN(ref.value('@IdGiro', 'INT')),
			@hi = MAX(ref.value('@IdGiro', 'INT'))
		FROM @TablaA�oProcesar A
		OUTER APPLY A.InstanciasGiros.nodes('InstanciaGiro') AS InsGiro(ref)
		WHERE @A�oInicio = A.A�o


		WHILE @lo <= @hi --SE PROCESAN LAS INSTANCIAS DE LOS GIRO POR A�O.
			BEGIN
				SELECT @InstanciaGiro = ref.query('.')
				FROM @TablaA�oProcesar A
				OUTER APPLY A.InstanciasGiros.nodes('InstanciaGiro') AS InsGiro(ref)	
				WHERE @lo = ref.value('@IdGiro', 'INT')
					AND A.A�o = @A�oInicio

				EXEC  [dbo].[ProcesarInstanciasGiro]
					@InstanciaGiro,
					@A�oInicio,
					@OutResultCode OUTPUT

						
				--SELECT @OutResultCode
				SET @lo = @lo + 1
			END;

		SET @A�oInicio = @A�oInicio + 1
	END;

--TODAS LAS TABLAS SE INSERTA CORRECTAMENTE
--SELECT * FROM InstanciaGiro
--SELECT * FROM InstGiroXEquipo
--SELECT * FROM IGXEQXCorredor
--SELECT * FROM Carrera
--SELECT * FROM MovTiempo
--SELECT * FROM Llegada
--SELECT * FROM SancionXCarrera
--SELECT * FROM GanadorPremioMonta�a G
--INNER JOIN Carrera C ON C.Id = G.IdCarrera
--INNER JOIN PremiosMonta�a P ON P.Id = G.IdPremioMonta�a

--SELECT * FROM MovimientoPuntosMonta�a
SELECT * FROM MovimientoPuntosRegularidad
SELECT * FROM MovTiempo

--DELETE InstanciaGiro
--DELETE InstGiroXEquipo
--DELETE IGXEQXCorredor
--DELETE Carrera
--DELETE MovTiempo
--DELETE Llegada
--DELETE SancionXCarrera
--DELETE GanadorPremioMonta�a
--DELETE MovimientoPuntosMonta�a
--DELETE MovimientoPuntosRegularidad





--SELECT * FROM Errores E ORDER BY  E.[GETDATE] DESC