-- PARTE A: CONSULTAS DE UNA TABLA

-- 1)  Devuelva todos los datos de las notas que no sean de la materia 75.1.
-- Variante usando OR
SELECT *
FROM notas n
WHERE n.codigo!=75
OR n.numero!=1;

-- Variante usando AND
SELECT *
FROM notas
WHERE NOT (codigo=75 AND numero =1);



-- 2)Devuelva para cada materia dos columnas: una llamada “codigo” que contenga una concatenaci´on del c´odigo de departamento, un punto y el n´umero de materia, con el formato
-- “XX.YY” (ambos valores con dos d´ıgitos, agregando ceros a la izquierda en caso de ser
-- necesario) y otra con el nombre de la materia

SELECT TO_CHAR(codigo,'fm00')||'.'||TO_CHAR(numero,'fm00') AS codigo, nombre
FROM materias;



-- 3) Para cada nota registrada, devuelva el padron, codigo de departamento, numero de materia,
-- fecha y nota expresada como un valor entre 1 y 100

SELECT padron, codigo, numero, fecha, (nota*10) AS nota
FROM notas;



-- 4) Idem al anterior pero mostrando los resultados paginados en paginas de 5 resultados cada
-- una, devolviendo la segunda pagina

SELECT padron, codigo, numero, fecha, (nota*10) AS nota
FROM notas
LIMIT 5 OFFSET 1;	
-- limit 5 hace que me devuelva 5, y offset 1 hace que en vez de ver el primer elemento(que serian los primeros 5), me da el segundo elemento
--IMPORTANTE, aca no hay ordenamiento porque no me lo pide la consigna, pero antes del LIMIT tendria que ordenar si tuviese que devolver en algun orden especifico.



-- 5) Ejecute una consulta SQL que devuelva el padron y nombre de los alumnos cuyo apellido
-- es “Molina"

-- opcion 1: usando el '=' asi nomas
SELECT padron, nombre
FROM alumnos
WHERE apellido = 'Molina';

-- opcion 2: haciendo algo que no se rompa por poner o no una mayuscula
SELECT padron, nombre
FROM alumnos
WHERE UPPER(apellido) = UPPER('Molina');	--Tengo que tener cuidado, porahi uno tiene acento y en la tabla no, o porahi uno tiene un espacion y el otro no.

-- opcion 3 usando ILIKE, (no es estandar de SQL) y es menos performante (no aprovecha indices)
SELECT padron, nombre
FROM alumnos
WHERE apellido ILIKE 'Molina';



-- 6) Obtener el padron de los alumnos que ingresaron a la facultad en el anio 2010.

SELECT *
FROM alumnos
WHERE fecha_ingreso >'2010-01-01'
AND fecha_ingreso <='2010-12-31';


-- opcion 2 usando BETWEEN
SELECT *
FROM alumnos
WHERE fecha_ingreso BETWEEN '2010-01-01' AND '2010-12-31';


