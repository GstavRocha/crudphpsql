<?php
	function conectar(){
       $servidor = 'localhost';
       $bd       = 'dbplaylist';
       $usuario  = 'root';
       $senha    = '';

       try {
          $conn = new PDO("mysql:host=$servidor;dbname=$bd", $usuario, $senha);
          //echo "Conectado a $bd em $servidor com sucesso.<br>";
		  return $conn;
       } 
	   catch (PDOException $pe) {
          die("ERRO: Não foi possível conectar-se ao BD $bd :" . $pe->getMessage()."<br>");
       }
	}
	conectar();
?>