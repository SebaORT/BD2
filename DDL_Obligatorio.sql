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
[CapacidadVagon] INT not null,  --La capacidad debe ser menor o igual 40 asientos 
)


IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[LINEA_METRO]'))
Create Table [dbo].[LINEA_METRO]
(
[Numero] INT Not Null Primary Key,
[Descripcion] Varchar(150) Null,
[Longitud] DECIMAL(10,3) not null,
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
Primary Key(CodigoEstacion, NumeroLinea)
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

Commit Transaction

GO

--Restriciones 
--Estacion

/*
IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[ESTACION]'))
Create Table [dbo].[ESTACION]
(
[Codigo] INT Not Null Primary Key,
[Barrio] VARCHAR(50) Not Null, --El barrio debe tener siempre un valor (nombre)
[Descripcion] VARCHAR(150) Null,
)
*/

/*
IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[TREN]'))
Create Table [dbo].[TREN]
(
[Numero] INT Not Null Primary Key,
[Descripcion] VARCHAR(150) Null,
[Letra] CHAR(1) not null,
[CantidadVagon] INT not null, 
[CapacidadVagon] INT not null, --La capacidad debe ser menor o igual 40 asientos 
)
*/
ALTER TABLE TREN ADD CONSTRAINT UK_TrenLetra UNIQUE(Letra)
ALTER TABLE TREN ADD CONSTRAINT CK_TrenCapVag CHECK (CapacidadVagon <= 40)

/*
IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[LINEA_METRO]'))
Create Table [dbo].[LINEA_METRO]
(
[Numero] INT Not Null Primary Key,
[Descripcion] Varchar(150) Null,
[Longuitud] DECIMAL(10,3) Not Null,
[CodigoColor] Varchar(50) Not Null,
[CodigoEstacionInicial] INT Not Null,
[CodigoEstacionFinal] INT Not Null,
)

Rojo, Azul, Amarillo, Naranja, Verde y Negro.
*/
ALTER TABLE LINEA_METRO ADD CONSTRAINT CK_Linea_Metro_Longitud CHECK(Longitud >= 1)
ALTER TABLE LINEA_METRO ADD CONSTRAINT CK_Linea_Metro_CodColor CHECK(CodigoColor IN ('ROJO', 'AZUL', 'AMARILLO', 'NARANJA', 'VERDE','NEGRO'))
ALTER TABLE LINEA_METRO ADD CONSTRAINT FK_Linea_Metro_Inicial FOREIGN KEY(CodigoEstacionInicial) REFERENCES ESTACION(Codigo)
ALTER TABLE LINEA_METRO ADD CONSTRAINT FK_Linea_Metro_Final FOREIGN KEY(CodigoEstacionFinal) REFERENCES ESTACION(Codigo)

/*
IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[ESTACION_LINEA_METRO]'))
Create Table [dbo].[ESTACION_LINEA_METRO]
(
[CodigoEstacion] INT Not Null,
[NumeroLinea] INT Not Null,
Primary Key(CodigoEstacion, NumeroLinea)
)
*/
ALTER TABLE ESTACION_LINEA_METRO ADD CONSTRAINT FK_ESTACION_LINEA_METRO_CodigoEstacion FOREIGN KEY(CodigoEstacion) REFERENCES ESTACION(Codigo)
ALTER TABLE ESTACION_LINEA_METRO ADD CONSTRAINT FK_ESTACION_LINEA_METRO_NumeroLinea FOREIGN KEY(NumeroLinea) REFERENCES LINEA_METRO(Numero)

/*
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
*/
ALTER TABLE TREN_ESTACION_LINEA_METRO ADD CONSTRAINT FK_TREN_ESTACION_LINEA_METRO_Linea_Metro FOREIGN KEY(CodigoEstacion, NumeroLinea) REFERENCES ESTACION_LINEA_METRO(CodigoEstacion, NumeroLinea)
ALTER TABLE TREN_ESTACION_LINEA_METRO ADD CONSTRAINT FK_ESTACION_LINEA_METRO_Tren FOREIGN KEY(NumeroTren) REFERENCES TREN(Numero)
