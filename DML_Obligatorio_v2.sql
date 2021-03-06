USE [ObligatorioBD2_GestionMetro]
GO
INSERT [dbo].[Estacion] ([Codigo], [Barrio], [Descripcion]) VALUES (1, N'Bruselas', N'Estacion numero 1 de Bruselas')
INSERT [dbo].[Estacion] ([Codigo], [Barrio], [Descripcion]) VALUES (2, N'Madrid / Malasaña', N'Estacion Malasaña de Madrid')
INSERT [dbo].[Estacion] ([Codigo], [Barrio], [Descripcion]) VALUES (3, N'Barcelona', N'Estacion N°1 Barcelona')
GO
INSERT [dbo].[LineaMetro] ([Numero], [Descripcion], [Longitud], [CodigoColor], [CodigoEstacionInicial], [CodigoEstacionFinal]) VALUES (1, N'Linea de Bruselas a Madrid', CAST(100.000 AS Decimal(10, 3)), N'Azul', 1, 2)
INSERT [dbo].[LineaMetro] ([Numero], [Descripcion], [Longitud], [CodigoColor], [CodigoEstacionInicial], [CodigoEstacionFinal]) VALUES (2, N'Linea de Madrid a Barcelona', CAST(300.000 AS Decimal(10, 3)), N'Rojo', 2, 3)
INSERT [dbo].[LineaMetro] ([Numero], [Descripcion], [Longitud], [CodigoColor], [CodigoEstacionInicial], [CodigoEstacionFinal]) VALUES (3, N'Linea Bruselas a Barcelona', CAST(600.000 AS Decimal(10, 3)), N'Rojo', 1, 3)
INSERT [dbo].[LineaMetro] ([Numero], [Descripcion], [Longitud], [CodigoColor], [CodigoEstacionInicial], [CodigoEstacionFinal]) VALUES (4, N'Linea Barcelona Bruselas', CAST(600.000 AS Decimal(10, 3)), N'Negro', 3, 1)
GO
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (1, 1)
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (1, 3)
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (2, 2)
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (3, 2)
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (3, 3)
INSERT [dbo].[EstacionLineaMetro] ([CodigoEstacion], [NumeroLinea]) VALUES (3, 4)
GO
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (1, N'Tren Bruselas', N'A', 10, 20)
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (2, N'Tren Madrid', N'M', 30, 30)
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (3, N'Tren Barcelona', N'Z', 40, 40)
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (4, N'Tren Bruselas 2', N'B', 20, 30)
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (5, N'Tren Madrid 2', N'C', 20, 30)
INSERT [dbo].[Tren] ([Numero], [Descripcion], [Letra], [CantidadVagon], [CapacidadVagon]) VALUES (6, N'Tren Barcelona 2', N'D', 20, 30)
GO
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (1, 1, 1, CAST(N'2020-06-15' AS Date), CAST(N'07:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (1, 1, 1, CAST(N'2021-09-14' AS Date), CAST(N'09:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (1, 1, 2, CAST(N'2021-06-05' AS Date), CAST(N'05:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (1, 1, 4, CAST(N'2020-03-04' AS Date), CAST(N'08:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (1, 3, 1, CAST(N'2021-09-15' AS Date), CAST(N'17:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (3, 2, 5, CAST(N'2020-01-02' AS Date), CAST(N'04:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (3, 4, 3, CAST(N'2020-07-02' AS Date), CAST(N'08:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (3, 4, 3, CAST(N'2021-09-21' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[TrenEstacionLineaMetro] ([CodigoEstacion], [NumeroLinea], [NumeroTren], [Fecha], [Hora]) VALUES (3, 4, 4, CAST(N'2020-02-03' AS Date), CAST(N'05:00:00' AS Time))
GO
