<?php
    require_once 'model_conexion.php';

    class Modelo_Area extends conexionBD{
        

        public function Listar_Area(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_LISTAR_AREA()";
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll(PDO::FETCH_ASSOC);
            foreach($resultado as $resp){
                $arreglo["data"][]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
        public function Registrar_Area($area,$descripcion,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_REGISTRAR_AREA(?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$area);
            $query ->bindParam(2,$descripcion);
            $query ->bindParam(3,$idusu);

            $resultado = $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
        public function Modificar_Area($id,$area,$descripcion,$esta,$idusu){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_MODIFICAR_AREA(?,?,?,?,?)";
            $query  = $c->prepare($sql);
            $query ->bindParam(1,$id);
            $query ->bindParam(2,$area);
            $query ->bindParam(3,$descripcion);
            $query ->bindParam(4,$esta);
            $query ->bindParam(5,$idusu);

            $resultado = $query->execute();
            if($row = $query->fetchColumn()){
                return $row;
            }
            conexionBD::cerrar_conexion();
        }
        public function Eliminar_Area($id){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_ELIMINAR_AREA(?)";
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
        public function Cargar_Select_Area(){
            $c = conexionBD::conexionPDO();
            $sql = "CALL SP_CARGAR_SELECT_AREA()";
            $query  = $c->prepare($sql);
            $query->execute();
            $resultado = $query->fetchAll();
            foreach($resultado as $resp){
                $arreglo[]=$resp;
            }
            return $arreglo;
            conexionBD::cerrar_conexion();
        }
    }




?>