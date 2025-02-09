<?php
    require '../../model/model_practicas_paciente.php';
    $MPP = new Modelo_Practicas_Paciente();//Instaciamos

$detalle_practicas = json_decode($_POST['componentes'], true); // Decodificar JSON a un array PHP
$exito = true; // Bandera de éxito global
$registros_nuevos = false; // Bandera para detectar si algunos registros son nuevos

foreach ($detalle_practicas as $detalle) {
    // Llamar al método para modificar el registro de hora y aula
    $resultado = $MPP->Modificar_Detalle_practicas(
        $detalle['idpracitcageneral'],   // ID de la hora
        $detalle['idpracitca'],   // ID de la hora
        $detalle['precio'],   // ID de la asignatura
    );

    if ($resultado == 1) {
        // Registro de hora y aula modificado
        $registros_nuevos = true; // Detectar si al menos uno fue registrado
    } elseif ($resultado == 0) {
        // Si el registro ya existe o no se realizó ninguna modificación, no hacemos nada
    } else {
        // Si ocurre algún error, marcamos como fallo
        $exito = false;
        break;
    }
}

if ($exito) {
    if ($registros_nuevos) {
        echo 1; // Algunos registros fueron modificados
    } else {
        echo 2; // No se modificaron nuevos registros
    }
} else {
    echo 0; // Error en la modificación
}
?>
