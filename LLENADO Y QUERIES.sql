USE dbschool;
-- REGISTRAR 4 CARRERAS
SELECT CrearCarrera('Ing en Sistemas ') AS CrearCarrera1;
SELECT CrearCarrera('Ing Aeronautica ') AS CrearCarrera2;
SELECT CrearCarrera('Ing Quimica ') AS CrearCarrera3;
SELECT CrearCarrera('Ing Mecanica ') AS CrearCarrera4;
-- ! ************************ REGISTRAR 5 docentes ************************
-- ! registro_siif,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,REGISTROSIIF
SELECT RegistrarDocente('Docente1', 'Ramirez1', '1995-12-24','asfdf@gmail.com',
85423698,'calle juan', 3034161730101,2000501 ) AS RegistrarDocente1;

SELECT RegistrarDocente('Docente2', 'Ramirez2', '1998-11-31','ase5411@gmail.com',
89456213,'calle Marti', 3034161730102,2000502 ) AS RegistrarDocente2;

SELECT RegistrarDocente('Docente3', 'Ramirez3', '1987-10-21','abuliu89@gmail.com',
12378956,'calle Poncio', 3034161730103,2000503 ) AS RegistrarDocente3;

SELECT RegistrarDocente('Docente4', 'Ramirez4', '1954-09-05','asdff8@gmail.com',
16254873,'calle Hermosa', 3034161730104,2000504 ) AS RegistrarDocente4;

SELECT RegistrarDocente('Docente5', 'Ramirez5', '2000-01-12','as8979f@gmail.com',
12897563,'calle Rub', 3034161730105,2000505 ) AS RegistrarDocente5;



-- ! ************************ REGISTRAR 10 estudiantes ************************
-- ! carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,carrera    ,fechacreacion,creditos
SELECT RegistrarEstudiante(2022001,'Estudiante1', 'Aguilar', '2000-12-06','est1as@gmail.com',
89746142,'Mixco', 3034161730111,2 ) AS RegistrarEstudiante1;

SELECT RegistrarEstudiante(2022002,'Estudiante2', 'Aguilar', '2000-01-24','asdf2@gmail.com',
97856342,'calle Mixco', 3034161730122,2 ) AS RegistrarEstudiante2;

SELECT RegistrarEstudiante(2022003,'Estudiante3', 'Aguilar', '2001-02-24','asdf3@gmail.com',
89621234,'calle Petapa', 3034161730133,2 ) AS RegistrarEstudiante3;

SELECT RegistrarEstudiante(2022004,'Estudiante4', 'Aguilar', '2000-03-24','asdf4@gmail.com',
85643217,'calle Petapa', 3034161730144,2 ) AS RegistrarEstudiante4;

SELECT RegistrarEstudiante(2022005,'Estudiante5', 'Aguilar', '2001-04-24','saderf8@gmail.com',
85467981,'calle Real', 3034161730155,3 ) AS RegistrarEstudiante5;

SELECT RegistrarEstudiante(2022006,'Estudiante6', 'Aguilar', '2001-05-24','asehbf899@gmail.com',
64598913,'calle Mixco', 3034161730166,3 ) AS RegistrarEstudiante6;

SELECT RegistrarEstudiante(2022007,'Estudiante7', 'Aguilar', '2001-06-24','setthg987@gmail.com',
45367454,'calle juan', 3034161730177,4 ) AS RegistrarEstudiante7;

SELECT RegistrarEstudiante(2022008,'Estudiante8', 'Aguilar', '2000-07-24','socop@gmail.com',
43765322,'calle Mixco', 3034161730188,4 ) AS RegistrarEstudiante8;

SELECT RegistrarEstudiante(2022009,'Estudiante9', 'Aguilar', '2000-08-24','socop8975621@gmail.com',
45378347,'calle Real', 3034161730199,5 ) AS RegistrarEstudiante9;

SELECT RegistrarEstudiante(20220010,'Estudiante10', 'Aguilar', '2000-09-24','asdfre88@gmail.com',
99443512,'calle Petapa', 3034161730100,5 ) AS RegistrarEstudiante10;

-- ! ************ REGISTRAR 5 cursos por cada carrera y 5 de área común ************
-- !  codigo,nombre,creditos_necesarios,creditos_otorga,carrera,obligatorio
-- ? AREA COMUN     1 es comun
SELECT CrearCurso(11, 'MATE BASICA 1',  0, 5, 1, 1) AS curso10;
SELECT CrearCurso(22, 'MATE BASICA 2',  0, 5, 1, 1) AS curso20;
SELECT CrearCurso(33, 'FISICA 1',       0, 5, 1, 1) AS curso30;
SELECT CrearCurso(44, 'IDIOMA TECNICO', 0, 5, 1, 0) AS curso40;
SELECT CrearCurso(55, 'ECONOMIA',       0, 5, 1, 0) AS curso50;
-- ? SISTEMAS
SELECT CrearCurso(66, 'ORGA', 15, 7, 2, 1) AS curso11;
SELECT CrearCurso(77, 'IPC1', 15, 5, 2, 1) AS curso21;
SELECT CrearCurso(88, 'ARQUI',15, 5, 2, 1) AS curso31;
SELECT CrearCurso(99, 'IA1',  15, 7, 2, 1) AS curso41;
SELECT CrearCurso(1010, 'SA', 15, 10,2, 1) AS curso51;
-- ? AERONAUTICA
SELECT CrearCurso(1111,  'AVION1', 15, 5, 3, 1) AS curso12;
SELECT CrearCurso(1212,  'AVION2', 15, 5, 3, 1) AS curso22;
SELECT CrearCurso(1313,  'AVION3', 15, 5, 3, 1) AS curso32;
SELECT CrearCurso(1414,  'AVION4', 15, 5, 3, 1) AS curso42;
SELECT CrearCurso(1515,  'AVION5', 15, 5, 3, 1) AS curso52;
-- ? QUIMICA
SELECT CrearCurso(1616,  'QUIMICA1', 15, 5, 4, 1) AS curso13;
SELECT CrearCurso(1717,  'QUIMICA2', 15, 5, 4, 1) AS curso23;
SELECT CrearCurso(1818,  'QUIMICA3', 15, 5, 4, 1) AS curso33;
SELECT CrearCurso(1919,  'QUIMICA4', 15, 5, 4, 1) AS curso43;
SELECT CrearCurso(2020,  'QUIMICA5', 15, 5, 4, 1) AS curso53;
-- ? MECANICA
SELECT CrearCurso(2121,  'CARROS1', 15, 5, 5, 1) AS curso14;
SELECT CrearCurso(2222,  'CARROS2', 15, 5, 5, 1) AS curso24;
SELECT CrearCurso(2323,  'CARROS3', 15, 5, 5, 1) AS curso34;
SELECT CrearCurso(2424,  'CARROS4', 15, 5, 5, 1) AS curso44;
SELECT CrearCurso(2525,  'CARROS5', 15, 5, 5, 1) AS curso54;

-- !-------------- 5. Habilitar curso para asignación--------------
-- ! codigo_curso ,ciclo , docente , cupo , seccion_
-- habilito 3 cursos los que son obligatorios
SELECT HabilitarCurso(11, '2S', 2000501, 5, 'A');
SELECT HabilitarCurso(22, '2S', 2000502, 5, 'B');
SELECT HabilitarCurso(33, '2S', 2000503, 8, 'C');
-- habilito solo 2 cursos de sistemas
SELECT HabilitarCurso(66, '2S', 2000504, 4, 'C');
SELECT HabilitarCurso(77, '2S', 2000505, 4, 'C');
-- !-------------- Agregar un horario de curso habilitado--------------
-- ! id_curso_habilitado, dia, horario
SELECT AgregarHorario(1, 1, '7:00-11:30');
SELECT AgregarHorario(1, 2, '7:00-11:30');
SELECT AgregarHorario(1, 3, '7:00-11:30');
SELECT AgregarHorario(1, 11,'7:00-11:30');

SELECT AgregarHorario(2, 6, '7:00-12:30');
SELECT AgregarHorario(3, 7, '7:00-11:30');
SELECT AgregarHorario(4, 7, '20:00-21:30');
SELECT AgregarHorario(5, 7, '16:00-18:30');
-- !-------------- ASIGNACION DE CURSO --------------
-- !codigo ,ciclo ,seccion , carne
-- Asigno los estudiantes de Sistemas a cursos AREA COMUN obligatorios
SELECT AsignarCurso(11,'2S', 'A', 2022001);
SELECT AsignarCurso(11,'2S', 'A', 2022002);
SELECT AsignarCurso(11,'2S', 'A', 2022003);
SELECT AsignarCurso(11,'2S', 'A', 2022004);

SELECT AsignarCurso(22,'2S', 'B', 2022001);
SELECT AsignarCurso(22,'2S', 'B', 2022002);
SELECT AsignarCurso(22,'2S', 'B', 2022003);
SELECT AsignarCurso(22,'2S', 'B', 2022004);

SELECT AsignarCurso(33,'2S', 'C', 2022001);
SELECT AsignarCurso(33,'2S', 'C', 2022002);
SELECT AsignarCurso(33,'2S', 'C', 2022003);
SELECT AsignarCurso(33,'2S', 'C', 2022004);
-- para desasignar:
SELECT AsignarCurso(33,'2S', 'C', 2022005);
SELECT AsignarCurso(33,'2S', 'C', 2022006);
SELECT AsignarCurso(33,'2S', 'C', 2022007);
-- !-------------- DESASIGNACION DE CURSO --------------
SET SQL_SAFE_UPDATES=0;
SELECT DesasignarCurso(33,'2S', 'C', 2022005);
SELECT DesasignarCurso(33,'2S', 'C', 2022006);
SELECT DesasignarCurso(33,'2S', 'C', 2022007);

-- !-------------- 9. Ingresar notas --------------
-- ! codigo_  ,ciclo ,seccion , carne , nota
SELECT IngresarNota(11, '2S', 'A', 2022001, 60);
SELECT IngresarNota(11, '2S', 'A', 2022002, 100);
SELECT IngresarNota(11, '2S', 'A', 2022003, 98);
SELECT IngresarNota(11, '2S', 'A', 2022004, 90);

SELECT IngresarNota(22, '2S', 'B', 2022001, 75);
SELECT IngresarNota(22, '2S', 'B', 2022002, 61);
SELECT IngresarNota(22, '2S', 'B', 2022003, 90);
SELECT IngresarNota(22, '2S', 'B', 2022004, 88);

SELECT IngresarNota(33, '2S', 'C', 2022001, 100);
SELECT IngresarNota(33, '2S', 'C', 2022002, 100);
SELECT IngresarNota(33, '2S', 'C', 2022003, 98);
SELECT IngresarNota(33, '2S', 'C', 2022004, 100);


-- ! -------------- 10. GENERAR ACTA --------------
SELECT GenerarActa(11, '2S', 'A');
SELECT GenerarActa(22, '2S', 'B');
SELECT GenerarActa(33, '2S', 'C');



-- ! -------------- PROCESAMIENTO DE DATOS --------------
-- ! -------------- 1. Consultar pensum --------------
CALL ConsultarPensum(1);
CALL ConsultarPensum(2);
CALL ConsultarPensum(3);
-- ! -------------- 2. Consultar estudiante --------------
CALL ConsultarEstudiante(2022001);
CALL ConsultarEstudiante(2022003);
-- ! -------------- 3. Consultar docente --------------
call ConsultarDocente(2000501);
-- ! -------------- 4. Consultar estudiantes asignados --------------
CALL ConsultarAsignados(11, '2S', 2022, 'A');
CALL ConsultarAsignados(33, '2S', 2022, 'C');
-- ! -------------- 5. Consultar aprobaciones --------------
CALL ConsultarAprobacion(11, '2S', 2022, 'A');
-- ! -------------- 6. Consultar actas --------------
CALL ConsultarActas(11);
-- ! -------------- 7. Consultar tasa de desasignación --------------
SELECT ConsultarDesasignacion(11, '2S', 2022, 'A');
SELECT ConsultarDesasignacion(22, '2S', 2022, 'B');
SELECT ConsultarDesasignacion(33, '2S', 2022, 'C');





