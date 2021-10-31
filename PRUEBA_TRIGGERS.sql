/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CodigoEstacion]
      ,[NumeroLinea]
      ,[NumeroTren]
      ,[Fecha]
      ,[Hora]
  FROM [ObligatorioBD2_GestionMetro].[dbo].[TrenEstacionLineaMetro]


  insert into [TrenEstacionLineaMetro]
  values 
  (3,4,3,'2020-01-01','09:00:00');

    update [TrenEstacionLineaMetro] 
	set Fecha = '2020-11-01'
	where codigoEstacion = 3 and numeroLinea = 4 and numeroTren = 3
	and Fecha = '2020-01-01' and hora = '09:00:00'
  -- (3,4,3,'2020-01-01','09:00:00');

  delete from [TrenEstacionLineaMetro] 
  where codigoEstacion = 3 and numeroLinea = 4 and numeroTren = 3
	and Fecha = '2020-11-01' and hora = '09:00:00'