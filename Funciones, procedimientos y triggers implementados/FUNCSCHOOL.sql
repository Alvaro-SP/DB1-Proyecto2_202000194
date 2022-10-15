

--! █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▄█   █▀▄ █▄▄
--! ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   ░█░ █▄█   █░▀░█ ░█░   █▄▀ █▄█            ----------202000194-------

--* █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀   ▄▀█ █▄░█ █▀▄   █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀▄ █░█ █▀█ █▀▀ █▀
--* █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█   █▀█ █░▀█ █▄▀   █▀▀ █▀▄ █▄█ █▄▄ ██▄ █▄▀ █▄█ █▀▄ ██▄ ▄█
DELIMITER //
DROP FUNCTION IF EXISTS ValidarCorreo //
CREATE FUNCTION ValidarCorreo(correo VARCHAR(45)) RETURNS BOOLEAN
    deterministic
    BEGIN
    DECLARE valido BOOLEAN;
    -- * valido con el regex de CORREO
    IF (SELECT REGEXP_INSTR(correo, '^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9_\-]@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\.[a-zA-Z]{2,4}$')=1)  THEN
        SELECT TRUE INTO valido;
    ELSE
        SELECT FALSE INTO valido;
    END IF;
    RETURN (valido);
    END //
DELIMITER ;
DELIMITER //
DROP FUNCTION IF EXISTS ValidarLetras //
CREATE FUNCTION ValidarLetras(correo VARCHAR(45)) RETURNS BOOLEAN
    deterministic
    BEGIN
    DECLARE valido BOOLEAN;
    -- * valido con el regex de CORREO
    IF (SELECT REGEXP_INSTR(correo, '^[a-zA-Z]+$')=1)  THEN
        SELECT TRUE INTO valido;
    ELSE
        SELECT FALSE INTO valido;
    END IF;
    RETURN (valido);
    END //
DELIMITER ;

--* ▀█▀ █▀█ █ █▀▀ █▀▀ █▀▀ █▀█ █▀
--* ░█░ █▀▄ █ █▄█ █▄█ ██▄ █▀▄ ▄█






-- ? █▀█ █▀▀ █▀▀ █ █▀ ▀█▀ █▀█ █▀█
-- ? █▀▄ ██▄ █▄█ █ ▄█ ░█░ █▀▄ █▄█



DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 1. REGISTRO DE ESTUDIANTES █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS RegistrarEstudiante //
CREATE FUNCTION RegistrarEstudiante
    (  
    carnet BIGINT,
    nombres VARCHAR(45),
    apellidos VARCHAR(45),
    fecha_nacimiento DATETIME,
    correo VARCHAR(45),
    telefono INT,
    direccion VARCHAR(45),
    dpi BIGINT,
    carrera INT 
    ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE cdate DATETIME;
    DECLARE temp BOOLEAN;
    SET cdate = now(); -- * obtengo la fecha actual    
    SET temp = ValidarCorreo(correo);
    IF (temp = 0) THEN
		RETURN 'ERROR DE CORREO VERIFICAR EL FORMATO DE CORREO';
	END IF;

    INSERT INTO ESTUDIANTE (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos)
    VALUES (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,cdate,0);

    RETURN "ESTUDIANTE GUARDADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Crear carrera █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS CrearCarrera //
CREATE FUNCTION CrearCarrera(nombre VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = ValidarLetras(nombre);
    IF (temp = 0) THEN
		RETURN 'ERROR EL NOMBRE SOLO DEBE TENER LETRAS';
	END IF;
    INSERT INTO CARRERA (id, nombre)VALUES (NULL, nombre);
    RETURN "ESTUDIANTE GUARDADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 3. Registrar docente █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█

DROP FUNCTION IF EXISTS RegistrarEstudiante //
CREATE FUNCTION RegistrarEstudiante
    (
    carnet BIGINT,
    nombres VARCHAR(45),
    apellidos VARCHAR(45),
    fecha_nacimiento DATETIME,
    correo VARCHAR(45),
    telefono INT,
    direccion VARCHAR(45),
    dpi BIGINT,
    carrera INT 
    ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE cdate DATETIME;
    DECLARE temp BOOLEAN;
    SET cdate = now(); -- * obtengo la fecha actual    
    SET temp = ValidarCorreo(correo);
    IF (temp = 0) THEN
		RETURN 'ERROR DE CORREO VERIFICAR EL FORMATO DE CORREO';
	END IF;

    INSERT INTO ESTUDIANTE (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos)
    VALUES (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,cdate,0);

    RETURN "ESTUDIANTE GUARDADO";
    END//
DELIMITER ;


SELECT RegistrarEstudiante(2020001942,'Alvaro', 'Socop', '2001-12-24','socop@gmail.com',55555555,'mlsw calle juan', 3034161730108,14 ) AS RESPUESTA_RegistrarEstudiante;

-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 4. Crear curso   █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██ 5. Habilitar curso para asignación ██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄ 6. Agregar un horario de curso habilitado ██▄██▄██▄███▄██▄██▄██▄
-- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 7. Asignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██ 8. Desasignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 9. Ingresar notas ██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█



--? █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ ▄▀█ █▀▄▀█ █ █▀▀ █▄░█ ▀█▀ █▀█   █▀▄ █▀▀   █▀▄ ▄▀█ ▀█▀ █▀█ █▀
--? █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ █▀█ █░▀░█ █ ██▄ █░▀█ ░█░ █▄█   █▄▀ ██▄   █▄▀ █▀█ ░█░ █▄█ ▄█

-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 1. Consultar pensum █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Consultar estudiante   █▄██▄██▄██▄██▄██▄██▄██▄██▄██
-- ! █▄██▄██▄██▄██▄██▄███▄██▄██▄█   3. Consultar docente     ██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 4. Consultar estudiantes asignados ██▄██▄██▄███▄██▄██▄██▄
-- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 5. Consultar aprobaciones █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█▄██ 6. Consultar actas █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄ 7. Consultar tasa de desasignación ██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█



-- * █▄██▄██▄██▄██▄██▄██▄██▄██▄█Historial de transacciones█▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█






SELECT RegistrarEstudiante(2020001942,'Alvaro', 'Socop', '2001-12-24','socop@gmail.com',55555555,'mlsw calle juan', 3034161730108,14 ) AS RESPUESTA_RegistrarEstudiante;
