<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Inicial</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-dark text-center">
    <h1 class="text-light">Listagem dos Músicos e da Gravadora</h1>
    <a href="create.php" class="btn btn-danger pull-right"><i class="fa fa-plus"></i>   Incluir Gravadoras</a>
    <div class="d-flex justify-content-center">
        <div class="d-flex justify-content-center flex-sm-col bg-light">
                <div class="d-flex flex-sm-col">
                    <?php
                    require_once "conexao.php";

                    echo '<table class="table table-bordered table-striped">';
                        echo '<thead>';
                            echo '<tr>';
                            echo '<th>#</th>';
                            echo '<th>Gravadora</th>';
                            echo  '<th> Site</th>';
                            echo '</tr>';
                        echo '</thead>';
                        echo '<tbody>';
                        try{
                            $conn = conectar();
                            $conn -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                            $CodGrav = 0;
                            $sql = 'CALL splistaGravadoras(?)';
                            $stm = $conn->prepare($sql);
                            $stm->bindParam(1, $CodGrav, PDO::PARAM_INT, 10);
                            $stm->execute();
                            
                            while($row = $stm->fetch()){
                                echo "<tr>";
                                    echo "<td>".$row['CoGravadora']."</td>";
                                    echo "<td>".$row['NoGravadora']."</td>";
                                    echo "<td>".$row['TxSite']."</td>";
                                    echo "<td>";
                                        echo '<a href="read.php?id='  . $row['CoGravadora'] .'" class="mr-3" title="Visualizar" data-toggle="tooltip"><span class="fa fa-eye"></span></a>';
									    echo '<a href="update.php?id='. $row['CoGravadora'] .'" class="mr-3" title="Alterar" data-toggle="tooltip"><span class="fa fa-pencil"></span></a>';
									    echo '<a href="delete.php?id='. $row['CoGravadora'] .'" title="Excluir" data-toggle="tooltip"><span class="fa fa-trash"></span></a>';
                                    echo "</td>";
                                echo "</tr>";
                            }
                            
                        } catch(PDOException $e) {
                                    echo 'ERRO: ' . $e->getMessage();
                        }
                        echo '</tbody>';
                    echo '</table>';

                    ?>
                </div>
            <div class="d-flex justify-content-center flex-sm-col bg-light">
        </div>
    </div>
    <script>
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();   
        });
    </script>
</body>
</html>