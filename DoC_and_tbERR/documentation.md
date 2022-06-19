# Especifications;
The standard language  for users is portuguese.
For a project most we use boostrap3 version link web. 
Create conection.php :arrow_right: lays down a conection with database and frontend.


### PhpAdmin
Create view list all record companies.

VIEWS:
Lista Gravadoras:
CREATE VIEW listaGravadoras
as 
SELECT CoGravadora, NoGravadora, TxSite from tbgravadora as g 
INNER JOIN tbpessoa as p 
ON p.CoPessoa = g.CoGravadora;

Consultar Gravadoras
CREATE VIEW consultGravadora
as
SELECT c.CoGravadora,p.NoPessoa AS NoGravadora , c.TxTituloCD, c.NuAno FROM tbcd as c 
INNER JOIN tbgravadora as g 
ON g.CoGravadora = c.CoGravadora
INNER JOIN tbpessoa as p 
ON p.CoPessoa = g.CoGravadora;

PROCEDURES:
Listar Gravadoras
DELIMITER $$
CREATE PROCEDURE spListaGravadoras (in codGrav INT)
BEGIN
	if codGrav = 0 THEN
    	SELECT * FROM listaGravadoras;
    ELSE
    	SELECT * FROM listaGravadoras WHERE CoGravadora = codGrav;
    END IF;
 END $$
 DELIMITER ;


Consultar Gravadoras:
DELIMITER $$
CREATE PROCEDURE spConsutlGravadora( in codConsult int)
BEGIN
	IF codConsult = 0 THEN
    	SELECT * FROM consultGravadora;
    ELSE
    	SELECT * FROM consultGravadora WHERE CoGravadoragit 
END $$
DELIMITER ;

Delete Gravadora: 
A tabela tem chaves que herdam é necessário deletar todos os cantos onde ela foi chamada; -- não deu certo
DELIMITER $$
CREATE PROCEDURE spGravadoraDel(IN codDel INT)
BEGIN
   	DELETE FROM tbgravadora WHERE CoGravadora = codDel;
    DELETE FROM tbpessoa WHERE CoPessoa = codDel;
END $$
DELIMITER ;

A Chave estrangeira da Tabela tbgravadora foi mudada para ON DELETE CASCADE, Abaixo segue o código.

ALTER TABLE tbgravadora DROP FOREIGN KEY tbgravadora_ibfk_1; ALTER TABLE tbgravadora ADD CONSTRAINT tbgravadora_ibfk_1 FOREIGN KEY (CoGravadora) REFERENCES tbpessoa(CoPessoa) ON DELETE CASCADE ON UPDATE CASCADE;

DEU CERTO
Incluir Gravadora:
DELIMITER $$
CREATE PROCEDURE spGravadoraIncluiAltera(IN codGravadora INT, IN nomeGravadora VARCHAR(50), in siteGravadora VARCHAR(50))
BEGIN
    IF (codGravadora = 0) THEN
      SELECT MAX(CoPessoa) INTO codGravadora FROM tbpessoa;

     
      INSERT INTO tbpessoa(CoPessoa, NoPessoa, InTipoPessoa)
      VALUES (codGravadora + 1, nomeGravadora, 2);

      INSERT INTO listaGravadoras(CoGravadora, TxSite)
      VALUES (codGravadora + 1, siteGravadora);
    ELSE
      UPDATE tbpessoa
         SET NoPessoa = nomeGravadora
       WHERE CoPessoa = codGravadora;

      UPDATE listaGravadoras
         SET TxSite = siteGravadora
       WHERE CoGravadora  = codGravadora;
    END IF;
END $$
DELIMITER ;

Meu Procedure
DELIMITER $$
CREATE PROCEDURE spGravadoraIncluiAltera(IN codGravadora INT, IN nomeGravadora VARCHAR(50), in siteGravadora VARCHAR(50))
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
    END IF;
END $$
DELIMITER ;

1 - Qst:

CREATE VIEW listaGravadoras
as
SELECT * FROM tbgravadora; 

