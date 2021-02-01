USE ProyectoFinalBD

DECLARE @xmlData XML

-- Path Darío C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\FinalDataXML.xml
SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\FinalDataXML.xml', SINGLE_BLOB) AS xmlData
		) 
-- SE DECLARAN VARIABLES.

DECLARE @TablaAñoProcesar TABLE (
	Sec INT IDENTITY(1, 1),
	Año INT,
	InstanciasGiros XML
	)

DECLARE @AñoInicio INT,
	@AñoFin INT,
	@hi INT,
	@lo INT
DECLARE @InstanciaGiro XML

DECLARE @OutResultCode INT

--SE LE ASIGNAN VALORES A LAS VARIABLES.
INSERT INTO @TablaAñoProcesar (
	Año,
	InstanciasGiros
	)
SELECT A.value('@Id', 'int'),
	A.query('InstanciaGiro/.')
FROM @xmlData.nodes('Root/Year') AS DataAño(A)

SELECT @AñoInicio = MIN(Año),
	@AñoFin = MAX(Año)
FROM @TablaAñoProcesar

WHILE @AñoInicio <= @AñoFin --SE PROCESAN LOS AÑOS.
	BEGIN
		SELECT @lo = MIN(ref.value('@IdGiro', 'INT')),
			@hi = MAX(ref.value('@IdGiro', 'INT'))
		FROM @TablaAñoProcesar A
		OUTER APPLY A.InstanciasGiros.nodes('InstanciaGiro') AS InsGiro(ref)
		WHERE @AñoInicio = A.Año

		WHILE @lo <= @hi --SE PROCESAN LAS INSTANCIAS DE LOS GIRO POR AÑO.
			BEGIN
				SELECT @InstanciaGiro = ref.query('.')
				FROM @TablaAñoProcesar A
				OUTER APPLY A.InstanciasGiros.nodes('InstanciaGiro') AS InsGiro(ref)
				WHERE @lo = ref.value('@IdGiro', 'INT')
					AND A.Año = @AñoInicio

				EXEC  [dbo].[ProcesarInstanciasGiro]
					@InstanciaGiro,
					@AñoInicio,
					@OutResultCode OUTPUT

				SET @lo = @lo + 1
			END;

		SET @AñoInicio = @AñoInicio + 1
	END;
		--SELECT *
		--FROM @TablaAñoProcesar