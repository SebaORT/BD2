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

	[Estacion] [int] NOT NULL,
	[Linea] [int] NOT NULL,
	[Tren] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Hora] [time](7) NOT NULL,
)

go


