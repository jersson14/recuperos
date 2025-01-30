<?php
    require '../../model/model_obras_sociales.php';
    $MOS = new Modelo_Obras_Sociales();//Instaciamos
    $id = strtoupper(htmlspecialchars($_POST['id'],ENT_QUOTES,'UTF-8'));

    $consulta = $MOS->Eliminar_Obras_Sociales($id);
    echo $consulta;



?>