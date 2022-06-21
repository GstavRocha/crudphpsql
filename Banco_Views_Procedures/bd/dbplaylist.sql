-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 21/06/2022 às 17:00
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

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsutlGravadora` (IN `codConsult` INT)   BEGIN
	IF codConsult = 0 THEN
    	SELECT * FROM consultGravadora;
    ELSE
    	SELECT * FROM consultGravadora WHERE CoGravadora = codConsult;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spDelGravadora` (IN `codGrava` SMALLINT)   BEGIN
	DELETE FROM tbpessoa WHERE CoPessoa = codGrava;
    DELETE FROM tbgravadora WHERE CoGravadora = codGrava;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraAlterAdd` (IN `cod` INT, IN `nome` VARCHAR(50), IN `site` VARCHAR(50))   BEGIN
    IF (cod = 0) THEN
      SELECT MAX(CoPessoa) INTO cod FROM tbpessoa;

     
      INSERT INTO tbpessoa(CoPessoa, NoPessoa, InTipoPessoa)
      VALUES (cod + 1, nome, 2);

      INSERT INTO listaGravadoras(CoGravadora, TxSite)
      VALUES (cod + 1, nome);
    ELSE
      UPDATE tbpessoa
         SET NoPessoa = nome
       WHERE CoPessoa = cod;

      UPDATE listaGravadoras
         SET TxSite = nome
       WHERE CoGravadora  = cod;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraDel` (IN `codDel` INT)   BEGIN
   	DELETE FROM tbgravadora WHERE CoGravadora = codDel;
    DELETE FROM tbpessoa WHERE CoPessoa = codDel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraIncluiAltera` (IN `codGravadora` INT, IN `nomeGravadora` VARCHAR(50), IN `siteGravadora` VARCHAR(50))   BEGIN
    IF (codGravadora = 0) THEN
      SELECT MAX(CoPessoa) INTO codGravadora FROM tbpessoa;
     
      INSERT INTO tbpessoa(CoPessoa, NoPessoa, InTipoPessoa)
      VALUES (codGravadora + 1, nomeGravadora, 2);

      INSERT INTO tbgravadora(CoGravadora, TxSite)
      VALUES (codGravadora + 1, siteGravadora);
    ELSE
      UPDATE tbpessoa
         SET NoPessoa = nomeGravadora
       WHERE CoPessoa = codGravadora;

      UPDATE tbgravadora
         SET TxSite = siteGravadora
       WHERE CoGravadora  = codGravadora;
       
       UPDATE listaGravadoras
         SET TxSite = nome
       WHERE CoGravadora  = codGravadora;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraIncluiGustavo` (IN `codGravadora` INT, IN `nomeGravadora` VARCHAR(50), IN `siteGravadora` VARCHAR(50))   BEGIN
    IF (codGravadora = 0) THEN
      SELECT MAX(CoPessoa) INTO codGravadora FROM tbpessoa;
     
      INSERT INTO tbpessoa(CoPessoa, NoPessoa, InTipoPessoa)
      VALUES (codGravadora + 1, nomeGravadora, 2);

      INSERT INTO tbgravadora(CoGravadora, TxSite)
      VALUES (codGravadora + 1, siteGravadora);
    ELSE
      UPDATE tbpessoa
         SET NoPessoa = nomeGravadora
       WHERE CoPessoa = codGravadora;

      UPDATE tbgravadora
         SET TxSite = siteGravadora
       WHERE CoGravadora  = codGravadora;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spListaGravadoras` (IN `codGrav` INT)   BEGIN
	if codGrav = 0 THEN
    	SELECT * FROM listaGravadoras;
    ELSE
    	SELECT * FROM listaGravadoras WHERE CoGravadora = codGrav;
    END IF;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spListaMusico` (IN `cod` INT)   BEGIN
   IF cod = 0 THEN
      SELECT * FROM vwListaMusico;
   ELSE
      SELECT * FROM vwListaMusico WHERE CoMusico = cod;
   END IF;  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMusicoExclui` (IN `cod` INT)   BEGIN
   DELETE FROM TbMusico WHERE CoMusico = cod;
   DELETE FROM TbPessoa WHERE CoPessoa = cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spMusicoIncluiAltera` (IN `cod` INT, IN `nome` VARCHAR(50), IN `salario` DECIMAL, IN `vocal` TINYINT, IN `banda` TINYINT)   BEGIN
    IF (cod = 0) THEN
      SELECT MAX(CoPessoa) INTO cod FROM tbpessoa;

      INSERT INTO tbpessoa(CoPessoa, NoPessoa, InTipoPessoa)
      VALUES (cod + 1, nome, 1);

      INSERT INTO tbmusico(CoMusico, VaSalario, InVocal, CoBanda)
      VALUES (cod + 1, salario, vocal, banda);
    ELSE
      UPDATE tbpessoa
         SET NoPessoa = nome
       WHERE CoPessoa = cod;

      UPDATE tbmusico
         SET VaSalario = salario,
             InVocal   = vocal,
             CoBanda   = banda
       WHERE CoMusico  = cod;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `consultGravadora`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `consultGravadora` (
`CoGravadora` smallint(6)
,`NoGravadora` varchar(50)
,`TxTituloCD` varchar(50)
,`NuAno` smallint(6)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `listaGravadoras`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `listaGravadoras` (
`CoGravadora` smallint(6)
,`NoGravadora` varchar(50)
,`TxSite` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbbanda`
--

CREATE TABLE `tbbanda` (
  `CoBanda` tinyint(4) NOT NULL,
  `NoBanda` varchar(50) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbbanda`
--

INSERT INTO `tbbanda` (`CoBanda`, `NoBanda`) VALUES
(1, 'Chiclete com Banana'),
(2, 'Asa de Águia'),
(26, 'Titãs'),
(77, 'Planet Hemp'),
(78, 'Titãs'),
(84, 'Titãs'),
(85, 'Titãs');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbbandacd`
--

CREATE TABLE `tbbandacd` (
  `CoBanda` tinyint(4) NOT NULL,
  `CoCD` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbbandacd`
--

INSERT INTO `tbbandacd` (`CoBanda`, `CoCD`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbcd`
--

CREATE TABLE `tbcd` (
  `CoCD` tinyint(4) NOT NULL,
  `CoGravadora` smallint(6) NOT NULL,
  `TxTituloCD` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `NuAno` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbcd`
--

INSERT INTO `tbcd` (`CoCD`, `CoGravadora`, `TxTituloCD`, `NuAno`) VALUES
(1, 10, 'Chiclete na caixa, banana no cacho', 2003),
(2, 10, 'Flutuar', 2008),
(3, 10, '100% Chiclete com Banana', 2008),
(4, 11, 'Tabuleiro Musical', 2007),
(5, 11, 'Sou Chicleteiro', 2004),
(6, 11, 'Santo protetor', 2001),
(7, 10, 'São João de rua', 2000),
(8, 11, 'Asa de Águia 20 anos', 2008),
(9, 11, 'Maxximum', 2005),
(10, 10, 'Sou Asa', 2004),
(11, 10, 'Asa na veia', 2002),
(12, 10, 'Se ligue', 2001),
(14, 14, 'Seila', 2010),
(15, 14, 'Seila', 2010),
(16, 14, 'Seila', 2010),
(17, 14, 'Seila', 2010),
(18, 14, 'Seila', 2010),
(19, 14, 'Seila', 2010),
(20, 14, 'Seila', 2010),
(21, 14, 'Seila', 2010),
(22, 14, 'Seila', 2010),
(23, 14, 'Seila', 2010);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbgravadora`
--

CREATE TABLE `tbgravadora` (
  `CoGravadora` smallint(6) NOT NULL,
  `TxSite` varchar(50) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbgravadora`
--

INSERT INTO `tbgravadora` (`CoGravadora`, `TxSite`) VALUES
(10, 'www.bmg.com.br'),
(11, 'www.somlivre.com.br'),
(14, 'www2'),
(18, 'www.pointo.;'),
(19, 'www.gustavo.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbmusica`
--

CREATE TABLE `tbmusica` (
  `CoMusica` tinyint(4) NOT NULL,
  `NoMusica` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `CoCD` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbmusica`
--

INSERT INTO `tbmusica` (`CoMusica`, `NoMusica`, `CoCD`) VALUES
(1, 'Voa, voa', 1),
(2, 'Rumba de Santa Clara', 1),
(3, 'Tem que ter Chiclete', 1),
(4, 'Menina, me dá seu amor', 1),
(5, 'Chiclete na caixa, banana no cacho', 1),
(6, 'Flutuar', 2),
(7, 'Eu quero esse amor', 2),
(8, 'Bomboniere', 2),
(11, 'Feitiço gelado', 2),
(13, 'Beijo em alto mar', 2),
(14, 'Vai chorar ou vai sorrir?', 2),
(15, 'Feitiço gelado', 2),
(17, 'Beijo em alto mar', 2),
(18, '100% Você', 3),
(19, 'Chicleteiro eu, chicleteira ela', 3),
(20, 'Cara, caramba, sou Camaleão', 3),
(21, 'E nunca mais vai me deixar', 4),
(22, 'Quando o Chiclete toca', 4),
(23, 'Chicleteiro eu, chicleteiro ela', 4),
(24, 'Eu quero esse amor', 4),
(25, 'Mar de rosas', 4),
(26, 'Solidão', 4),
(27, 'Minha paixão é Chiclete', 5),
(28, 'Ê, baiana', 5),
(29, 'Quero Chiclete', 6),
(30, 'Diga que valeu!', 6),
(31, 'Tareco e mariola', 7),
(32, 'Fogaréu', 7),
(33, 'Sétimo céu', 7),
(34, 'Quero você', 7),
(35, 'Simbora', 8),
(36, 'Quebra aê', 8),
(37, 'Pra lá de Bragadá', 9),
(38, 'O Asa chegou', 9),
(39, 'Gladiador', 10),
(40, 'O lobo', 10),
(43, 'Não tem lua', 12),
(44, 'Oba, vou passear!', 12),
(45, 'Leva eu', 12),
(46, 'Baila que eu vou', 11),
(47, 'Me abraça, me beija!', 11);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbmusico`
--

CREATE TABLE `tbmusico` (
  `CoMusico` smallint(6) NOT NULL,
  `CoBanda` tinyint(4) NOT NULL,
  `VaSalario` decimal(10,2) NOT NULL,
  `InVocal` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbmusico`
--

INSERT INTO `tbmusico` (`CoMusico`, `CoBanda`, `VaSalario`, `InVocal`) VALUES
(1, 1, '450000.00', 1),
(2, 1, '75000.00', 0),
(3, 1, '85000.00', 1),
(4, 1, '100000.00', 1),
(5, 2, '250000.00', 1),
(6, 2, '150000.00', 1),
(7, 2, '120000.00', 1),
(8, 2, '50000.00', 0),
(9, 2, '130000.00', 0),
(15, 0, '10000000.00', 1),
(16, 0, '10000000.00', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbpessoa`
--

CREATE TABLE `tbpessoa` (
  `CoPessoa` smallint(6) NOT NULL,
  `NoPessoa` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `InTipoPessoa` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Despejando dados para a tabela `tbpessoa`
--

INSERT INTO `tbpessoa` (`CoPessoa`, `NoPessoa`, `InTipoPessoa`) VALUES
(1, 'Gustavo', 1),
(2, 'Waltinho', 1),
(3, 'Leleco', 1),
(4, 'Wilson', 1),
(5, 'Durval Lelis', 1),
(6, 'Levi Pereira', 1),
(7, 'Radhi', 1),
(8, 'Bajara', 1),
(9, 'Ricardo Ferraro', 1),
(10, 'BMG', 2),
(11, 'Som Livre', 2),
(14, 'Teste3', 2),
(15, 'Luiz Gustavo Da Rocha Ferreira', 1),
(16, 'teste', 1),
(18, 'TesteRecords', 2),
(19, 'Gustavo RochaPunk', 2);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vm_musicobanda`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vm_musicobanda` (
`NoPessoa` varchar(50)
,`NoBanda` varchar(50)
,`VaSalario` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vwListaMusico`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vwListaMusico` (
`CoMusico` smallint(6)
,`NoBanda` varchar(50)
,`NoPessoa` varchar(50)
,`VaSalario` decimal(10,2)
,`Vocal` varchar(3)
,`InVocal` tinyint(4)
,`CoBanda` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_Gustavo`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_Gustavo` (
`NoBanda` varchar(50)
,`TxTituloCD` varchar(50)
,`NoMusica` varchar(50)
,`NuAno` smallint(6)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_musicobanda`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_musicobanda` (
`NoPessoa` varchar(50)
,`NoBanda` varchar(50)
,`VaSalario` decimal(10,2)
,`InVocal` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_musicobandavocal`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_musicobandavocal` (
`NoPessoa` varchar(50)
,`NoBanda` varchar(50)
,`VaSalario` decimal(10,2)
,`InVocal` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_Questão1Gustavo`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_Questão1Gustavo` (
`NoBanda` varchar(50)
,`TxTituloCD` varchar(50)
,`NoMusica` varchar(50)
,`NuAno` smallint(6)
);

-- --------------------------------------------------------

--
-- Estrutura para view `consultGravadora`
--
DROP TABLE IF EXISTS `consultGravadora`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `consultGravadora`  AS SELECT `c`.`CoGravadora` AS `CoGravadora`, `p`.`NoPessoa` AS `NoGravadora`, `c`.`TxTituloCD` AS `TxTituloCD`, `c`.`NuAno` AS `NuAno` FROM ((`tbcd` `c` join `tbgravadora` `g` on(`g`.`CoGravadora` = `c`.`CoGravadora`)) join `tbpessoa` `p` on(`p`.`CoPessoa` = `g`.`CoGravadora`))  ;

-- --------------------------------------------------------

--
-- Estrutura para view `listaGravadoras`
--
DROP TABLE IF EXISTS `listaGravadoras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listaGravadoras`  AS SELECT `g`.`CoGravadora` AS `CoGravadora`, `p`.`NoPessoa` AS `NoGravadora`, `g`.`TxSite` AS `TxSite` FROM (`tbgravadora` `g` join `tbpessoa` `p` on(`p`.`CoPessoa` = `g`.`CoGravadora`))  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vm_musicobanda`
--
DROP TABLE IF EXISTS `vm_musicobanda`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vm_musicobanda`  AS SELECT `p`.`NoPessoa` AS `NoPessoa`, `b`.`NoBanda` AS `NoBanda`, `m`.`VaSalario` AS `VaSalario` FROM ((`tbpessoa` `p` join `tbmusico` `m` on(`p`.`CoPessoa` = `m`.`CoMusico`)) join `tbbanda` `b` on(`m`.`CoBanda` = `b`.`CoBanda`))  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vwListaMusico`
--
DROP TABLE IF EXISTS `vwListaMusico`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwListaMusico`  AS SELECT `m`.`CoMusico` AS `CoMusico`, `b`.`NoBanda` AS `NoBanda`, `p`.`NoPessoa` AS `NoPessoa`, `m`.`VaSalario` AS `VaSalario`, CASE WHEN `m`.`InVocal` = 1 THEN 'Sim' ELSE 'Não' END AS `Vocal`, `m`.`InVocal` AS `InVocal`, `b`.`CoBanda` AS `CoBanda` FROM ((`tbpessoa` `p` join `tbmusico` `m` on(`p`.`CoPessoa` = `m`.`CoMusico`)) join `tbbanda` `b` on(`m`.`CoBanda` = `b`.`CoBanda`)) ORDER BY `b`.`NoBanda` ASC, `p`.`NoPessoa` ASC  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_Gustavo`
--
DROP TABLE IF EXISTS `vw_Gustavo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_Gustavo`  AS SELECT `a`.`NoBanda` AS `NoBanda`, `c`.`TxTituloCD` AS `TxTituloCD`, `d`.`NoMusica` AS `NoMusica`, `c`.`NuAno` AS `NuAno` FROM (((`tbbanda` `a` join `tbbandacd` `b` on(`a`.`CoBanda` = `b`.`CoBanda`)) join `tbcd` `c` on(`c`.`CoCD` = `b`.`CoCD`)) join `tbmusica` `d` on(`c`.`CoCD` = `d`.`CoCD`)) WHERE `c`.`NuAno` = 2001 OR `c`.`NuAno` = 2005 ORDER BY `c`.`NuAno` ASC  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_musicobanda`
--
DROP TABLE IF EXISTS `vw_musicobanda`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_musicobanda`  AS SELECT `p`.`NoPessoa` AS `NoPessoa`, `b`.`NoBanda` AS `NoBanda`, `m`.`VaSalario` AS `VaSalario`, `m`.`InVocal` AS `InVocal` FROM ((`tbpessoa` `p` join `tbmusico` `m` on(`p`.`CoPessoa` = `m`.`CoMusico`)) join `tbbanda` `b` on(`m`.`CoBanda` = `b`.`CoBanda`))  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_musicobandavocal`
--
DROP TABLE IF EXISTS `vw_musicobandavocal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_musicobandavocal`  AS SELECT `p`.`NoPessoa` AS `NoPessoa`, `b`.`NoBanda` AS `NoBanda`, `m`.`VaSalario` AS `VaSalario`, `m`.`InVocal` AS `InVocal` FROM ((`tbpessoa` `p` join `tbmusico` `m` on(`p`.`CoPessoa` = `m`.`CoMusico`)) join `tbbanda` `b` on(`m`.`CoBanda` = `b`.`CoBanda`)) WHERE `m`.`InVocal` = 11  ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_Questão1Gustavo`
--
DROP TABLE IF EXISTS `vw_Questão1Gustavo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_Questão1Gustavo`  AS SELECT `m`.`NoBanda` AS `NoBanda`, `b`.`TxTituloCD` AS `TxTituloCD`, `c`.`NoMusica` AS `NoMusica`, `b`.`NuAno` AS `NuAno` FROM (((`tbbanda` `m` join `tbbandacd` `a` on(`m`.`CoBanda` = `a`.`CoBanda`)) join `tbcd` `b` on(`a`.`CoCD` = `b`.`CoCD`)) join `tbmusica` `c` on(`c`.`CoCD` = `a`.`CoCD`)) WHERE `b`.`NuAno` = 2001 OR `b`.`NuAno` = 2005 ORDER BY `b`.`NuAno` ASC  ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tbbanda`
--
ALTER TABLE `tbbanda`
  ADD PRIMARY KEY (`CoBanda`);

--
-- Índices de tabela `tbbandacd`
--
ALTER TABLE `tbbandacd`
  ADD PRIMARY KEY (`CoBanda`,`CoCD`),
  ADD KEY `tbbandacd_ibfk_1` (`CoCD`);

--
-- Índices de tabela `tbcd`
--
ALTER TABLE `tbcd`
  ADD PRIMARY KEY (`CoCD`),
  ADD KEY `tbcd_ibfk_1` (`CoGravadora`);

--
-- Índices de tabela `tbgravadora`
--
ALTER TABLE `tbgravadora`
  ADD PRIMARY KEY (`CoGravadora`);

--
-- Índices de tabela `tbmusica`
--
ALTER TABLE `tbmusica`
  ADD PRIMARY KEY (`CoMusica`),
  ADD KEY `CoCD` (`CoCD`);

--
-- Índices de tabela `tbmusico`
--
ALTER TABLE `tbmusico`
  ADD PRIMARY KEY (`CoMusico`);

--
-- Índices de tabela `tbpessoa`
--
ALTER TABLE `tbpessoa`
  ADD PRIMARY KEY (`CoPessoa`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tbbandacd`
--
ALTER TABLE `tbbandacd`
  ADD CONSTRAINT `FK_BandaBandaCD` FOREIGN KEY (`CoBanda`) REFERENCES `tbbanda` (`CoBanda`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbbandacd_ibfk_1` FOREIGN KEY (`CoCD`) REFERENCES `tbcd` (`CoCD`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `tbcd`
--
ALTER TABLE `tbcd`
  ADD CONSTRAINT `tbcd_ibfk_1` FOREIGN KEY (`CoGravadora`) REFERENCES `tbgravadora` (`CoGravadora`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `tbgravadora`
--
ALTER TABLE `tbgravadora`
  ADD CONSTRAINT `tbgravadora_ibfk_1` FOREIGN KEY (`CoGravadora`) REFERENCES `tbpessoa` (`CoPessoa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tbmusica`
--
ALTER TABLE `tbmusica`
  ADD CONSTRAINT `tbmusica_ibfk_1` FOREIGN KEY (`CoCD`) REFERENCES `tbcd` (`CoCD`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `tbmusico`
--
ALTER TABLE `tbmusico`
  ADD CONSTRAINT `tbmusico_ibfk_1` FOREIGN KEY (`CoMusico`) REFERENCES `tbpessoa` (`CoPessoa`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
