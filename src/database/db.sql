-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-10-2021 a las 21:55:17
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectoss_script`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `ID_COMENT` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL,
  `ID_EXP` varchar(50) DEFAULT NULL,
  `comentario` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista`
--

CREATE TABLE `contratista` (
  `ID_CONT` int(11) NOT NULL,
  `ID_CONTN` int(11) NOT NULL,
  `CUIT` varchar(100) NOT NULL,
  `fecha_certificacion` date NOT NULL,
  `ID_REPR` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contratista`
--

INSERT INTO `contratista` (`ID_CONT`, `ID_CONTN`, `CUIT`, `fecha_certificacion`, `ID_REPR`) VALUES
(1, 1, '129370-1234A', '2021-09-22', NULL),
(4, 5, '123134', '2021-09-22', NULL),
(3, 2, '129370-1214A', '2021-09-28', NULL),
(5, 12, '123', '2021-09-02', 3),
(6, 14, '123', '2021-09-02', 5),
(7, 15, '1123', '2021-09-02', 6),
(8, 16, '1123', '2021-09-02', 7),
(9, 17, '1123', '2021-09-02', 8),
(10, 18, '1123', '2021-09-02', 9),
(11, 19, '1123', '2021-09-02', 10),
(12, 20, '123', '2021-09-15', 11),
(13, 21, '123', '2021-09-15', 12),
(14, 22, '123', '2021-09-15', 13),
(15, 23, '123', '2021-09-15', 14),
(16, 24, '123', '2021-09-15', 15),
(17, 25, '123', '2021-09-15', 16),
(18, 26, '123', '2021-09-15', 17),
(19, 27, '123', '2021-09-15', 18),
(20, 28, '123', '2021-09-15', 19),
(21, 29, '12312', '2021-09-08', 20),
(22, 30, '123', '2021-09-08', 21),
(23, 32, '1123', '2021-09-22', NULL),
(24, 33, '1237848709AASD:123', '2021-09-30', NULL),
(25, 34, '123', '2021-09-23', NULL),
(26, 35, '123', '2021-09-16', 22),
(27, 36, '123', '2021-09-16', 23),
(28, 37, '123', '2021-09-16', NULL),
(29, 38, '123', '2021-09-16', NULL),
(30, 39, '123', '2021-09-16', NULL),
(31, 40, '123', '2021-09-23', NULL),
(32, 41, '123', '2021-09-23', NULL),
(33, 42, '123', '2021-09-23', NULL),
(34, 43, '123', '2021-09-23', NULL),
(35, 44, '123', '2021-09-23', NULL),
(36, 45, '123', '2021-09-23', NULL),
(37, 46, '1237848709AASD:123', '2021-09-30', NULL),
(38, 47, '1237848709AASD:123', '2021-09-30', NULL),
(39, 48, '1237848709AASD:123', '2021-09-30', NULL),
(40, 49, '1237848709AASD:123', '2021-09-30', 24),
(41, 50, '123', '2021-09-09', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_domicilio`
--

CREATE TABLE `contratista_domicilio` (
  `ID_DOM` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contratista_domicilio`
--

INSERT INTO `contratista_domicilio` (`ID_DOM`, `ID_CONT`) VALUES
(1, 7),
(2, 8),
(3, 9),
(4, 10),
(5, 11),
(6, 12),
(7, 13),
(8, 14),
(9, 15),
(10, 16),
(11, 17),
(12, 18),
(13, 19),
(14, 20),
(15, 21),
(16, 22),
(17, 23),
(18, 24),
(19, 25),
(20, 26),
(21, 27),
(22, 28),
(23, 30),
(24, 31),
(25, 32),
(26, 33),
(27, 34),
(28, 35),
(29, 36),
(30, 37),
(31, 38),
(32, 39),
(33, 40),
(34, 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_nombre`
--

CREATE TABLE `contratista_nombre` (
  `ID_CONTN` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contratista_nombre`
--

INSERT INTO `contratista_nombre` (`ID_CONTN`, `nombre`, `apellido`) VALUES
(1, 'Alejandro', 'Ismael'),
(2, 'Arias Ricardo', 'Ismael'),
(3, '123', '123'),
(4, '123', '123'),
(5, '123', '123'),
(6, '123', '123'),
(7, '123', '123'),
(8, '123', '123'),
(9, '123', '123'),
(10, '123', '123'),
(11, '123', '123'),
(12, '123', '123'),
(13, '123', '123'),
(14, '123', '123'),
(15, '123', '123'),
(16, '123', '123'),
(17, '123', '123'),
(18, '123', '123'),
(19, '123', '123'),
(20, '123', '123'),
(21, '123', '123'),
(22, '123', '123'),
(23, '123', '123'),
(24, '123', '123'),
(25, '123', '123'),
(26, '123', '123'),
(27, '123', '123'),
(28, '123', '123'),
(29, '123', '3123'),
(30, '123', '123'),
(31, '123', '123'),
(32, '123', '123'),
(33, 'Pablo', 'German'),
(34, '123', '123'),
(35, '123', '123'),
(36, '123', '123'),
(37, '123', '123'),
(38, '123', '123'),
(39, '123', '123'),
(40, '123', '123'),
(41, '123', '123'),
(42, '123', '123'),
(43, '123', '123'),
(44, '123', '123'),
(45, '123', '123'),
(46, 'Pablo', 'German'),
(47, 'Pablo', 'German'),
(48, 'Pablo', 'German'),
(49, 'Pablo', 'German'),
(50, '123', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_telefono`
--

CREATE TABLE `contratista_telefono` (
  `ID_CONT` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contratista_telefono`
--

INSERT INTO `contratista_telefono` (`ID_CONT`, `ID_TEL`) VALUES
(7, 0),
(16, 2),
(17, 3),
(18, 4),
(19, 5),
(20, 6),
(21, 7),
(22, 8),
(23, 9),
(24, 10),
(24, 11),
(25, 12),
(25, 13),
(26, 14),
(26, 15),
(27, 16),
(27, 17),
(28, 18),
(34, 19),
(34, 20),
(35, 21),
(35, 22),
(36, 23),
(36, 24),
(37, 25),
(37, 26),
(38, 27),
(38, 28),
(39, 29),
(39, 30),
(40, 31),
(40, 32),
(41, 33),
(41, 34);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `con_email`
--

CREATE TABLE `con_email` (
  `ID_CONT` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `con_email`
--

INSERT INTO `con_email` (`ID_CONT`, `ID_EMAIL`) VALUES
(7, 1),
(8, 2),
(9, 3),
(10, 4),
(11, 5),
(12, 6),
(13, 7),
(14, 8),
(15, 9),
(16, 10),
(17, 11),
(18, 12),
(19, 13),
(20, 14),
(21, 15),
(22, 16),
(23, 17),
(24, 18),
(24, 19),
(25, 20),
(25, 21),
(26, 22),
(26, 23),
(27, 24),
(27, 25),
(28, 26),
(32, 27),
(32, 28),
(33, 29),
(33, 30),
(34, 31),
(34, 32),
(35, 33),
(35, 34),
(36, 35),
(36, 36),
(37, 37),
(37, 38),
(38, 39),
(38, 40),
(39, 41),
(39, 42),
(40, 43),
(40, 44),
(41, 45),
(41, 46);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `con_rub`
--

CREATE TABLE `con_rub` (
  `CONT_RUB` varchar(50) NOT NULL,
  `ID_RUBRO` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `con_rub`
--

INSERT INTO `con_rub` (`CONT_RUB`, `ID_RUBRO`, `ID_CONT`) VALUES
('7/1', 1, 7),
('7/2', 2, 7),
('7/3', 3, 7),
('7/4', 4, 7),
('7/10', 10, 7),
('7/11', 11, 7),
('7/6', 6, 7),
('7/7', 7, 7),
('7/5', 5, 7),
('7/13', 13, 7),
('7/8', 8, 7),
('7/9', 9, 7),
('7/12', 12, 7),
('22/12', 12, 22),
('38/2', 2, 38),
('38/4', 4, 38),
('38/8', 8, 38),
('39/2', 2, 39),
('40/2', 2, 40),
('40/3', 3, 40),
('40/4', 4, 40),
('40/7', 7, 40),
('41/10', 10, 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

CREATE TABLE `domicilio` (
  `ID_DOM` int(11) NOT NULL,
  `ID_LOCALIDAD` int(11) NOT NULL,
  `nmb_calle` varchar(45) NOT NULL,
  `nro_calle` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `domicilio`
--

INSERT INTO `domicilio` (`ID_DOM`, `ID_LOCALIDAD`, `nmb_calle`, `nro_calle`) VALUES
(1, 1, '123', 123),
(2, 1, '123', 123),
(3, 1, '123', 123),
(4, 1, '123', 123),
(5, 1, '123', 123),
(6, 2, '123', 123),
(7, 2, '123', 123),
(8, 2, '123', 123),
(9, 2, '123', 123),
(10, 2, '123', 123),
(11, 2, '123', 123),
(12, 2, '123', 123),
(13, 2, '123', 123),
(14, 2, '123', 123),
(15, 2, '123213', 123),
(16, 1, '123', 123),
(17, 1, '123', 123),
(18, 2, 'Direccion', 123),
(19, 1, 'Direccion', 123),
(20, 2, '123', 123),
(21, 2, '123', 123),
(22, 2, '123', 123),
(23, 2, '123', 123),
(24, 1, 'Direccion', 123),
(25, 1, 'Direccion', 123),
(26, 1, 'Direccion', 123),
(27, 1, 'Direccion', 123),
(28, 1, 'Direccion', 123),
(29, 1, 'Direccion', 123),
(30, 2, 'Direccion', 123),
(31, 2, 'Direccion', 123),
(32, 2, 'Direccion', 123),
(33, 2, 'Direccion', 123),
(34, 1, '123', 123),
(35, 2, '123', 123123),
(36, 2, '123', 123123),
(37, 2, '123', 123123),
(38, 2, '123', 123123),
(39, 2, '123', 123),
(40, 3, '123', 312),
(41, 1, '1', 1),
(42, 2, '123', 123);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `email`
--

CREATE TABLE `email` (
  `ID_EMAIL` int(11) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `email`
--

INSERT INTO `email` (`ID_EMAIL`, `email`) VALUES
(1, '123@123'),
(2, '123@123'),
(3, '123@123'),
(4, '123@123'),
(5, '123@123'),
(6, '123@123'),
(7, '123@123'),
(8, '123@123'),
(9, '123@123'),
(10, '123@123'),
(11, '123@123'),
(12, '123@123'),
(13, '123@123'),
(14, '123@123'),
(15, '123@123'),
(16, '123@123'),
(17, '123@123'),
(18, '123@123'),
(19, '123@123'),
(20, '123@123'),
(21, '123@123'),
(22, '123@123'),
(23, '123@123'),
(24, '123@123'),
(25, '123@123'),
(26, '123@123'),
(27, '123@123'),
(28, '123@123'),
(29, '123@123'),
(30, '123@123'),
(31, '123@123'),
(32, '123@123'),
(33, '123@123'),
(34, '123@123'),
(35, '123@123'),
(36, '123@123'),
(37, '123@123'),
(38, '123@123'),
(39, '123@123'),
(40, '123@123'),
(41, '123@123'),
(42, '123@123'),
(43, '123@123'),
(44, '123@123'),
(45, '123@123'),
(46, '123@123'),
(47, '123123'),
(48, '461237'),
(49, 'lolcuenta2000@gmail.com'),
(50, '123@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargados`
--

CREATE TABLE `encargados` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `ID_TIPOENC` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `encargados`
--

INSERT INTO `encargados` (`ID_ENCARGADO`, `nombre`, `apellido`, `ID_TIPOENC`) VALUES
(1, 'Director', 'ElGenio', 1),
(2, 'Director 2', 'Ismael', 1),
(3, 'Encargado ', 'Maestro', 2),
(4, 'Pablo', '123', 1),
(5, '123', '123', 2),
(6, 'Pablo', 'German', 2),
(7, 'Pablo', 'German', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enc_email`
--

CREATE TABLE `enc_email` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `enc_email`
--

INSERT INTO `enc_email` (`ID_ENCARGADO`, `ID_EMAIL`) VALUES
(4, 47),
(5, 48),
(6, 49),
(7, 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enc_tel`
--

CREATE TABLE `enc_tel` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `enc_tel`
--

INSERT INTO `enc_tel` (`ID_ENCARGADO`, `ID_TEL`) VALUES
(2, 35),
(4, 36),
(5, 37),
(6, 38),
(7, 47);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `ID_ESTADO` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expediente`
--

CREATE TABLE `expediente` (
  `ID_EXP` varchar(50) NOT NULL,
  `ID_NRORD` varchar(50) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `informe_tecnico` text DEFAULT NULL,
  `postpone_date` date DEFAULT NULL,
  `CUE` varchar(50) NOT NULL,
  `ID_ESTADO` int(11) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_OBRA` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_con`
--

CREATE TABLE `exp_con` (
  `NROEXP_CUIT` varchar(64) NOT NULL,
  `ID_CONT` int(11) NOT NULL,
  `ID_EXP` varchar(50) NOT NULL,
  `presupuesto_entregado` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_pk`
--

CREATE TABLE `exp_pk` (
  `ID_EXP` varchar(50) NOT NULL,
  `nro_expediente` int(11) NOT NULL,
  `anio_expediente` year(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fecha_garantia`
--

CREATE TABLE `fecha_garantia` (
  `ID_FECHA` int(11) NOT NULL,
  `ID_OBRA` int(11) NOT NULL,
  `fecha_garantia` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion`
--

CREATE TABLE `institucion` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `nombre_establecimiento` varchar(45) NOT NULL,
  `ID_MODALIDAD` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`CUE`, `ID_EST`, `nombre_establecimiento`, `ID_MODALIDAD`) VALUES
('0609217-00', 'JI 901', 'Jardin Magallanes', 1),
('0603132-00', 'JI 902', 'nose', 1),
('060311232-00', 'JI 903', 'nose', 1),
('1239487hASD', '123123', '123123', 5),
('1239487hASD12', '123123123', '123123', 6),
('1231', '2312', '3123', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_dom`
--

CREATE TABLE `inst_dom` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_DOM` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inst_dom`
--

INSERT INTO `inst_dom` (`CUE`, `ID_EST`, `ID_DOM`) VALUES
('1231', '2312', 42),
('1239487hASD', '123123', 37),
('1239487hASD12', '123123123', 40),
('1239487hASDD', '123123', 38),
('1239487hASDDD', '123123', 39),
('1239487hASDddd', '123123', 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_enc`
--

CREATE TABLE `inst_enc` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inst_enc`
--

INSERT INTO `inst_enc` (`CUE`, `ID_EST`, `ID_ENCARGADO`) VALUES
('0603132-00', 'JI 902', 2),
('0603132-00', 'JI 902', 3),
('0609217-00', 'JI 901', 1),
('1231', '2312', 2),
('1231', '2312', 3),
('1239487hASD', '123123', 2),
('1239487hASD12', '123123123', 2),
('1239487hASD12', '123123123', 5),
('1239487hASDD', '123123', 2),
('1239487hASDDD', '123123', 4),
('1239487hASDDD', '123123', 6),
('1239487hASDddd', '123123', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_tel`
--

CREATE TABLE `inst_tel` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inst_tel`
--

INSERT INTO `inst_tel` (`CUE`, `ID_EST`, `ID_TEL`) VALUES
('1231', '2312', 46),
('1239487hASD', '123123', 41),
('1239487hASD12', '123123123', 44),
('1239487hASDD', '123123', 42),
('1239487hASDDD', '123123', 43),
('1239487hASDddd', '123123', 45);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ins_email`
--

CREATE TABLE `ins_email` (
  `ID_EMAIL` int(11) NOT NULL,
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidad`
--

CREATE TABLE `localidad` (
  `ID_LOCALIDAD` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `localidad`
--

INSERT INTO `localidad` (`ID_LOCALIDAD`, `nombre`) VALUES
(1, 'Mar del Plata'),
(2, 'Batán'),
(3, 'Santa Clara'),
(4, 'Laguna de los Padres');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel_modalidad`
--

CREATE TABLE `nivel_modalidad` (
  `ID_MODALIDAD` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nivel_modalidad`
--

INSERT INTO `nivel_modalidad` (`ID_MODALIDAD`, `tipo`) VALUES
(1, 'Jardines'),
(2, 'Escuelas Primarias'),
(3, 'Escuelas Secundarias'),
(4, 'Escuelas Técnicas'),
(5, 'Adultos'),
(6, 'Especial'),
(7, 'Psicología');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nro_orden`
--

CREATE TABLE `nro_orden` (
  `ID_NRORD` varchar(50) NOT NULL,
  `nro_orden` int(11) NOT NULL,
  `mes_orden` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obra`
--

CREATE TABLE `obra` (
  `ID_OBRA` int(11) NOT NULL,
  `ID_ESTADO` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `ID_Contratacion` int(11) NOT NULL,
  `obra_realizada` text NOT NULL,
  `ID_FOND` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obra_monto`
--

CREATE TABLE `obra_monto` (
  `ID_MONTO` int(11) NOT NULL,
  `monto_letras` text DEFAULT NULL,
  `monto_numeros` int(11) NOT NULL,
  `ID_OBRA` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `representante`
--

CREATE TABLE `representante` (
  `ID_REPR` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `representante`
--

INSERT INTO `representante` (`ID_REPR`, `nombre`, `apellido`) VALUES
(1, '123', '123'),
(2, '123', '123'),
(3, '123', '123'),
(4, '123', '123'),
(5, '123', '123'),
(6, '123', '123'),
(7, '123', '123'),
(8, '123', '123'),
(9, '123', '123'),
(10, '123', '123'),
(11, '123', '123'),
(12, '123', '123'),
(13, '123', '123'),
(14, '123', '123'),
(15, '123', '123'),
(16, '123', '123'),
(17, '123', '123'),
(18, '123', '123'),
(19, '123', '123'),
(20, '123', '123'),
(21, '123', '123'),
(22, '123', '123'),
(23, '123', '123'),
(24, '123', '123'),
(25, '123', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `ID_ROL` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rubro`
--

CREATE TABLE `rubro` (
  `ID_RUBRO` int(11) NOT NULL,
  `Tipo` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rubro`
--

INSERT INTO `rubro` (`ID_RUBRO`, `Tipo`) VALUES
(1, 'Albañileria'),
(2, 'Calderas'),
(3, 'Calefacción'),
(4, 'Carpintería'),
(5, 'Cerrajería'),
(6, 'Instalación Eléctrica'),
(7, 'Instalación de Gas'),
(8, 'Instalación Sanitaria'),
(9, 'Herrería'),
(10, 'Pintura'),
(11, 'Techos'),
(12, 'Vidrios'),
(13, 'Yesería');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE `telefono` (
  `ID_TEL` int(11) NOT NULL,
  `telefono` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`ID_TEL`, `telefono`) VALUES
(1, '213'),
(2, '123'),
(3, '123'),
(4, '123'),
(5, '123'),
(6, '123'),
(7, '123'),
(8, '123'),
(9, '123'),
(10, '123123'),
(11, '123123'),
(12, '1111'),
(13, '1111'),
(14, '123'),
(15, '123'),
(16, '123'),
(17, '123'),
(18, '123'),
(19, '1111'),
(20, '1111'),
(21, '1111'),
(22, '1111'),
(23, '1111'),
(24, '1111'),
(25, '123123'),
(26, '123123'),
(27, '123123'),
(28, '123123'),
(29, '123123'),
(30, '123123'),
(31, '123123'),
(32, '123123'),
(33, '123'),
(34, '123'),
(35, '22355591283'),
(39, '123'),
(38, '12361263'),
(40, '123'),
(41, '123'),
(42, '123'),
(43, '4716236'),
(44, '123'),
(45, '1'),
(46, '123'),
(47, '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_contratacion`
--

CREATE TABLE `tipo_contratacion` (
  `ID_Contratacion` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_encargado`
--

CREATE TABLE `tipo_encargado` (
  `ID_TIPOENC` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_encargado`
--

INSERT INTO `tipo_encargado` (`ID_TIPOENC`, `tipo`) VALUES
(1, 'Director/a'),
(2, 'Inspector/a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_fondo`
--

CREATE TABLE `tipo_fondo` (
  `ID_FOND` int(11) NOT NULL,
  `tipo` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `ID_USER` int(11) NOT NULL,
  `ID_ROL` int(11) NOT NULL DEFAULT 1,
  `nombre` varchar(45) NOT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `user`
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
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`ID_COMENT`),
  ADD UNIQUE KEY `ID_COMENT` (`ID_COMENT`),
  ADD KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indices de la tabla `contratista`
--
ALTER TABLE `contratista`
  ADD PRIMARY KEY (`ID_CONT`),
  ADD UNIQUE KEY `ID_CONT` (`ID_CONT`),
  ADD KEY `ID_REPR` (`ID_REPR`),
  ADD KEY `ID_CONTN` (`ID_CONTN`);

--
-- Indices de la tabla `contratista_domicilio`
--
ALTER TABLE `contratista_domicilio`
  ADD PRIMARY KEY (`ID_DOM`,`ID_CONT`),
  ADD KEY `ID_CONT` (`ID_CONT`),
  ADD KEY `ID_DOM` (`ID_DOM`);

--
-- Indices de la tabla `contratista_nombre`
--
ALTER TABLE `contratista_nombre`
  ADD PRIMARY KEY (`ID_CONTN`),
  ADD UNIQUE KEY `ID_CONTN` (`ID_CONTN`);

--
-- Indices de la tabla `contratista_telefono`
--
ALTER TABLE `contratista_telefono`
  ADD PRIMARY KEY (`ID_CONT`,`ID_TEL`),
  ADD KEY `ID_TEL` (`ID_TEL`);

--
-- Indices de la tabla `con_email`
--
ALTER TABLE `con_email`
  ADD PRIMARY KEY (`ID_CONT`,`ID_EMAIL`),
  ADD KEY `ID_EMAIL` (`ID_EMAIL`);

--
-- Indices de la tabla `con_rub`
--
ALTER TABLE `con_rub`
  ADD PRIMARY KEY (`CONT_RUB`),
  ADD UNIQUE KEY `CUIT_RUB` (`CONT_RUB`),
  ADD KEY `ID_CONT` (`ID_CONT`),
  ADD KEY `ID_RUBRO` (`ID_RUBRO`);

--
-- Indices de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD PRIMARY KEY (`ID_DOM`),
  ADD UNIQUE KEY `ID_DOM_INS` (`ID_DOM`),
  ADD KEY `ID_LOCALIDAD` (`ID_LOCALIDAD`);

--
-- Indices de la tabla `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`ID_EMAIL`),
  ADD UNIQUE KEY `ID_EMAIL` (`ID_EMAIL`);

--
-- Indices de la tabla `encargados`
--
ALTER TABLE `encargados`
  ADD PRIMARY KEY (`ID_ENCARGADO`),
  ADD UNIQUE KEY `ID_ENCARGADO` (`ID_ENCARGADO`),
  ADD KEY `ID_TIPOENC` (`ID_TIPOENC`);

--
-- Indices de la tabla `enc_email`
--
ALTER TABLE `enc_email`
  ADD PRIMARY KEY (`ID_ENCARGADO`,`ID_EMAIL`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`,`ID_EMAIL`);

--
-- Indices de la tabla `enc_tel`
--
ALTER TABLE `enc_tel`
  ADD PRIMARY KEY (`ID_ENCARGADO`,`ID_TEL`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`,`ID_TEL`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`ID_ESTADO`),
  ADD UNIQUE KEY `ID_ESTADO` (`ID_ESTADO`);

--
-- Indices de la tabla `expediente`
--
ALTER TABLE `expediente`
  ADD PRIMARY KEY (`ID_EXP`),
  ADD UNIQUE KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `CUE` (`CUE`,`ID_EST`),
  ADD KEY `ID_OBRA` (`ID_OBRA`),
  ADD KEY `ID_ESTADO` (`ID_ESTADO`),
  ADD KEY `ID_NRORD` (`ID_NRORD`);

--
-- Indices de la tabla `exp_con`
--
ALTER TABLE `exp_con`
  ADD PRIMARY KEY (`NROEXP_CUIT`,`ID_CONT`,`ID_EXP`),
  ADD UNIQUE KEY `NROEXP_CUIT` (`NROEXP_CUIT`),
  ADD KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indices de la tabla `exp_pk`
--
ALTER TABLE `exp_pk`
  ADD PRIMARY KEY (`ID_EXP`),
  ADD UNIQUE KEY `ID_EXP` (`ID_EXP`);

--
-- Indices de la tabla `fecha_garantia`
--
ALTER TABLE `fecha_garantia`
  ADD PRIMARY KEY (`ID_FECHA`),
  ADD UNIQUE KEY `ID_FECHA` (`ID_FECHA`),
  ADD KEY `ID_OBRA` (`ID_OBRA`);

--
-- Indices de la tabla `institucion`
--
ALTER TABLE `institucion`
  ADD PRIMARY KEY (`CUE`,`ID_EST`),
  ADD UNIQUE KEY `CUE` (`CUE`),
  ADD UNIQUE KEY `ID_EST` (`ID_EST`),
  ADD KEY `ID_MODALIDAD` (`ID_MODALIDAD`);

--
-- Indices de la tabla `inst_dom`
--
ALTER TABLE `inst_dom`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_DOM`),
  ADD KEY `ID_DOM_INS` (`ID_DOM`),
  ADD KEY `CUE` (`CUE`,`ID_EST`);

--
-- Indices de la tabla `inst_enc`
--
ALTER TABLE `inst_enc`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_ENCARGADO`),
  ADD KEY `CUE` (`CUE`,`ID_EST`,`ID_ENCARGADO`);

--
-- Indices de la tabla `inst_tel`
--
ALTER TABLE `inst_tel`
  ADD PRIMARY KEY (`CUE`,`ID_EST`,`ID_TEL`),
  ADD KEY `ID_TEL` (`ID_TEL`);

--
-- Indices de la tabla `ins_email`
--
ALTER TABLE `ins_email`
  ADD PRIMARY KEY (`ID_EMAIL`,`CUE`,`ID_EST`),
  ADD KEY `CUE` (`CUE`,`ID_EST`);

--
-- Indices de la tabla `localidad`
--
ALTER TABLE `localidad`
  ADD PRIMARY KEY (`ID_LOCALIDAD`),
  ADD UNIQUE KEY `ID_LOCALIDAD` (`ID_LOCALIDAD`);

--
-- Indices de la tabla `nivel_modalidad`
--
ALTER TABLE `nivel_modalidad`
  ADD PRIMARY KEY (`ID_MODALIDAD`),
  ADD UNIQUE KEY `ID_MODALIDAD` (`ID_MODALIDAD`);

--
-- Indices de la tabla `nro_orden`
--
ALTER TABLE `nro_orden`
  ADD PRIMARY KEY (`ID_NRORD`),
  ADD UNIQUE KEY `ID_NRORD` (`ID_NRORD`);

--
-- Indices de la tabla `obra`
--
ALTER TABLE `obra`
  ADD PRIMARY KEY (`ID_OBRA`),
  ADD UNIQUE KEY `ID_OBRA` (`ID_OBRA`),
  ADD KEY `ID_ESTADO` (`ID_ESTADO`),
  ADD KEY `ID_Contratacion` (`ID_Contratacion`),
  ADD KEY `ID_FOND` (`ID_FOND`);

--
-- Indices de la tabla `obra_monto`
--
ALTER TABLE `obra_monto`
  ADD PRIMARY KEY (`ID_MONTO`),
  ADD KEY `ID_OBRA` (`ID_OBRA`);

--
-- Indices de la tabla `representante`
--
ALTER TABLE `representante`
  ADD PRIMARY KEY (`ID_REPR`),
  ADD UNIQUE KEY `ID_REPR` (`ID_REPR`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`ID_ROL`),
  ADD UNIQUE KEY `ID_ROL` (`ID_ROL`);

--
-- Indices de la tabla `rubro`
--
ALTER TABLE `rubro`
  ADD PRIMARY KEY (`ID_RUBRO`),
  ADD UNIQUE KEY `ID_RUBRO` (`ID_RUBRO`);

--
-- Indices de la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`ID_TEL`),
  ADD UNIQUE KEY `ID_TEL` (`ID_TEL`);

--
-- Indices de la tabla `tipo_contratacion`
--
ALTER TABLE `tipo_contratacion`
  ADD PRIMARY KEY (`ID_Contratacion`),
  ADD UNIQUE KEY `ID_Contratacion` (`ID_Contratacion`);

--
-- Indices de la tabla `tipo_encargado`
--
ALTER TABLE `tipo_encargado`
  ADD PRIMARY KEY (`ID_TIPOENC`),
  ADD UNIQUE KEY `ID_TIPOENC` (`ID_TIPOENC`);

--
-- Indices de la tabla `tipo_fondo`
--
ALTER TABLE `tipo_fondo`
  ADD PRIMARY KEY (`ID_FOND`),
  ADD UNIQUE KEY `ID_FOND` (`ID_FOND`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_USER`),
  ADD UNIQUE KEY `ID_USER` (`ID_USER`),
  ADD KEY `ID_ROL` (`ID_ROL`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `ID_COMENT` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contratista`
--
ALTER TABLE `contratista`
  MODIFY `ID_CONT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `contratista_nombre`
--
ALTER TABLE `contratista_nombre`
  MODIFY `ID_CONTN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `ID_DOM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `email`
--
ALTER TABLE `email`
  MODIFY `ID_EMAIL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `encargados`
--
ALTER TABLE `encargados`
  MODIFY `ID_ENCARGADO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `fecha_garantia`
--
ALTER TABLE `fecha_garantia`
  MODIFY `ID_FECHA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `localidad`
--
ALTER TABLE `localidad`
  MODIFY `ID_LOCALIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `nivel_modalidad`
--
ALTER TABLE `nivel_modalidad`
  MODIFY `ID_MODALIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `obra`
--
ALTER TABLE `obra`
  MODIFY `ID_OBRA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `obra_monto`
--
ALTER TABLE `obra_monto`
  MODIFY `ID_MONTO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `representante`
--
ALTER TABLE `representante`
  MODIFY `ID_REPR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `ID_ROL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rubro`
--
ALTER TABLE `rubro`
  MODIFY `ID_RUBRO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
  MODIFY `ID_TEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de la tabla `tipo_contratacion`
--
ALTER TABLE `tipo_contratacion`
  MODIFY `ID_Contratacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_encargado`
--
ALTER TABLE `tipo_encargado`
  MODIFY `ID_TIPOENC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_fondo`
--
ALTER TABLE `tipo_fondo`
  MODIFY `ID_FOND` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `ID_USER` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
