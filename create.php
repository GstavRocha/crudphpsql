<?php
require_once "conexao.php";

$nome = ""; 
$site = "";
$nome_err ="";
$site_err ="";
 
if($_SERVER["REQUEST_METHOD"] == "POST"){
    $input_nome = trim($_POST["nome"]);
    if(empty($input_nome)){
        $nome_err = "Informe o nome da Gravadora.";
    // } elseif(!filter_var($input_nome, FILTER_VALIDATE_REGEXP, array("options"=>array("regexp"=>"/^[a-zA-Z\s]+$/")))){
    //     $nome_err = "Informe um nome válido.";
    } else{
        $nome = $input_nome;
    }

    $input_site = trim($_POST["site"]);
    if(empty($input_site)){
        $site_err = "Informe  um site válio";
    // } elseif(!filter_var($input_site, FILTER_VALIDATE_REGEXP, array("options"=>array("regexp"=>"/^[a-zA-Z\s]+$/")))){
    //     $site_err = "Informe um site válido.";
    } else{
        $nome = $input_site;
    }

    if(empty($nome_err) && empty($site_err)){
        
        try {
		  $conn = conectar();
		  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		  $cod = 0;	
		  $sql = 'CALL spGravadoraAlterAdd(?, ?, ?)';
		  $stm = $conn->prepare($sql);
		  $stm->bindParam(1, $cod, PDO::PARAM_INT, 10);
		  $stm->bindParam(2, $nome, PDO::PARAM_STR, 50);
          $stm->bindParam(2, $site, PDO::PARAM_STR, 50);
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
                            <input type="text" name="name" class="form-control <?php echo (!empty($nome_err)) ? 'is-valid' : ''; ?>" value="<?php echo $nome; ?>">
                            <span class="invalid-feedback"><?php echo $nome_err;?></span>
                        </div>
						<div class="form-group">
                            <label>Site</label>
                            <input type="text" name="salary" class="form-control <?php echo (!empty($site_err)) ? 'is-valid' : ''; ?>" value="<?php echo $site; ?>">
                            <span class="invalid-feedback"><?php echo $site_err;?></span>
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