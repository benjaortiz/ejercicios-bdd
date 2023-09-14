-- PARTE D: JOINS
-- 13) Devolver para cada materia su nombre y el nombre del departamento

SELECT departamentos.nombre, materias.nombre
FROM departamentos JOIN materias ON (departamentos.codigo = materias.codigo);



-- 14) Para cada 10 registrado, devuelva el padron y nombre del alumno y el nombre de la materia
-- correspondientes a dicha nota

--Opcion 1 usando el ON para el join
SELECT alumnos.padron, alumnos.nombre, materias.nombre
FROM (alumnos JOIN notas ON (alumnos.padron=notas.padron)) 
JOIN materias ON (notas.codigo=materias.codigo AND notas.numero=materias.numero)
WHERE notas.nota=10;


-- Opcion 2 usando el USING para la condicion de join
SELECT alumnos.padron, alumnos.nombre, materias.nombre
FROM (alumnos JOIN notas USING(padron)) 
JOIN materias ON (notas.codigo=materias.codigo AND notas.numero=materias.numero)
WHERE notas.nota=10;


-- Opcion 3 sin usar join
SELECT alumnos.padron, alumnos.nombre, materias.nombre 
FROM alumnos, materias, notas
WHERE notas.nota = 10
AND alumnos.padron = notas.padron
AND notas.codigo=materias.codigo
AND notas.numero = materias.numero;



-- 15)  Listar para cada carrera su nombre y el padron de los alumnos que esten anotados en ella.
-- Incluir tambien las carreras sin alumnos inscriptos

SELECT carreras.nombre, inscripto_en.padron
FROM carreras LEFT JOIN inscripto_en USING(codigo);



-- 16) Listar para cada carrera su nombre y el padron de los alumnos con padron mayor a 75000
-- que esten anotados en ella. Incluir tambien las carreras sin alumnos inscriptos con padron
-- mayor a 75000.

SELECT	carreras.nombre, inscripto_en.padron
FROM carreras LEFT JOIN inscripto_en USING(codigo)
WHERE inscripto_en.padron >75000
OR inscripto_en.padron is null;	--puede ser que no tenga alumnos inscriptos



-- 17) Listar el padron de aquellos alumnos que tengan mas de una nota en la materia 75.15

SELECT DISTINCT n1.padron
FROM notas n1 JOIN notas n2 
ON (n1.padron = n2.padron AND 
	n1.codigo=n2.codigo AND
    n1.numero=n2.numero AND 
    n1.fecha<>n2.fecha)
WHERE n1.codigo=75 
AND n1.numero=15;


--Opcion 2 usando group by
SELECT padron
FROM notas
WHERE codigo=75
AND numero=15
GROUP BY(padron)
HAVING COUNT(*)>1;



-- 18) Obtenga el padron y nombre de los alumnos que aprobaron la materia 71.14 y no aprobaron
-- la materia 71.15

--Opcion 1 doble subconsulta usando IN y NOT IN
SELECT DISTINCT alumnos.padron, alumnos.nombre
FROM alumnos JOIN notas USING(padron)
WHERE alumnos.padron IN(SELECT padron
					   	FROM notas
					   	WHERE codigo=71
					   	AND numero=14
					   	AND nota >=4)
AND alumnos.padron NOT IN (SELECT padron
						  	FROM notas
						  	WHERE codigo=71
					   		AND numero=15
					   		AND nota >=4);

--Opcion 2 una sola subconsulta
SELECT DISTINCT alumnos.padron, alumnos.nombre
FROM alumnos JOIN notas USING(padron)
WHERE alumnos.padron =notas.padron
AND codigo=71
AND numero=14
AND nota >=4
AND alumnos.padron NOT IN (SELECT padron
						  	FROM notas
						  	WHERE codigo=71
					   		AND numero=15
					   		AND nota >=4);


--Opcion 3 usando EXCEPT (1 consulta con 1 subconsulta anidada, que a su vez tiene 2 subconsultas anidadas)
SELECT padron, nombre
FROM alumnos
WHERE padron IN (
	(
		SELECT padron FROM notas
		WHERE (codigo, numero) = (71, 14) AND nota >= 4
	) EXCEPT (
		SELECT padron FROM notas
		WHERE (codigo, numero) = (71, 15) AND nota >= 4
	)
);



-- 19) Obtener, sin repeticiones, todos los pares de padrones de alumnos tales que ambos alumnos
-- rindieron la misma materia el mismo dıa. Devuelva tambien la fecha y el codigo y numero
-- de la materia

-- Opcion 1 usando solo la condicion del JOIN
SELECT DISTINCT n1.padron, n2.padron
FROM notas n1 JOIN notas n2
ON(n1.padron<n2.padron		--si yo pido que los padrones sean distintos(<>,!=) me devuelve las tuplas invertidas tambien
  AND n1.codigo=n2.codigo
  AND n1.numero=n2.numero
  AND n1.fecha=n2.fecha);


-- Opcion 2 poniendo la restriccion de padron afuera
-- del JOIN
SELECT DISTINCT n1.padron, n2.padron
FROM notas n1 JOIN notas n2
ON(n1.codigo=n2.codigo
   AND n1.numero=n2.numero
   AND n1.fecha=n2.fecha)
WHERE n1.padron < n2.padron;



