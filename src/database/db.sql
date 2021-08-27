-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-08-2021 a las 01:31:38
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
-- Base de datos: `mercado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `problems`
--

CREATE TABLE `problems` (
  `ID_PROBLEM` int(20) NOT NULL,
  `ID_USER` int(20) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `problem` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `problems`
--

INSERT INTO `problems` (`ID_PROBLEM`, `ID_USER`, `name`, `problem`, `created_at`) VALUES
(15, NULL, 'aaaaaaaaaaaaaaaaaaaa', ' AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\r\n    NASHEAAAAAAAAEEEE', '2021-08-16 19:57:28'),
(16, NULL, 'Moneda', ' \r\n         No\r\n    \r\n    ', '2021-08-16 20:10:09'),
(17, NULL, 'membrillo', ' \r\n    sexo', '2021-08-17 19:16:26'),
(18, NULL, 'aaa', ' \r\n    aaa', '2021-08-17 19:42:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `Cod_Pro` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Precio` float NOT NULL,
  `Rubro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`Cod_Pro`, `Nombre`, `Precio`, `Rubro`) VALUES
(1, 'Moneda', 1.05, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `ID` int(20) UNSIGNED NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`ID`, `Nombre`) VALUES
(1, 'Pedidor'),
(2, 'Resultor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rubros`
--

CREATE TABLE `rubros` (
  `ID` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rubros`
--

INSERT INTO `rubros` (`ID`, `Descripcion`, `Nombre`) VALUES
(1, 'Es un cajero', 'Cajero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Rol` int(11) UNSIGNED NOT NULL,
  `Email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`ID`, `Nombre`, `Rol`, `Email`, `password`) VALUES
(10, 'Moneda', 1, 'lolcuenta2000@gmail.com', '$2a$10$IYq6q6FIp8m0DYSNpsYSj.gqPJlxOW7wbtEkygLw5SaUkVnH.Tjvm'),
(14, 'Moneda', 1, 'lolcuenta@gmail.com', '$2a$10$GDkfe0i8sMjg.EGRH2aRVOe5hQJY4w5Q/o7cVlwoF/kY/gJjlyV56'),
(15, 'Moneda', 1, 'lolcuena@gmail.com', '$2a$10$LQlJgIRyi7w4hmCoL7Yr5evMzIviJaC7n8IGPHtFk1r2VdjkQj0Vq'),
(16, 'Moneda', 1, 'locuena@gmail.com', '$2a$10$VSY28Tn42Kvp5mX/C.UNN.ivWKc23wBhjmi/XVjAvzyoxiPoHD.bS'),
(17, 'Moneda', 1, 'locueAna@gmail.com', '$2a$10$VBuW49ppr/fWS3k2d34yceR5YFxihr6mSNDGJ97BZNmWBp8Rs0R8K');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `problems`
--
ALTER TABLE `problems`
  ADD PRIMARY KEY (`ID_PROBLEM`),
  ADD KEY `ID_USER` (`ID_USER`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`Cod_Pro`),
  ADD KEY `Rubro` (`Rubro`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `rubros`
--
ALTER TABLE `rubros`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `Rol` (`Rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `problems`
--
ALTER TABLE `problems`
  MODIFY `ID_PROBLEM` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `Cod_Pro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `ID` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `rubros`
--
ALTER TABLE `rubros`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`Rubro`) REFERENCES `rubros` (`ID`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Rol`) REFERENCES `rol` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
