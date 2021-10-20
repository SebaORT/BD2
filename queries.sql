-- Mostrar los datos del/los trene/s que pasaron por última vez por una línea-estación
SELECT t.*,[Fecha],[Hora]
  FROM [ObligatorioBD2_GestionMetro].[dbo].[TrenEstacionLineaMetro]
  join [ObligatorioBD2_GestionMetro].[dbo].Tren t on t.Numero = NumeroTren


/*
  Mostrar los datos de las estaciones por las que pasaron más trenes este año que la
cantidad promedio de trenes que pasaron en el año anterior.

c. Mostrar numero de línea, descripción, nombre de la estación inicio, nombre de la estación
destino y cantidad de estaciones que la componen.
d. Mostrar los datos de la línea que recorre la distancia más larga
e. Mostrar los datos de las estaciones que están incluidas en líneas de color rojo pero no
están incluidas en líneas de color amarillo.
f. Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.

  */