<?php
// Process delete operation after confirmation
if(isset($_POST["id"]) && !empty($_POST["id"])){
    require_once "conexao.php";
	
	try {
		  $conn = conectar();
		  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		  $id = $_POST["id"];	
		  $sql = 'CALL spGravadoraDel(?)';
		  $stm = $conn->prepare($sql);
		  $stm->bindParam(1, $id, PDO::PARAM_INT, 10);
		  $stm->execute();
		  
		  header("location: index.php");
          exit();  
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
    <div class="d-flex justify-content-center">
        <div class="d-flex justify-content-center flex-sm-col bg-light">
            <div class="wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                        <h2 class="mt-5 mb-3">Excluir Gravadora</h2>
                            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                                <div class="alert alert-danger">
                                    <input type="hidden" name="id" value="<?php echo trim($_GET["id"]); ?>"/>
                                    <p>Deseja realmente excluir a Gravadora selecionada?</p>
                                    <p>
                                        <input type="submit" value="Yes" class="btn btn-danger">
                                        <a href="index.php" class="btn btn-secondary">Não</a>
                                        <a href="index.php" class="btn btn-primary">Voltar</a>  
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>        
                </div>
            </div>

        </div>
     
    </div>
    
</body>
</html>