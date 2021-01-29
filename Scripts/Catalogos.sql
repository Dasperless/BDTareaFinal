USE ProyectoFinalBD
-- Ruta Darío: C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\Catalogo-Tarea-Final.xml
-- Ruta Jacob: 
DECLARE @xmlData XML

SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\Catalogo-Tarea-Final.xml', SINGLE_BLOB) AS xmlData
		)

--INSERTA LOS CATÁLOGOS DE PAISES.
INSERT INTO Pais (
	id,
	Nombre
	)
SELECT ref.value('@Id', 'int'),
	ref.value('@Nombre', 'varchar(100)')
FROM @xmlData.nodes('Catalogos/Paises/Pais') xmlData(ref)
LEFT JOIN Pais P
	ON P.id = ref.value('@Id', 'int')
WHERE P.id IS NULL

--INSERTA LOS CATÁLOGOS DE GIROS.
INSERT INTO Giro(
	id,
	Nombre,
	IdPais
	)
SELECT ref.value('@Id', 'int'),
	ref.value('@Nombre', 'varchar(100)'),
	ref.value('@IdPais', 'int')
FROM @xmlData.nodes('Catalogos/Giros/Giro') xmlData(ref)
LEFT JOIN Giro G
	ON G.id = ref.value('@Id', 'int')
WHERE G.id IS NULL

--INSERTA LOS CATALOGOS DE LAS ETAPAS
INSERT INTO Etapas(
	Id,
	IdGiro,
	Nombre,
	Puntos
	)
SELECT ref.value('@Id', 'int'),
	ref.value('@IdGiro', 'int'),
	ref.value('@Nombre', 'varchar(100)'),
	ref.value('@Puntos', 'int')
FROM @xmlData.nodes('Catalogos/Etapas/Etapa') xmlData(ref)
LEFT JOIN Etapas E
	ON E.id = ref.value('@Id', 'int')
WHERE E.id IS NULL

--SE INSERTAN LOS CATALOGOS DE LOS PREMIOS DE MONTAÑA.
INSERT INTO PremiosMontaña(
	IdGiro,
	IdEtapa,
	Nombre,
	Puntos
	)
SELECT ref.value('@IdGiro', 'int'),
	ref.value('@IdEtapa', 'int'),
	ref.value('@Nombre', 'varchar(100)'),
	ref.value('@Puntos', 'int')
FROM @xmlData.nodes('Catalogos/PremiosMontana/PremioMontana') xmlData(ref)
LEFT JOIN PremiosMontaña PM
	ON PM.id = ref.value('@Id', 'int')
WHERE PM.id IS NULL

--SE INSERTAN LOS CATÁLOGOS DE LOS EQUIPOS.
INSERT INTO Equipo(
	id,
	Nombre
	)
SELECT ref.value('@Id', 'int'),
	ref.value('@Nombre', 'varchar(50)')
FROM @xmlData.nodes('Catalogos/Equipos/Equipo') xmlData(ref)
LEFT JOIN Equipo EQ
	ON EQ.id = ref.value('@Id', 'int')
WHERE EQ.id IS NULL

--SE INSERTAN LOS CATÁLOGOS DE LOS CORREDORES.
INSERT INTO Corredor(
		id,
		Nombre
	)
SELECT ref.value('@Id', 'INT'),
	ref.value('@Nombre', 'varchar(50)')
FROM @xmlData.nodes('Catalogos/Corredores/Corredor') xmlData(ref)
LEFT JOIN Corredor C
	ON C.id = ref.value('@Id', 'int')
WHERE C.id IS NULL

--CATÁLOGO DE LOS JUECES
INSERT INTO Juez(
	id,
	Nombre
	)
SELECT ref.value('@Id', 'INT'),
	ref.value('@Nombre', 'varchar(100)')
FROM @xmlData.nodes('Catalogos/Jueces/Juez') xmlData(ref)
LEFT JOIN Juez J
	ON J.id = ref.value('@Id', 'int')
WHERE J.id IS NULL

--CATÁLOGO DE TIPOS DE MOVIMIENTO TIEMPO
INSERT INTO TipoMovimiento (
	Id,
	Nombre
	)
SELECT ref.value('@Id', 'INT'),
	ref.value('@Nombre', 'varchar(50)')
FROM @xmlData.nodes('Catalogos/TiposMovimientoTiempo/TipoMovimientoTiempo') xmlData(ref)
LEFT JOIN TipoMovimiento TM
	ON TM.id = ref.value('@Id', 'int')
WHERE TM.id IS NULL

--CATÁLOGOS DE TIPOS DE MOVIMIENTOS PUNTOS REGULARIDAD
INSERT INTO TipoMovPuntosRegular(
	Id,
	Nombre
	)
SELECT ref.value('@Id', 'INT'),
	ref.value('@Nombre', 'varchar(50)')
FROM @xmlData.nodes('Catalogos/TiposMovimientosPuntosRegularidad/TipoMovimientosPuntosRegularidad') xmlData(ref)
LEFT JOIN TipoMovPuntosRegular TMovR
	ON TMovR.id = ref.value('@Id', 'int')
WHERE TMovR.id IS NULL

--CATÁLOGOS DE TIPOS DE MOVIMIENTOS PUNTOS MONTAÑA
INSERT INTO TipoMovPtosMontaña(
	Id,
	Nombre
	)
SELECT ref.value('@Id', 'INT'),
	ref.value('@Nombre', 'varchar(50)')
FROM @xmlData.nodes('Catalogos/TiposMovimientoPuntosMontana/TipoMovimientoPuntosMontana') xmlData(ref)
LEFT JOIN TipoMovPtosMontaña TMovPM
	ON TMovPM.id = ref.value('@Id', 'int')
WHERE TMovPM.id IS NULL

SELECT * FROM Pais
SELECT * FROM Giro
SELECT * FROM Etapas
SELECT * FROM Corredor
SELECT * FROM Juez
SELECT * FROM TipoMovimiento
SELECT * FROM TipoMovPuntosRegular
SELECT * FROM TipoMovPtosMontaña

--DELETE Pais
--DELETE Giro
--DELETE Etapas
--DELETE Corredor
--DELETE Juez
--DELETE TipoMovimiento
--DELETE TipoMovPuntosRegular
--DELETE TipoMovPtosMontaña