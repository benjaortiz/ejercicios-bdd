----------------------Creacion tabla de equipos
DROP TABLE IF EXISTS teams;

--crea la tabla vacia
CREATE TABLE teams (
team			VARCHAR(50)	NOT NULL,
players_used 	int			NOT NULL,
avg_age			NUMERIC(4,1),
possession 		NUMERIC	(4,1),
games			INTEGER,
goals			INTEGER,
assists			INTEGER,
cards_yellow	INTEGER,
card_red		INTEGER
);

-- Para insertar datos manualmente puedo usar INSERT:
INSERT INTO public.teams(
	team, players_used, avg_age, possession, games, goals, assists, cards_yellow, card_red)	 
	VALUES ('LESOTO', 22, 27, 40.3, 3, 0, 0, 6, 0);

-- Para eliminar datos manualmente usar DELETE:
DELETE FROM public.teams
WHERE team='LESOTO';

-- Copio los datos desde un archivo
COPY teams
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller1_definicion_de_datos_sql\teams.csv'
DELIMITER ';'
CSV HEADER --para indicar que saltee la primera linea
ENCODING 'LATIN1';

SELECT * FROM teams;
-----------------------Creacion Tabla de partidos


--team1	team2	number of goals team1	number of goals team2	stage
--Creacion de la tabla de partidos
DROP TABLE IF EXISTS matches;

--crea la tabla vacia
CREATE TABLE matches (
team1					VARCHAR(50)	NOT NULL,
team2 					VARCHAR(50)	NOT NULL,
number_of_goals_team1	INTEGER,
number_of_goals_team2	INTEGER,
stage					VARCHAR(50)
);
-- Importo los datos desde un archivo
COPY matches
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller1_definicion_de_datos_sql\matches.csv'
DELIMITER ';'
CSV HEADER --para indicar que saltee la primera linea
ENCODING 'LATIN1';

SELECT * FROM matches;

--exporto los datos a formato csv
COPY matches
TO 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller1_definicion_de_datos_sql\matches_copy.csv'
DELIMITER ';'
CSV HEADER;