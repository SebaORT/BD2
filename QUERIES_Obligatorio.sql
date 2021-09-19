USE [ObligatorioBD2_GestionMetro]
GO
--a.Mostrar los datos del/los trene/s que pasaron por última vez por una línea-estación
SELECT * FROM EstacionLineaMetro;

--b.Mostrar los datos de las estaciones por las que pasaron más trenes este año que la cantidad promedio de trenes que pasaron en el año anterior.
SELECT *
FROM Estacion e1
WHERE e1.Codigo IN (
	SELECT telm.CodigoEstacion
	FROM TrenEstacionLineaMetro telm
	WHERE (telm.fecha BETWEEN '2020-01-01' AND '2020-12-31')
	GROUP BY telm.CodigoEstacion
	HAVING COUNT(telm.NumeroTren) > (
	SELECT COUNT(telm2.NumeroTren)
	FROM TrenEstacionLineaMetro telm2
	WHERE (telm2.fecha BETWEEN '2021-01-01' AND GETDATE()))
	)
