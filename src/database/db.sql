-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2021 at 12:00 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proyectoss_script`
--

-- --------------------------------------------------------

--
-- Table structure for table `comentarios`
--

CREATE TABLE `comentarios` (
  `ID_COMENT` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL,
  `ID_EXP` varchar(50) DEFAULT NULL,
  `comentario` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contratista`
--

CREATE TABLE `contratista` (
  `ID_CONT` int(11) NOT NULL,
  `ID_CONTN` int(11) NOT NULL,
  `CUIT` varchar(100) NOT NULL,
  `fecha_certificacion` date NOT NULL,
  `ID_REPR` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contratista`
--

INSERT INTO `contratista` (`ID_CONT`, `ID_CONTN`, `CUIT`, `fecha_certificacion`, `ID_REPR`, `activo`) VALUES
(1, 1, '129370-1234A', '2021-09-22', NULL, 0),
(4, 5, '123134', '2021-09-22', NULL, 0),
(3, 2, '129370-1214A', '2021-09-28', NULL, 1),
(5, 3, '1234ASASD', '2021-09-29', 1, 1),
(6, 4, '1234ASASD', '2021-09-29', 2, 1),
(7, 5, '1234ASASDFG', '2021-10-07', 3, 1),
(8, 6, '1234ASASDFG', '2021-10-07', 4, 1),
(9, 7, '1234ASASDFG', '2021-10-07', 5, 1),
(10, 9, '1234ASASDFG', '2021-10-07', 7, 1),
(11, 10, '1234ASASDFG', '2021-10-07', 8, 1),
(12, 11, '123456789', '2021-10-29', 9, 1),
(13, 12, '123123', '2021-10-14', 10, 1),
(14, 13, 'CUIT', '2021-10-06', 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `contratista_domicilio`
--

CREATE TABLE `contratista_domicilio` (
  `ID_DOM` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contratista_domicilio`
--

INSERT INTO `contratista_domicilio` (`ID_DOM`, `ID_CONT`) VALUES
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(8, 11),
(9, 12),
(10, 13),
(11, 14);

-- --------------------------------------------------------

--
-- Table structure for table `contratista_nombre`
--

CREATE TABLE `contratista_nombre` (
  `ID_CONTN` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contratista_nombre`
--

INSERT INTO `contratista_nombre` (`ID_CONTN`, `nombre`, `apellido`) VALUES
(1, 'Alejandro', 'Ismael'),
(2, 'Arias Ricardo', 'Ismael'),
(3, 'Nombre', 'Apellido'),
(4, 'Nombre', 'Apellido'),
(5, 'zjcdghausydgas', 'Apellido'),
(6, 'zjcdghausydgas', 'Apellido'),
(7, 'zjcdghausydgas', 'Apellido'),
(8, 'zjcdghausydgas', 'Apellido'),
(9, 'zjcdghausydgas', 'Apellido'),
(10, 'zjcdghausydgas', 'Apellido'),
(11, 'Nombre aHORA', 'Apellido Ahora'),
(12, 'Nombre aHORA', 'Apellido aHIRA'),
(13, 'NOMBRE ', 'APELLIDO');

-- --------------------------------------------------------

--
-- Table structure for table `contratista_telefono`
--

CREATE TABLE `contratista_telefono` (
  `ID_CONT` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contratista_telefono`
--

INSERT INTO `contratista_telefono` (`ID_CONT`, `ID_TEL`) VALUES
(6, 0),
(12, 4),
(12, 6),
(13, 7),
(13, 8),
(14, 9),
(14, 10);

-- --------------------------------------------------------

--
-- Table structure for table `con_email`
--

CREATE TABLE `con_email` (
  `ID_CONT` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `con_email`
--

INSERT INTO `con_email` (`ID_CONT`, `ID_EMAIL`) VALUES
(6, 2),
(7, 3),
(11, 8),
(12, 9),
(12, 10),
(13, 11),
(14, 12);

-- --------------------------------------------------------

--
-- Table structure for table `con_rub`
--

CREATE TABLE `con_rub` (
  `CONT_RUB` varchar(50) NOT NULL,
  `ID_RUBRO` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `con_rub`
--

INSERT INTO `con_rub` (`CONT_RUB`, `ID_RUBRO`, `ID_CONT`) VALUES
('11/10', 10, 11),
('11/6', 6, 11),
('13/3', 3, 13),
('14/10', 10, 14),
('14/11', 11, 14),
('14/12', 12, 14),
('14/13', 13, 14);

-- --------------------------------------------------------

--
-- Table structure for table `domicilio`
--

CREATE TABLE `domicilio` (
  `ID_DOM` int(11) NOT NULL,
  `ID_LOCALIDAD` int(11) NOT NULL,
  `nmb_calle` varchar(45) NOT NULL,
  `nro_calle` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `domicilio`
--

INSERT INTO `domicilio` (`ID_DOM`, `ID_LOCALIDAD`, `nmb_calle`, `nro_calle`) VALUES
(1, 3, 'Calle', 1123),
(2, 3, 'Calle', 1123),
(3, 2, 'Calle', 9),
(4, 2, 'Calle', 9),
(5, 2, 'Calle', 9),
(6, 2, 'Calle', 9),
(7, 2, 'Calle', 9),
(8, 2, 'Calle', 9),
(9, 2, 'Calle', 123),
(10, 3, 'Calle', 123),
(11, 3, 'Calle', 123),
(12, 4, 'Calle', 123),
(13, 4, 'Calle', 123),
(14, 2, '123', 123),
(15, 3, 'Calle', 123),
(16, 3, 'Calle', 123);

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `ID_EMAIL` int(11) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `email`
--

INSERT INTO `email` (`ID_EMAIL`, `email`) VALUES
(1, 'lolcuenta@gmail.com'),
(2, 'lolcuenta@gmail.com'),
(3, 'lolcuenta@gmail.com'),
(4, 'lolcuenta@gmail.com'),
(5, 'lolcuenta@gmail.com'),
(6, 'lolcuenta@gmail.com'),
(7, 'lolcuenta@gmail.com'),
(8, 'lolcuenta@gmail.com'),
(9, 'email@2'),
(10, 'lolcuenta@gmail.com'),
(11, 'lolcuenta@gmail.com12'),
(12, '123@AS.COM'),
(14, 'juaniyvalen1234@gmail.com'),
(15, 'juaniyvalen1234@gmail.com'),
(16, 'lolcuenta2000@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `encargados`
--

CREATE TABLE `encargados` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `ID_TIPOENC` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `encargados`
--

INSERT INTO `encargados` (`ID_ENCARGADO`, `nombre`, `apellido`, `ID_TIPOENC`) VALUES
(1, 'Director', 'Director Ape', 1),
(2, 'gangplank', 'gangplank', 1),
(3, 'GP INSPECTOR', 'GP INSPECTOR', 2);

-- --------------------------------------------------------

--
-- Table structure for table `enc_email`
--

CREATE TABLE `enc_email` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `enc_email`
--

INSERT INTO `enc_email` (`ID_ENCARGADO`, `ID_EMAIL`) VALUES
(1, 14),
(2, 15),
(3, 16);

-- --------------------------------------------------------

--
-- Table structure for table `enc_tel`
--

CREATE TABLE `enc_tel` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `enc_tel`
--

INSERT INTO `enc_tel` (`ID_ENCARGADO`, `ID_TEL`) VALUES
(1, 11),
(2, 16),
(3, 17);

-- --------------------------------------------------------

--
-- Table structure for table `estado`
--

CREATE TABLE `estado` (
  `ID_ESTADO` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `expediente`
--

CREATE TABLE `expediente` (
  `ID_EXP` varchar(50) NOT NULL,
  `ID_NRORD` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `informe_tecnico` text,
  `postpone_date` date DEFAULT NULL,
  `CUE` varchar(50) NOT NULL,
  `ID_ESTADO` int(11) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_OBRA` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expediente`
--

INSERT INTO `expediente` (`ID_EXP`, `ID_NRORD`, `fecha_pedido`, `informe_tecnico`, `postpone_date`, `CUE`, `ID_ESTADO`, `ID_EST`, `ID_OBRA`) VALUES
('3|2021', 2, '2021-10-31', '      No se                                                                                                         \r\n\r\n                ', NULL, '123123213123', 1, '123123123', 1),
('5|2021', 4, '2021-10-31', '    DIcen que el tran                                                                                                        \r\n\r\n                ', NULL, '1231234', 1, 'ESTIDD', 3);

-- --------------------------------------------------------

--
-- Table structure for table `exp_con`
--

CREATE TABLE `exp_con` (
  `ID_CONT` int(11) NOT NULL,
  `ID_EXP` varchar(50) NOT NULL,
  `presupuesto_entregado` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exp_con`
--

INSERT INTO `exp_con` (`ID_CONT`, `ID_EXP`, `presupuesto_entregado`) VALUES
(1, '3|2021', 621000),
(13, '5|2021', 200000);

-- --------------------------------------------------------

--
-- Table structure for table `exp_pk`
--

CREATE TABLE `exp_pk` (
  `ID_EXP_AU` int(11) NOT NULL,
  `ID_EXP` varchar(50) NOT NULL,
  `nro_expediente` int(11) NOT NULL,
  `anio_expediente` year(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exp_pk`
--

INSERT INTO `exp_pk` (`ID_EXP_AU`, `ID_EXP`, `nro_expediente`, `anio_expediente`) VALUES
(1, '1|2021', 1, 2021),
(2, '2|2021', 2, 2021),
(3, '3|2021', 3, 2021),
(4, '4|2021', 4, 2021),
(5, '5|2021', 5, 2021);

-- --------------------------------------------------------

--
-- Table structure for table `fecha_garantia`
--

CREATE TABLE `fecha_garantia` (
  `ID_FECHA` int(11) NOT NULL,
  `ID_OBRA` int(11) NOT NULL,
  `fecha_garantia` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `institucion`
--

CREATE TABLE `institucion` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `nombre_establecimiento` varchar(45) NOT NULL,
  `ID_MODALIDAD` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `institucion`
--

INSERT INTO `institucion` (`CUE`, `ID_EST`, `nombre_establecimiento`, `ID_MODALIDAD`, `activo`) VALUES
('123123', 'ESTID', 'Nomb est', 2, 1),
('1231234', 'ESTIDD', 'Nomb est', 2, 1),
('123123213123', '123123123', '123', 6, 1),
('CUE', 'EST AID', 'Nomb est', 5, 1),
('123123asd1q', 'ESTIDD123', 'Nomb est', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inst_dom`
--

CREATE TABLE `inst_dom` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_DOM` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inst_dom`
--

INSERT INTO `inst_dom` (`CUE`, `ID_EST`, `ID_DOM`) VALUES
('123123', 'ESTID', 12),
('123123213123', '123123123', 14),
('1231234', 'ESTIDD', 13),
('123123asd1q', 'ESTIDD123', 16),
('CUE', 'EST AID', 15);

-- --------------------------------------------------------

--
-- Table structure for table `inst_enc`
--

CREATE TABLE `inst_enc` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `inst_enc`
--

INSERT INTO `inst_enc` (`CUE`, `ID_EST`, `ID_ENCARGADO`) VALUES
('123123asd1q', 'ESTIDD123', 2),
('123123asd1q', 'ESTIDD123', 3);

-- --------------------------------------------------------

--
-- Table structure for table `inst_tel`
--

CREATE TABLE `inst_tel` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inst_tel`
--

INSERT INTO `inst_tel` (`CUE`, `ID_EST`, `ID_TEL`) VALUES
('123123', 'ESTID', 12),
('123123213123', '123123123', 14),
('1231234', 'ESTIDD', 13),
('123123asd1q', 'ESTIDD123', 18),
('CUE', 'EST AID', 15);

-- --------------------------------------------------------

--
-- Table structure for table `ins_email`
--

CREATE TABLE `ins_email` (
  `ID_EMAIL` int(11) NOT NULL,
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `localidad`
--

CREATE TABLE `localidad` (
  `ID_LOCALIDAD` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `nivel_modalidad`
--

CREATE TABLE `nivel_modalidad` (
  `ID_MODALIDAD` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `nro_orden`
--

CREATE TABLE `nro_orden` (
  `ID_NRORD_AI` int(11) NOT NULL,
  `nro_orden` int(11) NOT NULL,
  `mes_orden` int(1) NOT NULL,
  `anio_orden` year(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nro_orden`
--

INSERT INTO `nro_orden` (`ID_NRORD_AI`, `nro_orden`, `mes_orden`, `anio_orden`) VALUES
(1, 1, 1, 2021),
(2, 2, 1, 2021),
(3, 3, 1, 2021),
(4, 4, 1, 2021);

-- --------------------------------------------------------

--
-- Table structure for table `obra`
--

CREATE TABLE `obra` (
  `ID_OBRA` int(11) NOT NULL,
  `ID_ESTADO` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `monto_numeros` int(11) NOT NULL,
  `ID_CONTRATACION` int(11) NOT NULL,
  `obra_realizada` text NOT NULL,
  `ID_FONDO` int(11) NOT NULL,
  `ID_OFICINA` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `obra`
--

INSERT INTO `obra` (`ID_OBRA`, `ID_ESTADO`, `fecha_contrato`, `monto_numeros`, `ID_CONTRATACION`, `obra_realizada`, `ID_FONDO`, `ID_OFICINA`) VALUES
(1, 1, '2021-10-31', 471263, 1, '                                                                                                               \r\nNo se\r\n                ', 1, 2),
(2, 1, '2021-10-31', 5712378, 2, '                                                                                                               \r\nqweqwe\r\n                ', 2, 3),
(3, 1, '2021-10-31', 5712378, 2, '                                                                                                               \r\nqweqwe\r\n                ', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `representante`
--

CREATE TABLE `representante` (
  `ID_REPR` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `representante`
--

INSERT INTO `representante` (`ID_REPR`, `nombre`, `apellido`) VALUES
(1, '1234', '12314'),
(2, '1234', '12314'),
(3, '1234', '12314'),
(4, '1234', '12314'),
(5, '1234', '12314'),
(6, '1234', '12314'),
(7, '1234', '12314'),
(8, '1234', '12314'),
(9, 'nOMBRE rEPRE', 'Apellido Repre'),
(10, '123', '123'),
(11, '123', '123');

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `ID_ROL` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rubro`
--

CREATE TABLE `rubro` (
  `ID_RUBRO` int(11) NOT NULL,
  `Tipo` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `telefono`
--

CREATE TABLE `telefono` (
  `ID_TEL` int(11) NOT NULL,
  `telefono` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `telefono`
--

INSERT INTO `telefono` (`ID_TEL`, `telefono`) VALUES
(1, 1234),
(2, 890706),
(3, 890706),
(4, 654321),
(5, 123456),
(6, 213),
(7, 123),
(8, 123),
(9, 123),
(10, 123),
(11, 47626513),
(12, 476126),
(13, 476126),
(14, 123),
(15, 123),
(16, 47626513),
(17, 123),
(18, 123);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_contratacion`
--

CREATE TABLE `tipo_contratacion` (
  `ID_CONTRATACION` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tipo_encargado`
--

CREATE TABLE `tipo_encargado` (
  `ID_TIPOENC` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tipo_fondo`
--

CREATE TABLE `tipo_fondo` (
  `ID_FONDO` int(11) NOT NULL,
  `tipo` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tipo_oficina`
--

CREATE TABLE `tipo_oficina` (
  `ID_OFICINA` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipo_oficina`
--

INSERT INTO `tipo_oficina` (`ID_OFICINA`, `tipo`) VALUES
(1, 'Infraestructura'),
(2, 'Infraestructura'),
(3, 'Vidrios'),
(4, 'Vidrios');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID_USER` int(11) NOT NULL,
  `ID_ROL` int(11) NOT NULL DEFAULT '1',
  `nombre` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID_USER`, `ID_ROL`, `nombre`, `password`) VALUES
(1, 1, 'Prueba', '$2a$10$dBbPPHcwvjfo4PwJKjHPFOFBCtXknEyVWxyC0t'),
(2, 1, 'Pruebaa', '$2a$10$W32RnodoW4UQVjwMDsdFheB8SZpi0NWylWu0qN'),
(3, 1, 'Pruebaaa', '$2a$10$dNpN8i8uB0Uf387opM7bPudqvGJ0wapgI5Y.RE'),
(4, 1, 'Pruebaaaa', '$2a$10$/Bgf4kle3s25J4.pulrutunfMno0nVr3.XHwoX'),
(5, 1, 'a', '$2a$10$QrH8tN6ooKBijfe7y0HLp.wNivENMYYubyTeJ1'),
(6, 1, 'b', '$2a$10$6zI8V3BV7WYCSxCrsGbd0uOU/Dw.4RBk6Kx7aU'),
(7, 1, 'c', '$2a$10$BRYGDMhaMyh8EAIr9j4QU.Q49po1qVX9R1iIJh'),
(8, 1, 'd', '$2a$10$TAeSKr5bzqfi/rLmUnenyeKsFrffFDXvfl09ki'),
(9, 2, 'Prueb', '$2a$10$ZodZU5aZC9JLFsDmRjgg1OfGCHtd8jKeed.JWmP.6CrmoL.ZPVGOG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`ID_COMENT`),
  ADD UNIQUE KEY `ID_COMENT` (`ID_COMENT`),
  ADD KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indexes for table `contratista`
--
ALTER TABLE `contratista`
  ADD PRIMARY KEY (`ID_CONT`),
  ADD UNIQUE KEY `ID_CONT` (`ID_CONT`),
  ADD KEY `ID_REPR` (`ID_REPR`),
  ADD KEY `ID_CONTN` (`ID_CONTN`);

--
-- Indexes for table `contratista_domicilio`
--
ALTER TABLE `contratista_domicilio`
  ADD PRIMARY KEY (`ID_DOM`,`ID_CONT`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indexes for table `contratista_nombre`
--
ALTER TABLE `contratista_nombre`
  ADD PRIMARY KEY (`ID_CONTN`),
  ADD UNIQUE KEY `ID_CONTN` (`ID_CONTN`);

--
-- Indexes for table `contratista_telefono`
--
ALTER TABLE `contratista_telefono`
  ADD PRIMARY KEY (`ID_CONT`,`ID_TEL`),
  ADD KEY `ID_TEL` (`ID_TEL`);

--
-- Indexes for table `con_email`
--
ALTER TABLE `con_email`
  ADD PRIMARY KEY (`ID_CONT`,`ID_EMAIL`),
  ADD KEY `ID_EMAIL` (`ID_EMAIL`);

--
-- Indexes for table `con_rub`
--
ALTER TABLE `con_rub`
  ADD PRIMARY KEY (`CONT_RUB`,`ID_RUBRO`,`ID_CONT`),
  ADD UNIQUE KEY `CUIT_RUB` (`CONT_RUB`),
  ADD KEY `ID_CONT` (`ID_CONT`),
  ADD KEY `ID_RUBRO` (`ID_RUBRO`);

--
-- Indexes for table `domicilio`
--
ALTER TABLE `domicilio`
  ADD PRIMARY KEY (`ID_DOM`),
  ADD UNIQUE KEY `ID_DOM_INS` (`ID_DOM`),
  ADD KEY `ID_LOCALIDAD` (`ID_LOCALIDAD`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`ID_EMAIL`),
  ADD UNIQUE KEY `ID_EMAIL` (`ID_EMAIL`);

--
-- Indexes for table `encargados`
--
ALTER TABLE `encargados`
  ADD PRIMARY KEY (`ID_ENCARGADO`),
  ADD UNIQUE KEY `ID_ENCARGADO` (`ID_ENCARGADO`),
  ADD KEY `ID_TIPOENC` (`ID_TIPOENC`);

--
-- Indexes for table `enc_email`
--
ALTER TABLE `enc_email`
  ADD PRIMARY KEY (`ID_ENCARGADO`,`ID_EMAIL`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`,`ID_EMAIL`);

--
-- Indexes for table `enc_tel`
--
ALTER TABLE `enc_tel`
  ADD PRIMARY KEY (`ID_ENCARGADO`,`ID_TEL`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`,`ID_TEL`);

--
-- Indexes for table `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`ID_ESTADO`),
  ADD UNIQUE KEY `ID_ESTADO` (`ID_ESTADO`);

--
-- Indexes for table `expediente`
--
ALTER TABLE `expediente`
  ADD PRIMARY KEY (`ID_EXP`),
  ADD UNIQUE KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `CUE` (`CUE`,`ID_EST`),
  ADD KEY `ID_OBRA` (`ID_OBRA`),
  ADD KEY `ID_ESTADO` (`ID_ESTADO`),
  ADD KEY `ID_NRORD` (`ID_NRORD`);

--
-- Indexes for table `exp_con`
--
ALTER TABLE `exp_con`
  ADD PRIMARY KEY (`ID_CONT`,`ID_EXP`),
  ADD KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indexes for table `exp_pk`
--
ALTER TABLE `exp_pk`
  ADD PRIMARY KEY (`ID_EXP_AU`),
  ADD UNIQUE KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_EXP_AU` (`ID_EXP_AU`);

--
-- Indexes for table `fecha_garantia`
--
ALTER TABLE `fecha_garantia`
  ADD PRIMARY KEY (`ID_FECHA`),
  ADD UNIQUE KEY `ID_FECHA` (`ID_FECHA`),
  ADD KEY `ID_OBRA` (`ID_OBRA`);

--
-- Indexes for table `institucion`
--
ALTER TABLE `institucion`
  ADD PRIMARY KEY (`CUE`,`ID_EST`),
  ADD UNIQUE KEY `CUE` (`CUE`),
  ADD UNIQUE KEY `ID_EST` (`ID_EST`),
  ADD KEY `ID_MODALIDAD` (`ID_MODALIDAD`);

--
-- Indexes for table `inst_dom`
--
ALTER TABLE `inst_dom`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_DOM`),
  ADD KEY `ID_DOM_INS` (`ID_DOM`);

--
-- Indexes for table `inst_enc`
--
ALTER TABLE `inst_enc`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_ENCARGADO`),
  ADD KEY `CUE` (`CUE`,`ID_EST`,`ID_ENCARGADO`);

--
-- Indexes for table `inst_tel`
--
ALTER TABLE `inst_tel`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_TEL`),
  ADD KEY `ID_TEL` (`ID_TEL`);

--
-- Indexes for table `ins_email`
--
ALTER TABLE `ins_email`
  ADD PRIMARY KEY (`ID_EMAIL`,`CUE`,`ID_EST`),
  ADD KEY `CUE` (`CUE`,`ID_EST`);

--
-- Indexes for table `localidad`
--
ALTER TABLE `localidad`
  ADD PRIMARY KEY (`ID_LOCALIDAD`),
  ADD UNIQUE KEY `ID_LOCALIDAD` (`ID_LOCALIDAD`);

--
-- Indexes for table `nivel_modalidad`
--
ALTER TABLE `nivel_modalidad`
  ADD PRIMARY KEY (`ID_MODALIDAD`),
  ADD UNIQUE KEY `ID_MODALIDAD` (`ID_MODALIDAD`);

--
-- Indexes for table `nro_orden`
--
ALTER TABLE `nro_orden`
  ADD PRIMARY KEY (`ID_NRORD_AI`),
  ADD UNIQUE KEY `ID_NRORD` (`ID_NRORD_AI`);

--
-- Indexes for table `obra`
--
ALTER TABLE `obra`
  ADD PRIMARY KEY (`ID_OBRA`),
  ADD UNIQUE KEY `ID_OBRA` (`ID_OBRA`),
  ADD KEY `ID_ESTADO` (`ID_ESTADO`),
  ADD KEY `ID_Contratacion` (`ID_CONTRATACION`),
  ADD KEY `ID_FOND` (`ID_FONDO`),
  ADD KEY `ID_OFICINA` (`ID_OFICINA`);

--
-- Indexes for table `representante`
--
ALTER TABLE `representante`
  ADD PRIMARY KEY (`ID_REPR`),
  ADD UNIQUE KEY `ID_REPR` (`ID_REPR`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`ID_ROL`),
  ADD UNIQUE KEY `ID_ROL` (`ID_ROL`);

--
-- Indexes for table `rubro`
--
ALTER TABLE `rubro`
  ADD PRIMARY KEY (`ID_RUBRO`),
  ADD UNIQUE KEY `ID_RUBRO` (`ID_RUBRO`);

--
-- Indexes for table `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`ID_TEL`),
  ADD UNIQUE KEY `ID_TEL` (`ID_TEL`);

--
-- Indexes for table `tipo_contratacion`
--
ALTER TABLE `tipo_contratacion`
  ADD PRIMARY KEY (`ID_CONTRATACION`),
  ADD UNIQUE KEY `ID_Contratacion` (`ID_CONTRATACION`);

--
-- Indexes for table `tipo_encargado`
--
ALTER TABLE `tipo_encargado`
  ADD PRIMARY KEY (`ID_TIPOENC`),
  ADD UNIQUE KEY `ID_TIPOENC` (`ID_TIPOENC`);

--
-- Indexes for table `tipo_fondo`
--
ALTER TABLE `tipo_fondo`
  ADD PRIMARY KEY (`ID_FONDO`),
  ADD UNIQUE KEY `ID_FOND` (`ID_FONDO`);

--
-- Indexes for table `tipo_oficina`
--
ALTER TABLE `tipo_oficina`
  ADD PRIMARY KEY (`ID_OFICINA`),
  ADD KEY `ID_OFICINA` (`ID_OFICINA`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_USER`),
  ADD UNIQUE KEY `ID_USER` (`ID_USER`),
  ADD KEY `ID_ROL` (`ID_ROL`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `ID_COMENT` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contratista`
--
ALTER TABLE `contratista`
  MODIFY `ID_CONT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contratista_nombre`
--
ALTER TABLE `contratista_nombre`
  MODIFY `ID_CONTN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `ID_DOM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `ID_EMAIL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `encargados`
--
ALTER TABLE `encargados`
  MODIFY `ID_ENCARGADO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `exp_pk`
--
ALTER TABLE `exp_pk`
  MODIFY `ID_EXP_AU` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fecha_garantia`
--
ALTER TABLE `fecha_garantia`
  MODIFY `ID_FECHA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `localidad`
--
ALTER TABLE `localidad`
  MODIFY `ID_LOCALIDAD` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nivel_modalidad`
--
ALTER TABLE `nivel_modalidad`
  MODIFY `ID_MODALIDAD` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nro_orden`
--
ALTER TABLE `nro_orden`
  MODIFY `ID_NRORD_AI` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `obra`
--
ALTER TABLE `obra`
  MODIFY `ID_OBRA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `representante`
--
ALTER TABLE `representante`
  MODIFY `ID_REPR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rol`
--
ALTER TABLE `rol`
  MODIFY `ID_ROL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rubro`
--
ALTER TABLE `rubro`
  MODIFY `ID_RUBRO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `telefono`
--
ALTER TABLE `telefono`
  MODIFY `ID_TEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tipo_contratacion`
--
ALTER TABLE `tipo_contratacion`
  MODIFY `ID_CONTRATACION` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_encargado`
--
ALTER TABLE `tipo_encargado`
  MODIFY `ID_TIPOENC` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_fondo`
--
ALTER TABLE `tipo_fondo`
  MODIFY `ID_FONDO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_oficina`
--
ALTER TABLE `tipo_oficina`
  MODIFY `ID_OFICINA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID_USER` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
