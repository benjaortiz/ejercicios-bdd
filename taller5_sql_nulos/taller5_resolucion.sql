--TALLER 5: VALORES NULOS

--2)Genere dos consultas que devuelvan el padron de
--los alumnos recibidos de la institucion secundaria ILSE (primer consulta) y recibidos de otra
--institucion secundaria (segunda consulta), sin saber a priori que la columna nombre inst sec
--permite nulos.

--Consulta de los alumnos de ILSE
SELECT padron
FROM alumnos
WHERE nombre_inst_sec = 'ILSE'

--Consulta de los alumnos que NO son de ILSE
SELECT padron
FROM alumnos
WHERE nombre_inst_sec <> 'ILSE'



--3)Corrija las consultas anteriores utilizando el operador IS para conocer si una
-- columna tiene o no valores nulos.

--Consulta de los alumnos de ILSE
SELECT padron
FROM alumnos
WHERE nombre_inst_sec = 'ILSE'
AND nombre_inst_sec IS NOT NULL

--Consulta de los alumnos que NO son de ILSE
SELECT padron
FROM alumnos
WHERE nombre_inst_sec <> 'ILSE'
OR nombre_inst_sec IS NULL



--4) Utilizando la funcion COALESE, devuelva un listado con el padron
-- y la institucion secundaria de todos los alumnos. Para aquellos alumnos sin institucion
-- secundaria, devolver el nombre ‘SIN INST’.

SELECT padron, COALESCE (nombre_inst_sec, 'SIN INST') as institucion
FROM alumnos



--5) En una consulta, devuelva (en tres columnas
-- distintas) la cantidad total de alumnos, la suma total de creditos obtenidos y el promedio
-- de creditos por alumno.

-- A)Cual es el problema que hay si no se consideran valores nulos?
--El problema es que aca el AVG no esta contando el alumno cuya cantidad de creditos es NULL
-- pero el count de alumnos lo cuenta como un alumno mas.

SELECT COUNT(*) as cant_alumnos, SUM(cantidad_creditos) as total_creds, AVG(cantidad_creditos)
FROM alumnos


-- B)¿Como puede solucionarse?
-- Si me dijeran que cuando los creditos son NULL, asuma como que son 0, entonces puedo usar un coalesce
SELECT COUNT(*) as cant_alumnos, SUM(cantidad_creditos) as total_creds, AVG(COALESCE(cantidad_creditos, 0))
FROM alumnos



-- 6) Utilizando NOT EXISTS, devuelva con una consulta las instituciones secundarias
-- de las cuales no egreso ningun alumno. Resuelva lo mismo pero utilizando NOT IN en vez de NOT EXISTS

--NOT EXISTS
SELECT ins.nombre
FROM inst_sec ins
WHERE NOT EXISTS (SELECT 1
				 FROM alumnos
				 WHERE ins.nombre = nombre_inst_sec)


-- NOT IN
--Aca vemos que no devuelve nada, eso es porque como hay un NULL,
-- no sabe cual nombre es, entonces porahi el nombre esta adentro
SELECT nombre
FROM inst_sec 
WHERE nombre NOT IN(SELECT nombre_inst_sec
				 FROM alumnos)



-- 7) Haga una consulta que devuelva para cada institucion secundanria 
-- la cantidad de alumnos que egresaron de ella. Revise que CNBA tenga el valor correcto.
-- Modifique la consulta para que cuente ´unicamente alumnos con padron mayor a 40000

--No me da el valor correcto, me devuelve que 1 alumno egresó de CNBA, tendria que ser 0
SELECT ins.nombre, COUNT(*)
FROM inst_sec ins LEFT OUTER JOIN alumnos al ON(ins.nombre = al.nombre_inst_sec)
GROUP BY ins.nombre




