-- Comentario en una linea en SQL
/*
 * Este es un comentario de varias lineas
 */

/*
 * SQL no distingue entre mayusculas y minusculas pero:
 * - Comandos y palabras reservadas de SQL van en Mayusculas
 * - Nombres de objetos y datos van en minusculas con _snake_case
 * - Para sttings usar comillas simples ('')
 * - Todas las sentencias terminan con un punto y coma (;)
 * */

SHOW DATABASES;


CREATE DATABASE IF NOT EXISTS curso_sql;

DROP DATABASE IF EXISTS curso_sql;

CREATE DATABASE IF NOT EXISTS para_daniel;

DROP DATABASE IF EXISTS para_daniel;

CREATE DATABASE IF NOT EXISTS curso_sql;

SHOW DATABASES;

CREATE USER 'DanielYaruro'@'localhost' IDENTIFIED BY 'Danisito2001';

GRANT ALL PRIVILEGES ON para_daniel.* TO 'DanielYaruro'@'localhost';

-- Con esto le damos todos los permisos a un usuario sobre una base de datos
GRANT ALL PRIVILEGES ON curso_sql.* TO 'DanielYaruro'@'localhost';

-- Actualizamos privilegios

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'DanielYaruro'@'localhost';

-- Con esto quitamos todos los permisos a un usuario
REVOKE ALL, GRANT OPTION FROM 'DanielYaruro'@'localhost';

DROP USER 'DanielYaruro'@'localhost';

-- Usamos este comando cuando queremos trabajar con una base de datos especifica
USE curso_sql;

-- Comando para mostrar tablas luego de haber usado 'USE'
SHOW TABLES;

-- Comando para crear una tabla con sus respectivos atributos
CREATE TABLE usuarios(
	nombre VARCHAR(50),
	correo VARCHAR(50)
)


-- Comando para modificar una tabla, EN ESTE CASO AÑADIR COLUMNA
ALTER TABLE usuarios ADD COLUMN cumpleaños VARCHAR(15);

-- Comando para modificar tabla y atributo, EN ESTE CASO CAMBIAR TIPO DE DATO
ALTER TABLE usuarios MODIFY cumpleaños DATE;

-- Comando para renombrar atributos
ALTER TABLE usuarios RENAME COLUMN cumpleaños TO nacimiento;

-- Comando para eliminar una columna de una tabla
ALTER TABLE usuarios DROP COLUMN nacimiento;

-- Comando para eliminar una tabla
DROP TABLE usuarios;

CREATE TABLE usuarios(

	usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	apellidos VARCHAR(30) NOT NULL,
	correo VARCHAR(50) UNIQUE NOT NULL,
	direccion VARCHAR(100) DEFAULT "Sin Direccion",
	edad INT UNSIGNED DEFAULT 0
);

-- Comando para describir una tabla
DESCRIBE usuarios;

-- Si queremos modificar la estructura de un dato debemos colocarle todo lo que conlleva ese dato cada vez.
ALTER TABLE usuarios MODIFY edad INT UNSIGNED DEFAULT 0 NOT NULL;


/*
 * Operaciones CRUD
 * */

-- Operacion para insertar datos

INSERT INTO usuarios (usuario_id, nombre, apellidos, correo, direccion, edad) VALUES 
(2220000, 'Daniel', 'Yaruro', 'danielyaruro20@gmail.com', 'CLL 11B #1A-20', 19)

INSERT INTO usuarios (nombre, apellidos, correo, direccion, edad) VALUES
('Valentina', 'Diaz', 'valdiaz20@gmail.com', 'ProvenzaCity', 20)

INSERT INTO usuarios (nombre, apellidos, correo, edad) VALUES
('Santiago', 'Escobar','xxxxx@xxx.com', 14)

SELECT * FROM usuarios;

-- Manera de agregar varios datos de una sola vez

INSERT INTO usuarios (nombre, apellidos, correo, direccion, edad) VALUES
	('Maria', 'Rojas Alvarez', 'mariarojas@gmail.com', 'Arawak', 21),
	('Nicole', 'Abril', 'nabril@outlook.com', 'Norte 14# 11-22', 18),
	('Oscar', 'Jimenez', 'oscardavidqlo@hotmail.com', 'ProvenzaGos #31-55 casa 2', 19);

INSERT INTO usuarios (nombre, apellidos, correo, direccion, edad) VALUES
	('Saray', 'Rios Amado', 'saris24@outlook.com', 'Santander CLL 14 #42-99', 23),
	('Robinson', 'Contreras', 'robc23@hotmail.com', 'Bucarica Bloque 14-18A Apto 201', 13),
	('Miguel', 'Yopal', 'mkgred@yahoo.com', 'Maracaibo 34 #11-20', 22)


INSERT INTO usuarios (nombre, apellidos, correo, direccion, edad) VALUES
	('Cataalina', 'Peñaranda', 'catajsh200@hotmail.com', 'Moniquira 1 #69-96', 21)
	
	
SELECT nombre, apellidos, usuario_id FROM usuarios;

-- Metodo que te sirve para saber la cantidad de registros que llevas y ponerle un alias

SELECT COUNT(*) AS total_usuarios FROM usuarios;

SELECT * FROM usuarios WHERE usuario_id = 2220005;

-- Te devuelve los datos de las personas que tienen edad 18 y 19 años
-- Mostrar multiples registros

SELECT * FROM usuarios WHERE edad IN (18,19)

SELECT * FROM usuarios WHERE nombre IN ('Nicole', 'Saray', 'Robinson')

SELECT * FROM usuarios;

-- El porcentaje sirve para decir que de ahi en adelante no importa lo que haya
SELECT * FROM usuarios WHERE apellidos LIKE 'R%';

-- Seleccionar usuarios donde su correo termine en @gmail.com

SELECT * FROM usuarios WHERE correo LIKE '%@gmail.com';

-- Usuarios que en el nombre tengan doble a
SELECT * FROM usuarios WHERE nombre LIKE '%a%a%';

-- Usuarios que en el nombre no tengan una doble a
SELECT * FROM usuarios WHERE nombre NOT LIKE '%a%a%';

-- Usuarios que el correo no termine en @gmail.com
SELECT * FROM usuarios WHERE correo NOT LIKE '%@gmail.com';

/*
 * Operadores Relacionales
 * */

-- Personas con edad mayores que 20
SELECT * FROM usuarios WHERE edad >= 20;

-- Personas con edad diferente de 21
SELECT * FROM usuarios WHERE edad != 21;

-- Negar la preposicion
SELECT * FROM usuarios WHERE NOT edad>=19;

-- Unir vatrias condiciones en una sentencia
SELECT * FROM usuarios WHERE edad >=20 AND nombre LIKE '%a%';

-- Condicion o una u otra
SELECT * FROM usuarios WHERE nombre LIKE '%e%' OR direccion = 'Sin Direccion';


/*
 * CLAUSULA UPDATE para actualizar datos
 * */
-- Update tiene que ir siempre con un where
UPDATE usuarios SET correo = 'santiagoescobar@gmail.com', direccion = 'CLL 11B #1-22B Apto 207' WHERE usuario_id = 2220002; 

/*
 * CLAUSULA DELETE para eliminar datos
 * */

DELETE FROM usuarios WHERE nombre = 'Daniel';

-- Manera de eliminar un campo de un registro

UPDATE usuarios SET direccion = NULL WHERE usuario_id = 2220000;

UPDATE usuarios SET direccion = 'Calle 11B #1A-20 Apto 703' WHERE usuario_id = 2220000;

SELECT * FROM usuarios;

-- Este comando sirve si quiero resetear toda la tabla y empezar desde 0
TRUNCATE TABLE usuarios;






