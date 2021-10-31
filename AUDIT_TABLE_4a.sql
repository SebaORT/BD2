USE [ObligatorioBD2_GestionMetro]
GO

/****** Object:  Table [dbo].[TrenEstacionLineaMetro]    Script Date: 31/10/2021 14:25:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AuditoriaLineaMetro](
	[UserAudit] varchar(255),
	[HostAudit] varchar(255),
	[DateAudit] Datetime,
	[OperationAudit] varchar(100),

	[Estacion] [int] NULL,
	[Linea] [int]  NULL,
	[Tren] [int]  NULL,
	[Fecha] [date]  NULL,
	[Hora] [time](7)  NULL,
	[Estacion_after] [int] NULL,
	[Linea_after] [int] NULL,
	[Tren_after] [int] NULL,
	[Fecha_after] [date] NULL,
	[Hora_after] [time](7) NULL
)

go


