USE ProyectoFinalBD
-- Ruta Darío: C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\Catalogo-Tarea-Final.xml
-- Ruta Jacob: 
DECLARE @xmlData XML

SET @xmlData = (
		SELECT *
		FROM OPENROWSET(BULK 'C:\Users\dvarg\Desktop\TEC\2020\Segundo Semestre\Bases de datos\Proyectos\Proyecto Final\BDTareaFinal\XML\Catalogo-Tarea-Final.xml', SINGLE_BLOB) AS xmlData
		)
DECLARE @lo INT, @hi INT
DECLARE @Id INT, @Nombre VARCHAR(100)
DECLARE @IdGiro INT, @IdEtapa INT, @Puntos INT
DECLARE @IdPais INT
DECLARE @OutResultCode INT


SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM  @xmlData.nodes('Catalogos/Paises/Pais') xmlData(ref)

--INSERTA LOS CATÁLOGOS DE PAISES.
WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/Paises/Pais') Pais(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarPais]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--INSERTA LOS CATÁLOGOS DE GIROS.
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM  @xmlData.nodes('Catalogos/Giros/Giro') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)'),
			@IdPais = ref.value('@IdPais', 'int')
		FROM @xmlData.nodes('Catalogos/Giros/Giro') Pais(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarGiro]
			@Id,
			@Nombre,
			@IdPais,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--INSERTA LOS CATALOGOS DE LAS ETAPAS
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/Etapas/Etapa') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@IdGiro = ref.value('@IdGiro', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)'),
			@Puntos = ref.value('@Puntos', 'int')
		FROM @xmlData.nodes('Catalogos/Etapas/Etapa') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarEtapa]
			@Id,
			@IdGiro,
			@Nombre,
			@Puntos,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;


--SE INSERTAN LOS CATALOGOS DE LOS PREMIOS DE MONTAÑA.
DECLARE @TablaPremiosMontaña TABLE (Sec INT IDENTITY (1,1), IdGiro INT, IdEtapa INT, Nombre Varchar(100), Puntos INT)	
INSERT INTO @TablaPremiosMontaña(
	IdGiro,
	IdEtapa,
	Nombre,
	Puntos
	)
SELECT	ref.value('@IdGiro', 'int'),
		ref.value('@IdEtapa', 'int'),
		ref.value('@Nombre', 'varchar(100)'),
		ref.value('@Puntos', 'int')
FROM @xmlData.nodes('Catalogos/PremiosMontana/PremioMontana') xmlData(ref)

SELECT  @hi = MAX(Sec),
		@lo = MIN(Sec)
FROM 	@TablaPremiosMontaña

WHILE @lo <= @hi
	BEGIN
		SELECT @IdGiro = T.IdGiro,
			@IdEtapa = T.IdEtapa,
			@Nombre = T.Nombre,
			@Puntos = T.Puntos
		FROM @TablaPremiosMontaña T
		WHERE Sec = @lo

		EXEC [dbo].[InsertarPremiosMontaña]
			@IdGiro,
			@IdEtapa,
			@Nombre,
			@Puntos,
			@OutResultCode OUTPUT

		SET @lo = @lo +1		
	END;

--SE INSERTAN LOS CATÁLOGOS DE LOS EQUIPOS.
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/Equipos/Equipo') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/Equipos/Equipo') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarEquipo]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--SE INSERTAN LOS CATÁLOGOS DE LOS CORREDORES.
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/Corredores/Corredor') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/Corredores/Corredor') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarCorredor]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--CATÁLOGO DE LOS JUECES
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/Jueces/Juez') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/Jueces/Juez') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarJuez]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--CATÁLOGO DE TIPOS DE MOVIMIENTO TIEMPO
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/TiposMovimientoTiempo/TipoMovimientoTiempo') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/TiposMovimientoTiempo/TipoMovimientoTiempo') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarTipoMovimiento]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--CATÁLOGOS DE TIPOS DE MOVIMIENTOS PUNTOS REGULARIDAD
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/TiposMovimientosPuntosRegularidad/TipoMovimientosPuntosRegularidad') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/TiposMovimientosPuntosRegularidad/TipoMovimientosPuntosRegularidad') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarTipoMovPuntosRegular]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		SET @lo = @lo +1
	END;

--CATÁLOGOS DE TIPOS DE MOVIMIENTOS PUNTOS MONTAÑA
SELECT  @hi = MAX(ref.value('@Id', 'int')),
		@lo = MIN(ref.value('@Id', 'int'))
FROM @xmlData.nodes('Catalogos/TiposMovimientoPuntosMontana/TipoMovimientoPuntosMontana') xmlData(ref)

WHILE @lo <= @hi
	BEGIN
		SELECT @Id = ref.value('@Id', 'int'),
			@Nombre = ref.value('@Nombre', 'varchar(100)')	
		FROM @xmlData.nodes('Catalogos/TiposMovimientoPuntosMontana/TipoMovimientoPuntosMontana') xmlData(ref)
		WHERE ref.value('@Id', 'int') = @lo

		EXEC [dbo].[InsertarTipoMovPtosMontaña]
			@Id,
			@Nombre,
			@OutResultCode OUTPUT

		--SELECT @OutResultCode
		SET @lo = @lo +1
	END;
SELECT * FROM Pais
SELECT * FROM Giro
SELECT * FROM Etapas
SELECT * FROM Corredor
SELECT * FROM Juez
SELECT * FROM TipoMovimiento
SELECT * FROM TipoMovPuntosRegular
SELECT * FROM TipoMovPtosMontaña

--SELECT * FROM Errores
--DELETE Pais
--DELETE Giro
--DELETE Etapas
--DELETE Corredor
--DELETE Juez
--DELETE TipoMovimiento
--DELETE TipoMovPuntosRegular
--DELETE TipoMovPtosMontaña