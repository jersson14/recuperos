<?php
    require '../../model/model_facturas.php';
    $MFA = new Modelo_Facturas();//Instaciamos
    $obra = htmlspecialchars($_POST['obra'],ENT_QUOTES,'UTF-8');

    $consulta = $MFA->Listar_facturas_edtado_obra_archivado($obra);
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
