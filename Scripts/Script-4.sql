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
UPDATE lenguajes SET lenguaje_id = 3 WHERE lenguaje_id = 99;


SELECT * FROM frameworks f;

/*
 * TRANSACCIONES
 * */
#Necesito ejecutar estas tres transacciones 
START TRANSACTION;
	UPDATE frameworks SET framework = 'Vue.js' WHERE framework_id = 3;
	DELETE FROM frameworks;
	INSERT INTO frameworks VALUES(0,'Spring', 5, 2);


SELECT * FROM frameworks f;	

-- Las transacciones deben terminar con un commit que es para aceptar los cambios o un rollback si se quiere deshacer todos los cambios desde que se inicio la transaccion

ROLLBACK; #Instruccion para echar hacia atras una transaccion
COMMIT; #Para confirmar transaccion

/*CLAUSULA LIMIT*/

#Limita la cantidad de datos a mostrar
#Cuando tenemos un solo valor en limit le decimos mostrar los primeros 2

SELECT * FROM frameworks f LIMIT 2;

-- Mostrar elementos del siguiente al registro dos, el segundo numero dice cuantos elementos a mostrar (en este caso 4 elementos)
SELECT * FROM frameworks f LIMIT 2,2;

-- Funciona para la paginacion de datos y mostrarlos por paginas

/*
 * FUNCIONES DE ENCRIPTACION
 * */

#Devuelve la cadena que le damos en un formato de hash
SELECT MD5('m1 Sup3r P4$$w0rD') AS password_encriptado;
SELECT SHA1('m1 Sup3r P4$$w0rD') AS password_encriptado;
SELECT SHA2('m1 Sup3r P4$$w0rD', 256) AS password_encriptado;


-- Mecanismo mas popular de encriptacion
-- Encriptacion de doble autenticacion, el segundo argumento es el factor de doble autenticacion para poder desencriptar el dato a guardar
SELECT AES_ENCRYPT('m1 Sup3r P4$$w0rD', 'secret_key')
-- Como desencriptarlo

-- SELECT AES_DECRYPT(nombre_campo, 'secret_key')

CREATE TABLE pagos_recurrentes(
	
	cuenta VARCHAR(8) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	-- Tipo BLOB funciona para guardar archivos encriptados o ficheros binarios
	tarjeta BLOB 

);

INSERT INTO pagos_recurrentes (cuenta, nombre, tarjeta) VALUES
('12345678', 'Daniel', AES_ENCRYPT('1097781698123456', 'milo')),
('12345677', 'Irma', AES_ENCRYPT('9124904712345678', 'secret_key')),
('12345676', 'Kenai', AES_ENCRYPT('6332992712345678', 'hermindilla')),
('12345675', 'Kala', AES_ENCRYPT('6494325912345678', 'marifer')),
('12345674', 'Miguel', AES_ENCRYPT('10986547324124123456', 'duqueza_secreta'))

SELECT * FROM pagos_recurrentes;

-- Si quiero que me muestre los datos desencriptados, (hacer casting)

SELECT CAST(AES_DECRYPT(tarjeta, 'milo') AS CHAR) AS tdc, nombre FROM pagos_recurrentes;

SELECT CAST(AES_DECRYPT(tarjeta, 'marifer') AS CHAR) AS tdc, nombre FROM pagos_recurrentes;

SELECT CAST(AES_DECRYPT(tarjeta, 'duqueza_secreta') AS CHAR) AS tdc, nombre FROM pagos_recurrentes;

