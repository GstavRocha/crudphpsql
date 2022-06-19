<?php
require_once "conexao.php";

$codigo = "";
$nome = "";
$site = "";

$codigo_err = "";
$nome_err = "";
$site_err = "";

if(isset($_POST["id"]) && !empty($_POST["id"])){
    $id = $_GET["id"];

    $input_nome = trim($_POST["nome"]);
    if(empty($input_nome)){
        $nome_err = "Informe o nome da Gravadora";
    }else{
        $nome = $input_nome;
    }
    
    $input_site = trim($_POST["site"]);
    if(empty($input_site)){
        $site_err = "Informe o site";
    }else{
        $site = $input_site;
    }

    if(empty($nome_err) && empty($site_err)){
        try{
            $conn = conectar();
            $conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);

            $sql = 'CALL spGravadoraAltera(?, ?, ?)';
            $stm = $conn->prepare($sql);
            $stm->bindParam(1, $id, PDO::PARAM_INT,10);
            $stm->bindParam(2, $nome,PDO::PARAM_STR,50);
            $stm->bindParam(3, $site,PDO::PARAM_STR,50);
            $stm->execute();

            header("location: index.php");
            exit();
        }catch(PDOException $e){
        echo 'ERRO: ' .$e->getMessage();
        }
    }
}else{
    // Check existence of id parameter before processing further
    if(isset($_GET["id"]) && !empty(trim($_GET["id"]))){
		$id = $_GET["id"];
		try {
			  $conn = conectar();
			  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			  $cod = trim($_GET["id"]);	
			  $sql = 'CALL splistaGravadoras(?)';
			  $stm = $conn->prepare($sql);
			  $stm->bindParam(1, $cod, PDO::PARAM_INT, 10);
			  $stm->execute();
			  $row = $stm->fetch();

			  $codGrav   = $row["CoGravadora"];
			  $nome    = $row["NoGravadora"];
			  $site  = $row["TxSite"];		  
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
  
    <title>Atualizar Gravadoras</title>
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
                    <h2 class="mt-5">Atualizar dados das Gravadoras</h2>
                    <form action="<?php echo htmlspecialchars(basename($_SERVER['REQUEST_URI'])); ?>" method="post">
                        <div class="form-group">
                            <label>Nome</label>
                            <input type="text" name="name" class="form-control <?php echo (!empty($nome_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $nome; ?>">
                            <span class="invalid-feedback"><?php echo $nome_err;?></span>
                        </div>
						<div class="form-group">
                            <label>Site</label>
                            <input type="text" name="vocal" class="form-control <?php echo (!empty($vocal_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $vocal; ?>">
                            <span class="invalid-feedback"><?php echo $vocal_err;?></span>
                        </div>
                        <input type="hidden" name="id" value="<?php echo $id; ?>"/>
                        <input type="submit" class="btn btn-primary" value="Submit">
                        <a href="index.php" class="btn btn-secondary ml-2">Cancelar</a>
                    </form>
                </div>
            </div>        
        </div>
     
    </div>
    
</body>
</html>