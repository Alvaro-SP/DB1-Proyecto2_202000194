--  SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

--! █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▄█   █▀▄ █▄▄
--! ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   ░█░ █▄█   █░▀░█ ░█░   █▄▀ █▄█            ----------202000194-------

--* █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀   
--* █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█   
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

DELIMITER //    -- ************************************************************
DROP FUNCTION IF EXISTS SEARCH_COURSE //
CREATE FUNCTION  SEARCH_COURSE(codigo INT, ciclo VARCHAR(45), seccion VARCHAR(45)) RETURNS INT
    deterministic
    BEGIN
    DECLARE valido INT;
    -- * valido con el regex de num
    IF (num>=0)  THEN
        SELECT id FROM HABILITADOS WHERE codigo_curso=codigo AND ciclo=ciclo AND seccion=seccion INTO valido;
    ELSE
        SET valido = -1;
    END IF;
    RETURN (valido);
    END //
DELIMITER ;



-- ? █▀█ █▀▀ █▀▀ █ █▀ ▀█▀ █▀█ █▀█
-- ? █▀▄ ██▄ █▄█ █ ▄█ ░█░ █▀▄ █▄█


-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 1. REGISTRO DE ESTUDIANTES █▄██▄██▄██▄██▄██▄██▄██▄██▄███ 😎
DELIMITER // 
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
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Crear carrera █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 😎
INSERT INTO CARRERA (nombre) VALUES ('Area Comun');
DELIMITER //
-- AGREGO AREA COMUN PRIMERO
DROP FUNCTION IF EXISTS CrearCarrera //
CREATE FUNCTION CrearCarrera(nombre VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    SET temp = ValidarLetras(nombre);
    IF (temp = 0) THEN
		RETURN 'ERROR EL NOMBRE SOLO DEBE TENER LETRAS';
	END IF;
    INSERT INTO CARRERA (nombre) VALUES (nombre);
    RETURN "ESTUDIANTE GUARDADO";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 3. Registrar docente █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DELIMITER //
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
    registro_siif BIGINT
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
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 4. Crear curso   █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DELIMITER //
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
    DECLARE existe INT;

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
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██ 5. Habilitar curso para asignación ██▄██▄██▄██▄██▄██▄██▄██▄██😎
DELIMITER //
DROP FUNCTION IF EXISTS HabilitarCurso //
CREATE FUNCTION HabilitarCurso
    (codigo_curso INT ,ciclo VARCHAR(45), docente BIGINT, cupo INT, seccion VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE existe INT;
    DECLARE existeSIIF BIGINT;
    DECLARE temp BOOLEAN;

    -- ? *Se debe validar que el curso exista
    SET existe = (SELECT codigo FROM CURSO WHERE codigo=codigo_curso);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CURSO ',codigo_curso);
    END IF;

    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        RETURN 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD';
    END IF;
    -- ? *Se debe validar que el DOCENTE exista
    SET existeSIIF = (SELECT registro_siif FROM DOCENTE WHERE registro_siif=docente);
    IF (existeSIIF IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL DOCENTE ',docente);
    END IF;
    -- ? Validar que sea un número entero positivo
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
-- ! █▄██▄██▄██▄██▄██▄ 6. Agregar un horario de curso habilitado ██▄██▄██▄███▄██▄██▄██▄😎
DELIMITER //
DROP FUNCTION IF EXISTS AgregarHorario //
CREATE FUNCTION AgregarHorario
    (id_curso_habilitado INT, dia INT, horario VARCHAR(45)) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    -- ? . Si no se encuentra el id debe retornar error.
    DECLARE existe INT;
    SET existe = (SELECT id FROM HABILITADOS WHERE id=id_curso_habilitado);
    IF (existe IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CURSO HABILITADO ',id_curso_habilitado);
    END IF;
    -- ? *Debe ser dentro del dominio [1,7] correspondiente al día de la semana.
    IF ((dia < 1) OR (dia > 7)) THEN
        RETURN 'ERROR DIA DEBE SER DENTRO DE DOMINIO [1,7]';
    END IF;

    -- ? INSERTO
    INSERT INTO CURSO (id, id_curso_habilitado, dia, horario)
    VALUES (NULL,id_curso_habilitado,dia,horario);
    RETURN "HORARIO AGREGADO CORRECTAMENTE AL CURSO";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 7. Asignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎 falta validar varias secciones 
DELIMITER //
DROP FUNCTION IF EXISTS AsignarCurso //
CREATE FUNCTION AsignarCurso
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT) RETURNS VARCHAR(65)
    deterministic
    BEGIN

    DECLARE idfound INT;
    DECLARE existe INT;
    DECLARE idtemp INT;
    DECLARE existecarne BIGINT;
    DECLARE creditosnecesarios INT;
    DECLARE creditosestudiante INT;
    DECLARE carreraestudiante INT;
    DECLARE carreradelcurso INT;
    DECLARE cupotemp INT;
    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        RETURN 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD';
    END IF;
    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		RETURN 'EL CURSO NO EXISTE O NO ESTA HABILITADO';
	END IF;

    -- ? Validar que el carnet exista
    SET existecarne = (SELECT carnet FROM ESTUDIANTE WHERE carnet=carne);
    IF (existecarne IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CARNET ',carne);
    END IF;
    

    -- ? Se debe validar que no se encuentre ya asignado a la misma u otra sección,  OJOOOOOOOOOOOOOOO
    SET existe = NULL;
    SET existe = (SELECT id FROM HABILITADOS WHERE codigo_curso=codigo AND ciclo=ciclo);
    IF (existe IS NOT NULL) THEN
        RETURN CONCAT('ERROR EL ESTUDIANTE YA ESTA ASIGNADO A LA MISMA U OTRA SECCION ',carne);
    END IF;
    -- ? que cuente con los créditos necesarios
    SET creditosnecesarios = (SELECT creditos_necesarios FROM CURSO WHERE codigo=codigo);
    SET creditosestudiante = (SELECT creditos FROM ESTUDIANTE WHERE carnet = carne);
    IF (creditosestudiante < creditosnecesarios) THEN
        RETURN 'ERROR EL ESTUDIANTE NO POSEE CREDITOS SUFICIENTES ';
    END IF;
    -- ? que pertenezca a un curso correspondiente a su carrera o área común,
    SET carreraestudiante = (SELECT carrera FROM ESTUDIANTE WHERE carnet = carne);
    SET carreradelcurso = (SELECT carrera FROM CURSO WHERE codigo = codigo);
    IF (carreraestudiante != 0)   THEN
        IF (carreraestudiante != carreradelcurso) THEN
            RETURN CONCAT('ERROR EL CURSO NO PERTENECE A LA CARRERA DEL ESTUDIANTE ',carne);
        END IF;
    END IF;
    -- ? también validar que la sección que elige el estudiante sí existe
    SET existe = NULL;
    SET existe = (SELECT id FROM HABILITADOS WHERE codigo_curso=codigo AND ciclo=ciclo AND seccion=seccion);
    IF (existe IS NOT NULL) THEN
        RETURN CONCAT('ERROR LA SECCION NO ESTA ENTRE CURSOS HABILITADOS',carne);
    END IF;
    -- ? y que no ha alcanzado el cupo máximo, de lo contrario mostrar una explicación del error.
    SET cupotemp = (SELECT cupos_disponibles FROM HABILITADOS WHERE idfound = id);
    IF (cupotemp<1) THEN
        RETURN 'ERROR EL CUPO DEL CURSO YA LLEGO A SU LIMITE F';
    END IF;
    -- ? INSERTO   Se realiza la asignación de un estudiante a determinado curso.
    INSERT INTO ASIGNADOS (id, id_curso_habilitado, carnet, boolasignado)
    VALUES (NULL, idfound, carnet, 1);
    -- ! FINALMENTE SOLO QUEDA RESTAR UNO A LOS CUPOS DISPONIBLES EN EL CURSO
    SET cupotemp = cupotemp -1;
    UPDATE HABILITADOS SET cupos_disponibles=cupotemp WHERE id=idfound; -- *actualizo el cupo del id encontrado con (codigo,ciclo,seccion)
    RETURN "ESTUDIANTE ASIGNADO CON EXITO AL CURSO";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██ 8. Desasignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DELIMITER //
DROP FUNCTION IF EXISTS DesasignarCurso //
CREATE FUNCTION DesasignarCurso
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE idfound INT;
    DECLARE existecarne BIGINT;
    DECLARE studentassig BIGINT;
    DECLARE cupotemp INT;
    DECLARE tempdesasignado INT;


    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        RETURN 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD';
    END IF;

    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		RETURN 'EL CURSO NO EXISTE O NO ESTA HABILITADO';
	END IF;

    -- ? Validar que el carnet exista
    SET existecarne = (SELECT carnet FROM ESTUDIANTE WHERE carnet=carne);
    IF (existecarne IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CARNET',carne);
    END IF;

    -- ? validar que el estudiante ya se encontraba asignado a esa sección,
    SET studentassig = (SELECT carnet FROM ASIGNADOS WHERE id_curso_habilitado=idfound);
    IF (studentassig IS NULL) THEN
        RETURN CONCAT('ERROR ESTUDIANTE NO ASIGNADO ',carne);
    END IF;

    -- ? se debe de llevar un control de cada desasignación y asegurarse de que el cupo no se 
    -- ? siga viendo reducido puesto que habría un cupo más para otro estudiante.
    SET cupotemp = (SELECT cupos_disponibles FROM HABILITADOS WHERE idfound = id); -- *TOMO EL CUPO DEL ID ACTUAL
    SET cupotemp = cupotemp +1;
    UPDATE HABILITADOS SET cupos_disponibles=cupotemp WHERE id=idfound; -- *actualizo el cupo del id encontrado con (codigo,ciclo,seccion)
    
    SET tempdesasignado = (SELECT cantidad_desasignados FROM DESASIGNADOS WHERE id_curso_habilitado=idfound);
    IF (tempdesasignado IS NULL) THEN
        -- ? INSERTO DESASIGNADO
        INSERT INTO DESASIGNADOS (id, id_curso_habilitado, cantidad_total, cantidad_desasignados)
        VALUES (NULL, idfound,0,1 );
    ELSE
        -- ? ACTUALIZO CANTIDAD DE DESASIGNADOS
        SET tempdesasignado = tempdesasignado +1;
        UPDATE DESASIGNADOS SET cantidad_desasignados=tempdesasignado WHERE id_curso_habilitado=idfound;
    END IF;


    RETURN "ESTUDIANTE DESASIGNADO DEL CURSO";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 9. Ingresar notas ██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DELIMITER //
DROP FUNCTION IF EXISTS IngresarNota //
CREATE FUNCTION IngresarNota
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT, nota DECIMAL) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE temp BOOLEAN;
    DECLARE existecarne BIGINT;
    DECLARE notatemp INT;
    DECLARE idfound INT;
    DECLARE creditos_necesarios INT;
    DECLARE creditoscurso INT;
    DECLARE creditosestud INT;

    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        RETURN 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD';
    END IF;
    -- ? Validar que el carnet exista
    SET existecarne = (SELECT carnet FROM ESTUDIANTE WHERE carnet=carne);
    IF (existecarne IS NULL) THEN
        RETURN CONCAT('ERROR NO SE HA ENCONTRADO EL CARNET',carne);
    END IF;
    -- ? Validar que sea positivo
    SET temp = is_int(nota);
    IF (temp = 0) THEN
		RETURN 'ERROR CREDITOS NECESARIO NECESITA SER ENTERO POSITIVO';
	END IF;
    SET creditos_necesarios = ROUND(creditos_necesarios,0);

    -- ? Se utiliza cuando el docense debe aplicar un redondeo al entero más próximo. 
    SET notatemp = ROUND(nota,0);

    -- ? Si el estudiante aprobó el curso (Nota >= 61) entonces se suma la cantidad de créditos 
    -- ? que posee el estudiante con la cantidad de créditos que otorga el curso aprobado.
    IF (notatemp >= 61) THEN
        SET creditoscurso = (SELECT creditos_otorga FROM CURSO WHERE codigo = codigo);
        SET creditosestud = (SELECT creditos FROM ESTUDIANTE WHERE carnet=carne);
        SET creditosestud = creditosestud + creditoscurso;
        UPDATE ESTUDIANTE SET creditos=creditosestud WHERE carnet=carne; -- ! actualizo CREDITOS si aprobo
    END IF;

    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		RETURN 'EL CURSO NO EXISTE O NO ESTA HABILITADO';
	END IF;

    -- ? INSERTO
    INSERT INTO NOTAS (id, id_curso_habilitado, carnet, nota)
    VALUES (NULL, idfound, carne, notatemp);
    RETURN "NOTA AGREGADA CORRECTAMENTE";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎
DELIMITER // 
DROP FUNCTION IF EXISTS GenerarActa //
CREATE FUNCTION GenerarActa
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45) ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE cdate DATETIME;
    DECLARE temp BOOLEAN;
    DECLARE idfound BOOLEAN;
    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		RETURN 'EL CURSO NO EXISTE O NO ESTA HABILITADO';
	END IF;
    -- ? Al momento de que el docente termina de ingresar notas se genera un acta, por lo que es necesario hacer la validación
    -- ? de que ya ingresó las notas de todos los estudiantes asignados, de lo contrario mostrar un error.

    -- ?  Se debe de almacenar la fecha y hora exacta en que se generó el acta.
    SET cdate = now(); -- * obtengo la fecha actual

    -- ? INSERTO
    INSERT INTO ACTA (id, id_curso_habilitado, fechayhora )
    VALUES (NULL, idfound, cdate);
    RETURN "CURSO CREADO";
    END//
DELIMITER ;



-- ? █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ ▄▀█ █▀▄▀█ █ █▀▀ █▄░█ ▀█▀ █▀█   █▀▄ █▀▀   █▀▄ ▄▀█ ▀█▀ █▀█ █▀
-- ? █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ █▀█ █░▀░█ █ ██▄ █░▀█ ░█░ █▄█   █▄▀ ██▄   █▄▀ █▀█ ░█░ █▄█ ▄█
DROP procedure IF EXISTS ConsultarPensum ;
DROP procedure IF EXISTS ConsultarEstudiante ;
DROP procedure IF EXISTS ConsultarDocente;
DROP procedure IF EXISTS ConsultarAsignados;
DROP procedure IF EXISTS ConsultarAprobacion;
DROP procedure IF EXISTS ConsultarActas;
DROP procedure IF EXISTS ConsultarDesasignacion;

-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 1. Consultar pensum █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DELIMITER //
create procedure ConsultarPensum (IN codigo_carrera INT)
    begin
    --  Código del curso
    -- → Nombre del curso
    -- → Es obligatorio (sí o no)
    -- → Créditos necesarios
    SELECT * FROM (
        (
            SELECT codigo, nombre, obligatorio, creditos_necesarios 
            FROM CURSO WHERE carrera = 0
        )
        UNION ALL
        (
            SELECT codigo, nombre, obligatorio, creditos_necesarios 
            FROM CURSO WHERE carrera = codigo_carrera
        )
    ) AS PENSUM_DE_ESTUDIOS;
    end; //
DELIMITER;
-- call ConsultarPensum(08);
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Consultar estudiante   █▄██▄██▄██▄██▄██▄██▄██▄██▄██

DELIMITER //
create procedure ConsultarEstudiante (IN carne BIGINT)
    begin
    -- → Carnet
    -- → Nombre completo (concatenado)
    -- → Fecha de nacimiento
    -- → Correo
    -- → Teléfono
    -- → Dirección
    -- → Número de DPI
    -- → Carrera
    -- → Créditos que posee
    SELECT carnet as CARNE,
    CONCAT(nombres," ", apellidos) AS NOMBRE_COMPLETO,
    fecha_nacimiento AS FECHA_DE_NACIMIENTO,
    correo AS CORREO,
    telefono AS TELEFONO,
    direccion AS DIRECCION,
    dpi AS NUMERO_DPI,
    carrera AS CARRERA,
    creditos AS CREDITOS_POSEE
    FROM ESTUDIANTE WHERE carnet=carne;
    end; //
DELIMITER;

-- ! █▄██▄██▄██▄██▄██▄███▄██▄██▄█   3. Consultar docente     ██▄██▄██▄██▄██▄██▄██▄██▄██▄█

DELIMITER //
create procedure ConsultarDocente (IN registro_siif BIGINT)
    begin
    -- → Registro SIIF
    -- → Nombre completo
    -- → Fecha de nacimiento
    -- → Correo
    -- → Teléfono
    -- → Dirección
    -- → Número de DPI
    SELECT registro_siif as REGISTRO_SIIF,
    CONCAT(nombres," ", apellidos) AS NOMBRE_COMPLETO,
    fecha_nacimiento AS FECHA_DE_NACIMIENTO,
    correo AS CORREO,
    telefono AS TELEFONO,
    direccion AS DIRECCION,
    dpi AS NUMERO_DPI
    FROM DOCENTE WHERE registro_siif=registro_siif;
    end; //
DELIMITER;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 4. Consultar estudiantes asignados ██▄██▄██▄███▄██▄██▄██▄

DELIMITER //

create procedure ConsultarAsignados (IN codigo INT, IN ciclo VARCHAR(45),IN anio INT,IN seccion VARCHAR(45))
    begin
    -- → Carnet
    -- → Nombre completo
    -- → Créditos que posee
    DECLARE idfound INT;
    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		SELECT 'EL CURSO NO EXISTE O NO ESTA HABILITADO' AS ALERTA;
	END IF;
    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        SELECT 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD' AS ALERTA;
    END IF;
    SET seccion = UPPER(seccion);
    IF (anio != 2022) THEN
        SELECT 'ANIO NO REGISTRADO' AS ALERTA;
    END IF;
    -- ? Si no existe mostrar error

    SELECT carnet as CARNET,
    CONCAT(nombres," ", apellidos) AS NOMBRE_COMPLETO,
    creditos AS CREDITOS_POSEE
    FROM ESTUDIANTE
    JOIN ASIGNADOS ON ASIGNADOS.carnet=ESTUDIANTE.carnet
    WHERE ASIGNADOS.id_curso_habilitado=idfound;
    end; //
DELIMITER;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 5. Consultar aprobaciones █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█

DELIMITER //
create procedure ConsultarAprobacion (IN codigo INT, IN ciclo VARCHAR(45),IN anio INT,IN seccion VARCHAR(45))
    begin
    -- → Código de curso (se repite en cada fila)
    -- → Carnet
    -- → Nombre completo
    -- → “APROBADO” / “DESAPROBADO”
    DECLARE idfound INT;
    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		SELECT 'EL CURSO NO EXISTE O NO ESTA HABILITADO' AS ALERTA;
	END IF;
    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        SELECT 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD' AS ALERTA;
    END IF;
    SET seccion = UPPER(seccion);
    IF (anio != 2022) THEN
        SELECT 'ANIO NO REGISTRADO' AS ALERTA;
    END IF;

    SELECT codigo as CODIGO_CURSO,
    carnet as CARNET,
    CONCAT(nombres," ", apellidos) AS NOMBRE_COMPLETO,
    (SELECT IF(NOTAS.nota>=61, "APROBADO", "DESAPROBADO") AS APROBACION)
    FROM ESTUDIANTE
    JOIN NOTAS ON NOTAS.carnet=ESTUDIANTE.carnet
    WHERE NOTAS.id_curso_habilitado=idfound;
    end; //
DELIMITER;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█▄██ 6. Consultar actas █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█

DELIMITER //
create procedure ConsultarActas (IN codigo_curso INT)
    begin
    -- → Código de curso (se repite en cada fila)
    -- → Sección
    -- → Ciclo, se debe de traducir según sea el caso: “PRIMER SEMESTRE” / “SEGUNDO SEMESTRE” / “VACACIONES DE JUNIO” / “VACACIONES DE DICIEMBRE”
    -- → Año
    -- ! → Cantidad de estudiantes que llevaron el curso (o cantidad de notas que fueron ingresadas)
    -- → Fecha y hora de generado
    -- ? *Si no existe mostrar error
    DECLARE idfound INT;
    SET idfound = (SELECT codigo_curso FROM HABILITADOS WHERE codigo_curso=codigo_curso LIMIT 1);
    IF (idfound IS NULL) THEN
		SELECT 'EL CURSO NO EXISTE O NO ESTA HABILITADO' AS ALERTA;
	END IF;
    -- ? CONSULTA
    SELECT codigo_curso as CODIGO_CURSO,
    HABILITADOS.seccion as SECCION,
    (SELECT IF(STRCMP(HABILITADOS.ciclo,"1S") = 0, "PRIMER SEMESTRE",

            IF(STRCMP(HABILITADOS.ciclo,"2S") = 0, "SEGUNDO SEMESTRE",

                IF(STRCMP(HABILITADOS.ciclo,"VJ") = 0, "VACACIONES DE JUNIO",

                    IF(STRCMP(HABILITADOS.ciclo,"VD") = 0, "VACACIONES DE DICIEMBRE", "N/E") ) )
            )) AS CICLO,
    2022 AS ANIO,
    (
        SELECT COUNT(NOTAS.id) FROM NOTAS           -- ? cuenta cantidad de notas ingresadas para el codigo de curso mandado
        JOIN HABILITADOS ON NOTAS.id_curso_habilitado=HABILITADOS.id
        WHERE HABILITADOS.codigo_curso = codigo_curso
    ) AS CANT_ESTUDIANT_CURSO,
    ACTA.fechayhora AS FECHA_HORA
    FROM HABILITADOS
    JOIN ACTA ON ACTA.id_curso_habilitado=HABILITADOS.id
    WHERE HABILITADOS.codigo_curso=codigo_curso;
    end; //
DELIMITER;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄ 7. Consultar tasa de desasignación ██▄██▄██▄██▄██▄██▄██▄██▄█

DELIMITER //
create procedure ConsultarDesasignacion (IN codigo INT, IN ciclo VARCHAR(45),IN anio INT,IN seccion VARCHAR(45))
    begin
    -- → Código de curso
    -- → Sección
    -- → Ciclo, se debe de traducir según sea el caso: “PRIMER SEMESTRE” / 
    -- “SEGUNDO SEMESTRE” / “VACACIONES DE JUNIO” / “VACACIONES DE 
    -- DICIEMBRE”
    -- → Año
    
    DECLARE idfound INT;
    DECLARE cantestudiantes INT;
    DECLARE cantllevaroncurso INT;
    -- ? Se debe hacer match con la relación de curso habilitado por medio del año actual, ciclo y sección.
    SET idfound = SEARCH_COURSE(codigo, ciclo, seccion); -- ? retorna el id del CURSO HABILITADO.
    IF (idfound = -1) THEN
		SELECT 'EL CURSO NO EXISTE O NO ESTA HABILITADO' AS ALERTA;
	END IF;
    -- ? *Solamente puede aceptar los siguientes valores: ‘1S’, ’2S’, ’VJ’, ’VD’
    IF ((SELECT STRCMP(ciclo, '1S') != 0) AND (SELECT STRCMP(ciclo, '2S') != 0) AND (SELECT STRCMP(ciclo, 'VJ') != 0) AND (SELECT STRCMP(ciclo, 'VD') != 0)) THEN
        SELECT 'ERROR EL CICLO DEBE SER 1S, 2S, VJ, VD' AS ALERTA;
    END IF;
    SET seccion = UPPER(seccion);
    IF (anio != 2022) THEN
        SELECT 'ANIO NO REGISTRADO' AS ALERTA;
    END IF;

    SET cantllevaroncurso =(
        SELECT COUNT(NOTAS.id) FROM NOTAS           -- ? cuenta cantidad de notas ingresadas para el codigo de curso mandado
        JOIN HABILITADOS ON NOTAS.id_curso_habilitado=HABILITADOS.id
        WHERE HABILITADOS.codigo_curso = codigo AND HABILITADOS.seccion = seccion AND HABILITADOS.ciclo = ciclo
    ) ;
    SET cantestudiantes = (SELECT COUNT(id) FROM DESASIGNADOS WHERE DESASIGNADOS.id_curso_habilitado = idfound);


    -- ? CONSULTA
    SELECT codigo as CODIGO_CURSO,
    seccion as SECCION,
    (SELECT IF(STRCMP(ciclo,"1S") = 0, "PRIMER SEMESTRE",
            IF(STRCMP(ciclo,"2S") = 0, "SEGUNDO SEMESTRE",
                IF(STRCMP(ciclo,"VJ") = 0, "VACACIONES DE JUNIO",
                    IF(STRCMP(ciclo,"VD") = 0, "VACACIONES DE DICIEMBRE", "N/E") ) )
            )) AS CICLO,
    2022 AS ANIO,
    -- → Cantidad de estudiantes que llevaron el curso
    cantllevaroncurso AS CANT_ESTUDIANT_CURSO,
    -- → Cantidad de estudiantes que se desasignaron
    cantestudiantes AS ESTUDIANTES_DESASIGNADOS,
    -- → Porcentaje de desasignación
    CONCAT((cantllevaroncurso * (cantestudiantes/100)), "%") AS PORCENTAJE_DESASIGNA
    FROM ESTUDIANTE
    JOIN NOTAS ON NOTAS.carnet=ESTUDIANTE.carnet
    WHERE NOTAS.id_curso_habilitado=idfound;
    end; //
DELIMITER;



-- * █▄██▄██▄██▄██▄██▄██▄██▄██▄█Historial de transacciones█▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█














--* ▀█▀ █▀█ █ █▀▀ █▀▀ █▀▀ █▀█ █▀
--* ░█░ █▀▄ █ █▄█ █▄█ ██▄ █▀▄ ▄█

-- ? CARRERA
DROP TRIGGER IF EXISTS after_insert_CARRERA;
DELIMITER //
    CREATE TRIGGER after_insert_CARRERA
    AFTER INSERT ON CARRERA
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla CARRERA',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_CARRERA;
DELIMITER //
    CREATE TRIGGER after_update_CARRERA
    AFTER UPDATE ON CARRERA
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla CARRERA',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_CARRERA;
DELIMITER //
    CREATE TRIGGER after_delete_CARRERA
    AFTER DELETE ON CARRERA
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla CARRERA',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? CURSO
DROP TRIGGER IF EXISTS after_insert_curso;
DELIMITER //
    CREATE TRIGGER after_insert_curso
    AFTER INSERT ON CURSO
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla CURSO',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_curso;
DELIMITER //
    CREATE TRIGGER after_update_curso
    AFTER UPDATE ON CURSO
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla CURSO',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_curso;
DELIMITER //
    CREATE TRIGGER after_delete_curso
    AFTER DELETE ON CURSO
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla CURSO',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? HABILITADOS
DROP TRIGGER IF EXISTS after_insert_habilitados;
DELIMITER //
    CREATE TRIGGER after_insert_habilitados
    AFTER INSERT ON HABILITADOS
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla HABILITADOS',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_habilitados;
DELIMITER //
    CREATE TRIGGER after_update_habilitados
    AFTER UPDATE ON HABILITADOS
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla HABILITADOS',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_habilitados;
DELIMITER //
    CREATE TRIGGER after_delete_habilitados
    AFTER DELETE ON HABILITADOS
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla HABILITADOS',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? DOCENTE
DROP TRIGGER IF EXISTS after_insert_docente;
DELIMITER //
    CREATE TRIGGER after_insert_docente
    AFTER INSERT ON DOCENTE
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla DOCENTE',
        'INSERT',
        CONCAT("INSERT INTO DOCENTE (registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,fechacreacion) VALUES (",NEW.registro_siif,", """,NEW.nombres,""", """,NEW.apellidos,""", """,NEW.fecha_nacimiento,""", """,NEW.correo,""", """,NEW.telefono,""", """,NEW.direccion,""", """,NEW.dpi,""", ",NEW.fechacreacion,");"),
        CONCAT("DELETE FROM DOCENTE WHERE registro_siif = ",  NEW.registro_siif,";")
        );
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_docente;
DELIMITER //
    CREATE TRIGGER after_update_docente
    AFTER UPDATE ON DOCENTE
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla DOCENTE',
        'UPDATE',
        CONCAT("UPDATE ESTUDIANTE SET registro_siif = ",NEW.registro_siif,", nombres = """,NEW.nombres,""", apellidos = """,NEW.apellidos,""", fecha_nacimiento = ",NEW.fecha_nacimiento," WHERE correo = ", OLD.correo," WHERE telefono = ", OLD.telefono," WHERE direccion = ", OLD.direccion," WHERE dpi = ", OLD.dpi," WHERE fechacreacion = ", OLD.fechacreacion,";"),
        CONCAT("UPDATE ESTUDIANTE SET registro_siif = ",OLD.registro_siif,", nombres = """,OLD.nombres,""", apellidos = """,OLD.apellidos,""", fecha_nacimiento = ",OLD.fecha_nacimiento," WHERE correo = ", NEW.correo," WHERE telefono = ", NEW.telefono," WHERE direccion = ", NEW.direccion," WHERE dpi = ", NEW.dpi," WHERE fechacreacion = ", NEW.fechacreacion,";")
    );
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_docente;
DELIMITER //
    CREATE TRIGGER after_delete_docente
    AFTER DELETE ON DOCENTE
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla DOCENTE',
        'DELETE',
        CONCAT("DELETE FROM DOCENTE WHERE registro_siif = ",  OLD.registro_siif,";"),
        CONCAT("INSERT INTO DOCENTE (registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,fechacreacion) VALUES (",OLD.registro_siif,", """,OLD.nombres,""", """,OLD.apellidos,""", """,OLD.fecha_nacimiento,""", """,OLD.correo,""", """,OLD.telefono,""", """,OLD.direccion,""", """,OLD.dpi,""", ",OLD.fechacreacion,");")
        );
    END;//
DELIMITER ;

-- ? DESASIGNADOS
DROP TRIGGER IF EXISTS after_insert_DESASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_insert_DESASIGNADOS
    AFTER INSERT ON DESASIGNADOS
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla DESASIGNADOS',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_DESASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_update_DESASIGNADOS
    AFTER UPDATE ON DESASIGNADOS
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla DESASIGNADOS',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_DESASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_delete_DESASIGNADOS
    AFTER DELETE ON DESASIGNADOS
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla DESASIGNADOS',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? ASIGNADOS
DROP TRIGGER IF EXISTS after_insert_ASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_insert_ASIGNADOS
    AFTER INSERT ON ASIGNADOS
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla ASIGNADOS',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_ASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_update_ASIGNADOS
    AFTER UPDATE ON ASIGNADOS
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla ASIGNADOS',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_ASIGNADOS;
DELIMITER //
    CREATE TRIGGER after_delete_ASIGNADOS
    AFTER DELETE ON ASIGNADOS
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla ASIGNADOS',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? ACTA
DROP TRIGGER IF EXISTS after_insert_ACTA;
DELIMITER //
    CREATE TRIGGER after_insert_ACTA
    AFTER INSERT ON ACTA
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla ACTA',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_ACTA;
DELIMITER //
    CREATE TRIGGER after_update_ACTA
    AFTER UPDATE ON ACTA
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla ACTA',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_ACTA;
DELIMITER //
    CREATE TRIGGER after_delete_ACTA
    AFTER DELETE ON ACTA
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla ACTA',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? NOTAS
DROP TRIGGER IF EXISTS after_insert_NOTAS;
DELIMITER //
    CREATE TRIGGER after_insert_NOTAS
    AFTER INSERT ON CARRERA
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla NOTAS',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_NOTAS;
DELIMITER //
    CREATE TRIGGER after_update_NOTAS
    AFTER UPDATE ON NOTAS
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla NOTAS',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_NOTAS;
DELIMITER //
    CREATE TRIGGER after_delete_NOTAS
    AFTER DELETE ON NOTAS
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla NOTAS',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? HORARIO
DROP TRIGGER IF EXISTS after_insert_HORARIO;
DELIMITER //
    CREATE TRIGGER after_insert_HORARIO
    AFTER INSERT ON CARRERA
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla HORARIO',
        'INSERT',
        "",
        "");
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_HORARIO;
DELIMITER //
    CREATE TRIGGER after_update_HORARIO
    AFTER UPDATE ON CARRERA
    FOR EACH ROW
    BEGIN
    insert HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla HORARIO',
        'UPDATE',
        "",
        "");
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_HORARIO;
DELIMITER //
    CREATE TRIGGER after_delete_HORARIO
    AFTER DELETE ON HORARIO
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla HORARIO',
        'DELETE',
        "",
        ""
        );
    END;//
DELIMITER ;

-- ? ESTUDIANTE
DROP TRIGGER IF EXISTS after_insert_students;
DELIMITER //
    CREATE TRIGGER after_insert_students
    AFTER INSERT ON ESTUDIANTE
    FOR EACH ROW
    BEGIN
        INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
        VALUES(now(),
        'Se ha realizado una acción en la tabla ESTUDIANTES',
        'INSERT',
        CONCAT("INSERT INTO ESTUDIANTE (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos) VALUES (",NEW.carnet,", """,NEW.nombres,""", """,NEW.apellidos,""", """,NEW.fecha_nacimiento,""", """,NEW.correo,""", """,NEW.telefono,""", """,NEW.direccion,""", """,NEW.dpi,""", """,NEW.carrera,""", """,NEW.fechacreacion,""", ",NEW.creditos,");"),
        CONCAT("DELETE FROM ESTUDIANTE WHERE carnet = ",  NEW.carnet,";")
        );
    END;//
DELIMITER ;
-- Antes de actualizar un registro, almacenar su sentencia UPDATE para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_update_students;
DELIMITER //
    CREATE TRIGGER after_update_students
    AFTER UPDATE ON ESTUDIANTE
    FOR EACH ROW
    BEGIN
    insert into HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    values(
        now(),
        'Se ha realizado una acción en la tabla ESTUDIANTES',
        'UPDATE',
        CONCAT("UPDATE ESTUDIANTE SET carnet = ",NEW.carnet,", nombres = """,NEW.nombres,""", apellidos = """,NEW.apellidos,""", fecha_nacimiento = ",NEW.fecha_nacimiento," WHERE correo = ", OLD.correo," WHERE telefono = ", OLD.telefono," WHERE direccion = ", OLD.direccion," WHERE dpi = ", OLD.dpi," WHERE carrera = ", OLD.carrera," WHERE fechacreacion = ", OLD.fechacreacion," WHERE creditos = ", OLD.creditos,";"),
        CONCAT("UPDATE ESTUDIANTE SET carnet = ",OLD.carnet,", nombres = """,OLD.nombres,""", apellidos = """,OLD.apellidos,""", fecha_nacimiento = ",OLD.fecha_nacimiento," WHERE correo = ", NEW.correo," WHERE telefono = ", NEW.telefono," WHERE direccion = ", NEW.direccion," WHERE dpi = ", NEW.dpi," WHERE carrera = ", NEW.carrera," WHERE fechacreacion = ", NEW.fechacreacion," WHERE creditos = ", NEW.creditos,";")
    );
    END;
    //
DELIMITER ;
-- Antes de borrar un registro, almacenar su sentencia INSERT, para revertirlo a su estado anterior.
DROP TRIGGER IF EXISTS after_delete_students;
DELIMITER //
    CREATE TRIGGER after_delete_students
    AFTER DELETE ON ESTUDIANTE
    FOR EACH ROW
    BEGIN
    INSERT INTO HISTORIAL(fecha, descripcion, tipo, executedSQL, reverseSQL)
    VALUES(now(),
        'Se ha realizado una acción en la tabla ESTUDIANTES',
        'DELETE',
        CONCAT("DELETE FROM ESTUDIANTE WHERE carnet = ",  OLD.carnet,";"),
        CONCAT("INSERT INTO ESTUDIANTE (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos) VALUES (",OLD.carnet,", """,OLD.nombres,""", """,OLD.apellidos,""", """,OLD.fecha_nacimiento,""", """,OLD.correo,""", """,OLD.telefono,""", """,OLD.direccion,""", """,OLD.dpi,""", """,OLD.carrera,""", """,OLD.fechacreacion,""", ",OLD.creditos,");")
        );
    END;//
DELIMITER ;

