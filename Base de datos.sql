USE [master]
GO
/****** Object:  Database [ProyectoFinalBD]  MSSQL15.SQLEXPRESS ponga ESO DARIO en ves del server  Script Date: 1/2/2021 23:27:33 ******/
CREATE DATABASE [ProyectoFinalBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProyectoFinalBD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProyectoFinalBD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProyectoFinalBD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProyectoFinalBD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
EXEC sys.sp_db_vardecimal_storage_format N'ProyectoFinalBD', N'ON'
GO
ALTER DATABASE [ProyectoFinalBD] SET QUERY_STORE = OFF
GO
USE [ProyectoFinalBD]
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrera](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEtapa] [int] NOT NULL,
	[CodigoInstanciaGiro] [varchar](50) NOT NULL,
	[CodigoCarrera] [varchar](50) NOT NULL,
	[Fecha] [date] NOT NULL,
	[HoraInicio] [time](7) NOT NULL,
 CONSTRAINT [PK_Carrera] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Corredor]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[DebitoSancion]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DebitoSancion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdSansionXCarrera] [int] NOT NULL,
 CONSTRAINT [PK_DebitoSansion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[Errores]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Errores](
	[SUSER_SNAME] [nvarchar](128) NULL,
	[ERROR_NUMBER] [int] NULL,
	[ERROR_STATE] [int] NULL,
	[ERROR_SEVERITY] [int] NULL,
	[ERROR_LINE] [int] NULL,
	[ERROR_PROCEDURE] [nvarchar](128) NULL,
	[ERROR_MESSAGE] [nvarchar](4000) NULL,
	[GETDATE] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Etapas]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[GanadorPremioMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanadorPremioMontaña](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrera] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdPremioMontaña] [int] NOT NULL,
	[CodigoCarrera] [varchar](50) NOT NULL,
	[NumeroCamisa] [int] NOT NULL,
 CONSTRAINT [PK_GanadorPremioMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Giro]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[IGXEQXCorredor]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IGXEQXCorredor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdIGXEQ] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[CodigoInstanciaGiro] [varchar](50) NOT NULL,
	[NumeroCamisa] [int] NOT NULL,
	[Equipo] [int] NOT NULL,
	[SumaTiempo] [int] NOT NULL,
	[SumaPuntosMes] [int] NOT NULL,
	[SumaPuntosMontaña] [int] NOT NULL,
 CONSTRAINT [PK_IGXEQXCorredor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanciaGiro]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanciaGiro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGiro] [int] NOT NULL,
	[CodigoInstancia] [varchar](50) NOT NULL,
	[Year] [date] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
 CONSTRAINT [PK_InstanciaGiro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstGiroXEquipo]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstGiroXEquipo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEquipo] [int] NOT NULL,
	[IdInstanciaGiro] [int] NOT NULL,
	[CodigoInstanciaGiro] [varchar](50) NOT NULL,
	[TotalTiempo] [int] NOT NULL,
	[TotalPuntos] [int] NOT NULL,
 CONSTRAINT [PK_InstGiroXEquipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Juez]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[Llegada]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Llegada](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdCarrera] [int] NOT NULL,
	[IdMovTiempo] [int] NOT NULL,
	[CodigoCarrera] [varchar](50) NOT NULL,
	[NumeroCamisa] [int] NOT NULL,
	[HoraFin] [time](7) NOT NULL,
 CONSTRAINT [PK_Llegada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoPuntosMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoPuntosMontaña](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[MovimientoPuntosRegularidad]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoPuntosRegularidad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdIGXEQXCorredor] [int] NOT NULL,
	[IdLlegada] [int] NOT NULL,
	[IdTipoMovPuntosRegular] [int] NOT NULL,
	[CantidadPuntos] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_MovimientoPuntosRegularidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovTiempo]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovTiempo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdIGXEQXCorredor] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[CantTiempo] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_MovTiempo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[PremiosMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiosMontaña](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGiro] [int] NULL,
	[IdEtapa] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Puntos] [int] NOT NULL,
 CONSTRAINT [PK_PremiosMontaña] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SancionXCarrera]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SancionXCarrera](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrera] [int] NOT NULL,
	[IdCorredor] [int] NOT NULL,
	[IdJuez] [int] NOT NULL,
	[CodigoCarrera] [varchar](50) NOT NULL,
	[NumeroCamisa] [int] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[MinutosCastigo] [int] NOT NULL,
 CONSTRAINT [PK_SansionXCarrera] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[TipoMovPtosMontaña]    Script Date: 1/2/2021 23:27:33 ******/
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
/****** Object:  Table [dbo].[TipoMovPuntosRegular]    Script Date: 1/2/2021 23:27:33 ******/
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
ALTER TABLE [dbo].[DebitoSancion]  WITH CHECK ADD  CONSTRAINT [FK_DebitoSancion_MovTiempo] FOREIGN KEY([Id])
REFERENCES [dbo].[MovTiempo] ([id])
GO
ALTER TABLE [dbo].[DebitoSancion] CHECK CONSTRAINT [FK_DebitoSancion_MovTiempo]
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
ALTER TABLE [dbo].[GanadorPremioMontaña]  WITH CHECK ADD  CONSTRAINT [FK_GanadorPremioMontaña_Corredor2] FOREIGN KEY([IdCorredor])
REFERENCES [dbo].[Corredor] ([Id])
GO
ALTER TABLE [dbo].[GanadorPremioMontaña] CHECK CONSTRAINT [FK_GanadorPremioMontaña_Corredor2]
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
ALTER TABLE [dbo].[Llegada]  WITH CHECK ADD  CONSTRAINT [FK_Llegada_MovTiempo] FOREIGN KEY([IdMovTiempo])
REFERENCES [dbo].[MovTiempo] ([id])
GO
ALTER TABLE [dbo].[Llegada] CHECK CONSTRAINT [FK_Llegada_MovTiempo]
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
ALTER TABLE [dbo].[MovimientoPuntosRegularidad]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoPuntosRegularidad_TipoMovPuntosRegular] FOREIGN KEY([IdTipoMovPuntosRegular])
REFERENCES [dbo].[TipoMovPuntosRegular] ([Id])
GO
ALTER TABLE [dbo].[MovimientoPuntosRegularidad] CHECK CONSTRAINT [FK_MovimientoPuntosRegularidad_TipoMovPuntosRegular]
GO
ALTER TABLE [dbo].[MovTiempo]  WITH CHECK ADD  CONSTRAINT [FK_MovTiempo_IGXEQXCorredor] FOREIGN KEY([IdIGXEQXCorredor])
REFERENCES [dbo].[IGXEQXCorredor] ([Id])
GO
ALTER TABLE [dbo].[MovTiempo] CHECK CONSTRAINT [FK_MovTiempo_IGXEQXCorredor]
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
ALTER TABLE [dbo].[SancionXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_SancionXCarrera_Carrera] FOREIGN KEY([IdCarrera])
REFERENCES [dbo].[Carrera] ([Id])
GO
ALTER TABLE [dbo].[SancionXCarrera] CHECK CONSTRAINT [FK_SancionXCarrera_Carrera]
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
/****** Object:  StoredProcedure [dbo].[InsertarCarrera]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarCarrera] --Nombre del procedimiento
	@inIdEtapa INT
	,@inCodigoInstanciaGiro VARCHAR(50)
	,@inCodigoCarrera INT 
	,@inFecha DATE
	,@inHoraInicio TIME
	,@OutIdInsertarCarrera INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Etapas
			WHERE id = @inIdEtapa
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe una etapa con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertarCarrera

		INSERT INTO dbo.Carrera (
			IdEtapa
			,CodigoInstanciaGiro
			,CodigoCarrera
			,Fecha
			,HoraInicio
			)
		VALUES (
			@inIdEtapa
			,@inCodigoInstanciaGiro
			,@inCodigoCarrera
			,@inFecha
			,@inHoraInicio
			)

		SET @OutIdInsertarCarrera = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertarCarrera;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertarCarrera;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarCorredor]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarCorredor]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Corredor]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovCorredor

		INSERT INTO [dbo].[Corredor] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovCorredor; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovCorredor;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarDebitoSancion]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarDebitoSancion] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdSansionXCarrera INT
	,@OutIdInsertarDebitoSancion INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].SancionXCarrera
			WHERE id = @inIdSansionXCarrera
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe Sancion

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransDebitoSancion

		INSERT INTO dbo.DebitoSancion (IdSansionXCarrera)
		VALUES (@inIdSansionXCarrera)

		SET @OutIdInsertarDebitoSancion = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransDebitoSancion;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransDebitoSancion;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarEquipo]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarEquipo]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Equipo]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovEquipo

		INSERT INTO [dbo].[Equipo] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovEquipo; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovEquipo;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarEtapa]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarEtapa]
	@inId INT,   
	@InIdGiro INT,
	@inNombre VARCHAR(100),
	@InPuntos INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Etapas]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id de la etapa ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovEtapa

		INSERT INTO [dbo].[Etapas] (Id,IdGiro,Nombre,Puntos)
		VALUES (@inID,
				@InIdGiro,
				@inNombre,
				@InPuntos
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovEtapa; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovEtapa;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarGanadorPremioMont]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarGanadorPremioMont] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCarrera INT
	,@inIdCorredor INT
	,@inIdPremioMontaña INT
	,@inCodigoCarrera VARCHAR(50)
	,@inNumeroCamisa INT 
	,@OutIdInsertarGanadorPremioMont INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Carrera
			WHERE id = @inIdCarrera
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].PremiosMontaña
			WHERE id = @inIdPremioMontaña
			)
	BEGIN
		SET @OutResultCode = 5017 --No existe un PremiosMontaña con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransGanadorPremioMont

		INSERT INTO dbo.GanadorPremioMontaña (
			IdCarrera
			,IdCorredor
			,IdPremioMontaña
			,CodigoCarrera
			,NumeroCamisa
			)
		VALUES (
			@inIdCarrera
			,@inIdCorredor
			,@inIdPremioMontaña
			,@inCodigoCarrera
			,@inNumeroCamisa
			)

		SET @OutIdInsertarGanadorPremioMont = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransGanadorPremioMont;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransGanadorPremioMont;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarGiro]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarGiro]
	@inID INT,   
	@inNombre VARCHAR(100),
	@InIdPais INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	--IF EXISTS (
	--	SELECT 1
	--	FROM [dbo].[Giro]
	--	WHERE id = @inid
	--	)
	--	BEGIN
	--		SET @OutResultCode = 50006 --El Id del Giro ya existe.
	--		RETURN
	--	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovGiro

		INSERT INTO [dbo].[Giro] (Id,Nombre,IdPais)
		VALUES (@inID,
				@inNombre,
				@InIdPais
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovGiro; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovGiro;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarIGXEquipo]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarIGXEquipo] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdEquipo INT
	,@inIdInstanciaGiro INT
	,@inCodigoInstanciaGiro VARCHAR(50)
	,@inTotalTiempo INT
	,@inTotalPuntos INT
	,@OutIdInsertarIGXEquipo INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Equipo
			WHERE id = @inIdEquipo
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un Equipo con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].InstanciaGiro
			WHERE id = @inIdInstanciaGiro
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una Intanciagiro con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertIGXEquipo

		INSERT INTO dbo.InstGiroXEquipo (
			IdEquipo
			,IdInstanciaGiro
			,CodigoInstanciaGiro
			,TotalTiempo
			,TotalPuntos
			)
		VALUES (
			@inIdEquipo
			,@inIdInstanciaGiro
			,@inCodigoInstanciaGiro
			,@inTotalTiempo
			,@inTotalPuntos
			)

		SET @OutIdInsertarIGXEquipo = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertIGXEquipo;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertIGXEquipo;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarIGXEQXCorredor]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarIGXEQXCorredor] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQ INT
	,@inIdCorredor INT
	,@inCodigoInstanciaGiro VARCHAR(50)
	,@inNumeroCamisa INT
	,@inEquipo INT 
	,@inSumaTiempo INT
	,@inSumaPuntosMes INT
	,@inSumaPuntosMontaña INT
	,@OutIdInsertarIGXEQXCorredor INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].InstGiroXEquipo
			WHERE id = @inIdIGXEQ
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe InstGiroXEquipo

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una Corredor con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransIGXEQXCorredor

		INSERT INTO dbo.IGXEQXCorredor (
			IdIGXEQ
			,IdCorredor
			,CodigoInstanciaGiro
			,NumeroCamisa
			,Equipo
			,SumaTiempo
			,SumaPuntosMes
			,SumaPuntosMontaña
			)
		VALUES (
			@inIdIGXEQ
			,@inIdCorredor
			,@inCodigoInstanciaGiro
			,@inNumeroCamisa
			,@inEquipo
			,@inSumaTiempo
			,@inSumaPuntosMes
			,@inSumaPuntosMontaña
			)

		SET @OutIdInsertarIGXEQXCorredor = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransIGXEQXCorredor;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransIGXEQXCorredor;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarInstanciaGiro]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarInstanciaGiro] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdGiro INT
	,@inCodigoInstancia	VARCHAR(50)
	,@inYear DATE
	,@inFechaInicio DATE
	,@inFechaFin DATE
	,@OutIdInsertarInstanciaGiro INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Giro
			WHERE id = @inIdGiro
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un giro con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertInstGiro

		INSERT INTO dbo.InstanciaGiro (
			IdGiro
			,CodigoInstancia
			,Year
			,FechaInicio
			,FechaFinal
			)
		VALUES (
			@inIdGiro
			,@inCodigoInstancia
			,@inYear
			,@inFechaInicio
			,@inFechaFin
			)

		SET @OutIdInsertarInstanciaGiro = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertInstGiro;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertInstGiro;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarJuez]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarJuez]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Juez]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovJuez

		INSERT INTO [dbo].[Juez] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovJuez; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovJuez;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarLlegada]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarLlegada] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCorredor INT
	,@inIdCarrera INT
	,@inIdMovTiempo INT 
	,@inCodigoCarrera VARCHAR(50)
	,@inNumeroCamisa INT
	,@inHoraFin TIME(7)
	,@OutIdInsertarLlegada INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe un corredor con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Carrera
			WHERE id = @inIdCarrera
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe una carrera con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].MovTiempo
			WHERE id = @inIdMovTiempo
			)
	BEGIN
		SET @OutResultCode = 5017 --No existe un mov tiempo con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertLlegada

		INSERT INTO dbo.Llegada (
			IdCorredor
			,IdCarrera
			,IdMovTiempo
			,CodigoCarrera
			,NumeroCamisa
			,HoraFin
			)
		VALUES (
			@inIdCorredor
			,@inIdCarrera
			,@inIdMovTiempo
			,@inCodigoCarrera
			,@inNumeroCamisa
			,@inHoraFin
			)

		SET @OutIdInsertarLlegada = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertLlegada;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertLlegada;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovPtsMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarMovPtsMontaña] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQXCorredor INT
	,@inIdTipoMovPtosMontaña INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsMontaña INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].IGXEQXCorredor
			WHERE id = @inIdIGXEQXCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].TipoMovPtosMontaña
			WHERE id = @inIdTipoMovPtosMontaña
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsMontaña

		INSERT INTO dbo.MovimientoPuntosMontaña (
			IdIGXEQXCorredor
			,IdTipoMovPtosMontaña
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdTipoMovPtosMontaña
			,@inCantidadPuntos
			,@inFecha
			)

		SET @OutIdInsertMovPtsMontaña = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsMontaña;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsMontaña;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovPtsRegularidad]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarMovPtsRegularidad] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQXCorredor INT
	,@inIdLlegada INT
	,@inIdTipoMovPuntosRegular INT
	,@inCantidadPuntos INT
	,@inFecha DATE
	,@OutIdInsertMovPtsRegular INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].IGXEQXCorredor
			WHERE id = @inIdIGXEQXCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Llegada
			WHERE id = @inIdLlegada
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].TipoMovPuntosRegular
			WHERE id = @inIdTipoMovPuntosRegular
			)
	BEGIN
		SET @OutResultCode = 5017 --No existe una llegada con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransMovPtsRegular

		INSERT INTO dbo.MovimientoPuntosRegularidad (
			IdIGXEQXCorredor
			,IdLlegada
			,IdTipoMovPuntosRegular
			,CantidadPuntos
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdLlegada
			,@inIdTipoMovPuntosRegular
			,@inCantidadPuntos
			,@inFecha
			)

		SET @OutIdInsertMovPtsRegular = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransMovPtsRegular;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransMovPtsRegular;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarMovTiempo]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarMovTiempo] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdIGXEQXCorredor INT
	,@inIdTipoMovimiento INT
	,@inCantTiempo INT
	,@inFecha DATE
	,@OutIdInsertarMovTiempo INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].IGXEQXCorredor
			WHERE id = @inIdIGXEQXCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe IGXEQXCorredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].TipoMovimiento
			WHERE id = @inIdTipoMovimiento
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un TipoMovimiento con ese id

		RETURN
	END;

	
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransInsertMovTiempo

		INSERT INTO dbo.MovTiempo (
			IdIGXEQXCorredor
			,IdTipoMovimiento
			,CantTiempo
			,Fecha
			)
		VALUES (
			@inIdIGXEQXCorredor
			,@inIdTipoMovimiento
			,@inCantTiempo
			,@inFecha
			)

		SET @OutIdInsertarMovTiempo = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransInsertMovTiempo;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransInsertMovTiempo;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarPais]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarPais]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[Pais]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovPais

		INSERT INTO [dbo].[Pais] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovPais; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovPais;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarPremiosMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarPremiosMontaña]
	@InIdGiro INT,   
	@InIdEtapa VARCHAR(100),
	@InNombre VARCHAR(100),
	@InPuntos INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovPM

		INSERT INTO [dbo].[PremiosMontaña] (IdGiro, IdEtapa, Nombre, Puntos)
		VALUES (@InIdGiro,
				@InIdEtapa,
				@InNombre,
				@InPuntos
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovPM; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovPM;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarSancionXCarrera]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE
	

 PROCEDURE [dbo].[InsertarSancionXCarrera] --Nombre del procedimiento
	--Variables de entrada del SP
	@inIdCarrera INT
	,@inIdCorredor INT
	,@inIdJuez INT
	,@inCodigoCarrera VARCHAR(50)
	,@inNumeroCamisa INT
	,@inDescripcion VARCHAR(100)
	,@inMinutosCastigo INT
	,@OutIdInsertarSancionXCarrera INT OUTPUT
	,@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Carrera
			WHERE id = @inIdCarrera
			)
	BEGIN
		SET @OutResultCode = 5020 --No existe Carrera 

		RETURN
	END;

	--Validaciones
	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Corredor
			WHERE id = @inIdCorredor
			)
	BEGIN
		SET @OutResultCode = 5015 --No existe Corredor

		RETURN
	END;

	IF NOT EXISTS (
			SELECT 1
			FROM [dbo].Juez
			WHERE id = @inIdJuez
			)
	BEGIN
		SET @OutResultCode = 5016 --No existe un Juez con ese id

		RETURN
	END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TransSancionXCarrera

		INSERT INTO dbo.SancionXCarrera(
			IdCarrera
			,IdCorredor
			,IdJuez
			,CodigoCarrera
			,NumeroCamisa
			,Descripcion
			,MinutosCastigo
			)
		VALUES (
			@inIdCarrera
			,@inIdCorredor
			,@inIdJuez
			,@inCodigoCarrera
			,@inNumeroCamisa
			,@inDescripcion
			,@inMinutosCastigo
			)

		SET @OutIdInsertarSancionXCarrera = SCOPE_IDENTITY();
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TransSancionXCarrera;--Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TransSancionXCarrera;

		INSERT INTO dbo.Errores --Tabla de Errores
		VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarTipoMovimiento]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarTipoMovimiento]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[TipoMovimiento]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovTM

		INSERT INTO [dbo].[TipoMovimiento] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovTM; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovTM;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarTipoMovPtosMontaña]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarTipoMovPtosMontaña]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[TipoMovPtosMontaña]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del Tipo de movimiento puntos regular ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovTMPuntosRegular

		INSERT INTO [dbo].[TipoMovPtosMontaña] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovTMPuntosRegular; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovTMPuntosRegular;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarTipoMovPuntosRegular]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarTipoMovPuntosRegular]
	@inID INT,   
	@inNombre VARCHAR(100),
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--VALIDACIONES
	IF EXISTS (
		SELECT 1
		FROM [dbo].[TipoMovPuntosRegular]
		WHERE id = @inid
		)
		BEGIN
			SET @OutResultCode = 50006 --El Id del País ya existe.
			RETURN
		END;

	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED

		BEGIN TRANSACTION TMovTMPuntosRegular

		INSERT INTO [dbo].[TipoMovPuntosRegular] (Id,Nombre)
		VALUES (@inID,
				@inNombre
				)
		SET @OutResultCode = 0;

		COMMIT TRANSACTION TMovTMPuntosRegular; --Finaliza la transacción
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION TMovTMPuntosRegular;

		INSERT INTO [dbo].[Errores]    --Tabla de Errores
		VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
			);

		SET @OutResultCode = 50005;
	END CATCH

	SET NOCOUNT OFF
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcesarInstanciasGiro]    Script Date: 1/2/2021 23:27:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ProcesarInstanciasGiro]
	@inXML XML,
	@InAñoInicio INT,
	@OutResultCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--SE DECLARAN VARIABLES.

	DECLARE @lo INT, @hi INT
	DECLARE @OutResult INT

	--Variables Instancia Giro
	DECLARE @IdGiro INT,
			@CodigoInstancia VARCHAR(100),
			@FechaInicio DATE,
			@FechaFin DATE

	--Tabla Giro X Equipo
	DECLARE @TablaGiroXEquipo TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		Equipo INT
	) 

	--Tabla Corredores en Equipo en Giro
	DECLARE @TablaCorredoresEnEquipoEnGiro  TABLE (
			Sec INT IDENTITY(1, 1),
			CodigoInstanciaGiro VARCHAR(100),
			Equipo INT,
			Corredor INT,
			NumeroCamisa INT
		) 

	--Tabla de Carreras
	DECLARE @TablaCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoInstanciaGiro VARCHAR(100),
		CodigoCarrera VARCHAR(100),
		IdEtapa INT,
		FechaCarrera DATE,
		HoraInicio TIME
	) 

	DECLARE @TablaFinalCorredoresEnCarrera TABLE (
		Sec INT IDENTITY(1, 1),
		CodigoCarrera VARCHAR(100),
		NumeroCamisa INT,
		HoraLlegada DATE
	) 

	DECLARE @TablaSancionCarrera TABLE (
		Sec INT IDENTITY(1,1),
		CodigoCarrera VARCHAR(100),
		IdJuez INT,
		NumeroCamisa INT,
		MinutosCastigo INT,
		Descripcion VARCHAR(100)
	)

	--SE LE ASIGNAN VALORES A LAS VARIABLES.

	SELECT	@IdGiro = ref.value('@IdGiro', 'INT'),
			@CodigoInstancia = ref.value('@CodigoInstancia', 'VARCHAR(100)'),
			@FechaInicio = ref.value('@FechaInicio', 'DATE'),
			@FechaFin = ref.value('@FechaFin', 'DATE')
	FROM @InXML.nodes('InstanciaGiro') AS InstanciaGiro(ref)

	--Se le asignan valores a la tabla Giro X Equipo
	INSERT INTO @TablaGiroXEquipo (
		CodigoInstanciaGiro,
		Equipo
		)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@Equipo', 'INT')
	FROM @InXML.nodes('InstanciaGiro/GiroXEquipo') AS GIXEQ(ref)

	--Se le asignan valores a la tabla Giro X Corredores X Equipo X Giro
	INSERT INTO @TablaCorredoresEnEquipoEnGiro (
		CodigoInstanciaGiro,
		Equipo,
		Corredor,
		NumeroCamisa
		)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@Equipo', 'INT'),
		ref.value('@Corredor', 'INT'),
		ref.value('@NumeroCamisa', 'INT')
	FROM @InXML.nodes('InstanciaGiro/CorredoresEnEquipoEnGiro ') AS CorredoreEqXGiro(ref)

	INSERT INTO @TablaCarrera(
		CodigoInstanciaGiro ,
		CodigoCarrera,
		IdEtapa,
		FechaCarrera,
		HoraInicio
	)
	SELECT ref.value('@CodigoInstanciaGiro', 'VARCHAR(100)'),
		ref.value('@CodigoCarrera', 'VARCHAR(100)'),
		ref.value('@IdEtapa', 'INT'),
		ref.value('@FechaCarrera', 'DATE'),
		ref.value('@HoraInicio', 'TIME')
	FROM  @InXML.nodes('InstanciaGiro/Carrera') AS CorredoreEqXGiro(ref)

	SELECT *
	FROM @TablaCarrera
	--BEGIN TRY
	--	--SE PROCESAN LAS INSTANCIAS DE GIRO
	--	SELECT @lo = MIN(TablaIG.Sec),
	--		@hi = MAX(TablaIG.Sec)
	--	FROM @TablaInstanciasGiro AS TablaIG

	--	WHILE @lo <= @hi
	--	BEGIN

	--		EXEC [dbo].[InsertarInstanciaGiro]
				
	--	END;
	--END TRY

	--BEGIN CATCH
	--	IF @@TRANCOUNT > 0
	--		ROLLBACK TRANSACTION ProcesarIG;

	--	INSERT INTO [dbo].[Errores]    --Tabla de Errores
	--	VALUES (
	--		SUSER_SNAME(),
	--		ERROR_NUMBER(),
	--		ERROR_STATE(),
	--		ERROR_SEVERITY(),
	--		ERROR_LINE(),
	--		ERROR_PROCEDURE(),
	--		ERROR_MESSAGE(),
	--		GETDATE()
	--		);

	--	SET @OutResultCode = 50005;
	--END CATCH

	SET NOCOUNT OFF
END;
GO
USE [master]
GO
ALTER DATABASE [ProyectoFinalBD] SET  READ_WRITE 
GO
