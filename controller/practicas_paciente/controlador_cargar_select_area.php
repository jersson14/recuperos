<?php
    require '../../model/model_practicas_paciente.php';
    $MPP = new Modelo_Practicas_Paciente();//Instaciamos
    $consulta = $MPP->Cargar_Areas();
    echo json_encode($consulta);
 
?>
