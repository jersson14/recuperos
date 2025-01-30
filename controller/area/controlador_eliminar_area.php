<?php
    require '../../model/model_area.php';
    $MA = new Modelo_Area();//Instaciamos
    $id = strtoupper(htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8'));

    $consulta = $MA->Eliminar_Area($id);
    echo $consulta;



?>