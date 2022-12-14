USE [master]
GO
/****** Object:  Database [personas.api]    Script Date: 18/10/2022 22:36:35 ******/
CREATE DATABASE [personas.api]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'personas.api', FILENAME = N'/var/opt/mssql/data/personas.api.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'personas.api_log', FILENAME = N'/var/opt/mssql/data/personas.api_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [personas.api] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [personas.api].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [personas.api] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [personas.api] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [personas.api] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [personas.api] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [personas.api] SET ARITHABORT OFF 
GO
ALTER DATABASE [personas.api] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [personas.api] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [personas.api] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [personas.api] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [personas.api] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [personas.api] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [personas.api] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [personas.api] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [personas.api] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [personas.api] SET  DISABLE_BROKER 
GO
ALTER DATABASE [personas.api] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [personas.api] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [personas.api] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [personas.api] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [personas.api] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [personas.api] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [personas.api] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [personas.api] SET RECOVERY FULL 
GO
ALTER DATABASE [personas.api] SET  MULTI_USER 
GO
ALTER DATABASE [personas.api] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [personas.api] SET DB_CHAINING OFF 
GO
ALTER DATABASE [personas.api] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [personas.api] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [personas.api] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [personas.api] SET QUERY_STORE = OFF
GO
USE [personas.api]
GO
/****** Object:  User [personaApi]    Script Date: 18/10/2022 22:36:35 ******/
CREATE USER [personaApi] FOR LOGIN [personaApi] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [personaApi]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageTemplate] [nvarchar](max) NULL,
	[Level] [nvarchar](128) NULL,
	[TimeStamp] [datetimeoffset](7) NOT NULL,
	[Exception] [nvarchar](max) NULL,
	[Properties] [xml] NULL,
	[LogEvent] [nvarchar](max) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](80) NOT NULL,
	[Codigo] [char](3) NOT NULL,
	[Iso] [char](2) NOT NULL,
 CONSTRAINT [PK_Paises] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](200) NULL,
	[Apellidos] [nvarchar](200) NULL,
	[TipoDocumentoId] [int] NOT NULL,
	[DocumentoNro] [varchar](10) NOT NULL,
	[PaisId] [int] NOT NULL,
	[TipoSexoId] [int] NOT NULL,
	[Edad] [int] NOT NULL,
	[FechaNacimiento] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[Telefono] [varchar](50) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonasContacto]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonasContacto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonaId] [int] NOT NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_PersonasContacto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonasParentezcos]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonasParentezcos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Persona1Id] [int] NULL,
	[Persona2Id] [int] NULL,
	[TipoParentezcoId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposDocumentos]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposDocumentos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [char](3) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TiposDocumentos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposParentezcos]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposParentezcos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposSexos]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposSexos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](10) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TiposSexos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Paises] ON 

INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (1, N'Aruba                                               ', N'ABW', N'AW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (2, N'Afghanistan                                         ', N'AFG', N'AF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (3, N'Angola                                              ', N'AGO', N'AO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (4, N'Anguilla                                            ', N'AIA', N'AI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (5, N'Albania                                             ', N'ALB', N'AL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (6, N'Andorra                                             ', N'AND', N'AD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (7, N'Netherlands Antilles                                ', N'ANT', N'AN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (8, N'United Arab Emirates                                ', N'ARE', N'AE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (9, N'Argentina                                           ', N'ARG', N'AR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (10, N'Armenia                                             ', N'ARM', N'AM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (11, N'American Samoa                                      ', N'ASM', N'AS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (12, N'Antarctica                                          ', N'ATA', N'AQ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (13, N'French Southern territories                         ', N'ATF', N'TF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (14, N'Antigua and Barbuda                                 ', N'ATG', N'AG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (15, N'Australia                                           ', N'AUS', N'AU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (16, N'Austria                                             ', N'AUT', N'AT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (17, N'Azerbaijan                                          ', N'AZE', N'AZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (18, N'Burundi                                             ', N'BDI', N'BI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (19, N'Belgium                                             ', N'BEL', N'BE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (20, N'Benin                                               ', N'BEN', N'BJ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (21, N'Burkina Faso                                        ', N'BFA', N'BF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (22, N'Bangladesh                                          ', N'BGD', N'BD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (23, N'Bulgaria                                            ', N'BGR', N'BG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (24, N'Bahrain                                             ', N'BHR', N'BH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (25, N'Bahamas                                             ', N'BHS', N'BS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (26, N'Bosnia and Herzegovina                              ', N'BIH', N'BA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (27, N'Belarus                                             ', N'BLR', N'BY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (28, N'Belize                                              ', N'BLZ', N'BZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (29, N'Bermuda                                             ', N'BMU', N'BM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (30, N'Bolivia                                             ', N'BOL', N'BO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (31, N'Brazil                                              ', N'BRA', N'BR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (32, N'Barbados                                            ', N'BRB', N'BB')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (33, N'Brunei                                              ', N'BRN', N'BN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (34, N'Bhutan                                              ', N'BTN', N'BT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (35, N'Bouvet Island                                       ', N'BVT', N'BV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (36, N'Botswana                                            ', N'BWA', N'BW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (37, N'Central African Republic                            ', N'CAF', N'CF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (38, N'Canada                                              ', N'CAN', N'CA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (39, N'Cocos (Keeling) Islands                             ', N'CCK', N'CC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (40, N'Switzerland                                         ', N'CHE', N'CH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (41, N'Chile                                               ', N'CHL', N'CL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (42, N'China                                               ', N'CHN', N'CN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (43, N'Côte d’Ivoire                                       ', N'CIV', N'CI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (44, N'Cameroon                                            ', N'CMR', N'CM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (45, N'Congo, The Democratic Republic of the               ', N'COD', N'CD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (46, N'Congo                                               ', N'COG', N'CG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (47, N'Cook Islands                                        ', N'COK', N'CK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (48, N'Colombia                                            ', N'COL', N'CO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (49, N'Comoros                                             ', N'COM', N'KM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (50, N'Cape Verde                                          ', N'CPV', N'CV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (51, N'Costa Rica                                          ', N'CRI', N'CR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (52, N'Cuba                                                ', N'CUB', N'CU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (53, N'Christmas Island                                    ', N'CXR', N'CX')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (54, N'Cayman Islands                                      ', N'CYM', N'KY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (55, N'Cyprus                                              ', N'CYP', N'CY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (56, N'Czech Republic                                      ', N'CZE', N'CZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (57, N'Germany                                             ', N'DEU', N'DE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (58, N'Djibouti                                            ', N'DJI', N'DJ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (59, N'Dominica                                            ', N'DMA', N'DM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (60, N'Denmark                                             ', N'DNK', N'DK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (61, N'Dominican Republic                                  ', N'DOM', N'DO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (62, N'Algeria                                             ', N'DZA', N'DZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (63, N'Ecuador                                             ', N'ECU', N'EC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (64, N'Egypt                                               ', N'EGY', N'EG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (65, N'Eritrea                                             ', N'ERI', N'ER')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (66, N'Western Sahara                                      ', N'ESH', N'EH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (67, N'Spain                                               ', N'ESP', N'ES')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (68, N'Estonia                                             ', N'EST', N'EE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (69, N'Ethiopia                                            ', N'ETH', N'ET')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (70, N'Finland                                             ', N'FIN', N'FI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (71, N'Fiji Islands                                        ', N'FJI', N'FJ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (72, N'Falkland Islands                                    ', N'FLK', N'FK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (73, N'France                                              ', N'FRA', N'FR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (74, N'Faroe Islands                                       ', N'FRO', N'FO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (75, N'Micronesia, Federated States of                     ', N'FSM', N'FM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (76, N'Gabon                                               ', N'GAB', N'GA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (77, N'United Kingdom                                      ', N'GBR', N'GB')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (78, N'Georgia                                             ', N'GEO', N'GE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (79, N'Ghana                                               ', N'GHA', N'GH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (80, N'Gibraltar                                           ', N'GIB', N'GI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (81, N'Guinea                                              ', N'GIN', N'GN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (82, N'Guadeloupe                                          ', N'GLP', N'GP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (83, N'Gambia                                              ', N'GMB', N'GM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (84, N'Guinea-Bissau                                       ', N'GNB', N'GW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (85, N'Equatorial Guinea                                   ', N'GNQ', N'GQ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (86, N'Greece                                              ', N'GRC', N'GR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (87, N'Grenada                                             ', N'GRD', N'GD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (88, N'Greenland                                           ', N'GRL', N'GL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (89, N'Guatemala                                           ', N'GTM', N'GT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (90, N'French Guiana                                       ', N'GUF', N'GF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (91, N'Guam                                                ', N'GUM', N'GU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (92, N'Guyana                                              ', N'GUY', N'GY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (93, N'Hong Kong                                           ', N'HKG', N'HK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (94, N'Heard Island and McDonald Islands                   ', N'HMD', N'HM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (95, N'Honduras                                            ', N'HND', N'HN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (96, N'Croatia                                             ', N'HRV', N'HR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (97, N'Haiti                                               ', N'HTI', N'HT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (98, N'Hungary                                             ', N'HUN', N'HU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (99, N'Indonesia                                           ', N'IDN', N'ID')
GO
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (100, N'India                                               ', N'IND', N'IN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (101, N'British Indian Ocean Territory                      ', N'IOT', N'IO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (102, N'Ireland                                             ', N'IRL', N'IE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (103, N'Iran                                                ', N'IRN', N'IR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (104, N'Iraq                                                ', N'IRQ', N'IQ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (105, N'Iceland                                             ', N'ISL', N'IS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (106, N'Israel                                              ', N'ISR', N'IL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (107, N'Italy                                               ', N'ITA', N'IT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (108, N'Jamaica                                             ', N'JAM', N'JM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (109, N'Jordan                                              ', N'JOR', N'JO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (110, N'Japan                                               ', N'JPN', N'JP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (111, N'Kazakstan                                           ', N'KAZ', N'KZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (112, N'Kenya                                               ', N'KEN', N'KE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (113, N'Kyrgyzstan                                          ', N'KGZ', N'KG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (114, N'Cambodia                                            ', N'KHM', N'KH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (115, N'Kiribati                                            ', N'KIR', N'KI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (116, N'Saint Kitts and Nevis                               ', N'KNA', N'KN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (117, N'South Korea                                         ', N'KOR', N'KR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (118, N'Kuwait                                              ', N'KWT', N'KW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (119, N'Laos                                                ', N'LAO', N'LA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (120, N'Lebanon                                             ', N'LBN', N'LB')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (121, N'Liberia                                             ', N'LBR', N'LR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (122, N'Libyan Arab Jamahiriya                              ', N'LBY', N'LY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (123, N'Saint Lucia                                         ', N'LCA', N'LC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (124, N'Liechtenstein                                       ', N'LIE', N'LI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (125, N'Sri Lanka                                           ', N'LKA', N'LK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (126, N'Lesotho                                             ', N'LSO', N'LS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (127, N'Lithuania                                           ', N'LTU', N'LT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (128, N'Luxembourg                                          ', N'LUX', N'LU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (129, N'Latvia                                              ', N'LVA', N'LV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (130, N'Macao                                               ', N'MAC', N'MO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (131, N'Morocco                                             ', N'MAR', N'MA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (132, N'Monaco                                              ', N'MCO', N'MC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (133, N'Moldova                                             ', N'MDA', N'MD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (134, N'Madagascar                                          ', N'MDG', N'MG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (135, N'Maldives                                            ', N'MDV', N'MV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (136, N'Mexico                                              ', N'MEX', N'MX')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (137, N'Marshall Islands                                    ', N'MHL', N'MH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (138, N'Macedonia                                           ', N'MKD', N'MK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (139, N'Mali                                                ', N'MLI', N'ML')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (140, N'Malta                                               ', N'MLT', N'MT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (141, N'Myanmar                                             ', N'MMR', N'MM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (142, N'Mongolia                                            ', N'MNG', N'MN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (143, N'Northern Mariana Islands                            ', N'MNP', N'MP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (144, N'Mozambique                                          ', N'MOZ', N'MZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (145, N'Mauritania                                          ', N'MRT', N'MR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (146, N'Montserrat                                          ', N'MSR', N'MS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (147, N'Martinique                                          ', N'MTQ', N'MQ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (148, N'Mauritius                                           ', N'MUS', N'MU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (149, N'Malawi                                              ', N'MWI', N'MW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (150, N'Malaysia                                            ', N'MYS', N'MY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (151, N'Mayotte                                             ', N'MYT', N'YT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (152, N'Namibia                                             ', N'NAM', N'NA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (153, N'New Caledonia                                       ', N'NCL', N'NC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (154, N'Niger                                               ', N'NER', N'NE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (155, N'Norfolk Island                                      ', N'NFK', N'NF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (156, N'Nigeria                                             ', N'NGA', N'NG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (157, N'Nicaragua                                           ', N'NIC', N'NI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (158, N'Niue                                                ', N'NIU', N'NU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (159, N'Netherlands                                         ', N'NLD', N'NL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (160, N'Norway                                              ', N'NOR', N'NO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (161, N'Nepal                                               ', N'NPL', N'NP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (162, N'Nauru                                               ', N'NRU', N'NR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (163, N'New Zealand                                         ', N'NZL', N'NZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (164, N'Oman                                                ', N'OMN', N'OM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (165, N'Pakistan                                            ', N'PAK', N'PK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (166, N'Panama                                              ', N'PAN', N'PA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (167, N'Pitcairn                                            ', N'PCN', N'PN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (168, N'Peru                                                ', N'PER', N'PE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (169, N'Philippines                                         ', N'PHL', N'PH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (170, N'Palau                                               ', N'PLW', N'PW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (171, N'Papua New Guinea                                    ', N'PNG', N'PG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (172, N'Poland                                              ', N'POL', N'PL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (173, N'Puerto Rico                                         ', N'PRI', N'PR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (174, N'North Korea                                         ', N'PRK', N'KP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (175, N'Portugal                                            ', N'PRT', N'PT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (176, N'Paraguay                                            ', N'PRY', N'PY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (177, N'Palestine                                           ', N'PSE', N'PS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (178, N'French Polynesia                                    ', N'PYF', N'PF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (179, N'Qatar                                               ', N'QAT', N'QA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (180, N'Réunion                                             ', N'REU', N'RE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (181, N'Romania                                             ', N'ROM', N'RO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (182, N'Russian Federation                                  ', N'RUS', N'RU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (183, N'Rwanda                                              ', N'RWA', N'RW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (184, N'Saudi Arabia                                        ', N'SAU', N'SA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (185, N'Sudan                                               ', N'SDN', N'SD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (186, N'Senegal                                             ', N'SEN', N'SN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (187, N'Singapore                                           ', N'SGP', N'SG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (188, N'South Georgia and the South Sandwich Islands        ', N'SGS', N'GS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (189, N'Saint Helena                                        ', N'SHN', N'SH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (190, N'Svalbard and Jan Mayen                              ', N'SJM', N'SJ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (191, N'Solomon Islands                                     ', N'SLB', N'SB')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (192, N'Sierra Leone                                        ', N'SLE', N'SL')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (193, N'El Salvador                                         ', N'SLV', N'SV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (194, N'San Marino                                          ', N'SMR', N'SM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (195, N'Somalia                                             ', N'SOM', N'SO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (196, N'Saint Pierre and Miquelon                           ', N'SPM', N'PM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (197, N'Sao Tome and Principe                               ', N'STP', N'ST')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (198, N'Suriname                                            ', N'SUR', N'SR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (199, N'Slovakia                                            ', N'SVK', N'SK')
GO
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (200, N'Slovenia                                            ', N'SVN', N'SI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (201, N'Sweden                                              ', N'SWE', N'SE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (202, N'Swaziland                                           ', N'SWZ', N'SZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (203, N'Seychelles                                          ', N'SYC', N'SC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (204, N'Syria                                               ', N'SYR', N'SY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (205, N'Turks and Caicos Islands                            ', N'TCA', N'TC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (206, N'Chad                                                ', N'TCD', N'TD')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (207, N'Togo                                                ', N'TGO', N'TG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (208, N'Thailand                                            ', N'THA', N'TH')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (209, N'Tajikistan                                          ', N'TJK', N'TJ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (210, N'Tokelau                                             ', N'TKL', N'TK')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (211, N'Turkmenistan                                        ', N'TKM', N'TM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (212, N'East Timor                                          ', N'TMP', N'TP')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (213, N'Tonga                                               ', N'TON', N'TO')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (214, N'Trinidad and Tobago                                 ', N'TTO', N'TT')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (215, N'Tunisia                                             ', N'TUN', N'TN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (216, N'Turkey                                              ', N'TUR', N'TR')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (217, N'Tuvalu                                              ', N'TUV', N'TV')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (218, N'Taiwan                                              ', N'TWN', N'TW')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (219, N'Tanzania                                            ', N'TZA', N'TZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (220, N'Uganda                                              ', N'UGA', N'UG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (221, N'Ukraine                                             ', N'UKR', N'UA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (222, N'United States Minor Outlying Islands                ', N'UMI', N'UM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (223, N'Uruguay                                             ', N'URY', N'UY')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (224, N'United States                                       ', N'USA', N'US')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (225, N'Uzbekistan                                          ', N'UZB', N'UZ')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (226, N'Holy See (Vatican City State)                       ', N'VAT', N'VA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (227, N'Saint Vincent and the Grenadines                    ', N'VCT', N'VC')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (228, N'Venezuela                                           ', N'VEN', N'VE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (229, N'Virgin Islands, British                             ', N'VGB', N'VG')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (230, N'Virgin Islands, U.S.                                ', N'VIR', N'VI')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (231, N'Vietnam                                             ', N'VNM', N'VN')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (232, N'Vanuatu                                             ', N'VUT', N'VU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (233, N'Wallis and Futuna                                   ', N'WLF', N'WF')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (234, N'Samoa                                               ', N'WSM', N'WS')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (235, N'Yemen                                               ', N'YEM', N'YE')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (236, N'Yugoslavia                                          ', N'YUG', N'YU')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (237, N'South Africa                                        ', N'ZAF', N'ZA')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (238, N'Zambia                                              ', N'ZMB', N'ZM')
INSERT [dbo].[Paises] ([Id], [Nombre], [Codigo], [Iso]) VALUES (239, N'Zimbabwe                                            ', N'ZWE', N'ZW')
SET IDENTITY_INSERT [dbo].[Paises] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposDocumentos] ON 

INSERT [dbo].[TiposDocumentos] ([Id], [Codigo], [Descripcion]) VALUES (1, N'DNI', N'Documento Nacional de Identidad')
INSERT [dbo].[TiposDocumentos] ([Id], [Codigo], [Descripcion]) VALUES (2, N'LC ', N'Libreta Cívica')
INSERT [dbo].[TiposDocumentos] ([Id], [Codigo], [Descripcion]) VALUES (3, N'LE ', N'Libreta de Enrolamiento')
INSERT [dbo].[TiposDocumentos] ([Id], [Codigo], [Descripcion]) VALUES (4, N'CI ', N'Cédula de Identidad')
INSERT [dbo].[TiposDocumentos] ([Id], [Codigo], [Descripcion]) VALUES (5, N'P  ', N'Pasaporte')
SET IDENTITY_INSERT [dbo].[TiposDocumentos] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposParentezcos] ON 

INSERT [dbo].[TiposParentezcos] ([Id], [Codigo], [Descripcion]) VALUES (1, N'P', N'Padre')
INSERT [dbo].[TiposParentezcos] ([Id], [Codigo], [Descripcion]) VALUES (2, N'HI', N'Hij@')
INSERT [dbo].[TiposParentezcos] ([Id], [Codigo], [Descripcion]) VALUES (3, N'HE', N'Herman@')
INSERT [dbo].[TiposParentezcos] ([Id], [Codigo], [Descripcion]) VALUES (4, N'TI', N'Ti@')
INSERT [dbo].[TiposParentezcos] ([Id], [Codigo], [Descripcion]) VALUES (5, N'PR', N'Prim@')
SET IDENTITY_INSERT [dbo].[TiposParentezcos] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposSexos] ON 

INSERT [dbo].[TiposSexos] ([Id], [Codigo], [Descripcion]) VALUES (1, N'M', N'Varon')
INSERT [dbo].[TiposSexos] ([Id], [Codigo], [Descripcion]) VALUES (2, N'F', N'Mujer')
SET IDENTITY_INSERT [dbo].[TiposSexos] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unq_persona]    Script Date: 18/10/2022 22:36:35 ******/
ALTER TABLE [dbo].[Personas] ADD  CONSTRAINT [unq_persona] UNIQUE NONCLUSTERED 
(
	[TipoDocumentoId] ASC,
	[DocumentoNro] ASC,
	[PaisId] ASC,
	[TipoSexoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_TiposDocumentos] FOREIGN KEY([TipoDocumentoId])
REFERENCES [dbo].[TiposDocumentos] ([Id])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_TiposDocumentos]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_TiposSexos] FOREIGN KEY([TipoSexoId])
REFERENCES [dbo].[TiposSexos] ([Id])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_TiposSexos]
GO
ALTER TABLE [dbo].[PersonasContacto]  WITH CHECK ADD  CONSTRAINT [FK_PersonasContacto_Personas] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Personas] ([Id])
GO
ALTER TABLE [dbo].[PersonasContacto] CHECK CONSTRAINT [FK_PersonasContacto_Personas]
GO
/****** Object:  StoredProcedure [dbo].[GetPersonaEstadistica]    Script Date: 18/10/2022 22:36:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Developer
-- Create date: 16/10/2022
-- Description:	Expone estadisticas: Cant. por sexo y porcentaje de argentinos
-- =============================================
CREATE PROCEDURE [dbo].[GetPersonaEstadistica]
AS
BEGIN	
	select 
		count( case when p.TipoSexoId = 2 then 2 end ) 'cantidad_mujeres',
		count( case when p.TipoSexoId = 1 then 1 end ) 'cantidad_hombres',
		(((select count(*) from Personas p2 where p2.PaisId=9) * 100) / count(Id)) 'porcentaje_argentinos'
	from Personas p
END
GO
USE [master]
GO
ALTER DATABASE [personas.api] SET  READ_WRITE 
GO
