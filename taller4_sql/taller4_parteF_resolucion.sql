-- PARTE F: CONSULTAS AVANZADAS

-- 23) Obtener el codigo y numero de la o las materias con mayor cantidad de notas registradas.

-- Opcion 1: subconsulta que contiene la cantidad de notas por materia, y en la consultas
-- principal comparo la cantidad de notas contra todas las de la subconsulta, y me quedo con
-- la que es mayor o igual a todas las de la subconsulta (si no es mas chica que alguna otra
-- entonces es la mas grande)
SELECT codigo, numero, COUNT(*)
FROM notas
GROUP BY (codigo,numero)
HAVING COUNT(nota) >= ALL (SELECT COUNT(*)
						  FROM notas
						  GROUP BY(codigo,numero));
						  
-- Opcion 2: creo una tabla auxiliar que tenga los datos que quiero y la cantidad de notas
-- por cada materia como una de sus columnas. Despues uso esa tabla en una consulta y en 
-- el WHERE pongo como condicion que quiero el/los elementos que tienen el MAXIMO valor de
-- la columna de 'cantidad de notas'.
WITH cantidades AS (
	SELECT n.codigo AS "cod", n.numero AS "num", COUNT(*) AS "cant"
	FROM notas n
	GROUP BY n.codigo, n.numero
) 
SELECT cod, num, cant
FROM cantidades c
WHERE c.cant = ( SELECT MAX(cant) FROM cantidades)


-- 24) Obtener el padron de los alumnos que tienen nota en todas las materias.

-- Opcion 1: cuento la cantidad de materias en las que cada alumno tiene notas y 
-- me quedo con para los que dicha cantidad es igual a la cantidad total de materias.
WITH cantidad_notas AS (
	SELECT padron, COUNT (DISTINCT TO_CHAR(codigo,'fm00')||TO_CHAR(numero,'fm00')) as materias
	FROM notas
	GROUP BY padron
)
SELECT padron
FROM cantidad_notas
WHERE materias = (SELECT COUNT(*)
				  FROM materias)


-- Opcion 1,b: pongo el count distinct en el HAVING (porque no lo tengo que devolver) y ahi mismo
-- filtro para quedarme los que tengan valor igual a la cantidad total de materias.
SELECT n.padron 
FROM notas n
GROUP BY n.padron
HAVING COUNT(DISTINCT to_char(codigo,'fm00') 
			|| '.' || to_char(numero,'fm00') )
			= (SELECT COUNT(*) FROM materias)

-- Opcion 1,c: igual que la 1,b pero en vez de concatenar casteando a char
-- directamente armo una tupla para la materia.
SELECT n.padron 
FROM notas n
GROUP BY n.padron
HAVING COUNT(DISTINCT (codigo, numero) )
			= (SELECT COUNT(*) FROM materias)


--Opcion 2: me quedo con los alumnos para los que NO EXISTA una materia
-- en la que no tengan nota
SELECT padron FROM alumnos a
WHERE NOT EXISTS (
	(SELECT m.codigo, m.numero FROM materias m) -- Todas las materias
	EXCEPT --- MENOS
	(SELECT n.codigo, n.numero FROM notas n 
	 	WHERE n.padron = a.padron) -- Las materias en las que tiene nota el alumno a
)

--Opcion 3: me quedo con los alumnos para los que no exista una materia en la que 
-- no exista una nota de dicho alumno.
SELECT padron FROM alumnos a
WHERE NOT EXISTS (
	SELECT * FROM materias m
	WHERE NOT EXISTS (
		SELECT * FROM notas n
		WHERE n.padron = a.padron AND n.codigo = m.codigo
		AND n.numero = m.numero
	)
)



-- 25) Obtener el promedio general de notas por alumno (cuantas notas tiene en promedio un
-- alumno), considerando unicamente alumnos con al menos una nota

-- Opcion 1: hago la tabla auxiliar con el WITH y calculo el promedio 
-- usando esa tabla
WITH cantidad_notas AS(
SELECT padron, COUNT(nota) as cant_notas
FROM notas
GROUP BY padron
)

SELECT AVG(cant_notas)
FROM cantidad_notas

--Opcion 2: directamente creo la tabla en el FROM usando una subconsulta
SELECT AVG(cant_notas) 
FROM
	(SELECT COUNT(*) AS "cant_notas"
		FROM notas
		GROUP BY padron) AS cantidad_notas

