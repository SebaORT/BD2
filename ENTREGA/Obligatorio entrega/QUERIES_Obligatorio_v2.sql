USE [ObligatorioBD2_GestionMetro]
GO
--a.Mostrar los datos del/los trene/s que pasaron por última vez por una línea-estación
SELECT t1.*
FROM TREN t1, TrenEstacionLineaMetro telm1
WHERE t1.Numero = telm1.NumeroTren
AND telm1.Fecha = (SELECT MAX(fecha)
						FROM TrenEstacionLineaMetro telm2
						WHERE telm1.NumeroLinea = telm2.NumeroLinea)


--b.Mostrar los datos de las estaciones por las 
-- que pasaron más trenes este año que la cantidad promedio de trenes que pasaron en el año anterior.
select * from [Estacion] where Codigo in
(SELECT telm.CodigoEstacion 
	FROM TrenEstacionLineaMetro telm
	WHERE ( year(telm.fecha) = year(getdate()))  -- trenes año actual
	GROUP BY telm.CodigoEstacion
	HAVING COUNT(telm.NumeroTren) > (SELECT AVG(miTabla.CANT) 
									FROM
	 (SELECT COUNT(telm2.NumeroTren) AS CANT FROM TrenEstacionLineaMetro telm2
	 WHERE (year(telm2.fecha) = year(getdate())-1)
	 GROUP BY telm2.CodigoEstacion) miTabla))

--c.Mostrar numero de línea, descripción, nombre de la estación inicio, nombre de la estación destino y cantidad de estaciones que la componen.
SELECT l1.numero, l1.descripcion, MIN(e1.CodigoEstacion) AS estacionInicio, MAX(e1.CodigoEstacion) AS estacionDestino, COUNT(e1.CodigoEstacion) AS numEstaciones
FROM LineaMetro l1, EstacionLineaMetro e1
WHERE l1.Numero = e1.NumeroLinea
GROUP BY l1.numero, l1.descripcion

--d.Mostrar los datos de la línea que recorre la distancia más larga
SELECT l1.*
FROM LineaMetro l1
WHERE l1.longitud = (
	SELECT MAX(l2.longitud)
	FROM LineaMetro l2
	)

--e.Mostrar los datos de las estaciones que están incluidas en líneas de color rojo pero no están incluidas en líneas de color amarillo.
SELECT e1.*
FROM Estacion e1
WHERE (
e1.Codigo IN (
		SELECT e2.CodigoEstacion
		FROM EstacionLineaMetro e2, LineaMetro l1
		WHERE e2.NumeroLinea = l1.Numero AND l1.CodigoColor = 'ROJO')
AND e1.codigo NOT IN (SELECT e2.CodigoEstacion
		FROM EstacionLineaMetro e2, LineaMetro l1
		WHERE e2.NumeroLinea = l1.Numero AND l1.CodigoColor = 'AMARILLO')
		)

--f.Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.
SELECT t1.*
FROM Tren t1
WHERE t1.Numero IN (
	SELECT telm1.NumeroTren
	FROM TrenEstacionLineaMetro telm1
	GROUP BY telm1.NumeroTren
	HAVING COUNT(telm1.CodigoEstacion) = (
		SELECT COUNT(e1.Codigo)
		FROM Estacion e1
		)
	)
	