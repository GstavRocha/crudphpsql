<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body class="bg-dark text-center">
    <h1 class="text-light">Listagem dos Músicos e da Gravadora</h1>
    <div class="d-flex justify-content-center">
        <div class="d-flex justify-content-center flex-sm-col bg-light">
            <div class="p-2"><a href="">Musicos</a></div>
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
                                echo '<tr>';
                                    echo '<td>'.$row['CoGravadora'].'</td>';
                                    echo '<td>'.$row['NoGravadora'].'</td>';
                                    echo '<td>'.$row['TxSite'].'</td>';
                                    echo '<td>';
                                        echo '<a href="read.php?id='.$row['CoGravadora'].'" class="mr-3" title="Visualizar" data-toggle="tooltip"><span class="fa fa-eye"></span></a>';
                                    }
                                } catch(PDOException $e) {
                                    echo 'ERRO: ' . $e->getMessage();
                                }
                        echo '</tbody>';
                    echo '</table>';

                    ?>
                </div>
            <div class="d-flex justify-content-center flex-sm-col bg-light">
            <div class="p-2"><a href="">Gravadoras</a></div>
        </div>
    </div>
    <script>
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();   
        });
    </script>
</body>

</html>