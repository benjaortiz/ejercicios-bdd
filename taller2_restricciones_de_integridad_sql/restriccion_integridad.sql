--Creacion tabla de equipos
DROP TABLE IF EXISTS teams;

--EJ 2)crear la tabla con Primary Key
CREATE TABLE teams (
team			VARCHAR(50)		CONSTRAINT pk_teams PRIMARY KEY,
players_used 	int				NOT NULL,
avg_age			NUMERIC(4,1) 	NOT NULL,
possession 		NUMERIC	(4,1)	NOT NULL,
games			INTEGER 		NOT NULL,
goals			INTEGER 		NOT NULL,
assists			INTEGER 		NOT NULL,
cards_yellow	INTEGER 		NOT NULL,
card_red		INTEGER 		NOT NULL
);

-- Copio los datos desde el archivo
COPY teams
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller2_restricciones_de_integridad_sql\teams.csv'
DELIMITER ';'
CSV HEADER 
ENCODING 'LATIN1';

--EJ 3) intento violar la unicidad de la primary key:
INSERT INTO public.teams(
	team, players_used, avg_age, possession, games, goals, assists, cards_yellow, card_red)	 
	VALUES ('ARGENTINA', 22, 27, 40.3, 3, 0, 0, 6, 0);


SELECT * FROM teams;



--Creacion de la tabla de partidos
DROP TABLE IF EXISTS matches;

--EJ 4) crea la tabla con las foreign key en team1 y team2
CREATE TABLE matches (
team1					VARCHAR(50) REFERENCES public.teams(team),
team2 					VARCHAR(50) REFERENCES public.teams(team),
number_of_goals_team1	INTEGER		NOT NULL,
number_of_goals_team2	INTEGER		NOT NULL,
stage					VARCHAR(50)	NOT NULL
);

-- Importo los datos desde el archivo
COPY matches
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller2_restricciones_de_integridad_sql\matches.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';


-- EJ 5) intento violar la restriccion de integridad referencial con una foreign key que no existe:
INSERT INTO public.matches(
team1, team2 , number_of_goals_team1, number_of_goals_team2, stage)
VALUES 	('ARGENTINA', 'LESOTO', 5, 0, 'Final');

SELECT * FROM matches;


--EJ 6) intento violar la restricion de integridad borrando una tupla que es referenciada
DELETE FROM teams
WHERE team = 'FRANCE';

--EJ 7) intento violar restriccion de integridad referencial cambiando el nombre de una tupla
--		que es referenciada
UPDATE teams SET team = 'ARG'
WHERE team='ARGENTINA';


--EJ 8) modifico la tabla matches para que se actualizen los valores referenciados si estos cambian
--		en la tabla original

DROP TABLE IF EXISTS matches;

CREATE TABLE matches (
team1					VARCHAR(50) REFERENCES public.teams(team) ON UPDATE CASCADE,
team2 					VARCHAR(50) REFERENCES public.teams(team) ON UPDATE CASCADE,
number_of_goals_team1	INTEGER		NOT NULL,
number_of_goals_team2	INTEGER		NOT NULL,
stage					VARCHAR(50)	NOT NULL
);

COPY matches
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller2_restricciones_de_integridad_sql\matches.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';


-- EJ 9) intento modificar el valor de un equipo para ver si se actualiza en la tabla que lo referencia
UPDATE teams SET team = 'ARG'
WHERE team='ARGENTINA';


-- EJ 10) modifico el create table para que si se elimina una tupla referenciada, se borren
--		tambien las filas que la referencian
DROP TABLE IF EXISTS matches;

CREATE TABLE matches (
team1					VARCHAR(50) REFERENCES public.teams(team) ON UPDATE CASCADE ON DELETE CASCADE,
team2 					VARCHAR(50) REFERENCES public.teams(team) ON UPDATE CASCADE ON DELETE CASCADE,
number_of_goals_team1	INTEGER		NOT NULL,
number_of_goals_team2	INTEGER		NOT NULL,
stage					VARCHAR(50)	NOT NULL
);

COPY matches
FROM 'E:\benja_fac\base de datos\bdd_ejercicios_2023\ejercicios-bdd\taller2_restricciones_de_integridad_sql\matches.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'LATIN1';

SELECT * FROM matches;
