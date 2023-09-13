-- PARTE B: FUNCIONES DE AGREGACION

-- 7) Obtener la mejor nota registrada en la materia 75.15

SELECT MAX(nota)
FROM notas
WHERE codigo=75 
AND numero=15;



-- 8) Obtener el promedio de notas de las materias del departamento de codigo 75

SELECT AVG(nota) AS promedio
FROM notas
WHERE codigo=75;



-- 9) Obtener el promedio de nota de aprobaci´on de las materias del departamento de codigo 75

SELECT AVG(nota) AS promedio_aprobacion
FROM notas
WHERE codigo=75
AND nota >=4;



-- 10) Obtener la cantidad de alumnos que tienen al menos una nota

SELECT COUNT(DISTINCT padron)
FROM notas;
-- uso el distinct porque sino puede contar padrones repeitdos de alumnos que tiene mas de una nota





