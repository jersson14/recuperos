<?php
    require_once 'model_conexion.php';

    class Modelo_Facturas extends conexionBD{
        

        public function Listar_Facturas(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_PRACTICAS_FACTURAS()";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Listar_Facturas_todo(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_FACTURAS_TODO()";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
       
        public function Listar_facturas_edtado_obra($obra,$estado){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_FACTURAS_OBRA_ESTADO(?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->bindParam(1,$obra);
            $query->bindParam(2,$estado);

            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Listar_facturas_fecha_usu($fechaini,$fechafin,$usu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_FACTURAS_FECHAS_USU(?,?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->bindParam(1,$fechaini);
            $query->bindParam(2,$fechafin);
            $query->bindParam(3,$usu);

            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
      
        public function Registrar_Factura($nrofact, $total, $rutaFactura, $rutaNotacre, $fecha, $idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_FACTURA(?,?,?,?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$nrofact);
            $query ->bindParam(2,$total);
            $query ->bindParam(3,$rutaFactura);
            $query ->bindParam(4,$rutaNotacre);
            $query ->bindParam(5,$fecha);
            $query ->bindParam(6,$idusu);

            $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();

        }
        function Registrar_detalle_facturas($id, $array_practicas_paciente, $array_subtotal){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_DETALLE_FACTURA(?,?,?)"; // Se agregaron 3 placeholders
            $query = $c->prepare($sql);
            $query->bindParam(1, $id, PDO::PARAM_INT);
            $query->bindParam(2, $array_practicas_paciente, PDO::PARAM_INT);
            $query->bindParam(3, $array_subtotal, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            
            $resul = $query->execute();
            conexionBD::cerrar_conexion();
            
            return $resul ? 1 : 0;
        }
        


        public function Eliminar_Factura($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_FACTURA(?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
    
            $resul = $query->execute();
            if($resul){
                return 1;
            }else{
                return 0;
            }
            conexionBD::cerrar_conexion();
        }
        public function Modificar_Estado($id,$esta,$motivo,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_ESTADO(?,?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$esta);
            $query ->bindParam(3,$motivo);
            $query ->bindParam(4,$idusu);

            $resul = $query->execute();
            if($resul){
                return 1;
            }else{
                return 0;
            }
            conexionBD::cerrar_conexion();
        }
        public function Cargar_Usuarios(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_USUARIOS()";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll();
            foreach($resultado as $resp){
                $arreglo[]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Cargar_Areas(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_AREA()";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll();
            foreach($resultado as $resp){
                $arreglo[]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Cargar_Practicaspaciente_factura($id2){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_PACIENTEYPRACTICA_FACTURA(?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id2);
            $query->execute();
            $resultado = $query->fetchAll();
            foreach($resultado as $resp){
                $arreglo[]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
       
        public function Cargar_Traermonto($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_TRAER_PRECIO_PRACTICA_PACIENTE(?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query->execute();
            $resultado = $query->fetchAll();
            foreach($resultado as $resp){
                $arreglo[]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Listar_practicas_apci($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_VER_PRACTICAS_PACIENTE(?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->bindParam(1,$id);

            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }

        public function Listar_detalle_facturas($id){
            $c = conexionBD::conexionPDO();
            $arreglo = array();
            $sql = "CALL SP_LISTA_DETALLE_FACTURAS(?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        
        }
        public function Eliminar_detalle_practica_unico($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_DETALLE_PRACTICA(?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
    
            $resul = $query->execute();
            if($resul){
                return 1;
            }else{
                return 0;
            }
            conexionBD::cerrar_conexion();
        }
        public function Modificar_Detalle_practicas($idpracitcageneral,$idpracitca, $precio) {
            $c = conexionBD::conexionPDO();
        
            // Suponiendo que usas una consulta SQL o un procedimiento almacenado
            $sql = "CALL SP_MODIFICAR_DETALLE_PRACTICAS(?, ?,?)"; // Cambia esto a tu consulta real
            $query = $c->prepare($sql);
            $query->bindParam(1, $idpracitcageneral);
            $query->bindParam(2, $idpracitca);
            $query->bindParam(3, $precio);
        
            try {
                $query->execute();
                // Dependiendo del resultado, puedes devolver 1 para éxito o 0 para error
                // Asegúrate de ajustar esto según tu procedimiento almacenado o lógica SQL
                return $query->rowCount() > 0 ? 1 : 0; // 1 si se modificó algo, 0 si no
            } catch (PDOException $e) {
                error_log($e->getMessage()); // Guarda el error en el log del servidor
                return 0; // Error en la modificación
            } finally {
                conexionBD::cerrar_conexion();
            }
        }
        public function Listar_Historial_facturas($id){
            $c = conexionBD::conexionPDO();
            $arreglo = array();
            $sql = "CALL SP_LISTA_HISTORIAL_FACTURA(?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        
        }
        
    }




?>