USE [master]
GO
/****** Object:  Database [ProyectoFinalBD]    Script Date: 1/29/2021 2:38:05 PM ******/
CREATE DATABASE [ProyectoFinalBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProyectoFinalBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProyectoFinalBD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProyectoFinalBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProyectoFinalBD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProyectoFinalBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProyectoFinalBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProyectoFinalBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProyectoFinalBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProyectoFinalBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProyectoFinalBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProyectoFinalBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProyectoFinalBD] SET  MULTI_USER 
GO
ALTER DATABASE [ProyectoFinalBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProyectoFinalBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProyectoFinalBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProyectoFinalBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProyectoFinalBD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProyectoFinalBD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProyectoFinalBD] SET QUERY_STORE = OFF
GO
USE [ProyectoFinalBD]
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrera](
	[Id] [int] NOT NULL,
	[IdEtapa] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[HoraInicio] [int] NOT NULL,
 CONSTRAINT [PK_Carrera] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Corredor]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corredor](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Corredor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DebitoSancion]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DebitoSancion](
	[Id] [int] NOT NULL,
	[IdSansionXCarrera] [int] NOT NULL,
 CONSTRAINT [PK_DebitoSansion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Equipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Etapas]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etapas](
	[Id] [int] NOT NULL,
	[IdGiro] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Puntos] [int] NOT NULL,
 CONSTRAINT [PK_Etapas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GanadorPremioMontaña]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanadorPremioMontaña](
	[Id] [int] NOT NULL,
	[IdCarrera] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdPremioMontaña] [int] NOT NULL,
 CONSTRAINT [PK_GanadorPremioMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Giro]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Giro](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[IdPais] [int] NOT NULL,
 CONSTRAINT [PK_Giro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IGXEQXCorredor]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IGXEQXCorredor](
	[Id] [int] NOT NULL,
	[IdIGXEQ] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[SumaTiempo] [int] NOT NULL,
	[SumaPuntosMes] [int] NOT NULL,
	[SumaPuntosMontaña] [int] NOT NULL,
 CONSTRAINT [PK_IGXEQXCorredor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanciaGiro]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanciaGiro](
	[Id] [int] NOT NULL,
	[Año] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[IdGiro] [int] NOT NULL,
 CONSTRAINT [PK_InstanciaGiro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstGiroXEquipo]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstGiroXEquipo](
	[Id] [int] NOT NULL,
	[IdEquipo] [int] NOT NULL,
	[IdInstanciaGiro] [int] NOT NULL,
	[TotalTiempo] [int] NOT NULL,
	[TotalPuntos] [int] NOT NULL,
 CONSTRAINT [PK_InstGiroXEquipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Juez]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Juez](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Juez] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Llegada]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Llegada](
	[Id] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdCarrera] [int] NOT NULL,
	[HoraFin] [int] NOT NULL,
 CONSTRAINT [PK_Llegada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoPuntosMontaña]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoPuntosMontaña](
	[Id] [int] NOT NULL,
	[IdIGXEQXCorredor] [int] NOT NULL,
	[IdTipoMovPtosMontaña] [int] NOT NULL,
	[CantidadPuntos] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_MovimientoPuntosMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoPuntosRegularidad]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoPuntosRegularidad](
	[Id] [int] NOT NULL,
	[IdIGXEQXCorredor] [int] NOT NULL,
	[IdLlegada] [int] NOT NULL,
	[IdTIpoMovPuntosRegular] [int] NOT NULL,
	[CantidadPuntos] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_MovimientoPuntosRegularidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovTiempo]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovTiempo](
	[id] [int] NOT NULL,
	[IdIGXEQXCorredor] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[IdLlegada] [int] NOT NULL,
	[CantTiempo] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_MovTiempo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Pais] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PremioMontaña]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremioMontaña](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Puntos] [int] NOT NULL,
 CONSTRAINT [PK_PremioMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PremiosMontaña]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiosMontaña](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGiro] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Puntos] [int] NOT NULL,
	[IdEtapa] [int] NOT NULL,
 CONSTRAINT [PK_PremiosMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SancionXCarrera]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SancionXCarrera](
	[Id] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdJuez] [int] NOT NULL,
 CONSTRAINT [PK_SansionXCarrera] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimiento](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoMovimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovPtosMontaña]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovPtosMontaña](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoMovPtosMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovPuntosRegular]    Script Date: 1/29/2021 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovPuntosRegular](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoMovPuntosRegular] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carrera]  WITH CHECK ADD  CONSTRAINT [FK_Carrera_Etapas] FOREIGN KEY([IdEtapa])
REFERENCES [dbo].[Etapas] ([Id])
GO
ALTER TABLE [dbo].[Carrera] CHECK CONSTRAINT [FK_Carrera_Etapas]
GO
ALTER TABLE [dbo].[DebitoSancion]  WITH CHECK ADD  CONSTRAINT [FK_DebitoSansion_SansionXCarrera] FOREIGN KEY([IdSansionXCarrera])
REFERENCES [dbo].[SancionXCarrera] ([Id])
GO
ALTER TABLE [dbo].[DebitoSancion] CHECK CONSTRAINT [FK_DebitoSansion_SansionXCarrera]
GO
ALTER TABLE [dbo].[Etapas]  WITH CHECK ADD  CONSTRAINT [FK_Etapas_Giro] FOREIGN KEY([IdGiro])
REFERENCES [dbo].[Giro] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Etapas] CHECK CONSTRAINT [FK_Etapas_Giro]
GO
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_Carrera] FOREIGN KEY([IdCarrera])
REFERENCES [dbo].[Carrera] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_Carrera]
GO
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_Corredor] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_Corredor]
GO
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_Corredor1] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_Corredor1]
GO
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_PremioMontaña] FOREIGN KEY([IdPremioMontaña])
REFERENCES [dbo].[PremioMontaña] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_PremioMontaña]
GO
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_PremiosMontaña] FOREIGN KEY([IdPremioMontaña])
REFERENCES [dbo].[PremiosMontaña] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_PremiosMontaña]
GO
ALTER TABLE [dbo].[Giro]  WITH CHECK ADD  CONSTRAINT [FK_Giro_Pais] FOREIGN KEY([IdPais])
REFERENCES [dbo].[Pais] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Giro] CHECK CONSTRAINT [FK_Giro_Pais]
GO
ALTER TABLE [dbo].[IGXEQXCorredor]  WITH CHECK ADD  CONSTRAINT [FK_IGXEQXCorredor_Corredor] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[IGXEQXCorredor] CHECK CONSTRAINT [FK_IGXEQXCorredor_Corredor]
GO
ALTER TABLE [dbo].[IGXEQXCorredor]  WITH CHECK ADD  CONSTRAINT [FK_IGXEQXCorredor_InstGiroXEquipo] FOREIGN KEY([IdIGXEQ])
REFERENCES [dbo].[InstGiroXEquipo] ([Id])
GO
ALTER TABLE [dbo].[IGXEQXCorredor] CHECK CONSTRAINT [FK_IGXEQXCorredor_InstGiroXEquipo]
GO
ALTER TABLE [dbo].[InstanciaGiro]  WITH CHECK ADD  CONSTRAINT [FK_InstanciaGiro_Giro] FOREIGN KEY([IdGiro])
REFERENCES [dbo].[Giro] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InstanciaGiro] CHECK CONSTRAINT [FK_InstanciaGiro_Giro]
GO
ALTER TABLE [dbo].[InstGiroXEquipo]  WITH CHECK ADD  CONSTRAINT [FK_InstGiroXEquipo_Equipo] FOREIGN KEY([IdEquipo])
REFERENCES [dbo].[Equipo] ([Id])
GO
ALTER TABLE [dbo].[InstGiroXEquipo] CHECK CONSTRAINT [FK_InstGiroXEquipo_Equipo]
GO
ALTER TABLE [dbo].[InstGiroXEquipo]  WITH CHECK ADD  CONSTRAINT [FK_InstGiroXEquipo_InstanciaGiro] FOREIGN KEY([IdInstanciaGiro])
REFERENCES [dbo].[InstanciaGiro] ([Id])
GO
ALTER TABLE [dbo].[InstGiroXEquipo] CHECK CONSTRAINT [FK_InstGiroXEquipo_InstanciaGiro]
GO
ALTER TABLE [dbo].[Llegada]  WITH CHECK ADD  CONSTRAINT [FK_Llegada_Carrera] FOREIGN KEY([IdCarrera])
REFERENCES [dbo].[Carrera] ([Id])
GO
ALTER TABLE [dbo].[Llegada] CHECK CONSTRAINT [FK_Llegada_Carrera]
GO
ALTER TABLE [dbo].[Llegada]  WITH CHECK ADD  CONSTRAINT [FK_Llegada_Corredor] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[Llegada] CHECK CONSTRAINT [FK_Llegada_Corredor]
GO
ALTER TABLE [dbo].[MovimientoPuntosMontaña]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosMontaña_IGXEQXCorredor] FOREIGN KEY([IdIGXEQXCorredor])
REFERENCES [dbo].[IGXEQXCorredor] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosMontaña] CHECK CONSTRAINT [FK_MovimientoPuntosMontaña_IGXEQXCorredor]
GO
ALTER TABLE [dbo].[MovimientoPuntosMontaña]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosMontaña_TipoMovPtosMontaña] FOREIGN KEY([IdTipoMovPtosMontaña])
REFERENCES [dbo].[TipoMovPtosMontaña] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosMontaña] CHECK CONSTRAINT [FK_MovimientoPuntosMontaña_TipoMovPtosMontaña]
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosRegularidad_IGXEQXCorredor] FOREIGN KEY([IdIGXEQXCorredor])
REFERENCES [dbo].[IGXEQXCorredor] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad] CHECK CONSTRAINT [FK_MovimientoPuntosRegularidad_IGXEQXCorredor]
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosRegularidad_Llegada] FOREIGN KEY([IdLlegada])
REFERENCES [dbo].[Llegada] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad] CHECK CONSTRAINT [FK_MovimientoPuntosRegularidad_Llegada]
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosRegularidad_TipoMovPuntosRegular] FOREIGN KEY([IdTIpoMovPuntosRegular])
REFERENCES [dbo].[TipoMovPuntosRegular] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad] CHECK CONSTRAINT [FK_MovimientoPuntosRegularidad_TipoMovPuntosRegular]
GO
ALTER TABLE [dbo].[MovTiempo]  WITH CHECK ADD  CONSTRAINT [FK_MovTiempo_IGXEQXCorredor] FOREIGN KEY([IdIGXEQXCorredor])
REFERENCES [dbo].[IGXEQXCorredor] ([Id])
GO
ALTER TABLE [dbo].[MovTiempo] CHECK CONSTRAINT [FK_MovTiempo_IGXEQXCorredor]
GO
ALTER TABLE [dbo].[MovTiempo]  WITH CHECK ADD  CONSTRAINT [FK_MovTiempo_Llegada] FOREIGN KEY([IdLlegada])
REFERENCES [dbo].[Llegada] ([Id])
GO
ALTER TABLE [dbo].[MovTiempo] CHECK CONSTRAINT [FK_MovTiempo_Llegada]
GO
ALTER TABLE [dbo].[MovTiempo]  WITH CHECK ADD  CONSTRAINT [FK_MovTiempo_TipoMovimiento] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[TipoMovimiento] ([Id])
GO
ALTER TABLE [dbo].[MovTiempo] CHECK CONSTRAINT [FK_MovTiempo_TipoMovimiento]
GO
ALTER TABLE [dbo].[PremiosMontaña]  WITH CHECK ADD  CONSTRAINT [FK_PremiosMontaña_Etapas] FOREIGN KEY([IdEtapa])
REFERENCES [dbo].[Etapas] ([Id])
GO
ALTER TABLE [dbo].[PremiosMontaña] CHECK CONSTRAINT [FK_PremiosMontaña_Etapas]
GO
ALTER TABLE [dbo].[PremiosMontaña]  WITH CHECK ADD  CONSTRAINT [FK_PremiosMontaña_Giro] FOREIGN KEY([IdGiro])
REFERENCES [dbo].[Giro] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PremiosMontaña] CHECK CONSTRAINT [FK_PremiosMontaña_Giro]
GO
ALTER TABLE [dbo].[SancionXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_SansionXCarrera_Corredor] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[SancionXCarrera] CHECK CONSTRAINT [FK_SansionXCarrera_Corredor]
GO
ALTER TABLE [dbo].[SancionXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_SansionXCarrera_Juez] FOREIGN KEY([IdJuez])
REFERENCES [dbo].[Juez] ([Id])
GO
ALTER TABLE [dbo].[SancionXCarrera] CHECK CONSTRAINT [FK_SansionXCarrera_Juez]
GO
USE [master]
GO
ALTER DATABASE [ProyectoFinalBD] SET  READ_WRITE 
GO
