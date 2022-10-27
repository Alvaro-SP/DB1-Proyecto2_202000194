USE dbschool;
-- REGISTRAR 4 CARRERAS
SELECT CrearCarrera('Ing en Sistemas ') AS CrearCarrera1;
SELECT CrearCarrera('Ing Aeronautica ') AS CrearCarrera2;
SELECT CrearCarrera('Ing Quimica ') AS CrearCarrera3;
SELECT CrearCarrera('Ing Mecanica ') AS CrearCarrera4;
-- REGISTRAR 5 docentes
-- ! registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,fechacreacion
SELECT RegistrarDocente('Docente1', 'Ramirez1', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730101,1 ) AS RegistrarDocente1;

SELECT RegistrarDocente('Docente2', 'Ramirez2', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730102,2 ) AS RegistrarDocente2;

SELECT RegistrarDocente('Docente3', 'Ramirez3', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730103,3 ) AS RegistrarDocente3;

SELECT RegistrarDocente('Docente4', 'Ramirez4', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730104,4 ) AS RegistrarDocente4;

SELECT RegistrarDocente('Docente5', 'Ramirez5', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730105,5 ) AS RegistrarDocente5;



-- REGISTRAR 10 estudiantes
-- ! carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera,fechacreacion,creditos
SELECT RegistrarEstudiante(1,'Estudiante1', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730111,2 ) AS RegistrarEstudiante1;

SELECT RegistrarEstudiante(2,'Estudiante2', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730122,2 ) AS RegistrarEstudiante2;

SELECT RegistrarEstudiante(3,'Estudiante3', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730133,2 ) AS RegistrarEstudiante3;

SELECT RegistrarEstudiante(4,'Estudiante4', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730144,2 ) AS RegistrarEstudiante4;

SELECT RegistrarEstudiante(5,'Estudiante5', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730155,3 ) AS RegistrarEstudiante5;

SELECT RegistrarEstudiante(6,'Estudiante6', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730166,3 ) AS RegistrarEstudiante6;

SELECT RegistrarEstudiante(7,'Estudiante7', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730177,4 ) AS RegistrarEstudiante7;

SELECT RegistrarEstudiante(8,'Estudiante8', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730188,4 ) AS RegistrarEstudiante8;

SELECT RegistrarEstudiante(9,'Estudiante9', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730199,5 ) AS RegistrarEstudiante9;

SELECT RegistrarEstudiante(10,'Estudiante10', 'Aguilar', '2001-12-24','socop@gmail.com',
55555555,'calle juan', 3034161730100,5 ) AS RegistrarEstudiante10;

-- REGISTRAR 5 cursos por cada carrera y 5 de área común
-- !  codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio
-- ? AREA COMUN     1 es comun
SELECT CrearCurso(11, 'MATE BASICA 1',  0, 5, 1, 0) AS curso10;
SELECT CrearCurso(22, 'MATE BASICA 2',  0, 5, 1, 0) AS curso20;
SELECT CrearCurso(33, 'FISICA 1',       0, 5, 1, 0) AS curso30;
SELECT CrearCurso(44, 'IDIOMA TECNICO', 0, 5, 1, 0) AS curso40;
SELECT CrearCurso(55, 'ECONOMIA',       0, 5, 1, 0) AS curso50;
-- ? SISTEMAS
SELECT CrearCurso(66, 'ORGA', 15, 5, 2, 1) AS curso11;
SELECT CrearCurso(77, 'IPC1', 15, 5, 2, 1) AS curso21;
SELECT CrearCurso(88, 'ARQUI',15, 5, 2, 1) AS curso31;
SELECT CrearCurso(99, 'IA',   15, 5, 2, 1) AS curso41;
SELECT CrearCurso(1010, 'SA', 15, 5, 2, 1) AS curso51;
-- ? AERONAUTICA
SELECT CrearCurso(1111,  'AVION1', 5, 5, 3, 1) AS curso12;
SELECT CrearCurso(1212,  'AVION2', 5, 5, 3, 1) AS curso22;
SELECT CrearCurso(1313,  'AVION3', 5, 5, 3, 1) AS curso32;
SELECT CrearCurso(1414,  'AVION4', 5, 5, 3, 1) AS curso42;
SELECT CrearCurso(1515,  'AVION5', 5, 5, 3, 1) AS curso52;
-- ? QUIMICA
SELECT CrearCurso(1616,  'QUIMICA1', 5, 5, 4, 1) AS curso13;
SELECT CrearCurso(1717,  'QUIMICA2', 5, 5, 4, 1) AS curso23;
SELECT CrearCurso(1818,  'QUIMICA3', 5, 5, 4, 1) AS curso33;
SELECT CrearCurso(1919,  'QUIMICA4', 5, 5, 4, 1) AS curso43;
SELECT CrearCurso(2020,  'QUIMICA5', 5, 5, 4, 1) AS curso53;
-- ? MECANICA
SELECT CrearCurso(2121,  'CARROS1', 5, 5, 5, 1) AS curso14;
SELECT CrearCurso(2222,  'CARROS2', 5, 5, 5, 1) AS curso24;
SELECT CrearCurso(2323,  'CARROS3', 5, 5, 5, 1) AS curso34;
SELECT CrearCurso(2424,  'CARROS4', 5, 5, 5, 1) AS curso44;
SELECT CrearCurso(2525,  'CARROS5', 5, 5, 5, 1) AS curso54;


-- ! 5. Habilitar curso para asignación 
-- !codigo_curso ,ciclo , docente , cupo , seccion_
SELECT HabilitarCurso(11, '1S', 1, 2, 'A');
SELECT HabilitarCurso(22, '1S', 2, 2, 'B');
SELECT HabilitarCurso(33, '1S', 3, 2, 'C');
-- ! Agregar un horario de curso habilitado
-- !id, id_curso_habilitado, dia, horario
SELECT AgregarHorario(1, 1, '7:00-11:30');
SELECT AgregarHorario(1, 2, '7:00-11:30');
SELECT AgregarHorario(1, 3, '7:00-11:30');
SELECT AgregarHorario(1, 4, '7:00-11:30');
SELECT AgregarHorario(1, 5, '7:00-11:30');

-- !codigo ,ciclo ,seccion , carne
SELECT AsignarCurso(11,'1S', 'A', 1);
SELECT AsignarCurso(11,'1S', 'A', 2);
SELECT AsignarCurso(11,'1S', 'A', 3);
SELECT AsignarCurso(22,'1S', 'B', 1);
SELECT AsignarCurso(66,'1S', 'A', 1);

SELECT DesasignarCurso(11,'1S', 'A', 1);

-- ! codigo_  ,ciclo ,seccion , carne , nota
SELECT IngresarNota(11, '1S', 'A', 1, 60);

SELECT GenerarActa(11, '1S', 'A');

SELECT ConsultarActas (11);

call ConsultarDocente(1);




