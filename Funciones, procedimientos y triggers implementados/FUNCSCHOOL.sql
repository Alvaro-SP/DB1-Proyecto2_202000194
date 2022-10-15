

--! █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▄█   █▀▄ █▄▄
--! ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   ░█░ █▄█   █░▀░█ ░█░   █▄▀ █▄█            ----------202000194-------

--* █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀   ▄▀█ █▄░█ █▀▄   █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀▄ █░█ █▀█ █▀▀ █▀
--* █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█   █▀█ █░▀█ █▄▀   █▀▀ █▀▄ █▄█ █▄▄ ██▄ █▄▀ █▄█ █▀▄ ██▄ ▄█
DELIMITER // -- ************************************************************
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
DELIMITER //  -- ************************************************************
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

DELIMITER //    -- ************************************************************
DROP FUNCTION IF EXISTS is_int //
CREATE FUNCTION is_int(num INT) RETURNS BOOLEAN
    deterministic
    BEGIN
    DECLARE valido BOOLEAN;
    -- * valido con el regex de num
    IF (num>=0)  THEN
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



DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 1. REGISTRO DE ESTUDIANTES █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 😎
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

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Crear carrera █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 😎
-- AGREGO AREA COMUN PRIMERO
INSERT INTO CARRERA (id, nombre) VALUES (NULL, 'Area Comun');
DROP FUNCTION IF EXISTS CrearCarrera //
CREATE FUNCTION CrearCarrera(nombre VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = ValidarLetras(nombre);
    IF (temp = 0) THEN
		RETURN 'ERROR EL NOMBRE SOLO DEBE TENER LETRAS';
	END IF;
    INSERT INTO CARRERA (id, nombre) VALUES (NULL, nombre);
    RETURN "ESTUDIANTE GUARDADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 3. Registrar docente █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎

DROP FUNCTION IF EXISTS RegistrarDocente //
CREATE FUNCTION RegistrarDocente
    (
    nombres VARCHAR(45),
    apellidos VARCHAR(45),
    fecha_nacimiento DATETIME,
    correo VARCHAR(45),
    telefono INT,
    direccion VARCHAR(45),
    dpi BIGINT,
    registro_siif INT
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

    INSERT INTO DOCENTE (registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,fechacreacion)
    VALUES (registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,cdate);

    RETURN "DOCENTE GUARDADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 4. Crear curso   █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DROP FUNCTION IF EXISTS CrearCurso //
CREATE FUNCTION CrearCurso
    (
    codigo INT ,
    nombre VARCHAR(45),
    creditos_necesarios INT ,
    creditos_otorga INT ,
    carrera INT ,
    obligatorio INT
    ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = is_int(creditos_necesarios);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);
    SET temp = is_int(creditos_otorga);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS OTORGA NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_otorga = ROUND(creditos_otorga,0);
    -- ? VALIDO SI EXISTE LA CARRERA
    DECLARE existe INT;
    SET existe = (SELECT id FROM CARRERA WHERE id=carrera);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO LA CARRERA ',carrera);
    END IF;
    -- ? VALIDO OBLIGATORIO
    IF ((obligatorio != 1) AND (obligatorio != 0) ) THEN
        RETURN 'PARAMETRO OBLIGATORIO DEBE SER 1 o 0';
    END IF;
    -- ? INSERTO
    INSERT INTO CURSO (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio)
    VALUES (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██ 5. Habilitar curso para asignación ██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS HabilitarCurso //
CREATE FUNCTION HabilitarCurso
    (codigo_curso INT ,ciclo VARCHAR(45), docente INT, cupo INT, seccion VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN

    -- ? *Se debe validar que el curso exista
    DECLARE existe INT;
    SET existe = (SELECT codigo FROM CURSO WHERE codigo=codigo_curso);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CURSO ',codigo_curso);
    END IF;

    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        RETURN 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD';
    END IF;
    -- ? *Se debe validar que el DOCENTE exista
    SET existe = NULL;
    SET existe = (SELECT registro_siif FROM DOCENTE WHERE registro_siif=docente);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL DOCENTE ',docente);
    END IF;
    -- ? Validar que sea un número entero positivo
    DECLARE temp BOOLEAN;
    SET temp = is_int(cupo);
    IF (temp = 0) THEN
		RETURN 'ERROR CUPO NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET cupo = ROUND(cupo,0);
    -- ? *Una letra y guardarla en mayúscula
    SET seccion = UPPER(seccion);


    -- ? INSERTO
    INSERT INTO HABILITADOS (id, codigo_curso, ciclo, seccion, docente, cupo_maximo, anio, cant_estudiantes, cupos_disponibles, dia, horario)
    VALUES (NULL,codigo_curso,ciclo,seccion,docente,cupo,2022,0,cupo);
    RETURN "CURSO HABILITADO CORRECTAMENTE";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄ 6. Agregar un horario de curso habilitado ██▄██▄██▄███▄██▄██▄██▄
DROP FUNCTION IF EXISTS AgregarHorario //
CREATE FUNCTION AgregarHorario
    (id_curso_habilitado INT, dia INT, horario VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = is_int(creditos_necesarios);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);
    SET temp = is_int(creditos_otorga);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS OTORGA NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_otorga = ROUND(creditos_otorga,0);
    -- ? VALIDO SI EXISTE LA CARRERA
    DECLARE existe INT;
    SET existe = (SELECT id FROM CARRERA WHERE id=carrera);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO LA CARRERA ',carrera);
    END IF;
    -- ? VALIDO OBLIGATORIO
    IF ((obligatorio != 1) AND (obligatorio != 0) ) THEN
        RETURN 'PARAMETRO OBLIGATORIO DEBE SER 1 o 0';
    END IF;
    -- ? INSERTO
    INSERT INTO CURSO (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio)
    VALUES (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 7. Asignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS AsignarCurso //
CREATE FUNCTION AsignarCurso
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = is_int(creditos_necesarios);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);
    SET temp = is_int(creditos_otorga);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS OTORGA NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_otorga = ROUND(creditos_otorga,0);
    -- ? VALIDO SI EXISTE LA CARRERA
    DECLARE existe INT;
    SET existe = (SELECT id FROM CARRERA WHERE id=carrera);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO LA CARRERA ',carrera);
    END IF;
    -- ? VALIDO OBLIGATORIO
    IF ((obligatorio != 1) AND (obligatorio != 0) ) THEN
        RETURN 'PARAMETRO OBLIGATORIO DEBE SER 1 o 0';
    END IF;
    -- ? INSERTO
    INSERT INTO CURSO (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio)
    VALUES (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;
DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██ 8. Desasignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS DesasignarCurso //
CREATE FUNCTION DesasignarCurso
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT , nota INT) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = is_int(creditos_necesarios);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);
    SET temp = is_int(creditos_otorga);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS OTORGA NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_otorga = ROUND(creditos_otorga,0);
    -- ? VALIDO SI EXISTE LA CARRERA
    DECLARE existe INT;
    SET existe = (SELECT id FROM CARRERA WHERE id=carrera);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO LA CARRERA ',carrera);
    END IF;
    -- ? VALIDO OBLIGATORIO
    IF ((obligatorio != 1) AND (obligatorio != 0) ) THEN
        RETURN 'PARAMETRO OBLIGATORIO DEBE SER 1 o 0';
    END IF;
    -- ? INSERTO
    INSERT INTO CURSO (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio)
    VALUES (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;
DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 9. Ingresar notas ██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS IngresarNota //
CREATE FUNCTION IngresarNota
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = is_int(creditos_necesarios);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);
    SET temp = is_int(creditos_otorga);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS OTORGA NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_otorga = ROUND(creditos_otorga,0);
    -- ? VALIDO SI EXISTE LA CARRERA
    DECLARE existe INT;
    SET existe = (SELECT id FROM CARRERA WHERE id=carrera);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO LA CARRERA ',carrera);
    END IF;
    -- ? VALIDO OBLIGATORIO
    IF ((obligatorio != 1) AND (obligatorio != 0) ) THEN
        RETURN 'PARAMETRO OBLIGATORIO DEBE SER 1 o 0';
    END IF;
    -- ? INSERTO
    INSERT INTO CURSO (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio)
    VALUES (codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;
DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS GenerarActa //
CREATE FUNCTION GenerarActa
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45) ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    -- ? INSERTO
    INSERT INTO ACTA (id, id_curso_habilitado, fechayhora )
    VALUES ();
    RETURN "CURSO CREADO";
    END//
DELIMITER ;



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
