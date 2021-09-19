USE [ObligatorioBD2_GestionMetro]
GO
--a.Mostrar los datos del/los trene/s que pasaron por última vez por una línea-estación
SELECT * FROM EstacionLineaMetro;

--b.Mostrar los datos de las estaciones por las que pasaron más trenes este año que la cantidad promedio de trenes que pasaron en el año anterior.
SELECT *
FROM Estacion e1
WHERE e1.Codigo IN (
	SELECT tel.codigoEstacion, tel.NumeroTren, SUM(tel.numeroTren), AVG(tel.NumeroTren) AS PromedioAnioAnterior
	FROM TrenEstacionLineaMetro tel
	WHERE AVG(tel.NumeroTren) = (
			SELECT AVG(tel.NumeroTren)
			FROM TrenEstacionLineaMetro tel
			GROUP BY tel.codigoEstacion, tel.NumeroTren
			HAVING (tel.Fecha BETWEEN DAY('2020-01-01') AND DAY('2020-12-31'))
		)
	GROUP BY tel.codigoEstacion, tel.NumeroTren
	HAVING (tel.Fecha BETWEEN DAY('2021-01-01') AND GETDATE())
	)