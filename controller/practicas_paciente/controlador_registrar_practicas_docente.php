<?php
    require '../../model/model_practicas_paciente.php';
    $MPP = new Modelo_Practicas_Paciente();//Instaciamos
    $area2 = strtoupper(htmlspecialchars($_POST['area2'],ENT_QUOTES,'UTF-8'));
    $paciente2 = strtoupper(htmlspecialchars($_POST['paciente2'],ENT_QUOTES,'UTF-8')); 
    $total = strtoupper(htmlspecialchars($_POST['total'],ENT_QUOTES,'UTF-8'));
    $idusu = strtoupper(htmlspecialchars($_POST['idusu'],ENT_QUOTES,'UTF-8'));

    $consulta = $MPP->Registrar_Practicas_paciente($area2,$paciente2,$total,$idusu);
    echo $consulta;



?>