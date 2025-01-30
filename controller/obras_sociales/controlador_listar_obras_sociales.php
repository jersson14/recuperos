<?php
    require '../../model/model_obras_sociales.php';
    $MOS = new Modelo_Obras_Sociales();//Instaciamos
    $consulta = $MOS->Listar_Obras_Sociales();
    if($consulta){
        echo json_encode($consulta);
    }else{
        echo '{
            "sEcho": 1,
            "iTotalRecords": "0",
            "iTotalDisplayRecords": "0",
            "aaData": []
        }';
    }
?>
