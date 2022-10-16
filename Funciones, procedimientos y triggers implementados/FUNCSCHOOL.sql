

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
--* ▀█▀ █▀█ █ █▀▀ █▀▀ █▀▀ █▀█ █▀
--* ░█░ █▀▄ █ █▄█ █▄█ ██▄ █▀▄ ▄█






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
DELIMITER // 
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

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 7. Asignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█😎 falta validar varias secciones 
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
    

    -- ? Se debe validar que no se encuentre ya asignado a la misma u otra sección,  🤐
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
    SET carreraestudiante = (SELECT carrera FROM ESTUDIANTE WHERE carnet = carne)
    SET carreradelcurso = (SELECT carrera FROM CURSO WHERE codigo = codigo)
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
    SET cupotemp = (SELECT cupos_disponibles FROM HABILITADOS WHERE idfound = id)
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
-- ! █▄██▄██▄██▄██▄██▄██▄██ 8. Desasignación de curso █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DELIMITER // 
DROP FUNCTION IF EXISTS DesasignarCurso //
CREATE FUNCTION DesasignarCurso
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45), carne BIGINT) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE idfound INT;
    DECLARE existecarne BIGINT;
    DECLARE studentassig BIGINT;


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
    SET cupotemp = (SELECT cupos_disponibles FROM HABILITADOS WHERE idfound = id) -- *TOMO EL CUPO DEL ID ACTUAL
    SET cupotemp = cupotemp +1;
    UPDATE HABILITADOS SET cupos_disponibles=cupotemp WHERE id=idfound; -- *actualizo el cupo del id encontrado con (codigo,ciclo,seccion)
    

    SET tempdesasignado = (SELECT cantidad_desasignados FROM DESASIGNADOS WHERE id_curso_habilitado=idfound);
    IF (tempdesasignado IS NULL) THEN
        -- ? INSERTO DESASIGNADO
        INSERT INTO DESASIGNADOS (id, id_curso_habilitado, cantidad_total, cantidad_desasignados)
        VALUES (NULL, idfound,0,1 );
    ELSE
        -- ? ACTUALIZO CANTIDAD DE DESASIGNADOS
        tempdesasignado = tempdesasignado +1;
        UPDATE DESASIGNADOS SET cantidad_desasignados=tempdesasignado WHERE id_curso_habilitado=idfound;
    END IF;


    RETURN "ESTUDIANTE DESASIGNADO DEL CURSO";
    END//
DELIMITER ;
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 9. Ingresar notas ██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
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

DELIMITER // -- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
DROP FUNCTION IF EXISTS GenerarActa //
CREATE FUNCTION GenerarActa
    (codigo INT ,ciclo VARCHAR(45),seccion VARCHAR(45) ) RETURNS VARCHAR(65)
    deterministic
    BEGIN
    DECLARE cdate DATETIME;
    DECLARE temp BOOLEAN;
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



--? █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ ▄▀█ █▀▄▀█ █ █▀▀ █▄░█ ▀█▀ █▀█   █▀▄ █▀▀   █▀▄ ▄▀█ ▀█▀ █▀█ █▀
--? █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ █▀█ █░▀░█ █ ██▄ █░▀█ ░█░ █▄█   █▄▀ ██▄   █▄▀ █▀█ ░█░ █▄█ ▄█

-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 1. Consultar pensum █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
delimiter //
create procedure update_price (IN temp_ISBN varchar(10), IN new_price integer)
               -> begin
               -> update book set price=new_price where ISBN=temp_ISBN;
               -> end; //
call update_price(001, 600); //
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█ 2. Consultar estudiante   █▄██▄██▄██▄██▄██▄██▄██▄██▄██
-- ! █▄██▄██▄██▄██▄██▄███▄██▄██▄█   3. Consultar docente     ██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄ 4. Consultar estudiantes asignados ██▄██▄██▄███▄██▄██▄██▄
-- ! █▄██▄██▄██▄██▄██▄██▄██▄█ 5. Consultar aprobaciones █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█▄██ 6. Consultar actas █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄ 7. Consultar tasa de desasignación ██▄██▄██▄██▄██▄██▄██▄██▄█
-- ! █▄██▄██▄██▄██▄██▄██▄██▄██▄█10. Generar acta █▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█



-- * █▄██▄██▄██▄██▄██▄██▄██▄██▄█Historial de transacciones█▄██▄██▄██▄██▄██▄██▄██▄██▄██▄██▄█






SELECT RegistrarEstudiante(2020001942,'Alvaro', 'Socop', '2001-12-24','socop@gmail.com',55555555,'mlsw calle juan', 3034161730108,14 ) AS RESPUESTA_RegistrarEstudiante;
