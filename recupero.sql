-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-02-2025 a las 23:45:19
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_AREA` ()   SELECT
areas_hospital.id_area,
areas_hospital.nombre
FROM areas_hospital$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_OBRAS_SOCIALES` ()   SELECT id_cuit,Cuit,Nombre
FROM obras_sociales$$

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
WHERE obras_sociales.id_cuit=ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_PRACTICAS` ()   SELECT 
practicas.id_práctica,
practicas.cod_practica,
practicas.practica

FROM practicas$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_SELECT_AREA` ()   SELECT
areas_hospital.id_area,areas_hospital.nombre
FROM areas_hospital
WHERE estado_area="ACTIVO"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_TRAER_PRECIO` (IN `ID` INT)   SELECT
practicas.cod_practica,
practicas.valor
FROM practicas
WHERE practicas.`id_práctica`=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CARGAR_USUARIOS` ()   SELECT 
usuario.id_usuario,
usuario.dni_usuario,
CONCAT_WS(usuario.usu_nombre,' ',usuario.usu_apellido)as USUARIO
FROM usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_AREA` (IN `ID` INT)   DELETE FROM areas_hospital
WHERE id_area=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_OBRA` (IN `ID` INT)   DELETE FROM obras_sociales
WHERE obras_sociales.id_cuit=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PACIENTE` (IN `ID` INT)   DELETE FROM pacientes
WHERE pacienteS.id_paciente=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRACTICA` (IN `ID` INT)   DELETE FROM practicas
WHERE id_práctica=ID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRACTICAS_PACIENTE` (IN `ID` INT)   BEGIN
DELETE FROM practica_totales
WHERE practica_totales.id_practica_paciente=ID;
DELETE FROM paciente_practica
WHERE paciente_practica.id_paciente_practica=ID;
END$$

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
practicas.id_práctica,
practicas.cod_practica,
practicas.practica,
practicas.valor,
practicas.estado,
practicas.id_usu,
practicas.id_obras,
practicas.created_at,
practicas.updated_at,
obras_sociales.Cuit AS CODIGO,
obras_sociales.Nombre as OBRA,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(practicas.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(practicas.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM practicas inner join obras_sociales
ON practicas.id_obras=obras_sociales.id_cuit inner join usuario
on practicas.id_usu=usuario.id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LISTAR_PRACTICAS_FILTRO` (IN `OBRA` INT, IN `FECHAINI` DATE, IN `FECHAFIN` DATE)   BEGIN
SELECT
practicas.id_práctica,
practicas.cod_practica,
practicas.practica,
practicas.valor,
practicas.estado,
practicas.id_usu,
practicas.id_obras,
practicas.created_at,
practicas.updated_at,
obras_sociales.Cuit AS CODIGO,
obras_sociales.Nombre as OBRA,
usuario.usu_usuario,
CONCAT_WS(' ',usuario.usu_nombre,usuario.usu_apellido) AS USUARIO,
	date_format(practicas.created_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada,
 	date_format(practicas.updated_at, "%d-%m-%Y - %H:%i:%s") as fecha_formateada2
FROM practicas inner join obras_sociales
ON practicas.id_obras=obras_sociales.id_cuit inner join usuario
on practicas.id_usu=usuario.id_usuario
 WHERE 
    practicas.id_obras = OBRA 
    OR DATE(practicas.created_at) BETWEEN FECHAINI AND FECHAFIN;
END$$

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
    paciente_practica.id_usuario, 
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
		SELECT 1;	
	ELSE
		SELECT 2;	
	END IF;
END IF;

END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_AREA` (IN `NAREA` VARCHAR(255), IN `DESCRIP` VARCHAR(255), IN `USU` INT)   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM areas_hospital where nombre=NAREA);
IF @CANTIDAD = 0 THEN
INSERT INTO areas_hospital(nombre,descripcion,id_usuario,created_at,estado_area)VALUE(NAREA,DESCRIPCION,USU,NOW(),'ACTIVO');
SELECT 1;
ELSE
SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_DETALLE_PRACTICAS` (IN `ID` INT, IN `PRACTICA` INT, IN `SUBTO` DECIMAL(8,2))   INSERT INTO practica_totales(practica_totales.id_practica_paciente,id_practica,subtotal,created_at)
VALUES(ID,PRACTICA,SUBTO,NOW())$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PRACTICAS` (IN `CODI` CHAR(8), IN `PRACT` VARCHAR(500), IN `VAL` DECIMAL(8,2), IN `OBRA` INT, IN `USU` INT)   BEGIN
DECLARE CANTIDAD INT;
SET @CANTIDAD:=(SELECT COUNT(*) FROM practicas where cod_practica=CODI);
IF @CANTIDAD = 0 THEN
INSERT INTO practicas(cod_practica,practica,valor,estado,id_usu,id_obras,created_at)VALUE(CODI,PRACT,VAL,'ACTIVO',USU,OBRA,NOW());
SELECT 1;
ELSE
SELECT 2;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_PRACTICAS_PACIENTE` (IN `AREA` INT, IN `PACIENTE` INT, IN `TOTALPRA` DECIMAL(8,2), IN `IDUSU` INT)   BEGIN 

DECLARE ULTI INT;

INSERT INTO paciente_practica(id_area,id_paciente,total,id_usuario,created_at)VALUES
(AREA,PACIENTE,TOTALPRA,IDUSU,NOW());

SET @ULTI:=(SELECT MAX(paciente_practica.id_paciente_practica) FROM paciente_practica);
select @ULTI;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USUARIO` (IN `DNI` CHAR(8), IN `NOMBRE` VARCHAR(50), IN `APELLIDO` VARCHAR(50), IN `EMAIL` VARCHAR(255), IN `TELEFONO` CHAR(11), IN `DIRECCION` TEXT, IN `FOTO` VARCHAR(255), IN `USU` VARCHAR(255), IN `CONTRA` VARCHAR(255), IN `ROL` VARCHAR(25))   BEGIN
    DECLARE CANTIDAD_DNI INT;
    DECLARE CANTIDAD_USU INT;

    -- Verificar si el DNI ya existe en otro registro (que no sea el mismo usuario)
    SET @CANTIDAD_DNI := (SELECT COUNT(*) FROM usuario WHERE dni_usuario = DNI AND id_usuario != ID_USUARIO);

    -- Verificar si el nombre de usuario ya existe en otro registro (que no sea el mismo usuario)
    SET @CANTIDAD_USU := (SELECT COUNT(*) FROM usuario WHERE usu_usuario = USU AND id_usuario != ID_USUARIO);

    -- Si no existe un DNI duplicado y un usuario duplicado
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
            usu_contrasenia = CONTRA,
            usu_rol = ROL,
            usu_foto = FOTO,
            updated_at = NOW()
        WHERE id_usuario = ID_USUARIO;

        SELECT 1; -- Indicar que la actualización fue exitosa

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
(1, 'PEDIATRIA', 'PEDIATRIA NIÑOS', 1, '2025-01-25 11:47:03', NULL, 'ACTIVO'),
(2, 'CARDIOLOGIA', 'CARDIO', 1, '2025-01-25 11:47:26', NULL, 'ACTIVO'),
(3, 'RECURSOS HUMANOS', 'RR.HH', 1, '2025-01-25 11:47:39', NULL, 'ACTIVO'),
(4, 'TRAUMATOLOGIA', 'ÁREA DE TRAUMATOLOGIAA', 4, '2025-01-25 12:41:25', '2025-01-25 12:42:48', 'ACTIVO');

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
(3, '10245', 'ASOCIACION MUTUAL DE LOS OBREROS CATOLICOS PADRE FEDERICO GROTE', 'JR. ANDAHUAYLAS N° 323', 'ANDAHUAYLAS', 'LUIS12@GMAIL.COM', 1, 'ACTIVO', '2025-01-26 10:59:32', NULL);

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
(4, '67686767', 'ANDREA', 'SANCHEZ DAVILA', 'AV. CANADA N° 233', 'CUSCO', '9265155115', 2, 1, '2025-01-26 15:15:38', '2025-01-26 15:55:28');

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
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente_practica`
--

INSERT INTO `paciente_practica` (`id_paciente_practica`, `id_area`, `id_paciente`, `total`, `id_usuario`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 9648.00, 1, '2025-02-08 08:09:43', NULL),
(7, 2, 2, 8448.00, 1, '2025-02-08 16:55:16', NULL),
(8, 2, 4, 1200.00, 1, '2025-02-08 17:07:57', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practicas`
--

CREATE TABLE `practicas` (
  `id_práctica` int(11) NOT NULL,
  `cod_practica` char(8) DEFAULT NULL,
  `practica` varchar(500) DEFAULT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `estado` enum('INACTIVO','ACTIVO') DEFAULT NULL,
  `id_usu` int(11) DEFAULT NULL,
  `id_obras` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `practicas`
--

INSERT INTO `practicas` (`id_práctica`, `cod_practica`, `practica`, `valor`, `estado`, `id_usu`, `id_obras`, `created_at`, `updated_at`) VALUES
(2, '1011', 'CONSULTA EN CAPS.', 1200.00, 'ACTIVO', 1, 2, '2025-01-30 14:35:29', '2025-01-30 15:44:33'),
(3, '1012', 'CONSULTA Y UNA PRáCTICA DEL CóDIGO 1.03.', 8448.00, 'ACTIVO', 1, 1, '2025-01-30 14:37:20', '2025-01-30 15:51:26'),
(4, '1021', 'CONSULTA EN CAPS Y UNA PRáCTICA DEL CóDIGO 103.', 1200.00, 'ACTIVO', 1, 1, '2025-01-30 15:22:03', '2025-01-30 15:51:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `practica_totales`
--

CREATE TABLE `practica_totales` (
  `id_practica_paciente_total` int(11) NOT NULL,
  `id_practica_paciente` int(11) DEFAULT NULL,
  `id_practica` int(11) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `practica_totales`
--

INSERT INTO `practica_totales` (`id_practica_paciente_total`, `id_practica_paciente`, `id_practica`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 4000.00, '2025-02-08 08:10:03', NULL),
(4, 1, 3, 4000.00, '2025-02-08 08:10:14', NULL),
(10, 7, 3, 8448.00, '2025-02-08 16:55:16', NULL),
(11, 8, 2, 1200.00, '2025-02-08 17:07:57', NULL);

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
  `usu_rol` enum('MEDICO','ADMINISTRADOR') DEFAULT NULL,
  `usu_estatus` enum('DESACTIVADO','ACTIVO') DEFAULT NULL,
  `usu_foto` varchar(500) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `dni_usuario`, `usu_nombre`, `usu_apellido`, `usu_email`, `usu_telefono`, `usu_direccion`, `usu_usuario`, `usu_contrasenia`, `usu_rol`, `usu_estatus`, `usu_foto`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, '72646121', 'JERSSON JORGE', 'CORILLA MIRANDA', 'jersson14071996@gmail.com', '974031318', 'JR. NICOLAS DE PIEROLA', 'jersson', '$2y$12$uNlahljrlLnIjOgmL9NnreYGzLWJSrO5dIUT8Dx.F.OsuyX7z7kkO', 'ADMINISTRADOR', 'ACTIVO', 'controller/usuario/fotos/IMG25-1-2025-11-600.jpg', 1, '2025-01-18 14:56:34', '2025-01-25 11:45:46'),
(2, '23354564', 'ESTEFANY', 'CHIPANA DAMIAN', 'ESTE23@GMAIL.COM', '922145214', 'JR. CANADA N° 323', 'ESTEFANY2025', '$2y$12$uNlahljrlLnIjOgmL9NnreYGzLWJSrO5dIUT8Dx.F.OsuyX7z7kkO', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG25-1-2025-11-312.jpg', 1, '2025-01-18 15:43:46', '2025-01-25 11:41:34'),
(3, '34455454', 'JHOSEP', 'DAVILA MERMA', 'JHOSEP321@GMAIL.COM', '924158487', 'JR. CUSCO N° 323', 'JHOSEP12@GMAIL.COM', '$2y$12$EghB6xXAOQTSCQNeww8bYOcFEnhmAb8.Na7NqfuujdBWEXLw4z1fi', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/', 1, '2025-01-25 00:00:00', '2025-01-25 11:40:38'),
(4, '64415434', 'SOFIA', 'SANCHEZ JIMENEZ', 'SFOI123@GMAIL.COM', '920414444', 'AV. PERU N° 323', 'SOFIA2025', '$2y$12$GLuvdovVqnkeMOZybSJ7HOo5i7dsfEBd9PF94BR35ly58UsAbzrSa', 'ADMINISTRADOR', 'ACTIVO', 'controller/usuario/fotos/IMG25-1-2025-11-176.jpg', 1, '2025-01-25 00:00:00', '2025-01-25 11:43:58'),
(5, '99526626', 'ANDRES', 'PEÑA HUAMAN', 'ANDRES21@GMAIL.COM', '954214587', 'AV. CANADA N° 323', 'ANDRES2025', '$2y$12$SgNBUsWce5wNi984Ln0uhOPvOgMd5HGmbuShTfTN.Ziyt4E2f2uBe', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG25-1-2025-11-631.webp', 1, '2025-01-25 09:57:53', '2025-01-25 11:38:24'),
(6, '15155177', 'JOSE', 'PEÑA DAVALOS', 'JOSE21@GMAIL.COM', '925414587', 'JR. CHALHUANCA N° 323', 'JOSE2025', '$2y$12$YRVa5QTS4DeNqtHsInTi8uvhmfsN9EdnJyiPzc6GrHuME5CJUtdka', 'MEDICO', 'ACTIVO', 'controller/usuario/fotos/IMG25-1-2025-11-287.jpg', 1, '2025-01-25 11:19:45', '2025-01-25 11:37:18');

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
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

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
  ADD PRIMARY KEY (`id_práctica`),
  ADD KEY `fk_usss` (`id_usu`),
  ADD KEY `fk_obrit` (`id_obras`);

--
-- Indices de la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  ADD PRIMARY KEY (`id_practica_paciente_total`),
  ADD KEY `id_practica_paciente` (`id_practica_paciente`),
  ADD KEY `id_practic` (`id_practica`);

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
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  MODIFY `id_cuit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `paciente_practica`
--
ALTER TABLE `paciente_practica`
  MODIFY `id_paciente_practica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `practicas`
--
ALTER TABLE `practicas`
  MODIFY `id_práctica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  MODIFY `id_practica_paciente_total` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `areas_hospital`
--
ALTER TABLE `areas_hospital`
  ADD CONSTRAINT `fk_user_area` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

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
  ADD CONSTRAINT `fk_obrit` FOREIGN KEY (`id_obras`) REFERENCES `obras_sociales` (`id_cuit`) ON DELETE NO ACTION,
  ADD CONSTRAINT `fk_usss` FOREIGN KEY (`id_usu`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION;

--
-- Filtros para la tabla `practica_totales`
--
ALTER TABLE `practica_totales`
  ADD CONSTRAINT `id_practic` FOREIGN KEY (`id_practica`) REFERENCES `practicas` (`id_práctica`) ON DELETE NO ACTION ON UPDATE CASCADE,
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
