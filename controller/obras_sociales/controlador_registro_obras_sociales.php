<?php
    require '../../model/model_obras_sociales.php';
    $MCA = new Modelo_Obras_Sociales();//Instaciamos
    $cuit = strtoupper(htmlspecialchars($_POST['cuit'],ENT_QUOTES,'UTF-8'));
    $nombre = strtoupper(htmlspecialchars($_POST['nombre'],ENT_QUOTES,'UTF-8'));
    $domi = strtoupper(htmlspecialchars($_POST['domi'],ENT_QUOTES,'UTF-8'));
    $local = strtoupper(htmlspecialchars($_POST['local'],ENT_QUOTES,'UTF-8'));
    $email = strtoupper(htmlspecialchars($_POST['email'],ENT_QUOTES,'UTF-8'));
    $idusu = strtoupper(htmlspecialchars($_POST['idusu'],ENT_QUOTES,'UTF-8'));

    $consulta = $MCA->Registrar_Obras_Sociales($cuit,$nombre,$domi,$local,$email,$idusu);
    echo $consulta;



?>