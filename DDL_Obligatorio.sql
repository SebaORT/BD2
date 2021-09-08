--IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ObligatorioBD2_GestionMetro')
--BEGIN
--CREATE DATABASE [ObligatorioBD2_GestionMetro];
--END;



--GO



use [ObligatorioBD2_GestionMetro];
GO



/*
-- if a Transact-SQL statement raises a run-time error,
the entire transaction is terminated and rolled back
*/
Set xact_abort On



Begin Transaction



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[ESTACION]'))
Create Table [dbo].[ESTACION]
(
[Codigo] INT Not Null Primary Key,
[Barrio] VARCHAR(50) Not Null, --El barrio debe tener siempre un valor (nombre)
[Descripcion] VARCHAR(150) Null,
)



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[TREN]'))
Create Table [dbo].[TREN]
(
[Numero] INT Not Null Primary Key,
[Descripcion] VARCHAR(150) Null,
[Letra] CHAR(1) not null,
[CantidadVagon] INT not null, 
[CapacidadVagon] INT not null, --La capacidad debe ser menor a 40 asientos 
)


IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[LINEA_METRO]'))
Create Table [dbo].[LINEA_METRO]
(
[Numero] INT Not Null Primary Key,
[Descripcion] Varchar(150) Null,
[Longuitud] INT Not Null,
[CodigoColor] Varchar(50) Not Null,
[CodigoEstacionInicial] INT Not Null,
[CodigoEstacionFinal] INT Not Null,
)



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[ESTACION_LINEA_METRO]'))
Create Table [dbo].[ESTACION_LINEA_METRO]
(
[CodigoEstacion] INT Not Null,
[NumeroLinea] INT Not Null,
Primary Key(CodigoEstacion, NumeroLinea),
)



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[TREN_ESTACION_LINEA_METRO]'))
Create Table [dbo].[TREN_ESTACION_LINEA_METRO]
(
[CodigoEstacion] INT Not Null,
[NumeroLinea] INT Not Null,
[NumeroTren] INT Not Null,
[Fecha] Date Not Null,
[Hora] Time Not Null,
Primary Key(CodigoEstacion,NumeroLinea,NumeroTren)
)


--Restriciones 
--Estacion





Commit Transaction