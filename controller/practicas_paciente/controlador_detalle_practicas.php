<?php
require '../../model/model_practicas_paciente.php';

$MPP = new Modelo_Practicas_Paciente(); // Instancia del modelo

// Recibir y limpiar los datos
$id = htmlspecialchars($_POST['id'], ENT_QUOTES, 'UTF-8');
$practicas = htmlspecialchars($_POST['practicas'], ENT_QUOTES, 'UTF-8');
$subtotal = htmlspecialchars($_POST['subtotal'], ENT_QUOTES, 'UTF-8');

// Convertimos los datos en arrays
$array_practicas = explode(",", $practicas);
$array_subtotal = explode(",", $subtotal);

// Validar que ambos arrays tengan la misma cantidad de elementos
if (count($array_practicas) !== count($array_subtotal)) {
    echo "Error: La cantidad de prácticas y subtotales no coincide.";
    exit;
}

// Insertar cada práctica con su respectivo subtotal
for ($i = 0; $i < count($array_practicas); $i++) { 
    $consulta = $MPP->Registrar_detalle_practicas($id, $array_practicas[$i], $array_subtotal[$i]);
    if (!$consulta) {
        echo "Error al registrar la práctica: " . $array_practicas[$i];
        exit;
    }
}

echo 1; // Confirmación de éxito
?>
