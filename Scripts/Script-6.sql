-- Procedures en otro script para poder ejecutar varias lineas a la vez
DELIMITER //

CREATE PROCEDURE sp_obtener_suscripciones()
	BEGIN 
		
		SELECT * FROM suscripciones s;
		
	END //
DELIMITER ;
	