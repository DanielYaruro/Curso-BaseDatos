CREATE DATABASE cursosql_base_3;

USE cursosql_base_3;

TRUNCATE TABLE caballeros;
DROP TABLE caballeros;

CREATE TABLE caballeros(
	
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30) UNIQUE,
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30),
	INDEX i_rango (rango),
	INDEX i_signo (signo),
	INDEX i_caballeros (ejercito, pais)
	
);

SHOW INDEX FROM caballeros;
SHOW TABLES;
SELECT * FROM caballeros;

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
  
 SELECT * FROM caballeros WHERE signo = 'Geminis';
SELECT * FROM caballeros;
 
CREATE TABLE caballeros(
	
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30),
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30),
	-- Sintaxis para buscador, que busque cualquier coincidencia en cualquiera de estos campos
	FULLTEXT INDEX  fi_search (armadura, signo, rango, ejercito, pais)

);

-- Le decimos que busque la coincidencia en cualquiera de estos campos
SELECT * FROM caballeros 
	WHERE MATCH(armadura, signo, rango, ejercito, pais)
	AGAINST('Oro' IN BOOLEAN MODE);
	

CREATE TABLE caballeros(
	
	caballero_id INT,
	nombre VARCHAR(30),
	armadura VARCHAR(30),
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30)
	
);

-- Hacemos que una columna sea la llave primaria
ALTER TABLE caballeros ADD CONSTRAINT pk_caballero_id PRIMARY KEY (caballero_id);


-- Como hacer que la llave primaria se vuelva autoincremental
ALTER TABLE caballeros MODIFY COLUMN caballero_id INT AUTO_INCREMENT;

-- Como añadir condiciones de unicidad a un campo
ALTER TABLE caballeros ADD CONSTRAINT uk_armadura UNIQUE (armadura);

SHOW INDEX FROM caballeros;

-- Como agregar indices por fuera
ALTER TABLE caballeros ADD INDEX i_rango (rango);

ALTER TABLE caballeros ADD INDEX i_ejercito_pais (ejercito, pais);

ALTER TABLE caballeros ADD FULLTEXT INDEX fi_search (nombre, signo);

-- Como eliminar indices

ALTER TABLE caballeros DROP INDEX i_rango;

ALTER TABLE caballeros DROP INDEX fi_search;

ALTER TABLE caballeros DROP INDEX i_ejercito_pais;




