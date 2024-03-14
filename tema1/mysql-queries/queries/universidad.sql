-- Query 1: ORDER BY
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

-- Query 2: IS NULL & AND
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- Query 3: BETWEEN
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- Query 4: LIKE
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%k';

-- Query 5:
SELECT * from asignatura WHERE cuatrimestre = 1 AND id_grado = 7 AND curso = 3;

-- Query 6: Two INNER JOINS
SELECT per.apellido1, per.apellido2, per.nombre, dep.nombre FROM profesor pro INNER JOIN departamento dep ON pro.id_departamento = dep.id INNER JOIN persona per ON pro.id_profesor = per.id ORDER BY per.apellido1, per.apellido2, per.nombre;

-- Query 7: Three INNER JOINS
SELECT asi.nombre, cur.anyo_inicio, cur.anyo_fin FROM persona per INNER JOIN alumno_se_matricula_asignatura mat ON per.id = mat.id_alumno INNER JOIN curso_escolar cur ON mat.id_curso_escolar = cur.id INNER JOIN asignatura asi ON mat.id_asignatura = asi.id WHERE nif = '26902806M';

-- Query 8: GROUP BY
SELECT dep.nombre FROM departamento dep INNER JOIN profesor pro ON dep.id = pro.id_departamento INNER JOIN asignatura asi ON pro.id_profesor = asi.id_profesor INNER JOIN grado gra ON asi.id_grado = gra.id WHERE gra.nombre = 'Grado en Ingeniería Informática (Plan 2015)' GROUP BY dep.nombre;

-- Query 9: GROUP BY + Variable
SET @id_curs_2018_2019 := (SELECT id FROM curso_escolar WHERE anyo_inicio = '2018' AND anyo_fin = '2019');
SELECT per.* FROM persona per INNER JOIN alumno_se_matricula_asignatura mat ON per.id = mat.id_alumno WHERE mat.id_curso_escolar = @id_curs_2018_2019 GROUP BY per.id;

-- LEFT & RIGHT JOIN (same as OUTER LEFT or OUTER RIGHT)
-- Query 1:
SELECT dep.nombre, per.apellido1, per.apellido2, per.nombre FROM persona per RIGHT JOIN profesor pro ON per.id = pro.id_profesor LEFT JOIN departamento dep ON pro.id_departamento = dep.id ORDER BY dep.nombre, per.apellido1, per.apellido2, per.nombre;

-- Query 2:
SELECT per.* FROM persona per RIGHT JOIN profesor pro ON per.id = pro.id_profesor LEFT JOIN departamento dep ON pro.id_departamento = dep.id WHERE dep.nombre IS NULL;

-- Query 3:
SELECT dep.* FROM departamento dep LEFT JOIN profesor pro ON dep.id = pro.id_departamento WHERE pro.id_departamento IS NULL;

-- Query 4:
SELECT per.* FROM persona per RIGHT JOIN profesor pro ON per.id = pro.id_profesor LEFT JOIN asignatura asi ON pro.id_profesor = asi.id_profesor WHERE asi.id_profesor IS NULL;

-- Query 5:
SELECT asi.* FROM asignatura asi LEFT JOIN profesor pro ON asi.id_profesor = pro.id_profesor WHERE pro.id_profesor IS NULL;

-- Query 6:
SELECT dep.id, dep.nombre FROM departamento dep LEFT JOIN profesor pro ON dep.id = pro.id_departamento WHERE pro.id_departamento IS NULL;


-- Consultes resum:
-- Query 1: COUNT()
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';

-- Query 2: DATE()
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND DATE(fecha_nacimiento) BETWEEN '1999-01-01' AND '1999-12-31';

-- Query 3: COUNT() + GROUP BY
SELECT COUNT(*) as cantidad, dep.nombre FROM profesor pro INNER JOIN departamento dep ON pro.id_departamento = dep.id GROUP BY dep.nombre ORDER BY cantidad DESC;

-- Query 4: LEFT JOIN
SELECT dep.nombre, per.nombre FROM departamento dep LEFT JOIN profesor pro ON dep.id = pro.id_departamento LEFT JOIN persona per ON per.id = pro.id_profesor;

-- Query 5: COUNT() with parameter so that doesn't coun null results.
SELECT gra.nombre, COUNT(asi.id_grado) as cantidad FROM grado gra LEFT JOIN asignatura asi ON gra.id = asi.id_grado GROUP BY gra.nombre;

-- Query 6: COUNT() + HAVING
SELECT gra.nombre, COUNT(asi.id_grado) as cantidad FROM grado gra LEFT JOIN asignatura asi ON gra.id = asi.id_grado GROUP BY gra.nombre HAVING COUNT(asi.id_grado) > 40;

-- Query 7: SUM() + GROUP BY two parameters
SELECT gra.nombre, asi.tipo, SUM(asi.creditos) as 'Creditos Total' FROM grado gra LEFT JOIN asignatura asi ON gra.id = asi.id_grado GROUP BY gra.nombre, asi.tipo;

-- Query 8: COUNT() + GROUP BY
SELECT cur.anyo_inicio, COUNT(DISTINCT per.id) FROM alumno_se_matricula_asignatura mat INNER JOIN persona per ON mat.id_alumno = per.id INNER JOIN curso_escolar cur ON cur.id = mat.id_curso_escolar GROUP BY cur.anyo_inicio;

-- Query 9: RIGHT JOIN
SELECT per.id, per.apellido1, per.apellido2, per.nombre, COUNT(asi.nombre) as 'Asignaturas Total', per.tipo FROM asignatura asi RIGHT JOIN persona per ON asi.id_profesor = per.id WHERE per.tipo = 'profesor' GROUP BY per.id ORDER BY COUNT(asi.nombre) DESC;

-- Query 10: ORDER BY & LIMIT
SELECT per.* FROM persona per WHERE per.tipo = 'alumno' ORDER BY per.fecha_nacimiento DESC LIMIT 1;

-- Query 11:
SELECT per.* FROM persona per INNER JOIN profesor pro ON per.id = pro.id_profesor LEFT JOIN asignatura asi ON pro.id_profesor = asi.id_profesor WHERE asi.id_profesor IS NULL;

