

--! █░█░█ █▀▀ █░░ █▀▀ █▀█ █▀▄▀█ █▀▀   ▀█▀ █▀█   █▀▄▀█ █▄█   █▀▄ █▄▄
--! ▀▄▀▄▀ ██▄ █▄▄ █▄▄ █▄█ █░▀░█ ██▄   ░█░ █▄█   █░▀░█ ░█░   █▄▀ █▄█


--* █▀▀ █░█ █▄░█ █▀▀ █ █▀█ █▄░█ █▀▀ █▀
--* █▀░ █▄█ █░▀█ █▄▄ █ █▄█ █░▀█ ██▄ ▄█
DELIMITER //
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

    INSERT INTO usuarios (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos)
                        VALUES (carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos,);

    RETURN "ESTUDIANTE GUARDADO"

BEGIN
    DECLARE factorial INT;


END//
DELIMITER ;

