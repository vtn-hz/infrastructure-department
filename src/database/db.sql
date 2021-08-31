-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-08-2021 a las 01:02:24
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
(15, NULL, 'Moned', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\r\n         aaaaaaaaaa\r\n    \r\n    \r\n    ', '2021-08-16 19:57:28'),
(16, NULL, 'Moneda', ' \r\n         No\r\n    \r\n    ', '2021-08-16 20:10:09'),
(17, NULL, 'membrillo', ' \r\n    sexo', '2021-08-17 19:16:26'),
(18, NULL, 'aaa', ' \r\n    aaa', '2021-08-17 19:42:11'),
(19, 18, 'ProblemaInstaLADA', ' \r\n         \r\n         AAAAAAAAAAA\r\n         aaaaaaaaaa\r\n    \r\n    \r\n    \r\n    ', '2021-08-24 13:49:49'),
(21, 18, 'ProblemaInstaLADA', ' 11111111111111111111\r\n    ', '2021-08-24 15:20:05'),
(23, 18, '11111', ' 1111111111\r\n    ', '2021-08-24 15:20:20');

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
(18, 'Valentino', 1, 'n@gmail.com', '$2a$10$jmD5IvdpFotNd5CaqADlh.2yk0DwEb30HhYU21BgoR.IWtFXw5KYW'),
(19, 'Anashi', 2, 'v@gmail.com', '$2a$10$oN7mtSVeiRRL9spdU1NuzemJJqOTx5KIAhMhgUNuTVZJXaKqGMs8i');

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
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
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
  MODIFY `ID_PROBLEM` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `ID` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Rol`) REFERENCES `rol` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
