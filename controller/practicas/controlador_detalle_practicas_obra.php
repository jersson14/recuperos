<?php
require '../../model/model_practicas.php';

$MPR = new Modelo_Practicas();

// Recibir y limpiar los datos
$id = htmlspecialchars($_POST['id'], ENT_QUOTES, 'UTF-8');
$codigo = htmlspecialchars($_POST['codigo'], ENT_QUOTES, 'UTF-8');
$practica = htmlspecialchars($_POST['practica'], ENT_QUOTES, 'UTF-8');
$valor = htmlspecialchars($_POST['valor'], ENT_QUOTES, 'UTF-8');
$idobra = htmlspecialchars($_POST['idobra'], ENT_QUOTES, 'UTF-8');

// Convertimos los datos en arrays
$array_codigo = explode(",", $codigo);
$array_practica = explode(",", $practica);
$array_valor = explode(",", $valor);
$array_idobra = explode(",", $idobra);

// Validar que todos los arrays tengan la misma cantidad de elementos
if (count($array_codigo) !== count($array_practica) || count($array_codigo) !== count($array_valor) || count($array_codigo) !== count($array_idobra)) {
    echo "Error: La cantidad de datos no coincide.";
    exit;
}

// Insertar cada práctica con su respectivo precio, cantidad y subtotal
for ($i = 0; $i < count($array_codigo); $i++) {
    $consulta = $MPR->Registrar_detalle_practicas_obras($id, $array_codigo[$i], $array_practica[$i], $array_valor[$i], $array_idobra[$i]);
    if (!$consulta) {
        echo "Error al registrar la práctica: " . $array_codigo[$i];
        exit;
    }
}

echo 1; // Confirmación de éxito
?>
