<?php
    require '../../model/model_area.php';
    $MA = new Modelo_Area();
    $area = strtoupper(htmlspecialchars($_POST['area'],ENT_QUOTES,'UTF-8'));
    $descripcion = strtoupper(htmlspecialchars($_POST['descripcion'],ENT_QUOTES,'UTF-8'));
    $idusu = strtoupper(htmlspecialchars($_POST['idusu'],ENT_QUOTES,'UTF-8'));

    $consulta = $MA->Registrar_Area($area,$descripcion,$idusu);
    echo $consulta;



?>