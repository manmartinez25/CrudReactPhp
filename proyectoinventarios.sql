-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2024 at 04:54 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proyectoinventarios`
--

-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

CREATE TABLE `factura` (
  `id_Factura` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `nombre_prod` tinytext NOT NULL,
  `cantidad_prod` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  `total` float NOT NULL,
  `Ventas_id_Ventas` int(11) NOT NULL,
  `Persona_id_Persona` int(11) NOT NULL,
  `Compañia_id_Compañia` int(11) NOT NULL,
  `Producto_id_Producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventario`
--

CREATE TABLE `inventario` (
  `id_Inventario` int(11) NOT NULL,
  `filtro_fecha` datetime NOT NULL,
  `stock` int(11) NOT NULL,
  `Producto_id_Producto` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produccion_compras`
--

CREATE TABLE `produccion_compras` (
  `id_Produccion_compras` int(11) NOT NULL,
  `num_lote` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `tipo_prod` tinytext NOT NULL,
  `cantidad` int(11) NOT NULL,
  `Producto_id_Producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `nombre_prod` varchar(30) NOT NULL,
  `tipo_prod` varchar(30) NOT NULL,
  `descripcion` tinytext NOT NULL,
  `precio` float NOT NULL,
  `stock` int(11) NOT NULL,
  `marca` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`id`, `nombre_prod`, `tipo_prod`, `descripcion`, `precio`, `stock`, `marca`) VALUES
(1, 'Amortiguadores De Gas Con Capó', 'Amortiguadores ', 'Kit de amortiguadores de amortiguadores del capó delantero;Material: aluminio.\r\nUbicación: capó delantero izquierdo y derecho,para Toyota Hilux SR5 M70 M80 REVO 2015-2023. Incluye 2 piezas de amortiguadores del capó delantero\r\nUn juego completo de acc', 183716, 5, 'XIANGSHANG');

-- --------------------------------------------------------

--
-- Table structure for table `tercero`
--

CREATE TABLE `tercero` (
  `id_Tercero` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `identificacion` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `telefono` int(11) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `TipoTercero` varchar(20) NOT NULL,
  `Ventas_id_Ventas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_Factura`,`Persona_id_Persona`,`Compañia_id_Compañia`),
  ADD KEY `fk_Factura_Persona1_idx` (`Persona_id_Persona`),
  ADD KEY `fk_Factura_Producto1_idx` (`Producto_id_Producto`);

--
-- Indexes for table `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_Inventario`,`Producto_id_Producto`,`fecha`),
  ADD KEY `fk_Inventario_Producto1_idx` (`Producto_id_Producto`);

--
-- Indexes for table `produccion_compras`
--
ALTER TABLE `produccion_compras`
  ADD PRIMARY KEY (`id_Produccion_compras`,`Producto_id_Producto`),
  ADD KEY `fk_Produccion_compras_Producto1_idx` (`Producto_id_Producto`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tercero`
--
ALTER TABLE `tercero`
  ADD PRIMARY KEY (`id_Tercero`,`Ventas_id_Ventas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `factura`
--
ALTER TABLE `factura`
  MODIFY `id_Factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_Inventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produccion_compras`
--
ALTER TABLE `produccion_compras`
  MODIFY `id_Produccion_compras` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tercero`
--
ALTER TABLE `tercero`
  MODIFY `id_Tercero` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_Factura_Persona1` FOREIGN KEY (`Persona_id_Persona`) REFERENCES `tercero` (`id_Tercero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_Producto1` FOREIGN KEY (`Producto_id_Producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_Inventario_Producto1` FOREIGN KEY (`Producto_id_Producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `produccion_compras`
--
ALTER TABLE `produccion_compras`
  ADD CONSTRAINT `fk_Produccion_compras_Producto1` FOREIGN KEY (`Producto_id_Producto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
