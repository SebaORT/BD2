/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [CodigoEstacion],
      Count(NumeroTren) CantidadTrenesEstacion
  FROM [dbo].[TrenEstacionLineaMetro]

  group by CodigoEstacion

  select * from [ObligatorioBD2_GestionMetro].[dbo].[TrenEstacionLineaMetro]