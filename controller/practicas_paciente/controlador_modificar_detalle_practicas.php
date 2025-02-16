<?php
require '../../model/model_practicas_paciente.php';
$MPP = new Modelo_Practicas_Paciente(); // Instanciamos el modelo

// Verificar si se reciben los datos necesarios en la solicitud
if (!isset($_POST['componentes'], $_POST['total'], $_POST['idusu'])) {
    echo json_encode(['status' => 0, 'message' => 'Faltan datos en la solicitud']);
    exit;
}

// Decodificar JSON a un array PHP
$detalle_practicas = json_decode($_POST['componentes'], true);

// Validar que el JSON sea válido
if (!is_array($detalle_practicas)) {
    echo json_encode(['status' => 0, 'message' => 'Formato de datos inválido']);
    exit;
}

// Obtener total e id de usuario
$total = floatval($_POST['total']);
$idusu = intval($_POST['idusu']);

$exito = true; // Bandera de éxito global
$registros_nuevos = false; // Bandera para detectar si algunos registros son nuevos

foreach ($detalle_practicas as $detalle) {
    // Validar que los datos existan y no estén vacíos
    if (
        empty($detalle['id_practica_general']) ||
        empty($detalle['id_practica']) ||
        !isset($detalle['precio'])
    ) {
        $exito = false;
        break;
    }

    // Llamar al método para modificar el registro de prácticas
    $resultado = $MPP->Modificar_Detalle_practicas(
        $detalle['id_practica_general'],
        $detalle['id_practica'],
        $detalle['precio'],
        $total,
        $idusu
    );

    if ($resultado == 1) {
        $registros_nuevos = true; // Se detectó al menos un cambio
    } elseif ($resultado === 0) {
        // Si no se realizaron cambios, continuamos sin hacer nada
    } else {
        $exito = false; // Si ocurre un error, marcamos como fallo
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
