-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 21/06/2022 às 16:48
-- Versão do servidor: 10.4.24-MariaDB
-- Versão do PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbplaylist`
--

-- --------------------------------------------------------

--
-- Estrutura para view `consultGravadora`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `consultGravadora`  AS SELECT `c`.`CoGravadora` AS `CoGravadora`, `p`.`NoPessoa` AS `NoGravadora`, `c`.`TxTituloCD` AS `TxTituloCD`, `c`.`NuAno` AS `NuAno` FROM ((`tbcd` `c` join `tbgravadora` `g` on(`g`.`CoGravadora` = `c`.`CoGravadora`)) join `tbpessoa` `p` on(`p`.`CoPessoa` = `g`.`CoGravadora`))  ;

--
-- VIEW `consultGravadora`
-- Dados: Nenhum
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;