-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-12-2021 a las 20:58:22
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
-- Base de datos: `proyectoss_script_u`
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
  `ID_REPR` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_domicilio`
--

CREATE TABLE `contratista_domicilio` (
  `ID_DOM` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_nombre`
--

CREATE TABLE `contratista_nombre` (
  `ID_CONTN` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratista_telefono`
--

CREATE TABLE `contratista_telefono` (
  `ID_CONT` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `con_email`
--

CREATE TABLE `con_email` (
  `ID_CONT` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `con_rub`
--

CREATE TABLE `con_rub` (
  `CONT_RUB` varchar(50) NOT NULL,
  `ID_RUBRO` int(11) NOT NULL,
  `ID_CONT` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `email`
--

CREATE TABLE `email` (
  `ID_EMAIL` int(11) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enc_email`
--

CREATE TABLE `enc_email` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_EMAIL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enc_tel`
--

CREATE TABLE `enc_tel` (
  `ID_ENCARGADO` int(11) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `ID_ESTADO` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`ID_ESTADO`, `nombre`) VALUES
(1, 'En Cotización '),
(2, 'En Proceso '),
(3, 'Finalizada'),
(4, 'Sin Asignar ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expediente`
--

CREATE TABLE `expediente` (
  `ID_EXP` varchar(50) NOT NULL,
  `ID_NRORD` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `informe_tecnico` text DEFAULT NULL,
  `postpone_date` date DEFAULT NULL,
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_ESTADO` int(11) NOT NULL,
  `ID_OBRA` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_con`
--

CREATE TABLE `exp_con` (
  `ID_CONT` int(11) NOT NULL,
  `ID_EXP` varchar(50) NOT NULL,
  `presupuesto_entregado` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_pk`
--

CREATE TABLE `exp_pk` (
  `ID_EXP_AU` int(11) NOT NULL,
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
  `ID_MODALIDAD` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_dom`
--

CREATE TABLE `inst_dom` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_DOM` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_enc`
--

CREATE TABLE `inst_enc` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inst_tel`
--

CREATE TABLE `inst_tel` (
  `CUE` varchar(50) NOT NULL,
  `ID_EST` varchar(50) NOT NULL,
  `ID_TEL` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

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
  `ID_NRORD_AI` int(11) NOT NULL,
  `nro_orden` int(11) NOT NULL,
  `mes_orden` int(1) NOT NULL,
  `anio_orden` year(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obra`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `representante`
--

CREATE TABLE `representante` (
  `ID_REPR` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `ID_ROL` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`ID_ROL`, `nombre`) VALUES
(1, 'User'),
(2, 'Admin');

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
  `telefono` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_contratacion`
--

CREATE TABLE `tipo_contratacion` (
  `ID_CONTRATACION` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_contratacion`
--

INSERT INTO `tipo_contratacion` (`ID_CONTRATACION`, `nombre`) VALUES
(1, 'Directa '),
(2, 'A Cotizar ');

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
  `ID_FONDO` int(11) NOT NULL,
  `tipo` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_fondo`
--

INSERT INTO `tipo_fondo` (`ID_FONDO`, `tipo`) VALUES
(1, 'Cuff'),
(2, 'Compensador'),
(3, 'Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_oficina`
--

CREATE TABLE `tipo_oficina` (
  `ID_OFICINA` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_oficina`
--

INSERT INTO `tipo_oficina` (`ID_OFICINA`, `tipo`) VALUES
(1, 'Salud y seguridad'),
(2, 'Emergencia'),
(3, 'Sae'),
(4, 'Transporte'),
(5, 'Infraestructura ');

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
(10, 2, 'DepartamentoInfra123', '$2a$10$XNzelT6hJmPzpqNabKvCEuPV4LfRMEw4CtnOppP6aFwZR4VlggNHy');

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
  ADD KEY `ID_CONT` (`ID_CONT`);

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
  ADD PRIMARY KEY (`CONT_RUB`,`ID_RUBRO`,`ID_CONT`),
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
  ADD PRIMARY KEY (`ID_CONT`,`ID_EXP`),
  ADD KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_CONT` (`ID_CONT`);

--
-- Indices de la tabla `exp_pk`
--
ALTER TABLE `exp_pk`
  ADD PRIMARY KEY (`ID_EXP_AU`),
  ADD UNIQUE KEY `ID_EXP` (`ID_EXP`),
  ADD KEY `ID_EXP_AU` (`ID_EXP_AU`);

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
  ADD KEY `ID_DOM_INS` (`ID_DOM`);

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
  ADD PRIMARY KEY (`ID_NRORD_AI`),
  ADD UNIQUE KEY `ID_NRORD` (`ID_NRORD_AI`);

--
-- Indices de la tabla `obra`
--
ALTER TABLE `obra`
  ADD PRIMARY KEY (`ID_OBRA`),
  ADD UNIQUE KEY `ID_OBRA` (`ID_OBRA`),
  ADD KEY `ID_ESTADO` (`ID_ESTADO`),
  ADD KEY `ID_Contratacion` (`ID_CONTRATACION`),
  ADD KEY `ID_FOND` (`ID_FONDO`),
  ADD KEY `ID_OFICINA` (`ID_OFICINA`);

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
  ADD PRIMARY KEY (`ID_CONTRATACION`),
  ADD UNIQUE KEY `ID_Contratacion` (`ID_CONTRATACION`);

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
  ADD PRIMARY KEY (`ID_FONDO`),
  ADD UNIQUE KEY `ID_FOND` (`ID_FONDO`);

--
-- Indices de la tabla `tipo_oficina`
--
ALTER TABLE `tipo_oficina`
  ADD PRIMARY KEY (`ID_OFICINA`),
  ADD KEY `ID_OFICINA` (`ID_OFICINA`);

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
  MODIFY `ID_CONT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `contratista_nombre`
--
ALTER TABLE `contratista_nombre`
  MODIFY `ID_CONTN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `ID_DOM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `email`
--
ALTER TABLE `email`
  MODIFY `ID_EMAIL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `encargados`
--
ALTER TABLE `encargados`
  MODIFY `ID_ENCARGADO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `exp_pk`
--
ALTER TABLE `exp_pk`
  MODIFY `ID_EXP_AU` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `fecha_garantia`
--
ALTER TABLE `fecha_garantia`
  MODIFY `ID_FECHA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `localidad`
--
ALTER TABLE `localidad`
  MODIFY `ID_LOCALIDAD` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nivel_modalidad`
--
ALTER TABLE `nivel_modalidad`
  MODIFY `ID_MODALIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `nro_orden`
--
ALTER TABLE `nro_orden`
  MODIFY `ID_NRORD_AI` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `obra`
--
ALTER TABLE `obra`
  MODIFY `ID_OBRA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `representante`
--
ALTER TABLE `representante`
  MODIFY `ID_REPR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `ID_ROL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rubro`
--
ALTER TABLE `rubro`
  MODIFY `ID_RUBRO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
  MODIFY `ID_TEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tipo_contratacion`
--
ALTER TABLE `tipo_contratacion`
  MODIFY `ID_CONTRATACION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_encargado`
--
ALTER TABLE `tipo_encargado`
  MODIFY `ID_TIPOENC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_fondo`
--
ALTER TABLE `tipo_fondo`
  MODIFY `ID_FONDO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_oficina`
--
ALTER TABLE `tipo_oficina`
  MODIFY `ID_OFICINA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `ID_USER` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
