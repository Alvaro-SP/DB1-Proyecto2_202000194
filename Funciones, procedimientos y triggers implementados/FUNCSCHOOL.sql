

--! █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▄█   █▀▄ █▄▄
--! ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   ░█░ █▄█   █░▀░█ ░█░   █▄▀ █▄█            ----------202000194-------


--* █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
--* █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█
DELIMITER //
DROP FUNCION IF EXISTS ValidarCorreo $$
CREATE FUNCTION ValidarCorreo(direccion VARCHAR(45)) RETURNS BOOLEAN
    DETERMINNISTIC
    BEGIN
    DECLARE valido BOOLEAN;
    --* valido con el regex de CORREO
    IF (SELECT REGEXP_INSTR(cad, '[^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})]')=0) THEN
        SELECT TRUE INTO valido;
    ELSE
        SELECT FALSE INTO valido;
    END IF;
    RETURN (valido);
    END $$
BEGIN
    DECLARE factorial INT;
END//
DELIMITER ;


DELIMITER //
DROP FUNCION IF EXISTS RegistrarEstudiante $$
CREATE FUNCTION RegistrarEstudiante
    (
    carnet BIGINT,
    nombres VARCHAR(45),
    apellidos VARCHAR(45),
    fecha_nacimiento DATETIME,
    correo VARCHAR(45),
    telefono INT
    direccion VARCHAR(45),
    dpi BIGINT
    carrera INT 
    ) RETURNS VARCHAR(45)
    DECLARE cdate DATETIME;
    SET cdate = SSELECT now(); --* obtengo la fecha actual


    INSERT INTO usuarios (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos)
    VALUES (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,cdate,0);

    RETURN "ESTUDIANTE GUARDADO"

BEGIN
    DECLARE factorial INT;


END//
DELIMITER ;

