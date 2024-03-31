CREATE DATABASE cursosql_finalbd;

USE cursosql_finalbd;

SHOW TABLES;

CREATE TABLE suscripciones (
  suscripcion_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  suscripcion VARCHAR(30) NOT NULL,
  costo DECIMAL(5,2) UNSIGNED NOT NULL
);

INSERT INTO suscripciones VALUES
  (0, 'Bronce', 199.99),
  (0, 'Plata', 299.99),
  (0, 'Oro', 399.99);

CREATE TABLE clientes (
  cliente_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  correo VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE tarjetas (
  tarjeta_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  tarjeta BLOB,
  FOREIGN KEY (cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE servicios(
  servicio_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  tarjeta INT UNSIGNED,
  suscripcion INT UNSIGNED,
  FOREIGN KEY(cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(tarjeta)
    REFERENCES tarjetas(tarjeta_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(suscripcion)
    REFERENCES suscripciones(suscripcion_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE actividad_clientes(
  ac_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  fecha DATETIME,
  FOREIGN KEY (cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

SELECT * FROM servicios s;
SELECT * FROM clientes c;
SELECT * FROM tarjetas t;
SELECT * FROM suscripciones s;

/*
 * STORE PROCEDEREOUS funciones en sql
 * */

-- Delimitar el codigo (hay que poner codigo en otro script)
DELIMITER //

CREATE PROCEDURE sp_obtener_suscripciones()
	BEGIN 
		
		SELECT * FROM suscripciones s;
		
	END //
DELIMITER ;

-- Llamar a un procedure

CALL sp_obtener_suscripciones();

-- Como mostrar los procedures de mi base de datos
SHOW PROCEDURE STATUS WHERE db = 'cursosql_finalbd';
	
DROP PROCEDURE sp_obtener_suscripciones; 
	
DELIMITER //
-- como colocar parametros de entrada 
CREATE PROCEDURE sp_asignar_servicio(
	IN in_suscripcion INT UNSIGNED,
	IN in_cliente VARCHAR(30),
	IN in_correo VARCHAR(50),
	IN in_tarjeta VARCHAR(16),
	-- como colocar parametros de salida
	OUT o_respuesta VARCHAR(50)
)

	BEGIN
		-- Declarar variables antes de empezar la funcion
		DECLARE existe_correo int DEFAULT 0;
		DECLARE cliente_id INT DEFAULT 0;
		DECLARE tarjeta_id INT DEFAULT 0;
		
		START TRANSACTION;
		-- Almacenar en una variable
			SELECT COUNT(*) INTO existe_correo FROM clientes c WHERE correo = in_correo;
		
			IF existe_correo <> 0 THEN SELECT 'Tu correo ya ha sido registrado' INTO o_respuesta;
			ELSE 
				INSERT INTO clientes c (cliente_id, nombre, correo) VALUES
				(0, in_cliente, in_correo);
				SELECT last_insert_id() INTO cliente_id;
			
				INSERT INTO tarjetas t (tarjeta_id, cliente, tarjeta) VALUES 
				(0,cliente_id, AES_ENCRYPT(in_tarjeta, cliente_id));
			
				SELECT last_insert_id() INTO tarjeta_id 
				INSERT INTO servicios (servicio_id,cliente,tarjeta,suscripcion) VALUES
				(0, cliente_id, tarjeta_id, in_suscripcion);
			
			SELECT 'Servicio asignado con exito' INTO o_respuesta;
				
			END IF;
		COMMIT;
	
	END
	


DELIMITER ;res

SHOW PROCEDURE STATUS WHERE db = 'cursosql_finalbd';

/*La respuesta almacenala en la variable de respuesta @res*/
CALL sp_asignar_servicio(3, 'Jonathan', 'danielyaruro20@gmail.com', '1097781698123456', @res);
SELECT @res;

SELECT * FROM clientes;
SELECT * FROM servicios;
SELECT * FROM suscripciones;
SELECT * FROM tarjetas;
SELECT * FROM actividad_clientes ac;

/*
 * TRIGGERS SINTAXIS
 * 
 * DELIMITER //
 * CREATE TRIGGER nombre_disparador
 * [BEFORE | AFTER]
 * [INSERT | UPDATE | DELETE]
 * ON nombre_tabla
 * FOR EACH ROW
 * BEGING
 * END
 * 
 * DELIMITER ;
 * */

DELIMITER //

CREATE TRIGGER tg_actividad_clientes
	AFTER INSERT 
	ON clientes
	FOR EACH ROW
	BEGIN
		INSERT INTO actividad_clientes (ac_id, cliente, fecha) VALUES
		(0, NEW.cliente_id, NOW())
		
	END //
	
DELIMITER ;

SHOW TRIGGERS FROM cursosql_finalbd;

DROP TRIGGER tg_actividad_clientes;

CALL sp_asignar_servicio(2, 'Maria Fernanda', 'mafe1005@outlook.com', '1234567890123456', @res2);
SELECT @res2;