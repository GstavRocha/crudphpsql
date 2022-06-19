<?php
require_once "conexao.php";

$nomeGravadora = "";
$siteGravadora = "";
$nomeGravadora_err = ""; 
$siteGravadora_err = "";
 
if($_SERVER["REQUEST_METHOD"] == "POST"){
    // Validate name
    $input_nomeGravadora = trim($_POST["nomeGravadora"]);
    if(empty($input_nomeGravadora)){
        $nomeGravadora_err = "Informe o nome.";
    } elseif(!filter_var($input_nomeGravadora, FILTER_VALIDATE_REGEXP, array("options"=>array("regexp"=>"/^[a-zA-Z\s]+$/")))){
        $nomeGravadora_err = "Informe um nome válido.";
    } else{
        $nomeGravadora = $input_nomeGravadora;
    }
    

    $input_siteGravadora = trim($_POST["siteGravadora"]);
    if(empty($input_siteGravadora)){
        $siteGravadora_err = "Informe um salário.";     
    } elseif(!ctype_digit($input_siteGravadora)){
        $siteGravadora_err = "Informe um salário válido.";
    } else{
        $siteGravadora = $input_siteGravadora;
    }

    if(empty($nomeGravadora_err) && empty($siteGravadora_err)){
        
        try {
		  $conn = conectar();
		  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		  $codGravadora = 0;	
		  $sql = 'CALL spGravadoraIncluiAltera(?, ?, ?)';
		  $stm = $conn->prepare($sql);
		  $stm->bindParam(1, $codGravadora, PDO::PARAM_INT, 10);
		  $stm->bindParam(2, $nanomeGravadorame, PDO::PARAM_STR, 50);
		  $stm->bindParam(3, $siteGravadora, PDO::PARAM_STR, 50);
		  $stm->execute();
		  
		  header("location: index.php");
          exit();
		  
		} catch(PDOException $e) {
			echo 'ERRO: ' . $e->getMessage();
		}  
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
    <h1 class="text-light">Inserir nova Gravadora</h1>
    <div class="d-flex justify-content-center">
        <div class="d-flex justify-content-center flex-sm-col bg-light">
            <div class="form-group">
                <h2 class="mt-5">Dados da Gravadora</h2>
                    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
                        <div class="form-group">
                            <label>Nome</label>
                            <input type="text" name="name" class="form-control <?php echo (!empty($nomeGravadora_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $nomeGravadora; ?>">
                            <span class="invalid-feedback"><?php echo $nomeGravadora_err;?></span>
                        </div>
						<div class="form-group">
                            <label>Site</label>
                            <input type="text" name="salary" class="form-control <?php echo (!empty($siteGravadora_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $siteGravadora; ?>">
                            <span class="invalid-feedback"><?php echo $siteGravadora_err;?></span>
                        </div>                   
                        <input type="submit" class="btn btn-danger" value="Submit">
                        <a href="index.php" class="btn btn-success ml-2">Cancelar</a>
                        <a href="index.php" class="btn btn-primary">Voltar</a>        
                    </form>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>