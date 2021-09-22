SELECT 
      t.*,[Fecha]
      ,[Hora]
  FROM [ObligatorioBD2_GestionMetro].[dbo].[TrenEstacionLineaMetro]
  join [ObligatorioBD2_GestionMetro].[dbo].Tren t on t.Numero = NumeroTren