-- PARTE C: OPERADORES DE CONJUNTO

-- 11) Devolver los padrones de los alumnos que no registran nota en materias

SELECT alumnos.padron
FROM alumnos LEFT JOIN notas ON (alumnos.padron = notas.padron)
WHERE notas IS NULL;

-- opcion 2 usando EXCEPT
(SELECT padron 
 FROM alumnos) 
 EXCEPT 
(SELECT padron 
 FROM notas);

-- 12) Con el objetivo de traducir a otro idioma los nombres de materias y departamentos, devolver
-- en una unica consulta los nombres de todas las materias y de todos los departamentos

(SELECT nombre
FROM materias)
UNION ALL
(SELECT nombre
FROM departamentos);

