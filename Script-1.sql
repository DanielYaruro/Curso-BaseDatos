CREATE DATABASE IF NOT EXISTS curso_sql_base2;

SHOW DATABASES;

USE curso_sql_base2;

CREATE TABLE usuarios(

	usuario_id INT(7) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	apellidos VARCHAR(30) NOT NULL,
	correo VARCHAR(50) UNIQUE NOT NULL,
	direccion VARCHAR(50) DEFAULT 'Sin direccion',
	edad INT(3) UNSIGNED NOT NULL DEFAULT 0
);


SHOW TABLES;

DESCRIBE usuarios;

INSERT INTO usuarios (usuario_id, nombre, apellidos, correo, direccion, edad) VALUES 
	(2220000, 'Daniel', 'Yaruro', 'danielyaruro20@gmail.com', 'CLL 11B #1A-20', 19);

INSERT INTO usuarios(nombre, apellidos, correo, direccion, edad) VALUES
	('Valentina', 'Diaz', 'valdiaz20@gmail.com', 'ProvenzaCity', 20),
	('Maria', 'Rojas Alvarez', 'mariarojas@gmail.com', 'Arawak', 21),
	('Nicole', 'Abril', 'nabril@outlook.com', 'Norte 14# 11-22', 18),
	('Oscar', 'Jimenez', 'oscardavidqlo@hotmail.com', 'ProvenzaGos #31-55 casa 2', 19),
	('Saray', 'Rios Amado', 'saris24@outlook.com', 'Santander CLL 14 #42-99', 23),
	('Robinson', 'Contreras', 'robc23@hotmail.com', 'Bucarica Bloque 14-18A Apto 201', 13),
	('Miguel', 'Yopal', 'mkgred@yahoo.com', 'Maracaibo 34 #11-20', 22),
	('Cataalina', 'Peñaranda', 'catajsh200@hotmail.com', 'Moniquira 1 #69-96', 21);


CREATE TABLE productos(

	producto_id INT(7) UNSIGNED PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL UNIQUE,
	descripcion VARCHAR(255) NOT NULL DEFAULT 'Producto sin descripcion',
	precio DECIMAL(7,2) UNSIGNED NOT NULL,
	cantidad_stock INT UNSIGNED DEFAULT 00 NOT NULL
	
);

DESCRIBE productos;

INSERT INTO productos (producto_id, nombre, descripcion, precio, cantidad_stock) VALUES
	(235, 'Computadora MACBOOK Air 2', 'Para el futuro del pais', 29999.99, 10),
	(253, 'Apple Iphone 15 PRO MAX', 'Con quad camara', 14999.99,30),
	(479, 'Cargador IPHONE 33 WATTS', ' Con ultra carga rapida', 2975.30, 99),
	(555, 'Laptop HP Grenfon', ' Con microfono y disco SSD', 15985.10, 40),
	(327, 'Audifonos Redmi Airdots 2', 'Carga inalambrica, duracion 3 horas', 3450.00, 20),
	(270, 'Apple Airpods 5 pro', 'Carga inalambrica, duracion 6 horas cancelacion ruido', 5600.99,35);

SELECT * FROM productos;

SELECT * FROM usuarios;

SELECT 6 / 5 AS calculo;

SELECT 7 + 4 AS calculo2;

#Funciones Matematicas
-- Funcion MOD que devuelve el modulo entre 2 numeros
SELECT MOD(5,2) AS calculo3;

SELECT CEILING(7.0001); #Redondea al siguiente numero

SELECT floor(7.9999); #Redondea a la parte entera

SELECT round(7.5); #Redondea de manera tradicional

SELECT pow(9,2); #Funcion para elevar un numero a una potencia
SELECT POWER(2,6);

SELECT sqrt(5); #Sacar raiz cuadrada

/*
 * Columnas Calculadas
 * */

SELECT nombre, precio, cantidad_stock, (precio * cantidad_stock) AS ganancia FROM productos;

ALTER TABLE productos DROP COLUMN ganancia;

ALTER TABLE productos ADD COLUMN ganancia DECIMAL DEFAULT 0;

SELECT * FROM productos;

/*
 * Funciones de agrupamiento
 * */
#Esto nos va a dar solo el precio maximo y lo imprimira
SELECT MAX(precio) AS precio_maximo FROM productos; 

#Esto nos dara toda la informacion de un producto, en este caso del producto mas caro
SELECT * FROM productos WHERE precio = (SELECT MAX(precio) FROM productos);

SELECT MIN(precio) AS precio_minimo FROM productos;

SELECT * FROM productos WHERE precio = (SELECT MIN(precio) FROM productos);

#Suma todos las filas de una columna, en este caso la cantidad total de productos
SELECT SUM(cantidad_stock) AS total_productos FROM productos;

#Promedio de los precios
SELECT avg(precio) AS promedio_precios FROM productos;

SELECT * FROM productos WHERE precio < (SELECT AVG(precio) FROM productos);

SELECT COUNT(*) AS cantidad_productos FROM productos;

#Otra manera de traer los datos que colocamos con funciones de agrupacion

SELECT nombre, MIN(precio) FROM productos GROUP BY producto_id;


CREATE TABLE caballeros(
	
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30),
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30)

);

INSERT INTO caballeros (caballero_id, nombre, armadura, rango, signo, ejercito, pais) VALUES
  (0,"Seiya","Pegaso","Bronce","Sagitario","Athena","Japón"),
  (0,"Shiryu","Dragón","Bronce","Libra","Athena","Japón"),
  (0,"Hyoga","Cisne","Bronce","Acuario","Athena","Rusia"),
  (0,"Shun","Andromeda","Bronce","Virgo","Athena","Japón"),
  (0,"Ikki","Fénix","Bronce","Leo","Athena","Japón"),
  (0,"Kanon","Géminis","Oro","Géminis","Athena","Grecia"),
  (0,"Saga","Géminis","Oro","Géminis","Athena","Grecia"),
  (0,"Camus","Acuario","Oro","Acuario","Athena","Francia"),
  (0,"Rhadamanthys","Wyvern","Espectro","Escorpión","Hades","Inglaterra"),
  (0,"Kanon","Dragón Marino","Marino","Géminis","Poseidón","Grecia"),
  (0,"Kagaho","Bennu","Espectro","Leo","Hades","Rusia");

 SELECT * FROM caballeros;

SHOW INDEX FROM usuarios;

#Fijese en los signos que hay, ahora cuentelos y guardelos como total y agrupelos por signo justamente
SELECT signo, COUNT(*) AS total FROM caballeros GROUP BY signo;

SELECT armadura, COUNT(*) AS total_armadura FROM caballeros GROUP BY armadura;

SELECT rango, COUNT(*) AS cantidad FROM caballeros WHERE ejercito = 'Athena' GROUP BY rango;

/*
 * EL where se utilizando usando campos que ya estan en la base de datos
 * El HAVING se utiliza cuando queremos filtrar informacion en base a las funciones de agrupamiento
 * */

SELECT rango, COUNT(*) AS cantidad FROM caballeros WHERE ejercito = 'Athena' GROUP BY rango HAVING cantidad>=4;

SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre HAVING precio_maximo >=10000;

/*
 * CLAUSULA DISTINT
 * Elimina los valores repetidos
 * */
SELECT DISTINCT signo FROM caballeros;
SELECT DISTINCT armadura FROM caballeros;
SELECT DISTINCT rango FROM caballeros;
SELECT DISTINCT ejercito FROM caballeros;
SELECT DISTINCT pais FROM caballeros;

/*
 * CLAUSULA ORDER
 * 
 * */
#Ordena los datos por el campo de manera ascendente
SELECT * FROM caballeros ORDER BY nombre ASC;

#Ordena los datos por el campo de manera descendente
SELECT * FROM caballeros ORDER BY nombre DESC;

#Ordena los datos por el campo primero de manera ascendente y luego se enfoca en el siguiente campo y lo ordena de forma ascendete

SELECT * FROM caballeros ORDER BY nombre, armadura;

#La sintaxis es que el order by debe ir al final
SELECT * FROM caballeros WHERE ejercito = 'Athena' ORDER BY nombre, armadura;

SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre HAVING precio_maximo >=10000 ORDER BY precio DESC;

/*
 * Clausura BETWEEN
 * */

# Seleccionar todo de producto con precio entre 14000 y 30000

SELECT * FROM productos WHERE precio BETWEEN 14000 AND 30000;

SELECT * FROM usuarios WHERE nombre REGEXP '[v-z]'; #Expresion regular que contenga palabra de la v a la z

SELECT ('Hola Mundo');

SELECT lower('Hola Mundo') AS saludo; 
SELECT ucase('Hola Mundo') AS saludo_mays; 

-- Devuelve los primeros 6 caracteres de el texto que le damos
SELECT LEFT('Hola mundo', 6);

SELECT RIGHT('Hola mundito', 5);

SELECT LENGTH('hOLA MUNDITO');

SELECT REPEAT('Hola mundo ', 4);

SELECT REVERSE('Hola mundo');

SELECT REPLACE('Hola Mundo', 'o', 'x');

SELECT TRIM('  HOLA MUNDO    ');

SELECT concat('Hola mundo', ' Mi nombre es Daniel', ' desde sql');

SELECT concat_ws('->', ' Hola','mundo', 'desde', 'sql');

SELECT ucase(nombre), lcase(descripcion), precio FROM productos;




