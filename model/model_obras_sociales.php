<?php
    require_once 'model_conexion.php';

    class Modelo_Obras_Sociales extends conexionBD{
        

        public function Listar_Obras_Sociales(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_OBRAS_SOCIALES()";
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Registrar_Obras_Sociales($cuit,$nombre,$domi,$local,$email,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_OBRA_SOCIAL(?,?,?,?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$cuit);
            $query ->bindParam(2,$nombre);
            $query ->bindParam(3,$domi);
            $query ->bindParam(4,$local);
            $query ->bindParam(5,$email);
            $query ->bindParam(6,$idusu);

            $resultado = $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
        public function Modificar_Obra_Social($id,$cuit,$nombre,$domi,$local,$email,$estado,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_OBRA_SOCIAL(?,?,?,?,?,?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$cuit);
            $query ->bindParam(3,$nombre);
            $query ->bindParam(4,$domi);
            $query ->bindParam(5,$local);
            $query ->bindParam(6,$email);
            $query ->bindParam(7,$estado);
            $query ->bindParam(8,$idusu);
            $resultado = $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
        public function Cargar_Select_Obras_Sociales(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_OBRAS_SOCIALES()";
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
        public function Eliminar_Obras_Sociales($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_OBRA(?)";
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
    }




?>