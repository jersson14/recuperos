<?php
    require_once 'model_conexion.php';

    class Modelo_Practicas extends conexionBD{
        

        public function Listar_Practicas(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_PRACTICAS()";
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
        public function Listar_practicas_filtro($fechaini,$fechafin){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_PRACTICAS_FILTRO(?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query->bindParam(1,$fechaini);
            $query->bindParam(2,$fechafin);

            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
         public function Registrar_Practicas($code,$pract,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_PRACTICAS(?,?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$code);
            $query ->bindParam(2,$pract);
            $query ->bindParam(3,$idusu);

            $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
         function Registrar_detalle_practicas_obras($id, $array_codigo,$array_practica,$array_valor, $array_idobra){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_DETALLE_PRACTICAS_OBRAS(?,?,?,?,?)"; // Se agregaron 3 placeholders
            $query = $c->prepare($sql);
            $query->bindParam(1, $id, PDO::PARAM_INT);
            $query->bindParam(2, $array_codigo, PDO::PARAM_INT);
            $query->bindParam(3, $array_practica, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            $query->bindParam(4, $array_valor, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            $query->bindParam(5, $array_idobra, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            
            $resul = $query->execute();
            conexionBD::cerrar_conexion();
            
            return $resul ? 1 : 0;
        }
        // Agregar este método a tu clase Modelo_Practicas existente

        function Registrar_practica_todas_obras($id, $codigo, $practica, $valor) {
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_PRACTICA_TODAS_OBRAS(?,?,?,?)";
            $query = $c->prepare($sql);
            $query->bindParam(1, $id, PDO::PARAM_INT);
            $query->bindParam(2, $codigo, PDO::PARAM_STR);
            $query->bindParam(3, $practica, PDO::PARAM_STR);
            $query->bindParam(4, $valor, PDO::PARAM_STR);
            
            $resul = $query->execute();
            conexionBD::cerrar_conexion();
            
            return $resul ? 1 : 0;
        }
        public function Modificar_Practicas($id,$code,$pract,$status,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_PRACTICAS(?,?,?,?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$code);
            $query ->bindParam(3,$pract);
            $query ->bindParam(4,$status);
            $query ->bindParam(5,$idusu);

            $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
        public function Eliminar_Practicas($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_PRACTICA(?)";
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
        public function Listar_Historial_practicas($id){
            $c = conexionBD::conexionPDO();
            $arreglo = array();
            $sql = "CALL SP_LISTA_HISTORIAL_PRACTICAS(?)";
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
         public function Listar_Practicas_Obra_Social($id){
            $c = conexionBD::conexionPDO();
            $arreglo = array();
            $sql = "CALL SP_LISTA_PRACTICAS_OBRAS_SOCIALES(?)";
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
                public function Eliminar_Practicas_Obras_sociales($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_PRACTICA_OBRAS(?)";
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
         public function Modificar_Practicas_Obras_masiva($id,$code,$pract,$valor,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_PRACTICAS_OBRAS_MASIVA(?,?,?,?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$code);
            $query ->bindParam(3,$pract);
            $query ->bindParam(4,$valor);
            $query ->bindParam(5,$idusu);

           $resul = $query->execute();
            if($resul){
                return 1;
            }else{
                return 0;
            }
            conexionBD::cerrar_conexion();
        }
          public function Modificar_Practicas_Obras($id,$code,$pract,$valor,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_PRACTICAS_OBRAS(?,?,?,?,?)";
            $arreglo = array();
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$code);
            $query ->bindParam(3,$pract);
            $query ->bindParam(4,$valor);
            $query ->bindParam(5,$idusu);

           $resul = $query->execute();
            if($resul){
                return 1;
            }else{
                return 0;
            }
            conexionBD::cerrar_conexion();
        }
         public function Listar_Historial_mod_practicas_obras($id){
            $c = conexionBD::conexionPDO();
            $arreglo = array();
            $sql = "CALL SP_LISTA_PRACTICAS_MOD_PRACTICAS_OBRAS_SOCIALES(?)";
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

        function Modificar_practica_todas_obras($id, $codigo, $practica, $valor) {
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_PRACTICA_TODAS_OBRAS2(?,?,?,?)";
            $query = $c->prepare($sql);
            $query->bindParam(1, $id, PDO::PARAM_INT);
            $query->bindParam(2, $codigo, PDO::PARAM_STR);
            $query->bindParam(3, $practica, PDO::PARAM_STR);
            $query->bindParam(4, $valor, PDO::PARAM_STR);
            
            $resul = $query->execute();
            conexionBD::cerrar_conexion();
            
            return $resul ? 1 : 0;
        }
         function Registrar_detalle_practicas_obras2($id, $array_codigo,$array_practica,$array_valor, $array_idobra){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_DETALLE_PRACTICAS_OBRAS2(?,?,?,?,?)"; // Se agregaron 3 placeholders
            $query = $c->prepare($sql);
            $query->bindParam(1, $id, PDO::PARAM_INT);
            $query->bindParam(2, $array_codigo, PDO::PARAM_INT);
            $query->bindParam(3, $array_practica, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            $query->bindParam(4, $array_valor, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            $query->bindParam(5, $array_idobra, PDO::PARAM_STR); // Asegurar que el subtotal sea string/decimal
            
            $resul = $query->execute();
            conexionBD::cerrar_conexion();
            
            return $resul ? 1 : 0;
        }
    }




?>