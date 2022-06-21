-- Conusltar

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spConsutlGravadora`( in codConsult int)
BEGIN
	IF codConsult = 0 THEN
    	SELECT * FROM consultGravadora;
    ELSE
    	SELECT * FROM consultGravadora WHERE CoGravadora = codConsult;
    END IF;
END$$
DELIMITER ;

-- DElETAR
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraDel`(IN codDel INT)
BEGIN
   	DELETE FROM tbgravadora WHERE CoGravadora = codDel;
    DELETE FROM tbpessoa WHERE CoPessoa = codDel;
END$$
DELIMITER ;

-- INCLUIR E ALTERAR
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGravadoraIncluiAltera`(IN `codGravadora` INT, IN `nomeGravadora` VARCHAR(50), IN `siteGravadora` VARCHAR(50))
BEGIN
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
DELIMITER ;

-- LISTAR
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListaGravadoras`(in codGrav INT)
BEGIN
	if codGrav = 0 THEN
    	SELECT * FROM listaGravadoras;
    ELSE
    	SELECT * FROM listaGravadoras WHERE CoGravadora = codGrav;
    END IF;
 END$$
DELIMITER ;
