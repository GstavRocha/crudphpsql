<?php
	// Verifica se foi enviado o ID do músico
	if(isset($_GET["id"]) && !empty(trim($_GET["id"]))){
		require_once "conexao.php";
		
		try {
			  $conn = conectar();
			  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			  $codConsult = trim($_GET["id"]);	
			  $sql = 'CALL spListaGravadoras(?)';
			  $stm = $conn->prepare($sql);
			  $stm->bindParam(1, $codConsult, PDO::PARAM_INT, 10);
			  $stm->execute();
              $row = $stm->fetch();
              

			  $codigo  = $row["CoGravadora"];
              $gravadora = $row["NoGravadora"];
              $site = $row["TxSite"];

		} catch(PDOException $e) {
			echo 'ERRO: ' . $e->getMessage();
		}
	}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
    <title>Consulta Gravadora</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-dark text-center">
    <h1 class="text-light">Consultar <?php echo $gravadora; ?></h1>
    <div class="d-flex justify-content-center">
        <div class="d-flex justify-content-center flex-sm-col bg-light">
            <div class="wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                            <p><b>Gravadora: <?php echo $gravadora; ?></b></p>
                            </div>
                            <div class="form-group">
                            <p><b>Site: <?php echo $site; ?></b></p>
                            </div>
                            <p><a href="index.php" class="btn btn-primary">Voltar</a></p>
                        </div>
                    </div>        
                </div>
            </div>

        </div>
     
    </div>
    
</body>
</html>