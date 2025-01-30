<?php
class conexionBD {
    private $pdo;

    public function conexionPDO() {
        $host = "localhost";
        $usuario = "root";
        $contrasena = "";
        $bdName = "recupero";
        try {
            // Asignar la conexión a la propiedad de clase $this->pdo
            $this->pdo = new PDO("mysql:host=$host;dbname=$bdName", $usuario, $contrasena);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->pdo->exec("set names utf8");
            return $this->pdo;
        } catch (PDOException $e) {
            echo 'Falló la conexión: ' . $e->getMessage();
            return null; // Retorna null en caso de error
        }
    }

    public function cerrar_conexion() {
        $this->pdo = null; // Cerrar la conexión establecida
    }
}
?>
