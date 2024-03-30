CREATE DATABASE cursosql_base4;

USE cursosql_base4;

/*
 * RESTRICCIONES (DELETE Y UPDATE)
 * - CASCADE
 * - SET NULL
 * - SET DEFAULT
 * - RESTICT
 * */

CREATE TABLE lenguajes(

	lenguaje_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	lenguaje VARCHAR(30) UNIQUE NOT NULL

);

CREATE TABLE frameworks(

	framework_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	framework VARCHAR(30) NOT NULL,
	lenguaje INT UNSIGNED,
	FOREIGN KEY (lenguaje) REFERENCES lenguajes(lenguaje_id)

);

INSERT INTO lenguajes (lenguaje) VALUES
('Javascript'),
('PHP'),
('Python'),
('Ruby'),
('JAVA');

INSERT INTO frameworks (framework, lenguaje) VALUES
('React', 1),
('Angular', 1),
('Vue', 1),
('Svelte', 1),
('Laravel', 2),
('Symfony', 2),
('Flask', 3),
('Django', 3),
('On Rails', 4);


SELECT *  FROM frameworks f
	INNER JOIN lenguajes l ON l.lenguaje_id = f.lenguaje;

SELECT * FROM frameworks f 
	LEFT JOIN lenguajes l ON l.lenguaje_id = f.lenguaje;

SELECT * FROM lenguajes_frameworks lf;

SELECT * FROM lenguajes l;
SELECT * FROM frameworks f;

DELETE FROM lenguajes WHERE lenguaje_id = 3;

UPDATE lenguajes SET lenguaje_id = 99 WHERE lenguaje_id = 3;

DROP TABLE lenguajes;

DROP TABLE frameworks;

CREATE TABLE lenguajes(

	lenguaje_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	lenguaje VARCHAR(30) UNIQUE NOT NULL

);


CREATE TABLE frameworks(

	framework_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	framework VARCHAR(30) NOT NULL,
	lenguaje INT UNSIGNED,
	FOREIGN KEY (lenguaje) REFERENCES lenguajes(lenguaje_id) #Dandole las restricciones
		ON DELETE SET NULL ON UPDATE CASCADE
	#	ON DELETE RESTRICT ON UPDATE RESTRICT
	
);

CREATE TABLE entornos(

	entorno_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	entorno VARCHAR(30) UNIQUE NOT NULL

)

INSERT INTO entornos(entorno) VALUES
('Frontend'),
('Backend');

INSERT INTO lenguajes (lenguaje_id, lenguaje) VALUES
(3, 'Python');

UPDATE frameworks SET lenguaje = 3 WHERE framework = 'Django';
UPDATE frameworks SET lenguaje = 3 WHERE framework = 'Flask';

CREATE TABLE frameworks(

	framework_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	framework VARCHAR(30) NOT NULL,
	lenguaje INT UNSIGNED,
	entorno INT UNSIGNED,
	FOREIGN KEY (lenguaje) REFERENCES lenguajes(lenguaje_id) #Dandole las restricciones
		ON DELETE SET NULL ON UPDATE CASCADE,
	#	ON DELETE RESTRICT ON UPDATE RESTRICT
	FOREIGN KEY (entorno) REFERENCES entornos(entorno_id)
		ON DELETE RESTRICT ON UPDATE CASCADE
	
);

INSERT INTO frameworks (framework, lenguaje, entorno) VALUES
('React', 1, 1),
('Angular', 1, 1),
('Vue', 1, 1),
('Svelte', 1, 1),
('Laravel', 2, 2),
('Symfony', 2, 2),
('Flask', 3, 2),
('Django', 3, 2),
('On Rails', 4, 2);

CREATE VIEW lenguajes_frameworks_entornos AS
SELECT * FROM frameworks f 
	INNER JOIN lenguajes l ON f.lenguaje = l.lenguaje_id
	INNER JOIN entornos e ON f.entorno = e.entorno_id
	
SELECT * FROM lenguajes_frameworks_entornos ORDER BY entorno;

DELETE FROM lenguajes WHERE lenguaje_id = 3;
UPDATE lenguajes SET lenguaje_id = 99 WHERE lenguaje_id = 3;


SELECT * FROM frameworks f;
