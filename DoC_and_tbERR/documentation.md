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
SELECT c.CoGravadora,p.NoPessoa, c.TxTituloCD, c.NuAno FROM tbcd as c 
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

1 - Qst:

CREATE VIEW listaGravadoras
as
SELECT * FROM tbgravadora; 