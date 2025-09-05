-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 05-09-2025 a las 19:19:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `recupero`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ANULAR_PAGO` (IN `ID` INT, IN `IDUSU` INT, IN `MOTIVO` VARCHAR(255), IN `MONTO_ANU` DECIMAL(8,2))   BEGIN
DECLARE IDFACT INT;
SET @IDFACT:=(SELECT historial_pagos.id_factura FROM historial_pagos where id_historial_pagos=ID);
UPDATE historial_pagos
SET
motivo_anulacion=MOTIVO,
estado='ANULADO',
created_at=NOW()
WHERE id_historial_pagos=ID;

UPDATE facturas
SET saldo_cobrado=saldo_cobrado-MONTO_ANU,
saldo_pendiente=saldo_pendiente+MONTO_ANU
WHERE facturas.id_factura=@IDFACT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_AREA` ()   SELECT
areas_hospital.id_area,
areas_hospital.nombre
FROM areas_hospital
WHERE areas_hospital.estado_area='ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_OBRAS_SOCIALES` ()   SELECT id_cuit,Cuit,Nombre
FROM obras_sociales
WHERE obras_sociales.estado_obra='ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PACIENTE` ()   SELECT
pacientes.Dni,
CONCAT_WS(pacientes.Nombres,' ',pacientes.Apellidos)as PACIENTE
FROM pacientes$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PACIENTEYPRACTICA` (IN `ID` INT)   BEGIN
SELECT
pacientes.id_paciente,
pacientes.Dni,
CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos)AS paciente
FROM obras_sociales INNER JOIN pacientes
ON obras_sociales.id_cuit=pacientes.Id_obra_social
WHERE obras_sociales.id_cuit=ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PACIENTEYPRACTICA2` (IN `ID` INT)   BEGIN
SELECT
practicas.`id_práctica`,
practicas.cod_practica,
practicas.practica
FROM obras_sociales INNER JOIN practicas
ON obras_sociales.id_cuit=practicas.id_obras
WHERE obras_sociales.id_cuit=ID and practicas.estado='ACTIVO';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PACIENTEYPRACTICA_FACTURA` (IN `ID` INT)   BEGIN
SELECT
	paciente_practica.id_paciente_practica,
	pacientes.Dni, 
	CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos) AS paciente 
FROM
	obras_sociales
	INNER JOIN
	pacientes
	ON 
		obras_sociales.id_cuit = pacientes.Id_obra_social
	INNER JOIN
	paciente_practica
	ON 
		pacientes.id_paciente = paciente_practica.id_paciente
WHERE
	obras_sociales.id_cuit = ID AND paciente_practica.tiene_factura=0 AND paciente_practica.estado='COMPLETADO';

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PRACTICAS` ()   SELECT 
practicas.id_práctica,
practicas.cod_practica,
practicas.practica

FROM practicas
WHERE practicas.estado='ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_SELECT_AREA` ()   SELECT
areas_hospital.id_area,areas_hospital.nombre
FROM areas_hospital
WHERE estado_area="ACTIVO"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_TRAER_PRECIO` (IN `ID` INT)   SELECT
practicas.cod_practica,
practicas.valor
FROM practicas
WHERE practicas.`id_práctica`=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_TRAER_PRECIO_PRACTICA_PACIENTE` (IN `ID` INT)   BEGIN
SELECT
	paciente_practica.id_paciente_practica, 
	paciente_practica.total
FROM
	paciente_practica
WHERE
	paciente_practica.id_paciente_practica = ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_USUARIOS` ()   SELECT 
    usuario.id_usuario,
    usuario.dni_usuario,
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM usuario
WHERE usuario.usu_estatus = 'ACTIVO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_AREA` (IN `ID` INT)   DELETE FROM areas_hospital
WHERE id_area=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_DETALLE_FACTURA` (IN `ID` INT)   BEGIN 

DECLARE IDPACI INT;

SET @IDPACI:=(SELECT detalle_fatura.id_practica_paciente FROM detalle_fatura where detalle_fatura.id_detalle_factura=ID);

DELETE FROM detalle_fatura
WHERE detalle_fatura.id_detalle_factura=ID;

UPDATE paciente_practica
set paciente_practica.tiene_factura=0
WHERE paciente_practica.id_paciente_practica=@IDPACI;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_DETALLE_PRACTICA` (IN `ID` INT)   DELETE FROM practica_totales
WHERE practica_totales.id_practica_paciente_total=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_FACTURA` (IN `ID` INT, IN `IDUSU` INT)   BEGIN
    -- Eliminar la relación en paciente_practica para todas las prácticas asociadas a la factura
    UPDATE paciente_practica
    SET paciente_practica.tiene_factura = 0
    WHERE paciente_practica.id_paciente_practica IN 
          (SELECT id_practica_paciente FROM detalle_fatura WHERE id_factura = ID);

		INSERT INTO historial_factura(id_factura,estado,motivo,created_at,id_usuario)
		VALUES(ID,'ELIMINADA','Factura eliminada',NOW(),IDUSU);

    -- Eliminar la factura
    UPDATE facturas 
		set facturas.estado_fact='ELIMINADA',
				created_at = NOW(),
				facturas.id_usuario=IDUSU
		WHERE facturas.id_factura = ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_OBRA` (IN `ID` INT)   DELETE FROM obras_sociales
WHERE obras_sociales.id_cuit=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PACIENTE` (IN `ID` INT)   DELETE FROM pacientes
WHERE pacienteS.id_paciente=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRACTICA` (IN `ID` INT)   DELETE FROM practicas
WHERE id_practica=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRACTICAS_PACIENTE` (IN `ID` INT)   BEGIN
DELETE FROM practica_totales
WHERE practica_totales.id_practica_paciente=ID;
DELETE FROM paciente_practica
WHERE paciente_practica.id_paciente_practica=ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRACTICA_OBRAS` (IN `ID` INT)   DELETE FROM practicas_obras_sociales WHERE practicas_obras_sociales.id_practicas_obras=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_AREA` ()   SELECT
id_area,
nombre,
descripcion,
areas_hospital.id_usuario,
areas_hospital.created_at,
	date_format(areas_hospital.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
areas_hospital.updated_at,
	date_format(areas_hospital.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2,
estado_area,
areas_hospital.updated_at,
usuario.usu_usuario,
	CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO 

FROM areas_hospital inner join usuario
ON areas_hospital.id_usuario=usuario.id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_EMPRESA` ()   SELECT 
id_empresa,
logo,
nombre,
email,
codigo,
telefono,
direccion,
created_at,
updated_ar
FROM empresa$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_ARCHIVADAS` ()   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE
	DATE(facturas.created_at) BETWEEN CURDATE() AND CURDATE() AND facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_FECHAS_USU` (IN `FECHAINI` DATE, IN `FECHAFIN` DATE, IN `USU` INT)   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.saldo_cobrado, 
	facturas.saldo_pendiente,  
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
	FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura

	WHERE DATE(facturas.created_at)  BETWEEN FECHAINI AND FECHAFIN OR usuario.id_usuario=USU AND NOT facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_FECHAS_USU_ARCHIVADO` (IN `FECHAINI` DATE, IN `FECHAFIN` DATE, IN `USU` INT)   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
	FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura

	WHERE  facturas.estado_fact='ELIMINADA' AND DATE(facturas.created_at)  BETWEEN FECHAINI AND FECHAFIN OR usuario.id_usuario=USU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_OBRA_ESTADO` (IN `IDOBRA` INT, IN `ESTADO` VARCHAR(25))   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.saldo_cobrado, 
	facturas.saldo_pendiente,  
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE
	obras_sociales.id_cuit=IDOBRA OR facturas.estado_fact=ESTADO AND NOT facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_OBRA_ESTADO_ARCHIVADO` (IN `IDOBRA` INT, IN `ESTADO` VARCHAR(25))   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE
	obras_sociales.id_cuit=IDOBRA AND facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_TODO` ()   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto,
	facturas.saldo_cobrado, 
	facturas.saldo_pendiente,  
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
	FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE NOT facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_FACTURAS_TODO_ARCHIVADO` ()   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
	FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_OBRAS_SOCIALES` ()   SELECT
obras_sociales.id_cuit,
obras_sociales.Cuit,
obras_sociales.Nombre,
obras_sociales.domicilio,
obras_sociales.localidad,
obras_sociales.email,
obras_sociales.id_usuario,
obras_sociales.estado_obra,
obras_sociales.created_at,
obras_sociales.updated_at,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(obras_sociales.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(obras_sociales.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM obras_sociales inner join usuario
ON obras_sociales.id_usuario=usuario.id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTES` ()   SELECT
pacientes.id_paciente,
pacientes.Dni,
pacientes.Nombres,
pacientes.Apellidos,
CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos) AS PACIENTE,
pacientes.Direccion,
pacientes.localidad,
pacientes.Telefono,
pacientes.Id_obra_social,
pacientes.id_usuario,
pacientes.created_at,
pacientes.updated_at,
obras_sociales.Cuit AS CODIGO,
obras_sociales.Nombre as OBRA,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(pacientes.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(pacientes.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM pacientes inner join obras_sociales
ON pacientes.Id_obra_social=obras_sociales.id_cuit inner join usuario
on pacientes.id_usuario=usuario.id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PACIENTES_FILTRO` (IN `OBRA` INT, IN `FECHAINI` DATE, IN `FECHAFIN` DATE)   BEGIN
  SELECT
    pacientes.id_paciente,
    pacientes.Dni,
    pacientes.Nombres,
    pacientes.Apellidos,
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE,
    pacientes.Direccion,
    pacientes.localidad,
    pacientes.Telefono,
    pacientes.Id_obra_social,
    pacientes.id_usuario,
    pacientes.created_at,
    pacientes.updated_at,
    obras_sociales.Cuit AS CODIGO,
    obras_sociales.Nombre AS OBRA,
    usuario.usu_usuario,
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO,
    DATE_FORMAT(pacientes.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada,
    DATE_FORMAT(pacientes.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2
  FROM 
    pacientes
  INNER JOIN 
    obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
  INNER JOIN 
    usuario ON pacientes.id_usuario = usuario.id_usuario
  WHERE 
    pacientes.Id_obra_social = OBRA 
    OR DATE(pacientes.created_at) BETWEEN FECHAINI AND FECHAFIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS` ()   SELECT
practicas.id_practica,
practicas.cod_practica,
practicas.practica,
practicas.estado,
practicas.id_usu,
practicas.created_at,
practicas.updated_at,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(practicas.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(practicas.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM practicas inner join usuario
on practicas.id_usu=usuario.id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_FACTURAS` ()   SELECT DISTINCT
	facturas.id_factura, 
	facturas.numero_fact, 
	facturas.monto, 
	facturas.saldo_cobrado, 
	facturas.saldo_pendiente,  
	facturas.archivo_fact, 
	facturas.fecha_nota_credito, 
	DATE_FORMAT(facturas.fecha_nota_credito, "%d-%m-%Y") AS fecha_credito, 
	facturas.nota_credito, 
	facturas.estado_fact, 
	facturas.created_at, 
	facturas.updated_at, 
	DATE_FORMAT(facturas.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
	DATE_FORMAT(facturas.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
	facturas.id_usuario, 
	obras_sociales.id_cuit, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre AS obra_social, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido, 
	CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM
	facturas
	INNER JOIN
	detalle_fatura
	ON 
		facturas.id_factura = detalle_fatura.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	obras_sociales
	INNER JOIN
	practicas
	ON 
		obras_sociales.id_cuit = practicas.id_obras
	INNER JOIN
	practica_totales
	ON 
		practicas.`id_práctica` = practica_totales.id_practica AND
		paciente_practica.id_paciente_practica = practica_totales.id_practica_paciente
	INNER JOIN
	usuario
	ON 
		facturas.id_usuario = usuario.id_usuario
	INNER JOIN
	historial_factura
	ON 
		facturas.id_factura = historial_factura.id_factura
WHERE
	DATE(facturas.created_at) BETWEEN CURDATE() AND CURDATE() AND NOT facturas.estado_fact='ELIMINADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_FILTRO` (IN `FECHAINI` DATE, IN `FECHAFIN` DATE)   BEGIN
SELECT
practicas.id_practica,
practicas.cod_practica,
practicas.practica,
practicas.estado,
practicas.id_usu,
practicas.created_at,
practicas.updated_at,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(practicas.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(practicas.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM practicas inner join usuario
on practicas.id_usu=usuario.id_usuario
 WHERE DATE(practicas.created_at) BETWEEN FECHAINI AND FECHAFIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_OBRA` (IN `ID` INT)   SELECT
	paciente_practica.id_paciente_practica,
	pacientes.Dni, 
	CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos) AS paciente,
	paciente_practica.total
FROM
	obras_sociales
	INNER JOIN
	pacientes
	ON 
		obras_sociales.id_cuit = pacientes.Id_obra_social
	INNER JOIN
	paciente_practica
	ON 
		pacientes.id_paciente = paciente_practica.id_paciente
WHERE
	obras_sociales.id_cuit =ID  AND paciente_practica.tiene_factura=0 AND paciente_practica.estado='COMPLETADO'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES` ()   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
		paciente_practica.historia_clinica,
		paciente_practica.estado,
    paciente_practica.id_usuario,
	    paciente_practica.tiene_factura, 	
    paciente_practica.created_at, 
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_DIARIO` ()   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario, 
    paciente_practica.created_at,
		    paciente_practica.tiene_factura, 	
			paciente_practica.historia_clinica,
		paciente_practica.estado,
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE DATE(paciente_practica.created_at)  BETWEEN CURDATE() AND CURDATE()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_DIARIO_MEDICO` (IN `IDUSU` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario, 
    paciente_practica.created_at,
		    paciente_practica.tiene_factura, 	
			paciente_practica.historia_clinica,
		paciente_practica.estado,
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE DATE(paciente_practica.created_at)  BETWEEN CURDATE() AND CURDATE() AND paciente_practica.id_usuario=IDUSU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_FECHAS` (IN `FECHAINI` DATE, IN `FECHAFIN` DATE, IN `USU` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario, 
    paciente_practica.created_at,
		    paciente_practica.tiene_factura, 	
			paciente_practica.historia_clinica,
		paciente_practica.estado,
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE DATE(paciente_practica.created_at)  BETWEEN FECHAINI AND FECHAFIN OR usuario.id_usuario=USU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_FECHAS_MEDICO` (IN `FECHAINI` DATE, IN `FECHAFIN` DATE, IN `USU` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario, 
    paciente_practica.created_at,
		    paciente_practica.tiene_factura, 	
			paciente_practica.historia_clinica,
		paciente_practica.estado,
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE DATE(paciente_practica.created_at)  BETWEEN FECHAINI AND FECHAFIN AND usuario.id_usuario=USU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_FILTRO` (IN `ID` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario,
		paciente_practica.historia_clinica,
		paciente_practica.estado,
		    paciente_practica.tiene_factura, 		
    paciente_practica.created_at, 
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE pacientes.Id_obra_social=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_FILTRO_MEDICO` (IN `ID` INT, IN `IDUSU` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario,
		paciente_practica.historia_clinica,
		paciente_practica.estado,
		    paciente_practica.tiene_factura, 		
    paciente_practica.created_at, 
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
	WHERE pacientes.Id_obra_social=ID AND paciente_practica.id_usuario=IDUSU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_PACIENTES_MEDICO` (IN `IDUSU` INT)   SELECT
    pacientes.id_paciente, 
    pacientes.Dni, 
    CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
    pacientes.Nombres, 
    pacientes.Apellidos, 
    paciente_practica.id_paciente_practica, 
    paciente_practica.id_area, 
    paciente_practica.id_paciente, 
    paciente_practica.total, 
    paciente_practica.id_usuario,
		paciente_practica.historia_clinica,
		paciente_practica.estado,
	    paciente_practica.tiene_factura, 	
    paciente_practica.created_at, 
    paciente_practica.updated_at, 
    DATE_FORMAT(paciente_practica.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada, 
    DATE_FORMAT(paciente_practica.updated_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada2, 
    areas_hospital.id_area, 
    areas_hospital.nombre AS area_nombre, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido, 
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO, 
    obras_sociales.id_cuit, 
    obras_sociales.Cuit, 
    obras_sociales.Nombre AS obra_social
FROM pacientes
INNER JOIN paciente_practica ON pacientes.id_paciente = paciente_practica.id_paciente
LEFT JOIN usuario ON paciente_practica.id_usuario = usuario.id_usuario
LEFT JOIN areas_hospital ON paciente_practica.id_area = areas_hospital.id_area
LEFT JOIN obras_sociales ON pacientes.Id_obra_social = obras_sociales.id_cuit
WHERE paciente_practica.id_usuario=IDUSU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_FACTURAS` ()   SELECT COUNT(facturas.id_factura)
FROM facturas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_FACTURAS_COBRADAS` ()   SELECT COUNT(facturas.id_factura)
FROM facturas
WHERE facturas.estado_fact='COBRADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_FACTURAS_PENDIENTES` ()   SELECT COUNT(facturas.id_factura)
FROM facturas
WHERE facturas.estado_fact='PENDIENTE'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_FACTURAS_RECHAZADA` ()   SELECT COUNT(facturas.id_factura)
FROM facturas
WHERE facturas.estado_fact='RECHAZADA'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_OBRAS_SOCIALES` ()   SELECT COUNT(obras_sociales.id_cuit)as total_obras
FROM obras_sociales$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_PACIENTES` ()   SELECT COUNT(pacientes.id_paciente)as total_pacientes
FROM pacientes$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_PRACTICAS` ()   SELECT COUNT(practicas.`id_practica`)as total_practicas
FROM practicas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_TOTAL_PRACTICAS_PACIENTE` ()   SELECT COUNT(paciente_practica.id_paciente_practica)
FROM paciente_practica$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_USUARIO` ()   SELECT
	usuario.id_usuario, 
	usuario.dni_usuario,
	usuario.usu_nombre, 
	usuario.usu_apellido,
	CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,  
 
	usuario.usu_email, 
	usuario.usu_direccion, 
	usuario.usu_usuario, 
	usuario.usu_contrasenia, 
	usuario.usu_rol, 
	usuario.usu_estatus, 
	usuario.usu_telefono,
	usuario.id_empresa, 
	usuario.created_at,
	usuario.updated_at,
	date_format(usuario.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
	usuario.usu_foto,
	empresa.id_empresa

FROM
	usuario
	INNER JOIN
	empresa
	ON 
		usuario.id_empresa = empresa.id_empresa$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_VER_PRACTICAS_PACIENTE` (IN `ID` INT)   SELECT
	pacientes.id_paciente, 
	pacientes.Dni, 
	pacientes.Nombres, 
	pacientes.Apellidos, 
	CONCAT_WS(' ', pacientes.Nombres, pacientes.Apellidos) AS PACIENTE, 
	paciente_practica.id_paciente_practica, 
	practica_totales.id_practica_paciente_total, 
	practica_totales.id_practica_paciente, 
	practica_totales.id_practica,
	practica_totales.precio_unitario as PRECIOUNI, 
	practica_totales.cantidad AS CANTIDAD, 	
	practica_totales.subtotal, 
	practicas.`id_práctica`, 
	practicas.cod_practica, 
	practicas.practica AS PRACTICA, 
	practica_totales.created_at, 
	practica_totales.updated_at
FROM
	practica_totales
	INNER JOIN
	practicas
	ON 
		practica_totales.id_practica = practicas.`id_práctica`
	INNER JOIN
	paciente_practica
	ON 
		practica_totales.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	pacientes
	ON 
		paciente_practica.id_paciente = pacientes.id_paciente
	WHERE practica_totales.id_practica_paciente=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_DETALLE_FACTURAS` (IN `ID` INT)   SELECT
	detalle_fatura.id_detalle_factura, 
	detalle_fatura.id_factura, 
	detalle_fatura.id_practica_paciente, 
	detalle_fatura.subtotal,
	detalle_fatura.created_at, 
	pacientes.id_paciente, 
	pacientes.Dni, 
	pacientes.Nombres, 
	pacientes.Apellidos,
	CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos) AS PACIENTE
FROM
	detalle_fatura
	INNER JOIN
	facturas
	ON 
		detalle_fatura.id_factura = facturas.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	pacientes
	ON 
		paciente_practica.id_paciente = pacientes.id_paciente
	WHERE detalle_fatura.id_factura=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_DETALLE_FACTURAS_EDITAR` (IN `ID` INT)   SELECT
	detalle_fatura.id_detalle_factura, 
	detalle_fatura.id_factura, 
	detalle_fatura.id_practica_paciente, 
	detalle_fatura.subtotal,
	detalle_fatura.created_at, 
	pacientes.id_paciente, 
	pacientes.Dni, 
	pacientes.Nombres, 
	pacientes.Apellidos,
	CONCAT_WS(' ',pacientes.Nombres,pacientes.Apellidos) AS PACIENTE
FROM
	detalle_fatura
	INNER JOIN
	facturas
	ON 
		detalle_fatura.id_factura = facturas.id_factura
	INNER JOIN
	paciente_practica
	ON 
		detalle_fatura.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	pacientes
	ON 
		paciente_practica.id_paciente = pacientes.id_paciente
	WHERE detalle_fatura.id_factura=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_DETALLE_PRACTICAS` (IN `ID` INT)   SELECT
	practica_totales.id_practica_paciente_total, 
	practica_totales.id_practica_paciente, 
	practica_totales.id_practica,
	practica_totales.precio_unitario, 
	practica_totales.cantidad, 
	practica_totales.subtotal, 
	practica_totales.created_at, 
	practica_totales.updated_at, 
	paciente_practica.id_paciente_practica, 
	practicas.cod_practica, 
	practicas.practica
FROM
	practica_totales
	INNER JOIN
	paciente_practica
	ON 
		practica_totales.id_practica_paciente = paciente_practica.id_paciente_practica
	INNER JOIN
	practicas
	ON 
		practica_totales.id_practica = practicas.`id_práctica`
WHERE
	practica_totales.id_practica_paciente = ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_HISTORIAL_FACTURA` (IN `ID` INT)   SELECT DISTINCT
    historial_factura.id_historial_factur, 
    historial_factura.id_factura, 
    historial_factura.estado, 
    historial_factura.created_at,
    DATE_FORMAT(historial_factura.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada,
historial_factura.motivo,
    historial_factura.id_usuario, 
    usuario.id_usuario, 
    usuario.dni_usuario, 
    usuario.usu_nombre, 
    usuario.usu_apellido,
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO

FROM historial_factura
INNER JOIN usuario ON historial_factura.id_usuario = usuario.id_usuario
WHERE historial_factura.id_factura = ID
ORDER BY historial_factura.id_historial_factur DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_HISTORIAL_PAGOS` (IN `ID` INT)   SELECT
    historial_pagos.id_historial_pagos,
    historial_pagos.monto_pagado,
    historial_pagos.id_usu,
    historial_pagos.motivo_anulacion,
    historial_pagos.created_at as fecha_anula,
    historial_pagos.id_factura,
    historial_pagos.estado,
    DATE_FORMAT(historial_pagos.created_at, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada,
    CONCAT_WS(' ', usuario.usu_nombre, usuario.usu_apellido) AS USUARIO
FROM
    historial_pagos
INNER JOIN
    facturas ON historial_pagos.id_factura = facturas.id_factura
INNER JOIN
    usuario ON usuario.id_usuario = historial_pagos.id_usu  -- Cambio aquí para obtener el usuario correcto
WHERE 
    historial_pagos.id_factura =ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_HISTORIAL_PRACTICAS` (IN `p_id` INT)   BEGIN
    SELECT
        hp.id_actualiza_practica, 
        hp.id_usuario, 
        -- columnas actuales desde la tabla de prácticas
        p.cod_practica,
        hp.id_practica,  
        p.practica, 
        hp.fecha_actualización,
        DATE_FORMAT(hp.fecha_actualización, "%d-%m-%Y - %H:%i:%s") AS fecha_formateada,
        u.dni_usuario, 
        u.usu_nombre, 
        u.usu_apellido,
        CONCAT_WS(' ', u.usu_nombre, u.usu_apellido) AS USUARIO
    FROM historial_practicas hp
    JOIN practicas p ON hp.id_practica = p.id_practica
    LEFT JOIN usuario u ON hp.id_usuario = u.id_usuario
    WHERE hp.id_practica = p_id
    ORDER BY hp.fecha_actualización DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_PRACTICAS_MOD_PRACTICAS_OBRAS_SOCIALES` (IN `ID` INT)   SELECT
	historial_practicas_obras_sociales.id_historial, 
	historial_practicas_obras_sociales.id_practica_obra, 
	historial_practicas_obras_sociales.cod_practica_nuevo, 
	historial_practicas_obras_sociales.practica_nueva, 
	historial_practicas_obras_sociales.valor_nuevo, 
	historial_practicas_obras_sociales.id_usuario, 
	historial_practicas_obras_sociales.fecha_actualizacion, 
  	date_format(historial_practicas_obras_sociales.fecha_actualizacion, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,

	historial_practicas_obras_sociales.tipo, 
	usuario.id_usuario, 
	usuario.dni_usuario, 
	usuario.usu_nombre, 
	usuario.usu_apellido,
  CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO
FROM
	usuario
	INNER JOIN
	practicas
	ON 
		practicas.id_usu = usuario.id_usuario
	INNER JOIN
	practicas_obras_sociales
	ON 
		practicas_obras_sociales.id_practica = practicas.id_practica
	INNER JOIN
	historial_practicas_obras_sociales
	ON 
		historial_practicas_obras_sociales.id_practica_obra = practicas_obras_sociales.id_practicas_obras
    WHERE historial_practicas_obras_sociales.id_practica_obra=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTA_PRACTICAS_OBRAS_SOCIALES` (IN `ID` INT)   SELECT
	practicas_obras_sociales.id_practicas_obras, 
	practicas_obras_sociales.id_practica, 
	practicas_obras_sociales.id_obra, 
	practicas_obras_sociales.nombre_prac, 
	practicas_obras_sociales.codigo_prac, 
	practicas_obras_sociales.valor, 
	practicas_obras_sociales.created_at, 
	obras_sociales.Cuit, 
	obras_sociales.Nombre, 
	practicas.id_practica, 
	practicas.cod_practica, 
	practicas.practica
FROM
	practicas_obras_sociales
	INNER JOIN
	practicas
	ON 
		practicas.id_practica = practicas_obras_sociales.id_practica
	INNER JOIN
	obras_sociales
	ON 
		obras_sociales.id_cuit = practicas_obras_sociales.id_obra
  WHERE practicas_obras_sociales.id_practica=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_AREA` (IN `ID` INT, IN `NAREA` VARCHAR(255), IN `DESCRIP` VARCHAR(255), IN `ESTADO` VARCHAR(20), IN `USU` INT)   BEGIN
DECLARE AREAACTUAL VARCHAR(255);
DECLARE CANTIDAD INT;
SET @AREAACTUAL:=(SELECT nombre FROM areas_hospital WHERE id_area=ID);
IF @AREAACTUAL = NAREA THEN
	UPDATE areas_hospital SET
	nombre=NAREA,
	descripcion=DESCRIP,
	estado_area=ESTADO,
	id_usuario=USU,
	updated_at =NOW()
	WHERE id_area=ID;
	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM areas_hospital WHERE nombre=NAREA);
	IF @CANTIDAD=0 THEN
	UPDATE areas_hospital SET
	nombre=NAREA,
	descripcion=DESCRIP,
	estado_area=ESTADO,
	id_usuario=USU,
	updated_at =NOW()
	WHERE id_area=ID;
		SELECT 1;	
	ELSE
		SELECT 2;	
	END IF;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_DETALLE_FACTURA` (IN `ID` INT, IN `PRACTICA` VARCHAR(255), IN `SUBTO` DECIMAL(8,2), IN `TOTA` DECIMAL(8,2), IN `USU` INT)   BEGIN
    DECLARE ULTI INT;

    -- Verificar si las prácticas ya existen en `detalle_fatura`
    IF NOT EXISTS (
        SELECT 1 
        FROM detalle_fatura 
        WHERE id_factura = ID 
        AND FIND_IN_SET(id_practica_paciente, PRACTICA) > 0
    ) THEN
        -- Insertar todas las prácticas si no existen
        INSERT INTO detalle_fatura (id_factura, id_practica_paciente, subtotal, created_at)
        SELECT ID, CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(PRACTICA, ',', n.digit+1), ',', -1) AS UNSIGNED), SUBTO, NOW()
        FROM (SELECT 0 digit UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
              UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) n
        WHERE n.digit < (LENGTH(PRACTICA) - LENGTH(REPLACE(PRACTICA, ',', '')) + 1);

        -- Obtener el último ID insertado
        SET ULTI = (SELECT MAX(id_practica_paciente) FROM detalle_fatura 
                    WHERE id_factura = ID AND FIND_IN_SET(id_practica_paciente, PRACTICA) > 0);

        -- Actualizar `paciente_practica` para todas las prácticas afectadas
        UPDATE paciente_practica
        SET tiene_factura = 1
        WHERE FIND_IN_SET(id_paciente_practica, PRACTICA) > 0;
    END IF;

    -- Actualizar la factura con el nuevo monto y usuario
    UPDATE facturas
    SET 
        monto = TOTA,
        updated_at = NOW(),
        id_usuario = USU
    WHERE id_factura = ID;

    -- Devolver el último ID insertado
    SELECT ULTI AS ultimo_id_insertado;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_DETALLE_PRACTICAS` (IN `ID` INT, IN `PRACTICA` INT, IN `PRECI` DECIMAL(8,2), IN `CANTI` INT, IN `SUBTO` DECIMAL(8,2), IN `TOTA` DECIMAL(8,2), IN `USU` INT)   BEGIN
    -- Verificar si la práctica ya existe en la tabla `practica_totales`
    IF NOT EXISTS (
        SELECT 1 
        FROM practica_totales 
        WHERE id_practica_paciente = ID 
        AND id_practica = PRACTICA
    ) THEN
        -- Insertar solo si no existe
        INSERT INTO practica_totales(id_practica_paciente, id_practica,precio_unitario,cantidad, subtotal,updated_at)
        VALUES(ID, PRACTICA,PRECI,CANTI, SUBTO, NOW());
    END IF;

    -- Actualizar la fecha de modificación de la práctica del paciente
    UPDATE paciente_practica
    SET 
		total = TOTA,
		updated_at = NOW(),
		id_usuario=USU
    WHERE id_paciente_practica = ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_EMPRESA` (IN `ID` INT, IN `NOMBRE` VARCHAR(250), IN `EMAIL` VARCHAR(250), IN `COD` VARCHAR(10), IN `TELEFONO` VARCHAR(20), IN `DIRECCION` VARCHAR(250))   UPDATE empresa SET
	nombre=NOMBRE,
	email=EMAIL,
	codigo=COD,
	telefono=TELEFONO,
	direccion=DIRECCION,
	updated_ar =NOW()
	WHERE id_empresa=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_EMPRESA_FOTO` (IN `ID` INT, IN `RUTA` VARCHAR(255))   UPDATE empresa SET
logo=RUTA
WHERE id_empresa=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_ESTADO` (IN `ID` INT, IN `ESTA` VARCHAR(20), IN `MOTIVO` VARCHAR(255), IN `USU` INT)   BEGIN
    DECLARE ID_CAMBIO INT;
    DECLARE done INT DEFAULT FALSE;

    -- Cursor para manejar múltiples IDs
    DECLARE cur CURSOR FOR 
    SELECT detalle_fatura.id_practica_paciente  
    FROM facturas 
    INNER JOIN detalle_fatura ON facturas.id_factura = detalle_fatura.id_factura 
    WHERE detalle_fatura.id_factura = ID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ID_CAMBIO;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Actualizar el estado de cada detalle relacionado
        IF ESTA = 'RECHAZADA' THEN
            UPDATE paciente_practica
            SET tiene_factura = 0
            WHERE paciente_practica.id_paciente_practica = ID_CAMBIO;
        ELSE
            UPDATE paciente_practica
            SET tiene_factura = 1
            WHERE paciente_practica.id_paciente_practica = ID_CAMBIO;
        END IF;

    END LOOP;

    CLOSE cur;

    -- ✅ Insertar en historial UNA SOLA VEZ después del bucle
    UPDATE facturas
    SET estado_fact = ESTA,
		updated_at = NOW()
    WHERE id_factura = ID;

    INSERT INTO historial_factura(id_factura, estado,motivo, created_at, id_usuario) 
    VALUES (ID, ESTA,MOTIVO, NOW(), USU);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_FACTURA` (IN `ID` INT, IN `TOTALPRA` DECIMAL(8,2), IN `FACT` VARCHAR(500), IN `NOTACRE` VARCHAR(500), IN `FECHANOTACRE` DATE, IN `IDUSU` INT)   BEGIN 


UPDATE facturas
SET monto = TOTALPRA,
archivo_fact=FACT,
nota_credito=NOTACRE,
fecha_nota_credito=FECHANOTACRE,
updated_at =NOW(),
id_usuario = IDUSU
WHERE facturas.id_factura=ID;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_FACTURA_ARCHIVO` (IN `ID` INT, IN `FACT` VARCHAR(500), IN `NOTACRE` VARCHAR(500), IN `FECHANOTACRE` DATE, IN `IDUSU` INT)   BEGIN 


UPDATE facturas
SET 
archivo_fact=FACT,
nota_credito=NOTACRE,
fecha_nota_credito=FECHANOTACRE,
updated_at =NOW(),
id_usuario = IDUSU
WHERE facturas.id_factura=ID;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_FACTURA_SOLA` (IN `TOTAL` DECIMAL(8,2), IN `ID` INT, IN `IDFAC` INT)   UPDATE facturas
set facturas.monto=TOTAL,
		facturas.id_usuario=ID,
		facturas.updated_at=NOW()
		WHERE facturas.id_factura=IDFAC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_HC` (IN `ID` INT, IN `RUTA` VARCHAR(500))   UPDATE paciente_practica SET
historia_clinica=RUTA,
estado='COMPLETADO'
WHERE id_paciente_practica=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_OBRA_SOCIAL` (IN `ID` INT, IN `NCUIT` CHAR(11), IN `NOMB` VARCHAR(255), IN `DOMICILIO` TEXT, IN `LOCALIDAD` VARCHAR(255), IN `EMAIL` VARCHAR(40), IN `ESTATUS` VARCHAR(20), IN `IDUSU` INT)   BEGIN
DECLARE OBRAACTUAL VARCHAR(255);
DECLARE CANTIDAD INT;
SET @OBRAACTUAL:=(SELECT Cuit FROM obras_sociales WHERE id_cuit=ID);
IF @OBRAACTUAL = NCUIT THEN
	UPDATE obras_sociales SET
	Cuit=NCUIT,
	Nombre=NOMB,
	domicilio=DOMICILIO,
	localidad=LOCALIDAD,
	email=EMAIL,
	estado_obra=ESTATUS,
	id_usuario=IDUSU,
	updated_at =NOW()
	WHERE id_cuit=ID;
	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM obras_sociales WHERE Cuit=NCUIT);
	IF @CANTIDAD=0 THEN
UPDATE obras_sociales SET
	Cuit=NCUIT,
	Nombre=NOMB,
	domicilio=DOMICILIO,
	localidad=LOCALIDAD,
	email=EMAIL,
	estado_obra=ESTATUS,
	id_usuario=IDUSU,
	updated_at =NOW()
	WHERE id_cuit=ID;
		SELECT 1;	
	ELSE
		SELECT 2;	
	END IF;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PACIENTE` (IN `ID` INT, IN `NDNI` CHAR(8), IN `NOMBRE` VARCHAR(255), IN `APE` VARCHAR(255), IN `DIREC` VARCHAR(255), IN `LOCALIDA` VARCHAR(255), IN `TELE` CHAR(11), IN `OBRA` INT, IN `USU` INT)   BEGIN
DECLARE PACIENTEACTUAL VARCHAR(255);
DECLARE CANTIDAD INT;
SET @PACIENTEACTUAL:=(SELECT Dni FROM pacientes WHERE id_paciente=ID);
IF @PACIENTEACTUAL = NDNI THEN
	UPDATE pacientes SET
	Dni=NDNI,
	Nombres=NOMBRE,
	Apellidos=APE,
	Direccion=DIREC,
	localidad=LOCALIDA,
	Telefono=TELE,
	Id_obra_social=OBRA,
	id_usuario=USU,
	updated_at =NOW()
	WHERE id_paciente=ID;
	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM pacientes WHERE Dni=NDNI);
	IF @CANTIDAD=0 THEN
	UPDATE pacientes SET
	Dni=NDNI,
	Nombres=NOMBRE,
	Apellidos=APE,
	Direccion=DIREC,
	localidad=LOCALIDA,
	Telefono=TELE,
	Id_obra_social=OBRA,
	id_usuario=USU,
	updated_at =NOW()
	WHERE id_paciente=ID;
		SELECT 1;	
	ELSE
		SELECT 2;	
	END IF;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PRACTICAS` (IN `ID` INT, IN `CODI` CHAR(8), IN `PRACT` VARCHAR(500), IN `VAL` DECIMAL(8,2), IN `OBRA` INT, IN `ESTA` VARCHAR(20), IN `USU` INT)   BEGIN
DECLARE PRACTICAACTUAL VARCHAR(255);
DECLARE CANTIDAD INT;
SET @PRACTICAACTUAL:=(SELECT cod_practica FROM practicas WHERE id_práctica=ID);
IF @PRACTICAACTUAL = CODI THEN
	UPDATE practicas SET
	cod_practica=CODI,
	practica=PRACT,
	valor=VAL,
	estado=ESTA,
	id_usu=USU,
	id_obras=OBRA,
	updated_at =NOW()
	WHERE id_práctica=ID;
	INSERT INTO historial_practicas(id_practica,Valor_monetario,id_usuario,fecha_actualización)VALUES(ID,VAL,USU,NOW());

	SELECT 1;
ELSE
SET @CANTIDAD:=(SELECT COUNT(*) FROM practicas WHERE cod_practica=CODI);
	IF @CANTIDAD=0 THEN
	UPDATE practicas SET
	cod_practica=CODI,
	practica=PRACT,
	valor=VAL,
	estado=ESTA,
	id_usu=USU,
	id_obras=OBRA,
	updated_at =NOW()
	WHERE id_práctica=ID;

INSERT INTO historial_practicas(id_practica,Valor_monetario,id_usuario,fecha_actualización)VALUES(ID,VAL,USU,NOW());
		SELECT 1;	
	ELSE
		SELECT 2;	
	END IF;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PRACTICAS_OBRAS` (IN `ID` INT, IN `COD` CHAR(8), IN `PRACTI` VARCHAR(255), IN `VALOR` DECIMAL(8,2), IN `IDUSU` INT)   BEGIN
    UPDATE practicas_obras_sociales
    SET
        codigo_prac = COD,
        nombre_prac = PRACTI,
        valor = VALOR,
        updated_at = NOW()
    WHERE id_practicas_obras = ID;

    INSERT INTO historial_practicas_obras_sociales(
        id_practica_obra,
        cod_practica_nuevo,
        practica_nueva,
        valor_nuevo,
        id_usuario,
        fecha_actualizacion,
        tipo
    )
    VALUES (ID, COD, PRACTI, VALOR, IDUSU, NOW(),'MODIFICACIÓN INDIVIDUAL');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PRACTICAS_OBRAS_MASIVA` (IN `ID` INT, IN `COD` CHAR(8), IN `PRACTI` VARCHAR(255), IN `VALOR` DECIMAL(8,2), IN `IDUSU` INT)   BEGIN
    -- Primero actualizamos los registros deseados
    UPDATE practicas_obras_sociales
    SET
        codigo_prac = COD,
        nombre_prac = PRACTI,
        valor = VALOR,
        updated_at = NOW()
    WHERE id_practica = ID;

    -- Ahora insertamos en historial todos los ids de practicas_obras_sociales 
    -- que cumplan la condición (mismo ID en id_practica)
    INSERT INTO historial_practicas_obras_sociales(
        id_practica_obra,
        cod_practica_nuevo,
        practica_nueva,
        valor_nuevo,
        id_usuario,
        fecha_actualizacion,
        tipo
    )
    SELECT 
        po.id_practicas_obras,  -- el id real de la tabla padre
        COD,
        PRACTI,
        VALOR,
        IDUSU,
        NOW(),
        'MODIFICACIÓN MASIVA'
    FROM practicas_obras_sociales po
    WHERE po.id_practica = ID;  -- aquí seleccionas todos los que acabas de actualizar
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_PRACTICA_SOLA` (IN `TOTA` DECIMAL(8,2), IN `ID` INT, IN `IDPRA` INT)   UPDATE paciente_practica
set paciente_practica.total=TOTA,
		paciente_practica.id_usuario=ID,
		paciente_practica.updated_at=NOW()
		WHERE paciente_practica.id_paciente_practica=IDPRA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_USUARIO` (IN `ID` INT, IN `DNI` CHAR(8), IN `NOMBRE` VARCHAR(50), IN `APELLIDO` VARCHAR(50), IN `EMAIL` VARCHAR(255), IN `TELEFONO` CHAR(11), IN `DIRECCION` TEXT, IN `FOTO` VARCHAR(255), IN `USU` VARCHAR(255), IN `ROL` VARCHAR(25))   BEGIN
    DECLARE CANTIDAD_DNI INT;
    DECLARE CANTIDAD_USU INT;
    DECLARE USUARIOACTUAL VARCHAR(255);

    -- Verificar si el DNI ya existe en otro registro (que no sea el mismo usuario)
    SET @CANTIDAD_DNI := (SELECT COUNT(*) FROM usuario WHERE dni_usuario = DNI AND id_usuario != ID_USUARIO);

    -- Verificar si el nombre de usuario ya existe en otro registro (que no sea el mismo usuario)
    SET @CANTIDAD_USU := (SELECT COUNT(*) FROM usuario WHERE usu_usuario = USU AND id_usuario != ID_USUARIO);

    -- Si el DNI y el nombre de usuario no existen como duplicados
    IF @CANTIDAD_DNI = 0 AND @CANTIDAD_USU = 0 THEN
        -- Realizar la actualización del usuario
        UPDATE usuario
        SET 
            dni_usuario = DNI,
            usu_nombre = NOMBRE,
            usu_apellido = APELLIDO,
            usu_email = EMAIL,
            usu_telefono = TELEFONO,
            usu_direccion = DIRECCION,
            usu_usuario = USU,
            usu_rol = ROL,
            usu_foto = FOTO,
            updated_at = NOW()
        WHERE id_usuario = ID;

        SELECT 1; -- Indicar que la actualización fue exitosa

    ELSE
        -- Si hay duplicados en el DNI o el nombre de usuario
        SELECT 2; -- Indicar que el DNI o el nombre de usuario ya existen
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_USUARIO_CONTRA` (IN `ID` INT, IN `CONTRA` VARCHAR(255))   UPDATE usuario SET
usuario.usu_contrasenia=CONTRA
WHERE usuario.id_usuario=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODIFICAR_USUARIO_ESTATUS` (IN `ID` INT, IN `ESTATUS` VARCHAR(20))   UPDATE usuario SET
usuario.usu_estatus=ESTATUS
WHERE usuario.id_usuario=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REALIZAR_PAGO` (IN `ID` INT, IN `PAGO` DECIMAL(8,2), IN `SALDI` DECIMAL(8,2), IN `IDUSU` INT)   BEGIN
INSERT INTO historial_pagos(monto_pagado,id_usu,created_at,id_factura,estado) VALUES(PAGO,IDUSU,NOW(),ID,'VALIDO' );

UPDATE facturas
SET saldo_cobrado = saldo_cobrado+PAGO,
saldo_pendiente = SALDI
WHERE id_factura=ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_AREA` (IN `NAREA` VARCHAR(255), IN `DESCRIP` VARCHAR(255), IN `USU` INT)   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM areas_hospital where nombre=NAREA);
IF @CANTIDAD = 0 THEN
INSERT INTO areas_hospital(nombre,descripcion,id_usuario,created_at,estado_area)VALUE(NAREA,DESCRIP,USU,NOW(),'ACTIVO');
SELECT 1;
ELSE
SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_DETALLE_FACTURA` (IN `IDS` INT, IN `PRACTICA_PACI` TEXT, IN `SUBTO` DECIMAL(8,2))   BEGIN
    -- Insertar detalle de factura (debes manejar esto en bucle desde el backend si hay varios)
    INSERT INTO detalle_fatura(id_factura, id_practica_paciente, subtotal, created_at)
    VALUES (IDS, PRACTICA_PACI, SUBTO, NOW());

    -- Actualizar todos los registros que coincidan con los IDs de la lista
    UPDATE paciente_practica
    SET tiene_factura = 1
    WHERE FIND_IN_SET(paciente_practica.id_paciente_practica, PRACTICA_PACI);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_DETALLE_PRACTICAS` (IN `ID` INT, IN `PRACTICA` INT, IN `PRECIO` DECIMAL(8,2), IN `CANTIDAD` INT, IN `SUBTO` DECIMAL(8,2))   INSERT INTO practica_totales(practica_totales.id_practica_paciente,id_practica,precio_unitario,cantidad,subtotal,created_at)
VALUES(ID,PRACTICA,PRECIO,CANTIDAD,SUBTO,NOW())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_DETALLE_PRACTICAS_OBRAS` (IN `ID` INT, IN `COD` CHAR(8), IN `PRACTICA` VARCHAR(255), IN `PRECIO` DECIMAL(8,2), IN `OBRA` INT)   INSERT INTO practicas_obras_sociales(id_practica,id_obra,nombre_prac,codigo_prac,valor,created_at)
VALUES(ID,OBRA,PRACTICA,COD,PRECIO,NOW())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_FACTURA` (IN `NROFACT` CHAR(25), IN `TOTALPRA` DECIMAL(8,2), IN `FACT` VARCHAR(500), IN `NOTACRE` VARCHAR(500), IN `FECHANOTACRE` DATE, IN `IDUSU` INT)   BEGIN 

DECLARE ULTI INT;

INSERT INTO facturas(numero_fact,monto,saldo_cobrado,saldo_pendiente,archivo_fact,nota_credito,fecha_nota_credito,estado_fact,created_at,id_usuario)VALUES
(NROFACT,TOTALPRA,0,TOTALPRA,FACT,NOTACRE,FECHANOTACRE,'PENDIENTE',NOW(),IDUSU);



SET @ULTI:=(SELECT MAX(facturas.id_factura) FROM facturas);
select @ULTI;


INSERT INTO historial_factura(id_factura,estado,motivo,created_at,id_usuario)
VALUES(@ULTI,'REGISTRO DE FACTURA','Se creo nueva factura',NOW(),IDUSU);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_OBRA_SOCIAL` (IN `NCUIT` CHAR(11), IN `NOMB` VARCHAR(255), IN `DOMICILIO` TEXT, IN `LOCALIDAD` VARCHAR(255), IN `EMAIL` VARCHAR(40), IN `IDUSU` INT)   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM obras_sociales where Cuit=NCUIT);
IF @CANTIDAD = 0 THEN
INSERT INTO obras_sociales(Cuit,Nombre,domicilio,localidad,email,id_usuario,estado_obra,created_at)VALUE(NCUIT,NOMB,DOMICILIO,LOCALIDAD,EMAIL,IDUSU,'ACTIVO',NOW());
SELECT 1;
ELSE
SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PACIENTE` (IN `NDNI` CHAR(8), IN `NOMBRE` VARCHAR(255), IN `APE` VARCHAR(255), IN `DIREC` VARCHAR(255), IN `LOCALIDA` VARCHAR(255), IN `TELE` CHAR(11), IN `OBRA` INT, IN `USU` INT)   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM pacientes where Dni=NDNI );
IF @CANTIDAD = 0 THEN
INSERT INTO pacientes(Dni,Nombres,Apellidos,Direccion,localidad,Telefono,Id_obra_social,id_usuario,created_at)VALUE(NDNI ,NOMBRE,APE,DIREC,LOCALIDA,TELE,OBRA,USU,NOW());
SELECT 1;
ELSE
SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PRACTICAS` (IN `CODI` CHAR(8), IN `PRACT` VARCHAR(500), IN `USU` INT)   BEGIN
    DECLARE CANTIDAD INT DEFAULT 0;
    DECLARE ID_PRACTICA INT;

    SELECT COUNT(*) INTO CANTIDAD 
    FROM practicas 
    WHERE cod_practica = CODI;

    IF CANTIDAD = 0 THEN
        -- Insertar en practicas
        INSERT INTO practicas(cod_practica, practica, estado, id_usu, created_at)
        VALUES (CODI, PRACT, 'ACTIVO', USU, NOW());

        -- Guardar el ID insertado
        SET ID_PRACTICA = LAST_INSERT_ID();

        -- Insertar en historial
        INSERT INTO historial_practicas(id_practica, cod_practica, practica,id_usuario, fecha_actualización)
        VALUES (ID_PRACTICA, CODI,PRACT, USU, NOW());

        -- Devolver el ID de la práctica insertada
        SELECT ID_PRACTICA AS id_practica_insertada;
    ELSE
        SELECT 2 AS estado; -- ya existe
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PRACTICAS_PACIENTE` (IN `AREA` INT, IN `PACIENTE` INT, IN `TOTALPRA` DECIMAL(8,2), IN `rutaPracticaPaci` VARCHAR(255), IN `IDUSU` INT)   BEGIN 

DECLARE ULTI INT;
DECLARE FILE VARCHAR(255);
SET FILE = rutaPracticaPaci;

INSERT INTO paciente_practica(id_area, id_paciente, total, id_usuario, historia_clinica, estado, created_at)
VALUES (AREA, PACIENTE, TOTALPRA, IDUSU, FILE, 
        CASE WHEN FILE = 'controller/practicas_paciente/filepracticas/' THEN 'PENDIENTE' ELSE 'COMPLETADO' END, 
        NOW());

SET ULTI = LAST_INSERT_ID();
SELECT ULTI;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PRACTICA_TODAS_OBRAS` (IN `ID` INT, IN `COD` CHAR(8), IN `PRACTICA` VARCHAR(255), IN `PRECIO` DECIMAL(8,2))   BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE obra_id INT;
    
    -- Cursor para obtener todas las obras sociales activas
    DECLARE cur_obras CURSOR FOR 
        SELECT id_cuit FROM obras_sociales WHERE estado_obra = 'ACTIVO'; -- Asume que tienes una tabla obras_sociales con estado activo
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abrir el cursor
    OPEN cur_obras;
    
    -- Loop para insertar en cada obra social
    read_loop: LOOP
        FETCH cur_obras INTO obra_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Insertar la práctica para cada obra social
        INSERT INTO practicas_obras_sociales(
            id_practica,
            id_obra,
            nombre_prac,
            codigo_prac,
            valor,
            created_at
        ) VALUES(
            ID,
            obra_id,
            PRACTICA,
            COD,
            PRECIO,
            NOW()
        );
        
    END LOOP;
    
    -- Cerrar cursor
    CLOSE cur_obras;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USUARIO` (IN `DNI` CHAR(8), IN `NOMBRE` VARCHAR(50), IN `APELLIDO` VARCHAR(50), IN `EMAIL` VARCHAR(255), IN `TELEFONO` CHAR(11), IN `DIRECCION` TEXT, IN `FOTO` VARCHAR(255), IN `USU` VARCHAR(255), IN `CONTRA` VARCHAR(255), IN `ROL` VARCHAR(25))   BEGIN
    DECLARE CANTIDAD_DNI INT;
    DECLARE CANTIDAD_USU INT;

    -- Verificar si el DNI ya existe
    SET @CANTIDAD_DNI := (SELECT COUNT(*) FROM usuario WHERE dni_usuario = DNI);

    -- Verificar si el nombre de usuario ya existe
    SET @CANTIDAD_USU := (SELECT COUNT(*) FROM usuario WHERE usu_usuario = USU);

    -- Si no existe un DNI duplicado ni un usuario duplicado
    IF @CANTIDAD_DNI = 0 AND @CANTIDAD_USU = 0 THEN
        -- Insertar el nuevo usuario
        INSERT INTO usuario (
            dni_usuario, usu_nombre, usu_apellido, usu_email, 
            usu_telefono, usu_direccion, usu_usuario, usu_contrasenia, 
            usu_rol,usu_estatus, usu_foto, created_at, updated_at
        ) VALUES (
            DNI, NOMBRE, APELLIDO, EMAIL, 
            TELEFONO, DIRECCION, USU, CONTRA, 
            ROL,'ACTIVO', FOTO, NOW(), NOW()
        );

        SELECT 1; -- Indicar que la inserción fue exitosa

    ELSE
        -- Si hay duplicados en el DNI o el nombre de usuario
        SELECT 2; -- Indicar que el DNI o el nombre de usuario ya existen
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VERIFICAR_USUARIO` (IN `USU` VARCHAR(255))   SELECT
	usuario.id_usuario, 
	usuario.dni_usuario,
	usuario.usu_nombre, 
	usuario.usu_apellido,
	CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,  
	usuario.usu_email, 
	usuario.usu_direccion, 
	usuario.usu_usuario, 
	usuario.usu_contrasenia, 
	usuario.usu_rol, 
	usuario.usu_estatus, 
	usuario.usu_telefono,
	usuario.id_empresa, 
	usuario.created_at,
	usuario.updated_at,
	usuario.usu_foto,
	empresa.id_empresa,
	empresa.logo,
	empresa.nombre
FROM
	usuario
	INNER JOIN
	empresa
	ON 
		usuario.id_empresa = empresa.id_empresa
where usuario.usu_usuario = BINARY USU$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas_hospital`
--

CREATE TABLE `areas_hospital` (
  `id_area` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT '',
  `descripcion` text NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `estado_area` enum('INACTIVO','ACTIVO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas_hospital`
--

INSERT INTO `areas_hospital` (`id_area`, `nombre`, `descripcion`, `id_usuario`, `created_at`, `updated_at`, `estado_area`) VALUES
(1, 'PEDIATRIA', 'PEDIATRIA NIÑOS MENORES', 1, '2025-01-25 11:47:03', '2025-03-01 09:50:36', 'ACTIVO'),
(2, 'CARDIOLOGIA', 'CARDIO', 1, '2025-01-25 11:47:26', NULL, 'ACTIVO'),
(3, 'RECURSOS HUMANOS', 'RR.HH', 1, '2025-01-25 11:47:39', NULL, 'ACTIVO'),
(4, 'TRAUMATOLOGIA', 'ÁREA DE TRAUMATOLOGIAA', 4, '2025-01-25 12:41:25', '2025-01-25 12:42:48', 'ACTIVO'),
(6, 'CONTABILIDAD', 'CONTABILIDAD', 1, '2025-02-23 13:13:08', '2025-02-23 13:13:17', 'ACTIVO'),
(8, 'TERAPID', 'AREA DE TERAPIA', 1, '2025-02-23 13:14:05', NULL, 'ACTIVO'),
(9, 'ALMACEN', 'ALAMACEN', 1, '2025-02-27 16:27:12', NULL, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_fatura`
--

CREATE TABLE `detalle_fatura` (
  `id_detalle_factura` int(255) NOT NULL,
  `id_factura` int(11) DEFAULT NULL,
  `id_practica_paciente` int(11) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_fatura`
--

INSERT INTO `detalle_fatura` (`id_detalle_factura`, `id_factura`, `id_practica_paciente`, `subtotal`, `created_at`) VALUES
(13, 15, 17, 1500.00, '2025-02-16 15:55:31'),
(14, 16, 18, 9196.00, '2025-02-16 16:04:05'),
(15, 17, 19, 7996.00, '2025-02-16 16:05:27'),
(16, 18, 20, 10750.00, '2025-02-16 16:10:01'),
(23, 23, 21, 10750.00, '2025-02-16 16:25:36'),
(24, 23, 22, 9500.00, '2025-02-16 16:25:36'),
(25, 24, 23, 4580.00, '2025-02-17 08:14:18'),
(26, 25, 16, 12576.00, '2025-02-17 16:28:36'),
(36, 25, 19, 7996.00, '2025-02-22 15:04:58'),
(40, 25, 18, 32192.00, '2025-02-22 15:05:52'),
(42, 16, 24, 26376.00, '2025-02-22 15:06:43'),
(43, 29, 26, 19000.00, '2025-02-22 15:10:42'),
(95, 30, 18, 32192.00, '2025-02-23 10:11:07'),
(96, 31, 24, 26376.00, '2025-02-23 10:11:27'),
(97, 32, 17, 1500.00, '2025-02-23 14:52:14'),
(98, 32, 29, 1500.00, '2025-02-23 14:52:14'),
(99, 32, 30, 2400.00, '2025-02-23 14:52:14'),
(101, 33, 27, 12000.00, '2025-02-23 14:53:45'),
(102, 34, 27, 12000.00, '2025-02-26 09:09:12'),
(103, 35, 32, 12000.00, '2025-02-27 17:11:18'),
(104, 36, 35, 1500.00, '2025-02-27 17:12:27'),
(105, 36, 36, 3000.00, '2025-02-27 17:12:27'),
(106, 37, 28, 11376.00, '2025-03-01 11:33:19'),
(107, 37, 24, 26376.00, '2025-03-01 11:33:19'),
(108, 37, 31, 26376.00, '2025-03-01 11:33:19'),
(109, 38, 19, 0.00, '2025-03-15 17:16:37'),
(110, 38, 28, 0.00, '2025-03-15 17:16:37'),
(111, 38, 24, 0.00, '2025-03-15 17:16:37'),
(112, 38, 31, 0.00, '2025-03-15 17:16:37'),
(113, 38, 14, 0.00, '2025-03-15 17:16:37'),
(114, 39, 19, 0.00, '2025-03-15 17:21:20'),
(115, 39, 28, 0.00, '2025-03-15 17:21:20'),
(116, 39, 24, 0.00, '2025-03-15 17:21:20'),
(117, 39, 31, 0.00, '2025-03-15 17:21:20'),
(118, 39, 14, 0.00, '2025-03-15 17:21:20'),
(119, 40, 19, 0.00, '2025-03-15 17:24:03'),
(120, 40, 28, 0.00, '2025-03-15 17:24:03'),
(121, 40, 24, 0.00, '2025-03-15 17:24:03'),
(122, 40, 31, 0.00, '2025-03-15 17:24:03'),
(123, 40, 14, 0.00, '2025-03-15 17:24:03'),
(124, 41, 33, 0.00, '2025-03-15 17:29:25'),
(125, 41, 38, 0.00, '2025-03-15 17:29:25'),
(126, 42, 19, 7996.00, '2025-03-15 17:31:19'),
(127, 42, 28, 11376.00, '2025-03-15 17:31:19'),
(128, 42, 24, 26376.00, '2025-03-15 17:31:19'),
(129, 42, 31, 26376.00, '2025-03-15 17:31:19'),
(130, 42, 14, 17192.00, '2025-03-15 17:31:19'),
(131, 43, 19, 7996.00, '2025-03-15 17:32:06'),
(132, 43, 28, 11376.00, '2025-03-15 17:32:06'),
(133, 43, 24, 26376.00, '2025-03-15 17:32:06'),
(134, 43, 31, 26376.00, '2025-03-15 17:32:06'),
(135, 43, 14, 17192.00, '2025-03-15 17:32:06'),
(136, 44, 48, 9196.00, '2025-03-22 14:36:44'),
(137, 45, 44, 11376.00, '2025-03-22 17:08:05'),
(138, 45, 48, 9196.00, '2025-03-22 17:08:05'),
(139, 45, 43, 7996.00, '2025-03-22 17:08:05'),
(140, 45, 49, 23988.00, '2025-03-22 17:08:06'),
(141, 45, 46, 26234.00, '2025-03-22 17:08:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id_empresa` int(11) NOT NULL,
  `logo` varchar(500) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `codigo` char(6) DEFAULT '',
  `telefono` varchar(250) DEFAULT NULL,
  `direccion` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_ar` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id_empresa`, `logo`, `nombre`, `email`, `codigo`, `telefono`, `direccion`, `created_at`, `updated_ar`) VALUES
(1, 'controller/empresa/FOTOS/IMG18-1-2025-15-473.jpg', 'HOSPITAL SAMIC', 'DERIVACIONES.CALAFAT1E@GMAIL.COM', '01', '+54 2902 49-183', 'JR. PIEROLA N° 212', '2025-01-18 14:56:21', '2025-01-18 15:58:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id_factura` int(11) NOT NULL,
  `numero_fact` char(30) DEFAULT NULL,
  `monto` decimal(8,2) DEFAULT NULL,
  `saldo_cobrado` decimal(8,2) DEFAULT NULL,
  `saldo_pendiente` decimal(8,2) DEFAULT NULL,
  `archivo_fact` varchar(500) DEFAULT NULL,
  `nota_credito` varchar(255) DEFAULT NULL,
  `fecha_nota_credito` date DEFAULT NULL,
  `estado_fact` enum('FACTURADA','PENDIENTE','COBRADA','RECHAZADA','ELIMINADA') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_usuario` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id_factura`, `numero_fact`, `monto`, `saldo_cobrado`, `saldo_pendiente`, `archivo_fact`, `nota_credito`, `fecha_nota_credito`, `estado_fact`, `created_at`, `updated_at`, `id_usuario`) VALUES
(15, '67U756756745', 1500.00, 0.00, 0.00, 'controller/facturas/filefacturas/FAC22-2-2025-13-682.PDF', 'controller/facturas/filenotacredito/NC22-2-2025-13-682.PDF', '2025-01-31', 'ELIMINADA', '2025-02-21 16:20:59', '2025-02-22 13:16:43', 1),
(16, '5765678678', 35572.00, 0.00, 35572.00, 'controller/facturas/filefacturas/IMG16-2-2025-16-31.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-02-22 16:14:36', '2025-02-22 15:06:43', 2),
(17, '2222205505', 7996.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG16-2-2025-16-575.pdf', 'controller/facturas/filenotacredito/NC16-2-2025-16-575.pdf', '2025-01-30', 'ELIMINADA', '2025-02-22 16:42:00', NULL, 4),
(18, '8767676767', 10750.00, 0.00, 0.00, 'controller/facturas/filefacturas/FAC28-6-2025-16-1.PDF', 'controller/facturas/filenotacredito/NC28-6-2025-16-1.PDF', '2025-06-28', 'ELIMINADA', '2025-03-22 17:02:00', '2025-06-28 16:42:50', 5),
(22, '678567567567', 20250.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG16-2-2025-16-255.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'PENDIENTE', '2025-02-16 16:22:10', NULL, 1),
(23, '56566787887', 20250.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG16-2-2025-16-42.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'PENDIENTE', '2025-02-16 16:25:36', NULL, 1),
(24, '68768568568', 4580.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG17-2-2025-8-390.jpeg', 'controller/facturas/filenotacredito/', '0000-00-00', 'FACTURADA', '2025-02-17 08:14:18', NULL, 1),
(25, '11111111122', 69956.00, 15000.00, 54956.00, 'controller/facturas/filefacturas/FAC22-2-2025-14-200.PDF', 'controller/facturas/filenotacredito/NC22-2-2025-14-487.PDF', '2025-01-02', 'COBRADA', '2025-02-17 16:28:35', '2025-02-22 15:05:52', 1),
(29, '72646121', 19000.00, 12000.00, 7000.00, 'controller/facturas/filefacturas/FAC22-2-2025-15-199.PDF', 'controller/facturas/filenotacredito/NC22-2-2025-15-199.PDF', '2025-01-29', 'PENDIENTE', '2025-02-22 15:10:42', '2025-02-22 15:54:29', 1),
(30, '9999877877', 32192.00, 0.00, 32192.00, 'controller/facturas/filefacturas/IMG23-2-2025-10-214.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'FACTURADA', '2025-02-23 10:11:07', '2025-03-01 12:13:23', 1),
(31, '111111111111', 26376.00, 0.00, 26376.00, 'controller/facturas/filefacturas/IMG23-2-2025-10-133.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-02-23 10:11:35', NULL, 1),
(32, '67575756767', 5400.00, 0.00, 5400.00, 'controller/facturas/filefacturas/IMG23-2-2025-14-760.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'FACTURADA', '2025-02-23 14:52:14', NULL, 1),
(33, '778788877888', 12000.00, 0.00, 12000.00, 'controller/facturas/filefacturas/IMG23-2-2025-14-401.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-02-23 14:53:58', NULL, 1),
(34, '0009899889', 12000.00, 10000.00, 2000.00, 'controller/facturas/filefacturas/IMG26-2-2025-9-477.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'COBRADA', '2025-02-26 09:09:12', '2025-02-26 09:09:35', 1),
(35, '9867677887', 12000.00, 0.00, 12000.00, 'controller/facturas/filefacturas/IMG27-2-2025-17-835.jpg', 'controller/facturas/filenotacredito/NC27-2-2025-17-835.jpg', '2025-02-06', 'PENDIENTE', '2025-02-27 17:11:18', NULL, 1),
(36, '5555544444', 4500.00, 0.00, 4500.00, 'controller/facturas/filefacturas/IMG27-2-2025-17-779.jpg', 'controller/facturas/filenotacredito/NC27-2-2025-17-779.jpg', '2025-01-30', 'PENDIENTE', '2025-02-27 17:12:27', NULL, 1),
(37, '2343443545', 64128.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG1-3-2025-11-704.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-01 15:11:54', NULL, 1),
(38, '32T54675674R', 89316.00, NULL, NULL, 'controller/facturas/filefacturas/IMG15-3-2025-17-166.jpeg', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-15 17:21:02', NULL, 1),
(39, '54656756756', 89316.00, NULL, NULL, 'controller/facturas/filefacturas/IMG15-3-2025-17-110.jpg', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-15 17:22:52', NULL, 1),
(40, '5476435234534', 89316.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG15-3-2025-17-647.jpeg', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-15 17:30:25', NULL, 1),
(41, '864543423233', 17156.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG15-3-2025-17-983.jpg', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-15 17:30:23', NULL, 1),
(42, '123234489998', 89316.00, 0.00, 0.00, 'controller/facturas/filefacturas/IMG15-3-2025-17-599.jpg', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-15 17:31:54', NULL, 1),
(43, '67654665467546', 89316.00, 20000.00, 69316.00, 'controller/facturas/filefacturas/IMG15-3-2025-17-439.png', 'controller/facturas/filenotacredito/', '0000-00-00', 'PENDIENTE', '2025-03-15 17:32:06', NULL, 1),
(44, '322245546776', 9196.00, 999999.99, -999999.99, 'controller/facturas/filefacturas/IMG22-3-2025-14-750.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'ELIMINADA', '2025-03-22 17:01:53', NULL, 1),
(45, '34567567567567', 78790.00, 0.00, 78790.00, 'controller/facturas/filefacturas/IMG22-3-2025-17-902.pdf', 'controller/facturas/filenotacredito/', '0000-00-00', 'PENDIENTE', '2025-03-22 17:08:05', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_factura`
--

CREATE TABLE `historial_factura` (
  `id_historial_factur` int(255) NOT NULL,
  `id_factura` int(255) DEFAULT NULL,
  `estado` enum('FACTURADA','PENDIENTE','COBRADA','RECHAZADA','REGISTRO DE FACTURA','ELIMINADA') DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_factura`
--

INSERT INTO `historial_factura` (`id_historial_factur`, `id_factura`, `estado`, `motivo`, `created_at`, `id_usuario`) VALUES
(35, 17, 'RECHAZADA', NULL, '2025-02-16 16:27:24.000000', 1),
(37, 15, 'RECHAZADA', NULL, '2025-02-17 08:02:07.000000', 1),
(38, 24, 'REGISTRO DE FACTURA', NULL, '2025-02-17 08:14:18.000000', 1),
(39, 24, 'PENDIENTE', NULL, '2025-02-17 08:15:00.000000', 1),
(40, 24, 'COBRADA', NULL, '2025-02-17 08:15:12.000000', 1),
(41, 24, 'FACTURADA', NULL, '2025-02-17 16:22:08.000000', 1),
(42, 24, 'FACTURADA', NULL, '2025-02-17 16:23:01.000000', 1),
(43, 24, 'FACTURADA', NULL, '2025-02-17 16:23:57.000000', 1),
(44, 16, 'RECHAZADA', 'NO CUMPLE', '2025-02-17 16:26:07.000000', 1),
(45, 18, 'COBRADA', '', '2025-02-17 16:28:09.000000', 1),
(46, 25, 'REGISTRO DE FACTURA', NULL, '2025-02-17 16:28:36.000000', 1),
(47, 18, 'FACTURADA', '', '2025-02-17 16:46:16.000000', 1),
(48, 25, 'COBRADA', 'SE RELIZO EL COBRO', '2025-02-17 16:49:22.000000', 1),
(49, 15, 'COBRADA', '', '2025-02-22 11:59:01.000000', 1),
(53, 29, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-22 15:10:42.000000', 1),
(54, 30, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-23 10:11:07.000000', 1),
(55, 31, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-23 10:11:27.000000', 1),
(56, 31, 'ELIMINADA', 'Factura eliminada', '2025-02-23 10:11:35.000000', 1),
(57, 32, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-23 14:52:14.000000', 1),
(58, 32, 'COBRADA', 'SE REALIZO EL COBRO', '2025-02-23 14:52:46.000000', 1),
(59, 32, 'FACTURADA', 'SE FACTURO', '2025-02-23 14:52:58.000000', 1),
(60, 30, 'COBRADA', 'SE FACTURO', '2025-02-23 14:53:22.000000', 1),
(61, 33, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-23 14:53:45.000000', 1),
(62, 33, 'ELIMINADA', 'Factura eliminada', '2025-02-23 14:53:58.000000', 1),
(63, 34, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-26 09:09:12.000000', 1),
(64, 34, 'COBRADA', 'SE COBRO LA FACTURA', '2025-02-26 09:09:35.000000', 1),
(65, 35, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-27 17:11:18.000000', 1),
(66, 36, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-02-27 17:12:27.000000', 1),
(67, 37, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-01 11:33:19.000000', 1),
(68, 30, 'FACTURADA', '', '2025-03-01 12:13:23.000000', 1),
(69, 37, 'ELIMINADA', 'Factura eliminada', '2025-03-01 15:11:54.000000', 1),
(70, 38, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:16:37.000000', 1),
(71, 38, 'ELIMINADA', 'Factura eliminada', '2025-03-15 17:21:02.000000', 1),
(72, 39, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:21:20.000000', 1),
(73, 39, 'ELIMINADA', 'Factura eliminada', '2025-03-15 17:22:52.000000', 1),
(74, 40, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:24:03.000000', 1),
(75, 41, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:29:25.000000', 1),
(76, 41, 'ELIMINADA', 'Factura eliminada', '2025-03-15 17:30:23.000000', 1),
(77, 40, 'ELIMINADA', 'Factura eliminada', '2025-03-15 17:30:25.000000', 1),
(78, 42, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:31:19.000000', 1),
(79, 42, 'ELIMINADA', 'Factura eliminada', '2025-03-15 17:31:54.000000', 1),
(80, 43, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-15 17:32:06.000000', 1),
(81, 44, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-22 14:36:44.000000', 1),
(82, 44, 'ELIMINADA', 'Factura eliminada', '2025-03-22 17:01:53.000000', 1),
(83, 18, 'ELIMINADA', 'Factura eliminada', '2025-03-22 17:02:00.000000', 1),
(84, 45, 'REGISTRO DE FACTURA', 'Se creo nueva factura', '2025-03-22 17:08:05.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_pagos`
--

CREATE TABLE `historial_pagos` (
  `id_historial_pagos` int(11) NOT NULL,
  `monto_pagado` decimal(8,2) DEFAULT NULL,
  `id_usu` int(11) DEFAULT NULL,
  `motivo_anulacion` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `id_factura` int(11) DEFAULT NULL,
  `estado` enum('ANULADO','VALIDO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_pagos`
--

INSERT INTO `historial_pagos` (`id_historial_pagos`, `monto_pagado`, `id_usu`, `motivo_anulacion`, `created_at`, `id_factura`, `estado`) VALUES
(1, 10000.00, 1, NULL, '2025-03-15 12:15:08', 25, 'VALIDO'),
(2, 5000.00, 1, NULL, '2025-03-15 12:14:53', 25, 'VALIDO'),
(3, 20000.00, 2, 'MALA DIGITACIÓN', '2025-03-15 13:27:33', 25, 'ANULADO'),
(4, 20000.00, 1, NULL, '2025-03-15 17:32:17', 43, NULL),
(5, 999999.99, 1, NULL, '2025-03-22 16:47:52', 44, NULL),
(6, 10000.00, 1, NULL, '2025-03-22 16:54:25', 29, NULL),
(7, 2000.00, 1, NULL, '2025-03-22 16:59:14', 29, NULL),
(8, 2000.00, 1, NULL, '2025-03-22 16:59:39', 29, NULL),
(9, 2000.00, 1, NULL, '2025-03-22 17:00:14', 29, 'VALIDO'),
(10, 10000.00, 1, NULL, '2025-03-22 17:02:11', 34, 'VALIDO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_practicas`
--

CREATE TABLE `historial_practicas` (
  `id_actualiza_practica` int(11) NOT NULL,
  `cod_practica` char(8) DEFAULT NULL,
  `id_practica` int(255) DEFAULT NULL,
  `practica` varchar(255) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_actualización` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_practicas`
--

INSERT INTO `historial_practicas` (`id_actualiza_practica`, `cod_practica`, `id_practica`, `practica`, `id_usuario`, `fecha_actualización`) VALUES
(5, NULL, 9, NULL, 1, '2025-02-16 15:54:21'),
(6, NULL, 11, NULL, 1, '2025-02-17 16:39:10'),
(7, NULL, 12, NULL, 1, '2025-02-23 14:49:12'),
(8, NULL, 13, NULL, 1, '2025-02-27 16:41:32'),
(9, NULL, 12, NULL, 1, '2025-03-01 10:25:46'),
(10, '433443', 16, 'sdfsdf', 2, '2025-09-04 17:40:11'),
(11, '656565', 17, 'PROBAMNDO', 1, '2025-09-04 17:40:27'),
(12, '154787', 18, 'JERSSON', 1, '2025-09-04 17:58:16'),
(13, '64645', 19, 'CORILLA', 1, '2025-09-04 17:59:26'),
(15, '9998', 21, 'GUZMAN', 1, '2025-09-04 18:12:53'),
(16, '55555', 22, 'JORGE', 1, '2025-09-04 18:15:05'),
(17, '222222', 23, 'CARRASCO', 1, '2025-09-04 18:15:44'),
(18, '14071996', 24, 'JORGITO', 1, '2025-09-04 18:18:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_practicas_obras_sociales`
--

CREATE TABLE `historial_practicas_obras_sociales` (
  `id_historial` int(11) NOT NULL,
  `id_practica_obra` int(11) NOT NULL,
  `cod_practica_nuevo` char(8) NOT NULL,
  `practica_nueva` varchar(255) DEFAULT NULL,
  `valor_nuevo` decimal(8,2) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT current_timestamp(),
  `tipo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_practicas_obras_sociales`
--

INSERT INTO `historial_practicas_obras_sociales` (`id_historial`, `id_practica_obra`, `cod_practica_nuevo`, `practica_nueva`, `valor_nuevo`, `id_usuario`, `fecha_actualizacion`, `tipo`) VALUES
(1, 19, '140796', 'NUEVOS MODELOS', 25000.00, 1, '2025-09-05 10:36:48', 'MODIFICACIÓN INDIVIDUAL'),
(2, 12, '140790', 'NUEVOS MODELOS2', 1400.00, 1, '2025-09-05 10:37:20', 'MODIFICACIÓN INDIVIDUAL'),
(4, 12, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(5, 13, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(6, 14, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(7, 15, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(8, 19, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(9, 20, '250177', 'PROBANDO2', 2200.00, 1, '2025-09-05 10:42:25', 'MODIFICACIÓN MASIVA'),
(11, 12, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA'),
(12, 13, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA'),
(13, 14, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA'),
(14, 15, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA'),
(15, 19, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA'),
(16, 20, '145555', 'MODELO PROBANDO', 2500.00, 1, '2025-09-05 10:43:21', 'MODIFICACIÓN MASIVA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obras_sociales`
--

CREATE TABLE `obras_sociales` (
  `id_cuit` int(11) NOT NULL,
  `Cuit` char(11) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `domicilio` text DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `estado_obra` enum('INACTIVO','ACTIVO') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `obras_sociales`
--

INSERT INTO `obras_sociales` (`id_cuit`, `Cuit`, `Nombre`, `domicilio`, `localidad`, `email`, `id_usuario`, `estado_obra`, `created_at`, `updated_at`) VALUES
(1, '005', 'CAMARA DE EMPRESARIOS DE AGENCIAS DE REMISES DE ARGENTINA', 'JR. CUSCO N° 323', 'ABANCAY', 'JOSUE@GMAIL.COM', 1, 'ACTIVO', '2025-01-25 14:23:01', '2025-01-26 11:52:58'),
(2, '008', 'PERSONAL DE LA SANIDAD ARGENTINA ', 'AV. CANADA N° 221', 'CUSCO ', 'PERSONA21@GMAIL.COM', 1, 'ACTIVO', '2025-01-25 14:23:34', '2025-01-26 11:53:37'),
(3, '10245', 'ASOCIACION MUTUAL DE LOS OBREROS CATOLICOS PADRE FEDERICO GROTE', 'JR. ANDAHUAYLAS N° 323', 'ANDAHUAYLAS', 'LUIS12@GMAIL.COM', 1, 'ACTIVO', '2025-01-26 10:59:32', NULL),
(5, '4535', 'OBRA SOCIAL DEL PERSONAL DE LA INDUSTRIA TEXTIL', 'LAS VEGAS', 'BUENOS AIRES', 'BBB@GMAIL.COM', 1, 'ACTIVO', '2025-02-16 15:45:47', NULL),
(6, '546', 'OBRA SOCIAL DE LOS MEDICOS DE LA CIUDAD DE BUENOS AIRES', 'JR. CURSO', 'SANTA CRUZ', 'MUID@GMAIL.COM', 1, 'ACTIVO', '2025-02-16 15:46:15', NULL),
(7, '56778', 'OBRA SOCIAL PROGRAMAS MEDICOS SOCIEDAD ARGENTINA DE CONSULTORIA MUTUAL', 'AV. HUANDA', 'BUENOS AITES', 'HUWD@GMAIL.COM', 1, 'ACTIVO', '2025-02-16 15:46:40', NULL),
(8, '5445', 'OBRA SOCIAL DE LOCUTORES', 'AV. PERú', 'ROSARIO', 'SDFF@GMAIL.COM', 1, 'ACTIVO', '2025-02-16 15:47:12', NULL),
(9, '4554', 'OBRA SOCIAL DE VIAJANTES VENDEDORES DE LA REPUBLICA ARGENTINA. (ANDAR)', 'JR. SANAMEZ', 'ROSARIO', 'WERFE@GMAIL.COM', 1, 'ACTIVO', '2025-02-16 15:47:37', NULL),
(10, '32333', 'OBRA SOCIAL DE LA PREVENCION Y LA SALUD', 'JR. CUSCO N° 212', 'BUENOS AIRES', 'BU21E@GMAIL.COM', 1, 'ACTIVO', '2025-02-23 14:47:50', '2025-02-23 14:48:03'),
(11, '54666', 'OBRA SOCIAL DEL PERSONAL DE LA INDUSTRIA DEL HIELO Y MERCADOS PARTICULARES', 'JR. CUSCO', 'BUENOS AIRES', '32SAD@MAIL.COM', 1, 'ACTIVO', '2025-02-27 16:33:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int(11) NOT NULL,
  `Dni` char(8) NOT NULL,
  `Nombres` varchar(255) DEFAULT NULL,
  `Apellidos` varchar(255) DEFAULT NULL,
  `Direccion` text NOT NULL,
  `localidad` varchar(255) NOT NULL DEFAULT '',
  `Telefono` char(11) DEFAULT NULL,
  `Id_obra_social` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `Dni`, `Nombres`, `Apellidos`, `Direccion`, `localidad`, `Telefono`, `Id_obra_social`, `id_usuario`, `created_at`, `updated_at`) VALUES
(1, '74145841', 'JENNIFERAA', 'CHAVEZ FANOLAAA', 'JR. CUSCO N° 233AA', 'ABANCAYAA', '926414582', 2, 1, '2025-01-25 14:25:17', '2025-01-26 15:54:53'),
(2, '65414587', 'JOSE LUIS', 'CHIPANA HUAMANA', 'AV. TACNA N° 323', 'CUSCO', '912414555', 1, 1, '2025-01-25 14:26:58', '2025-01-26 15:55:18'),
(3, '52117414', 'DARYELI', 'QUISPE DAMIAN', 'JR. PERú N° 322', 'LIMA', '925414147', 3, 1, '2025-01-26 14:27:31', '2025-01-26 15:55:31'),
(4, '67686767', 'ANDREA', 'SANCHEZ DAVILA', 'AV. CANADA N° 233', 'CUSCO', '9265155115', 2, 1, '2025-01-26 15:15:38', '2025-01-26 15:55:28'),
(6, '52815151', 'JUANA', 'CHAVEZ DAVALOS', 'AV. PERU N° 323', 'ROSARIO', '9591515515', 5, 1, '2025-02-16 15:48:42', NULL),
(7, '92662626', 'JUAN CARLOS', 'CHIPA DAMIAN', 'AV. PERú N° 323', 'BUENOS AIRES', '92511552332', 8, 1, '2025-02-16 15:49:14', NULL),
(8, '95251155', 'JIMENA', 'HUAMAN DAVALOS', 'JR. ANDHAUAYLAS N° 323', 'ROSARIO', '9251151551', 8, 1, '2025-02-16 15:50:01', NULL),
(9, '26621651', 'PEDRO', 'ESTACIO HUAMAN', 'JR. AREQUIPA N° 323', 'BUENOS AIRES', '921515155', 8, 1, '2025-02-16 15:50:24', NULL),
(10, '66922262', 'CELIA', 'MIRANDA MUNGUIA', 'AV. LA COSTA N° 233', 'RIO GRANDE', '95251151515', 2, 1, '2025-02-16 15:50:52', NULL),
(11, '19215151', 'DANIEL', 'DAVILA PEÑA', 'AV. CAMANA N° 233', 'ROSARIOP', '9451151515', 2, 1, '2025-02-16 15:51:20', NULL),
(12, '26266212', 'WILLIAM', 'MIRANDA MUNGUIA', 'JR. PRADO', 'ABANCAY', '95226262626', 1, 1, '2025-02-16 16:12:03', NULL),
(13, '12121221', 'RODOLFO', 'MIRANDA MUNGUIA', 'JR. CUSCO N° 3423', 'AV. PERU', '926626226', 1, 1, '2025-02-16 16:12:26', NULL),
(14, '23342323', 'ORLANDO ', 'GUZMAN CHAVEZ', 'AV. DANIEL ALCIDES CARRION\n', 'BUENOS AIRES', '9261651551', 2, 1, '2025-02-17 08:13:51', NULL),
(15, '23234234', 'DAMIAN', 'SANCHEZ PEñA', 'JR. CANADA N° 23', 'BUENOS AIRES', '9562511551', 2, 2, '2025-02-17 17:01:26', NULL),
(16, '21155151', 'JORGE', 'MIRANDA CARRASCO', 'JR. NICOLAS N° 333', 'BUENOS AIRES', '921515155', 2, 1, '2025-02-23 13:10:53', '2025-02-23 14:48:47'),
(17, '85484844', 'NICOLAS', 'CHAVEZ HUAMAN', 'JR. CANADA N° 233', 'BUENOS AIRES', '915155151', 3, 1, '2025-02-23 14:48:42', NULL),
(18, '72155115', 'DANIEL', 'CHIPA GUZMAN', 'JR. CUSCO N° 233', 'BUENOS AIRES', '92651215155', 2, 1, '2025-02-27 16:34:17', NULL),
(19, '74151515', 'ANDRES', 'CHIPANA ROSAS', 'JR. CANADA N° 233', 'BUENOS AIRES', '9261515155', 3, 1, '2025-02-27 16:40:54', NULL),
(20, '81151515', 'RAUL', 'PEÑA', 'JR. CANADA N° 122', 'BUENOS AIRES', '5115151551', 2, 2, '2025-02-28 17:33:07', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente_practica`
--

CREATE TABLE `paciente_practica` (
  `id_paciente_practica` int(11) NOT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `tiene_factura` int(255) DEFAULT 0,
  `historia_clinica` varchar(500) DEFAULT '',
  `estado` enum('COMPLETADO','PENDIENTE') DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente_practica`
--

INSERT INTO `paciente_practica` (`id_paciente_practica`, `id_area`, `id_paciente`, `total`, `id_usuario`, `tiene_factura`, `historia_clinica`, `estado`, `updated_at`, `created_at`) VALUES
(14, 1, 10, 17192.00, 1, 1, NULL, NULL, '2025-02-16 17:00:47', '2025-02-16 15:51:54'),
(16, 2, 4, 50572.00, 1, 1, NULL, NULL, '2025-02-23 10:39:58', '2025-02-16 15:52:55'),
(17, 2, 7, 1500.00, 1, 1, NULL, NULL, NULL, '2025-02-16 15:54:54'),
(18, 4, 11, 32192.00, 1, 1, NULL, NULL, '2025-02-22 11:24:51', '2025-02-16 16:01:33'),
(19, 2, 1, 7996.00, 1, 1, NULL, NULL, NULL, '2025-02-16 16:04:49'),
(20, 2, 2, 10750.00, 1, 0, NULL, NULL, '2025-02-23 10:37:57', '2025-02-16 16:09:44'),
(21, 2, 12, 10750.00, 2, 1, NULL, NULL, NULL, '2025-02-16 16:12:42'),
(22, 1, 13, 9500.00, 2, 1, NULL, NULL, NULL, '2025-02-16 16:13:35'),
(23, 2, 14, 11376.00, 2, 1, NULL, NULL, '2025-02-26 09:07:00', '2025-02-17 08:14:02'),
(24, 2, 4, 26376.00, 1, 1, NULL, NULL, '2025-02-23 10:26:50', '2025-02-17 08:32:05'),
(26, 2, 12, 19000.00, 1, 1, NULL, NULL, NULL, '2025-02-22 09:13:17'),
(27, 2, 12, 12000.00, 1, 1, NULL, NULL, NULL, '2025-02-22 10:58:36'),
(28, 1, 1, 11376.00, 2, 1, NULL, NULL, '2025-02-23 12:53:27', '2025-02-23 12:04:03'),
(29, 2, 7, 1500.00, 2, 1, NULL, NULL, '2025-02-23 12:52:16', '2025-02-23 12:22:48'),
(30, 2, 7, 2400.00, 1, 1, NULL, NULL, '2025-02-23 14:51:08', '2025-02-23 14:50:53'),
(31, 2, 4, 26376.00, 1, 1, NULL, NULL, '2025-03-01 10:57:22', '2025-02-27 16:51:52'),
(32, 2, 2, 12000.00, 1, 1, NULL, NULL, NULL, '2025-02-27 16:54:17'),
(33, 3, 11, 5780.00, 1, 0, NULL, NULL, NULL, '2025-02-27 16:56:45'),
(35, 2, 8, 1500.00, 2, 1, NULL, NULL, NULL, '2025-02-27 17:00:04'),
(36, 2, 9, 3000.00, 2, 1, NULL, NULL, NULL, '2025-02-27 17:02:19'),
(38, 3, 11, 11376.00, 1, 0, NULL, NULL, NULL, '2025-03-01 15:18:35'),
(39, 2, 12, 19000.00, 1, 0, NULL, NULL, NULL, '2025-03-15 15:35:14'),
(43, 2, 10, 7996.00, 1, 1, 'controller/practicas_paciente/filepracticas/HC22-3-2025-12-816.pdf', 'COMPLETADO', NULL, '2025-03-22 10:42:56'),
(44, 3, 4, 11376.00, 1, 1, 'controller/practicas_paciente/filepracticas/IMG22-3-2025-10-711.pdf', 'COMPLETADO', NULL, '2025-03-22 10:43:24'),
(45, 2, 20, 15992.00, 1, 0, 'controller/practicas_paciente/filepracticas/HC22-3-2025-12-648.pdf', 'COMPLETADO', NULL, '2025-03-22 12:45:29'),
(46, 6, 18, 26234.00, 1, 1, 'controller/practicas_paciente/filepracticas/HC22-3-2025-12-336.pdf', 'COMPLETADO', NULL, '2025-03-22 12:46:19'),
(48, 2, 4, 9196.00, 2, 1, 'controller/practicas_paciente/filepracticas/HC22-3-2025-14-270.pdf', 'COMPLETADO', NULL, '2025-03-22 14:29:51'),
(49, 3, 10, 23988.00, 2, 1, 'controller/practicas_paciente/filepracticas/HC22-3-2025-14-454.pdf', 'COMPLETADO', NULL, '2025-03-22 14:44:24'),
(50, 3, 8, 2700.00, 2, 0, 'controller/practicas_paciente/filepracticas/', 'PENDIENTE', NULL, '2025-03-22 14:55:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicas`
--

CREATE TABLE `practicas` (
  `id_practica` int(11) NOT NULL,
  `cod_practica` char(8) DEFAULT NULL,
  `practica` varchar(500) DEFAULT NULL,
  `estado` enum('INACTIVO','ACTIVO') DEFAULT NULL,
  `id_usu` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `practicas`
--

INSERT INTO `practicas` (`id_practica`, `cod_practica`, `practica`, `estado`, `id_usu`, `created_at`, `updated_at`) VALUES
(2, '1011', 'CONSULTA EN CAPS.', 'ACTIVO', 1, '2025-01-30 14:35:29', '2025-01-30 15:44:33'),
(3, '1012', 'CONSULTA Y UNA PRáCTICA DEL CóDIGO 1.03.', 'ACTIVO', 1, '2025-01-30 14:37:20', '2025-02-12 16:03:37'),
(4, '1021', 'CONSULTA EN CAPS Y UNA PRáCTICA DEL CóDIGO 103.', 'ACTIVO', 2, '2025-01-30 15:22:03', '2025-02-12 15:26:25'),
(5, '1030.27', 'VULVOSCOPíA', 'ACTIVO', 1, '2025-02-09 11:31:07', NULL),
(6, '1031', 'E.C.G.', 'ACTIVO', 1, '2025-02-09 11:31:27', NULL),
(7, '1032', 'ESPIROMETRíA', 'ACTIVO', 1, '2025-02-09 11:31:41', NULL),
(9, '1060.15', 'KINESIOTERAPIA (HASTA DIEZ SESIONES CONTINUADAS).', 'ACTIVO', 1, '2025-02-16 15:53:46', '2025-02-16 15:54:21'),
(10, '1060.16', 'LASERTERAPIA (HASTA DIEZ SESIONES CONTINUADAS).', 'ACTIVO', 1, '2025-02-16 15:54:42', NULL),
(11, '1090.3', 'INSTILACIóN INTRATECAL DE CITOSTáTICOS', 'ACTIVO', 1, '2025-02-17 16:39:10', NULL),
(12, '1050.21', 'TONOGRAFIA', 'ACTIVO', 1, '2025-02-23 14:49:12', '2025-03-01 10:25:46'),
(13, '1090.1', 'CIRUGíA AMBULATORIA: CIRUGíA MENOR QUE NO REQUIERE INTERNACIóN NI ANESTESIA GENERAL.', 'ACTIVO', 1, '2025-02-27 16:41:32', NULL),
(14, '12234', 'HOLA', 'ACTIVO', 1, '2025-09-04 17:35:53', NULL),
(15, '1223', 'sdfsdf', 'ACTIVO', 2, '2025-09-04 17:37:38', NULL),
(16, '433443', 'sdfsdf', 'ACTIVO', 2, '2025-09-04 17:40:11', NULL),
(17, '656565', 'PROBAMNDO', 'ACTIVO', 1, '2025-09-04 17:40:27', NULL),
(18, '154787', 'JERSSON', 'ACTIVO', 1, '2025-09-04 17:58:16', NULL),
(19, '64645', 'CORILLA', 'ACTIVO', 1, '2025-09-04 17:59:26', NULL),
(21, '9998', 'GUZMAN', 'ACTIVO', 1, '2025-09-04 18:12:53', NULL),
(22, '55555', 'JORGE', 'ACTIVO', 1, '2025-09-04 18:15:05', NULL),
(23, '222222', 'CARRASCO', 'ACTIVO', 1, '2025-09-04 18:15:44', NULL),
(24, '14071996', 'JORGITO', 'ACTIVO', 1, '2025-09-04 18:18:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicas_obras_sociales`
--

CREATE TABLE `practicas_obras_sociales` (
  `id_practicas_obras` int(11) NOT NULL,
  `id_practica` int(11) DEFAULT NULL,
  `id_obra` int(11) DEFAULT NULL,
  `nombre_prac` varchar(255) DEFAULT NULL,
  `codigo_prac` char(8) DEFAULT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `practicas_obras_sociales`
--

INSERT INTO `practicas_obras_sociales` (`id_practicas_obras`, `id_practica`, `id_obra`, `nombre_prac`, `codigo_prac`, `valor`, `created_at`, `updated_at`) VALUES
(5, 19, 2, 'JERSSON', '154787', 1222.00, '2025-09-04 17:59:26', NULL),
(6, 19, 1, 'JERSSON', '154787', 1222.00, '2025-09-04 17:59:26', NULL),
(7, 19, 7, 'JERSSON', '154787', 1222.00, '2025-09-04 17:59:26', NULL),
(8, 19, 10, 'JERSSON', '154787', 1800.00, '2025-09-04 17:59:26', NULL),
(12, 24, 1, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21'),
(13, 24, 2, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21'),
(14, 24, 3, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21'),
(15, 24, 5, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21'),
(19, 24, 9, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21'),
(20, 24, 10, 'MODELO PROBANDO', '145555', 2500.00, '2025-09-04 18:18:18', '2025-09-05 10:43:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practica_totales`
--

CREATE TABLE `practica_totales` (
  `id_practica_paciente_total` int(11) NOT NULL,
  `id_practica_paciente` int(11) DEFAULT NULL,
  `precio_unitario` decimal(8,2) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_prac_obras` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `practica_totales`
--

INSERT INTO `practica_totales` (`id_practica_paciente_total`, `id_practica_paciente`, `precio_unitario`, `cantidad`, `subtotal`, `created_at`, `updated_at`, `id_prac_obras`) VALUES
(28, 14, 1200.00, 1, 1200.00, '2025-02-16 15:51:54', NULL, NULL),
(29, 14, 7996.00, 1, 7996.00, '2025-02-16 15:51:54', NULL, NULL),
(31, 16, 3380.00, 1, 3380.00, '2025-02-16 15:52:55', NULL, NULL),
(32, 16, 1200.00, 1, 1200.00, '2025-02-16 15:52:55', NULL, NULL),
(33, 17, 1500.00, 1, 1500.00, '2025-02-16 15:54:54', NULL, NULL),
(34, 18, 7996.00, 1, 7996.00, '2025-02-16 16:01:33', NULL, NULL),
(35, 18, 1200.00, 1, 1200.00, '2025-02-16 16:01:33', NULL, NULL),
(36, 19, 7996.00, 1, 7996.00, '2025-02-16 16:04:49', NULL, NULL),
(37, 20, 9500.00, 1, 9500.00, '2025-02-16 16:09:44', NULL, NULL),
(38, 20, 1250.00, 1, 1250.00, '2025-02-16 16:09:44', NULL, NULL),
(39, 21, 9500.00, 1, 9500.00, '2025-02-16 16:12:42', NULL, NULL),
(40, 21, 1250.00, 1, 1250.00, '2025-02-16 16:12:42', NULL, NULL),
(41, 22, 9500.00, 1, 9500.00, '2025-02-16 16:13:35', NULL, NULL),
(42, 16, 7996.00, 1, 7996.00, NULL, '2025-02-16 17:00:06', NULL),
(44, 18, 7996.00, 1, 7996.00, NULL, '2025-02-17 07:45:15', NULL),
(45, 23, 3380.00, 1, 3380.00, '2025-02-17 08:14:02', NULL, NULL),
(47, 24, 7996.00, 1, 7996.00, '2025-02-17 08:32:05', NULL, NULL),
(48, 24, 3380.00, 1, 3380.00, '2025-02-17 08:32:06', NULL, NULL),
(50, 26, 9500.00, 2, 19000.00, '2025-02-22 09:13:17', NULL, NULL),
(51, 27, 1250.00, 2, 2500.00, '2025-02-22 10:58:36', NULL, NULL),
(52, 27, 9500.00, 1, 9500.00, '2025-02-22 10:58:36', NULL, NULL),
(53, 18, 15000.00, 1, 15000.00, NULL, '2025-02-22 11:24:47', NULL),
(54, 16, 7996.00, 1, 7996.00, NULL, '2025-02-22 11:26:55', NULL),
(57, 16, 15000.00, 2, 30000.00, NULL, '2025-02-23 10:39:58', NULL),
(58, 28, 7996.00, 1, 7996.00, '2025-02-23 12:04:03', NULL, NULL),
(61, 29, 1500.00, 1, 1500.00, '2025-02-23 12:22:48', NULL, NULL),
(64, 28, 3380.00, 1, 3380.00, NULL, '2025-02-23 12:36:31', NULL),
(68, 30, 1200.00, 2, 2400.00, '2025-02-23 14:50:53', NULL, NULL),
(70, 23, 7996.00, 1, 7996.00, NULL, '2025-02-26 09:07:00', NULL),
(71, 31, 7996.00, 1, 7996.00, '2025-02-27 16:51:52', NULL, NULL),
(72, 31, 3380.00, 1, 3380.00, '2025-02-27 16:51:52', NULL, NULL),
(73, 32, 9500.00, 1, 9500.00, '2025-02-27 16:54:17', NULL, NULL),
(74, 32, 1250.00, 2, 2500.00, '2025-02-27 16:54:17', NULL, NULL),
(75, 33, 1200.00, 2, 2400.00, '2025-02-27 16:56:45', NULL, NULL),
(76, 33, 3380.00, 1, 3380.00, '2025-02-27 16:56:45', NULL, NULL),
(79, 35, 1500.00, 1, 1500.00, '2025-02-27 17:00:05', NULL, NULL),
(80, 36, 1500.00, 2, 3000.00, '2025-02-27 17:02:19', NULL, NULL),
(85, 31, 15000.00, 1, 15000.00, NULL, '2025-03-01 10:57:22', NULL),
(86, 38, 7996.00, 1, 7996.00, '2025-03-01 15:18:35', NULL, NULL),
(87, 38, 3380.00, 1, 3380.00, '2025-03-01 15:18:35', NULL, NULL),
(88, 39, 9500.00, 2, 19000.00, '2025-03-15 15:35:14', NULL, NULL),
(89, 43, 7996.00, 1, 7996.00, '2025-03-22 10:42:56', NULL, NULL),
(90, 44, 7996.00, 1, 7996.00, '2025-03-22 10:43:24', NULL, NULL),
(91, 44, 3380.00, 1, 3380.00, '2025-03-22 10:43:24', NULL, NULL),
(92, 45, 7996.00, 1, 7996.00, '2025-03-22 12:45:29', NULL, NULL),
(93, 45, 7996.00, 1, 7996.00, '2025-03-22 12:45:29', NULL, NULL),
(94, 46, 3380.00, 1, 3380.00, '2025-03-22 12:46:19', NULL, NULL),
(95, 46, 15000.00, 1, 15000.00, '2025-03-22 12:46:19', NULL, NULL),
(96, 46, 7854.00, 1, 7854.00, '2025-03-22 12:46:19', NULL, NULL),
(97, 48, 7996.00, 1, 7996.00, '2025-03-22 14:29:51', NULL, NULL),
(98, 48, 1200.00, 1, 1200.00, '2025-03-22 14:29:51', NULL, NULL),
(99, 49, 7996.00, 2, 15992.00, '2025-03-22 14:44:24', NULL, NULL),
(100, 49, 7996.00, 1, 7996.00, '2025-03-22 14:44:24', NULL, NULL),
(101, 50, 1500.00, 1, 1500.00, '2025-03-22 14:55:17', NULL, NULL),
(102, 50, 1200.00, 1, 1200.00, '2025-03-22 14:55:17', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `dni_usuario` char(8) DEFAULT NULL,
  `usu_nombre` varchar(255) DEFAULT NULL,
  `usu_apellido` varchar(255) DEFAULT NULL,
  `usu_email` varchar(255) DEFAULT NULL,
  `usu_telefono` char(11) DEFAULT NULL,
  `usu_direccion` varchar(255) DEFAULT NULL,
  `usu_usuario` varchar(255) DEFAULT NULL,
  `usu_contrasenia` varchar(255) DEFAULT NULL,
  `usu_rol` enum('MEDICO','FACTURA','ADMINISTRADOR') DEFAULT NULL,
  `usu_estatus` enum('DESACTIVADO','ACTIVO') DEFAULT NULL,
  `usu_foto` varchar(500) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `dni_usuario`, `usu_nombre`, `usu_apellido`, `usu_email`, `usu_telefono`, `usu_direccion`, `usu_usuario`, `usu_contrasenia`, `usu_rol`, `usu_estatus`, `usu_foto`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, '72646121', 'JERSSON', 'CORILLA MIRANDA', 'jersson1@gmail.com', '974031312', 'AV. PERÚ N° 323', 'jersson', '$2y$12$LfYcbb0t9NbbspTrbweeSu2M36w0P6jvwf5nU6YenKTfoCNK.ckTe', 'ADMINISTRADOR', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-51.jpg', 1, '2025-01-18 14:56:34', '2025-03-01 12:48:47'),
(2, '15155115', 'ESTEFANY', 'CHAVEZ PEDRAZA', 'estefany2025@gmail.com', '9511515155', 'AV. PERÚ N° 323', 'ESTEFANY2025', '$2y$12$4hHkLyuAcnD4QHgPOOPs2.trZVKC4Br3P6vamRqOVYUPibEjsoUzW', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-451.jpeg', 1, '2025-01-18 15:43:46', '2025-03-01 14:49:43'),
(3, '23355655', 'GONZALO', 'JORDAN', 'gonzalo2025@gmail.com', '921118588', 'AV. PERÚ N° 111', 'GONZALO2025', '$2y$12$LfYcbb0t9NbbspTrbweeSu2M36w0P6jvwf5nU6YenKTfoCNK.ckTe', 'ADMINISTRADOR', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-578.png', 1, '2025-01-25 00:00:00', '2025-03-01 12:51:10'),
(4, '55445454', 'JAVIER', 'DAMIAN CHIPA', 'javier21@gmail.com', '92122002202', 'JR. CUSCO N° 23', 'JAVIER2025', '$2y$12$LfYcbb0t9NbbspTrbweeSu2M36w0P6jvwf5nU6YenKTfoCNK.ckTe', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-683.jpg', 1, '2025-01-25 00:00:00', '2025-03-01 12:51:51'),
(5, '15155115', 'SANDRO', 'CHAVEZ LOAYZA', 'sandro21@gmail.com', '9511515155', 'AV. PERÚ N° 323', 'sandro2025', '$2y$12$LfYcbb0t9NbbspTrbweeSu2M36w0P6jvwf5nU6YenKTfoCNK.ckTe', 'FACTURA', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-100.jpg', 1, '2025-01-25 09:57:53', '2025-03-01 12:39:29'),
(6, '66663222', 'JIMENA', 'PEDRAZA', 'jimena12@gmail.com', '9211100000', 'JR. AREQUIPA N° 233', 'JIMENA2025', '$2y$12$LfYcbb0t9NbbspTrbweeSu2M36w0P6jvwf5nU6YenKTfoCNK.ckTe', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-947.jpeg', 1, '2025-01-25 11:19:45', '2025-03-01 12:52:32'),
(7, '66226226', 'JUANA', 'CHAVEZ', 'juana12@gmail.com', '92262662', 'JR. CUSCO N° 321', 'JUANA2025', '$2y$12$jv9br.jav/dRWEKf5TFSpuB8UUas4.voLfT2cCQOWv5v8WMdrM4dK', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-755.jpeg', 1, '2025-03-01 12:43:15', '2025-03-01 12:43:15'),
(8, '62626266', 'DANIEL', 'CHAVEZ HUAMAN', 'daniel12@gmail.com', '9616216515', 'JR. AREQUIPA N° 323', 'daniel2025', '$2y$12$6gABxP4qvZo3GLMHBe77BeXtN/qhiYlqgDDPzF/HqgqFMSz49Bzji', 'ADMINISTRADOR', 'ACTIVO', 'controller/usuario/fotos/IMG1-3-2025-12-3.jpg', 1, '2025-03-01 12:46:46', '2025-03-01 12:49:04');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas_hospital`
--
ALTER TABLE `areas_hospital`
  ADD PRIMARY KEY (`id_area`),
  ADD KEY `fk_user_area` (`id_usuario`);

--
-- Indices de la tabla `detalle_fatura`
--
ALTER TABLE `detalle_fatura`
  ADD PRIMARY KEY (`id_detalle_factura`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_practica_paciente2` (`id_practica_paciente`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `fk_use_fac` (`id_usuario`);

--
-- Indices de la tabla `historial_factura`
--
ALTER TABLE `historial_factura`
  ADD PRIMARY KEY (`id_historial_factur`),
  ADD KEY `fk_id_fac` (`id_factura`);

--
-- Indices de la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  ADD PRIMARY KEY (`id_historial_pagos`),
  ADD KEY `fk_historia_pago` (`id_factura`);

--
-- Indices de la tabla `historial_practicas`
--
ALTER TABLE `historial_practicas`
  ADD PRIMARY KEY (`id_actualiza_practica`),
  ADD KEY `fk_id_practica` (`id_practica`);

--
-- Indices de la tabla `historial_practicas_obras_sociales`
--
ALTER TABLE `historial_practicas_obras_sociales`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `FK_OBRA_SOCIAL_PRAC` (`id_practica_obra`);

--
-- Indices de la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  ADD PRIMARY KEY (`id_cuit`),
  ADD KEY `fk_user` (`id_usuario`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`),
  ADD KEY `fk_obra_social` (`Id_obra_social`),
  ADD KEY `fk_usuario` (`id_usuario`);

--
-- Indices de la tabla `paciente_practica`
--
ALTER TABLE `paciente_practica`
  ADD PRIMARY KEY (`id_paciente_practica`),
  ADD KEY `fk_area` (`id_area`),
  ADD KEY `fk_paciente` (`id_paciente`),
  ADD KEY `fk_usu233` (`id_usuario`);

--
-- Indices de la tabla `practicas`
--
ALTER TABLE `practicas`
  ADD PRIMARY KEY (`id_practica`),
  ADD KEY `fk_usss` (`id_usu`);

--
-- Indices de la tabla `practicas_obras_sociales`
--
ALTER TABLE `practicas_obras_sociales`
  ADD PRIMARY KEY (`id_practicas_obras`) USING BTREE,
  ADD KEY `id_practica22` (`id_practica`),
  ADD KEY `id_obra_2` (`id_obra`);

--
-- Indices de la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  ADD PRIMARY KEY (`id_practica_paciente_total`),
  ADD KEY `id_practica_paciente` (`id_practica_paciente`),
  ADD KEY `id_prac_obritas` (`id_prac_obras`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_empresa` (`id_empresa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas_hospital`
--
ALTER TABLE `areas_hospital`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_fatura`
--
ALTER TABLE `detalle_fatura`
  MODIFY `id_detalle_factura` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `historial_factura`
--
ALTER TABLE `historial_factura`
  MODIFY `id_historial_factur` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  MODIFY `id_historial_pagos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historial_practicas`
--
ALTER TABLE `historial_practicas`
  MODIFY `id_actualiza_practica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `historial_practicas_obras_sociales`
--
ALTER TABLE `historial_practicas_obras_sociales`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  MODIFY `id_cuit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `paciente_practica`
--
ALTER TABLE `paciente_practica`
  MODIFY `id_paciente_practica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `practicas`
--
ALTER TABLE `practicas`
  MODIFY `id_practica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `practicas_obras_sociales`
--
ALTER TABLE `practicas_obras_sociales`
  MODIFY `id_practicas_obras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  MODIFY `id_practica_paciente_total` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `areas_hospital`
--
ALTER TABLE `areas_hospital`
  ADD CONSTRAINT `fk_user_area` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_fatura`
--
ALTER TABLE `detalle_fatura`
  ADD CONSTRAINT `id_factura` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_practica_paciente2` FOREIGN KEY (`id_practica_paciente`) REFERENCES `paciente_practica` (`id_paciente_practica`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `fk_use_fac` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_factura`
--
ALTER TABLE `historial_factura`
  ADD CONSTRAINT `fk_id_fac` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_pagos`
--
ALTER TABLE `historial_pagos`
  ADD CONSTRAINT `fk_historia_pago` FOREIGN KEY (`id_factura`) REFERENCES `facturas` (`id_factura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_practicas`
--
ALTER TABLE `historial_practicas`
  ADD CONSTRAINT `fk_id_practica` FOREIGN KEY (`id_practica`) REFERENCES `practicas` (`id_practica`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_practicas_obras_sociales`
--
ALTER TABLE `historial_practicas_obras_sociales`
  ADD CONSTRAINT `FK_OBRA_SOCIAL_PRAC` FOREIGN KEY (`id_practica_obra`) REFERENCES `practicas_obras_sociales` (`id_practicas_obras`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `fk_obra_social` FOREIGN KEY (`Id_obra_social`) REFERENCES `obras_sociales` (`id_cuit`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `paciente_practica`
--
ALTER TABLE `paciente_practica`
  ADD CONSTRAINT `fk_area` FOREIGN KEY (`id_area`) REFERENCES `areas_hospital` (`id_area`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usu233` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `practicas`
--
ALTER TABLE `practicas`
  ADD CONSTRAINT `fk_usss` FOREIGN KEY (`id_usu`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION;

--
-- Filtros para la tabla `practicas_obras_sociales`
--
ALTER TABLE `practicas_obras_sociales`
  ADD CONSTRAINT `id_obra_2` FOREIGN KEY (`id_obra`) REFERENCES `obras_sociales` (`id_cuit`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `id_practica22` FOREIGN KEY (`id_practica`) REFERENCES `practicas` (`id_practica`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  ADD CONSTRAINT `id_prac_obritas` FOREIGN KEY (`id_prac_obras`) REFERENCES `practicas_obras_sociales` (`id_practicas_obras`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `id_practica_paciente` FOREIGN KEY (`id_practica_paciente`) REFERENCES `paciente_practica` (`id_paciente_practica`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
