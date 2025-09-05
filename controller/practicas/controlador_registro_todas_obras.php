<?php
require '../../model/model_practicas.php';

$MPR = new Modelo_Practicas();

// Recibir y limpiar los datos
$id = htmlspecialchars($_POST['id'], ENT_QUOTES, 'UTF-8');
$codigo = htmlspecialchars($_POST['codigo'], ENT_QUOTES, 'UTF-8');
$practica = htmlspecialchars($_POST['practica'], ENT_QUOTES, 'UTF-8');
$valor = htmlspecialchars($_POST['valor'], ENT_QUOTES, 'UTF-8');

// Validar datos requeridos
if (empty($id) || empty($codigo) || empty($practica) || empty($valor)) {
    echo "Error: Faltan datos requeridos.";
    exit;
}

try {
    // Llamar al procedimiento que registra para todas las obras sociales
    $consulta = $MPR->Registrar_practica_todas_obras($id, $codigo, $practica, $valor);
    
    if ($consulta) {
        echo 1; // Confirmación de éxito
    } else {
        echo "Error al registrar la práctica para todas las obras sociales.";
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>