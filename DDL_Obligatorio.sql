IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ObligatorioBD2_GestionMetro')
BEGIN
CREATE DATABASE [ObligatorioBD2_GestionMetro];
END;

GO

use [ObligatorioBD2_GestionMetro];
GO

/*
-- if a Transact-SQL statement raises a run-time error,
the entire transaction is terminated and rolled back
*/
Set xact_abort On

Begin Transaction

IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[Estacion]'))
Create Table [dbo].[Estacion]
(
[Codigo] INT Not Null Primary Key,
[Barrio] VARCHAR(50) Not Null, --El barrio debe tener siempre un valor (nombre)
[Descripcion] VARCHAR(150) Null,
)

IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[Tren]'))
Create Table [dbo].[Tren]
(
[Numero] INT Not Null Primary Key,
[Descripcion] VARCHAR(150) Null,
[Letra] CHAR(1) not null,
[CantidadVagon] INT not null, 
[CapacidadVagon] INT not null,  --La capacidad debe ser menor o igual 40 asientos 
)


IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[LineaMetro]'))
Create Table [dbo].[LineaMetro]
(
[Numero] INT Not Null Primary Key,
[Descripcion] Varchar(150) Null,
[Longitud] DECIMAL(10,3) not null,
[CodigoColor] Varchar(50) Not Null,
[CodigoEstacionInicial] INT Not Null,
[CodigoEstacionFinal] INT Not Null,
)



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[EstacionLineaMetro]'))
Create Table [dbo].[EstacionLineaMetro]
(
[CodigoEstacion] INT Not Null ,
[NumeroLinea] INT Not Null,
Primary Key(CodigoEstacion, NumeroLinea)
)



IF NOT EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[TrenEstacionLineaMetro]'))
Create Table [dbo].[TrenEstacionLineaMetro]
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

/*
constraints Tren
*/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'UK_TrenLetra'))
ALTER TABLE Tren ADD CONSTRAINT UK_TrenLetra UNIQUE(Letra)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CK_TrenCapVag'))
ALTER TABLE Tren ADD CONSTRAINT CK_TrenCapVag CHECK (CapacidadVagon <= 40)

/*
constraints LineaMetro
*/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CK_LineaMetro_Longitud'))
ALTER TABLE LineaMetro ADD CONSTRAINT CK_LineaMetro_Longitud CHECK(Longitud >= 1)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'CK_LineaMetro_CodColor'))
ALTER TABLE LineaMetro ADD CONSTRAINT CK_LineaMetro_CodColor CHECK(CodigoColor IN ('ROJO', 'AZUL', 'AMARILLO', 'NARANJA', 'VERDE','NEGRO'))

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_LineaMetro_Inicial'))
ALTER TABLE LineaMetro ADD CONSTRAINT FK_LineaMetro_Inicial FOREIGN KEY(CodigoEstacionInicial) REFERENCES Estacion(Codigo)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_LineaMetro_Final'))
ALTER TABLE LineaMetro ADD CONSTRAINT FK_LineaMetro_Final FOREIGN KEY(CodigoEstacionFinal) REFERENCES Estacion(Codigo)

/*
constraints EstacionLineaMetro
*/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_EstacionLineaMetro_CodigoEstacion'))
ALTER TABLE EstacionLineaMetro ADD CONSTRAINT FK_EstacionLineaMetro_CodigoEstacion FOREIGN KEY(CodigoEstacion) REFERENCES Estacion(Codigo)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_EstacionLineaMetro_NumeroLinea'))
ALTER TABLE EstacionLineaMetro ADD CONSTRAINT FK_EstacionLineaMetro_NumeroLinea FOREIGN KEY(NumeroLinea) REFERENCES LineaMetro(Numero)

/*
TrenEstacionLineaMetro
*/


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_TrenEstacionLineaMetro_Tren'))
ALTER TABLE TrenEstacionLineaMetro ADD CONSTRAINT FK_TrenEstacionLineaMetro_Tren FOREIGN KEY(NumeroTren) REFERENCES Tren(Numero)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_TrenEstacionLineaMetro_Estacion'))
ALTER TABLE TrenEstacionLineaMetro ADD CONSTRAINT FK_TrenEstacionLineaMetro_Estacion FOREIGN KEY(CodigoEstacion) REFERENCES Estacion(Codigo)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_TrenEstacionLineaMetro_LineaMetro'))
ALTER TABLE TrenEstacionLineaMetro ADD CONSTRAINT FK_TrenEstacionLineaMetro_LineaMetro FOREIGN KEY(NumeroLinea) REFERENCES LineaMetro(Numero)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'FK_TrenEstacionLineaMetro_EstacionLineaMetro'))
ALTER TABLE TrenEstacionLineaMetro ADD CONSTRAINT FK_TrenEstacionLineaMetro_EstacionLineaMetro FOREIGN KEY(CodigoEstacion, NumeroLinea) REFERENCES EstacionLineaMetro(CodigoEstacion, NumeroLinea)


Commit Transaction