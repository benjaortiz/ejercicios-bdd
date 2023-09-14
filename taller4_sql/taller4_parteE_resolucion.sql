-- PARTE E: AGRUPAMIENTO

-- 20) Para cada departamento, devuelva su codigo, nombre, la cantidad de materias que tiene y la
-- cantidad total de notas registradas en materias del departamento. Ordene por la cantidad
-- de materias descendente

SELECT d.codigo, d.nombre, COUNT(DISTINCT n.numero) as cantidad_materias , COUNT( n.nota) as notas
FROM departamentos d LEFT JOIN notas n ON(d.codigo=n.codigo)
GROUP BY d.codigo
ORDER BY (COUNT(n.numero)) DESC;



-- 21) Para cada carrera devuelva su nombre y la cantidad de alumnos inscriptos. Incluya las
-- carreras sin alumnos

SELECT car.nombre, COUNT(ie.padron)
FROM carreras car LEFT JOIN inscripto_en ie USING(codigo)
GROUP BY (car.codigo);



-- 22) Para cada alumno con al menos tres notas, devuelva su padron, nombre, promedio de notas
-- y mejor nota registrada.

SELECT alumnos.nombre, alumnos.padron, COUNT(1) as cant_notas, AVG(nota), MAX(nota)
FROM alumnos JOIN notas USING(padron)
GROUP BY (padron)
HAVING COUNT(1)>=3;

