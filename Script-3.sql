USE cursosql_base_3;

TRUNCATE TABLE caballeros;
DROP TABLE caballeros;

CREATE TABLE caballeros(
	
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura INT UNSIGNED,
	rango INT UNSIGNED,
	signo INT UNSIGNED,
	ejercito INT UNSIGNED,
	pais INT UNSIGNED,
	# FOREING KEY(nom llave foranea) REFERENCES tabla(atributo id de la tabla a referenciar)
	FOREIGN KEY(armadura) REFERENCES armaduras(armadura_id),
	FOREIGN KEY(rango) REFERENCES rangos(rango_id),
	FOREIGN KEY(signo) REFERENCES signos(signo_id),
	FOREIGN KEY(ejercito) REFERENCES ejercitos(ejercito_id),
	FOREIGN KEY(pais) REFERENCES paises(pais_id)

);

CREATE TABLE armaduras(

	armadura_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50)
);

ALTER TABLE armaduras MODIFY nombre VARCHAR(30) UNIQUE NOT NULL;

CREATE TABLE signos(

	signo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE rangos(

	rango_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50)
);

ALTER TABLE rangos MODIFY nombre VARCHAR(30) UNIQUE NOT NULL;


CREATE TABLE ejercitos(

	ejercito_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE paises(

	pais_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	pais VARCHAR(50) UNIQUE NOT NULL
	
)


INSERT INTO caballeros (caballero_id, nombre, armadura, rango, signo, ejercito, pais) VALUES
  (0,"Seiya","Pegaso","Bronce","Sagitario","Athena","Japón"),
  (0,"Shiryu","Dragón","Bronce","Libra","Athena","Japón"),
  (0,"Hyoga","Cisne","Bronce","Acuario","Athena","Rusia"),
  (0,"Shun","Andromeda","Bronce","Virgo","Athena","Japón"),
  (0,"Ikki","Fénix","Bronce","Leo","Athena","Japón"),
  (0,"Kanon","Géminis","Oro","Géminis","Athena","Grecia"),
  (0,"Saga","Junini","Oro","Junini","Athena","Grecia"),
  (0,"Camus","Acuario","Oro","Acuario","Athena","Francia"),
  (0,"Rhadamanthys","Wyvern","Espectro","Oro","Hades","Inglaterra"),
  (0,"Kanon","Dragón Marino","Marino","Géminis Oro","Poseidón","Grecia"),
  (0,"Kagaho","Bennu","Espectro","Leo","Hades","Rusia");
  
 
 INSERT INTO armaduras VALUES
 (1,'Pegaso'),
 (2,'Dragon'),
 (3,'Cisne'),
 (4,'Andromeda'), 
 (5,'Fenix'), 
 (6,'Geminis'),
 (7,'Acuario'),
 (8,'Wyvern'),
 (9,'Dragon Marino'),
 (10,'Bennu');

INSERT INTO rangos VALUES
(1,'Bronce'),
(2, 'Oro'),
(3, 'Espectro'),
(4, 'Marino');

INSERT INTO signos VALUES
(1, 'Aries'),
(2, 'Tauro'),
(3, 'Geminis'),
(4, 'Cancer'),
(5, 'Leo'),
(6, 'Virgo'),
(7, 'Libra'),
(8, 'Escorpion'),
(9, 'Sagitario'),
(10, 'Capricornio'),
(11, 'Acuario'),
(12, 'Piscis');

INSERT INTO ejercitos VALUES
(1, 'Athena'),
(2, 'Hades'),
(3, 'Poseidon');

INSERT INTO paises VALUES
(1, 'Japon'),
(2, 'Rusia'),
(3, 'Grecia'),
(4, 'Francia'),
(5, 'Inglaterra');

INSERT INTO caballeros VALUES
  (1,"Seiya", 1, 1, 9, 1, 1),
  (2,"Shiryu", 2, 1, 7, 1, 1),
  (3,"Hyoga", 3, 1, 11 ,1 ,2),
  (4,"Shun", 4, 1, 6, 1, 1),
  (5,"Ikki", 5, 1, 5, 1, 1),
  (6,"Kanon", 6, 2, 3, 1, 3),
  (7,"Saga", 6, 2, 3, 1, 3),
  (8,"Camus", 7, 2, 11, 1, 4),
  (9,"Rhadamanthys", 8, 3, 8, 2, 5),
  (10,"Kanon", 9, 4, 3, 3, 3),
  (11,"Kagaho", 10, 3, 5, 2, 2);


SHOW TABLES;
DESCRIBE caballeros;
SELECT * FROM caballeros;
SELECT * FROM armaduras;
SELECT * FROM rangos;
SELECT * FROM signos;
SELECT * FROM ejercitos;
SELECT * FROM paises;

/*
 * SINTAXIS PARA LOS JOINS EN SQL
 * */

SELECT * FROM caballeros c 
	LEFT JOIN signos s 
	ON c.signo = s.signo_id;

SELECT * FROM caballeros c 
	RIGHT JOIN signos s 
	ON c.signo = s.signo_id;

# Elementos en comun de ambos conjuntos
SELECT * FROM caballeros c 
	INNER JOIN signos s 
	ON c.signo = s.signo_id;


# FULL OUTER JOIN combina ambos elementos

SELECT * FROM caballeros c 
	LEFT JOIN signos s 
	ON c.signo = s.signo_id 
UNION 
SELECT * FROM caballeros c
RIGHT JOIN signos s 
ON c.signo = s.signo_id;
# 

SELECT c.caballero_id, c.nombre, a.nombre, s.nombre , r.nombre , e.nombre , p.pais  FROM caballeros c 
	INNER JOIN armaduras a ON c.armadura = a.armadura_id
	INNER JOIN signos s ON c.signo = s.signo_id 
	INNER JOIN rangos r ON c.rango  = r.rango_id 
	INNER JOIN ejercitos e ON c.ejercito  = e.ejercito_id 
	INNER JOIN paises p ON c.pais = p.pais_id;
 
/*
 * SUBCONSULTAS
 * */

#Esta consulta me da el signo y la cantidad de caballeros que pertenecen a ese signo
SELECT nombre, (SELECT count(*) FROM caballeros c WHERE c.signo = s.signo_id) AS total_caballeros FROM signos s;

SELECT nombre, (SELECT COUNT(*) FROM caballeros c WHERE c.rango = r.rango_id) AS total_caballeros FROM rangos r;

SELECT nombre, (SELECT COUNT(*) FROM caballeros c WHERE c.ejercito = e.ejercito_id) AS total_caballeros FROM ejercitos e;

/*VISTAS EN SQL, son como subtablas para que al usarla no tenga que usarse la base de datos completa 'Nivel de abstraccion'*/

CREATE VIEW caballeros_vista AS
	SELECT c.caballero_id, c.nombre, a.nombre, r.nombre, s.nombre, e.nombre, p.pais  FROM caballeros c
	INNER JOIN armaduras a ON c.armadura = a.armadura_id 
	INNER JOIN rangos r ON c.rango = r.rango_id 
	INNER JOIN signos s ON c.signo = s.signo_id 
	INNER JOIN ejercitos e ON c.ejercito = e.ejercito_id 
	INNER JOIN paises p ON c.pais = p.pais_id;
	
DROP VIEW vista_caballeros;
SELECT * FROM vista_caballeros;

/*Manera de visualizar las vistas de las tablas*/
SHOW FULL TABLES IN cursosql_base_3 WHERE TABLE_TYPE LIKE 'VIEW';

CREATE VIEW cantidad_signos AS
	SELECT nombre, (SELECT COUNT(*) FROM caballeros c WHERE c.signo = s.signo_id) AS total_signos FROM signos s;

SELECT * FROM cantidad_signos;
DROP VIEW cantidad_signos;




