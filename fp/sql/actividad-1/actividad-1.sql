CREATE DATABASE IF NOT EXISTS `World`
CHARACTER SET utf8 
COLLATE utf8_bin;

USE World;

CREATE TABLE IF NOT EXISTS `Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `capital` VARCHAR(100) NOT NULL,
  `language` VARCHAR(100) NOT NULL,
  `surface_area` DECIMAL(15,2) NOT NULL,
  `population` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;

INSERT INTO `Country` (`name`, `capital`, `language`, `surface_area`, `population`) VALUES
('Argentina', 'Buenos Aires', 'Spanish', 2780400.00, 45376763),
('Brazil', 'Brasília', 'Portuguese', 8515767.00, 215313498),
('Chile', 'Santiago', 'Spanish', 756096.00, 19116201),
('Uruguay', 'Montevideo', 'Spanish', 176215.00, 3473730),
('Paraguay', 'Asunción', 'Spanish', 406752.00, 7132538),
('Bolivia', 'Sucre', 'Spanish', 1098581.00, 11673021),
('Peru', 'Lima', 'Spanish', 1285216.00, 32971854),
('Ecuador', 'Quito', 'Spanish', 283561.00, 17643054),
('Colombia', 'Bogotá', 'Spanish', 1141748.00, 50882891),
('Venezuela', 'Caracas', 'Spanish', 916445.00, 28435940),
('United States', 'Washington D.C.', 'English', 9833517.00, 331002651),
('Canada', 'Ottawa', 'English', 9984670.00, 37742154),
('Mexico', 'Mexico City', 'Spanish', 1964375.00, 128932753),
('France', 'Paris', 'French', 643801.00, 65273511),
('Germany', 'Berlin', 'German', 357022.00, 83783942),
('Italy', 'Rome', 'Italian', 301340.00, 60461826),
('Spain', 'Madrid', 'Spanish', 505370.00, 46754778),
('United Kingdom', 'London', 'English', 243610.00, 67886011),
('Japan', 'Tokyo', 'Japanese', 377915.00, 126476461),
('China', 'Beijing', 'Chinese', 9596960.00, 1439323776);

DELIMITER //
CREATE PROCEDURE `country_get_all`()
BEGIN
    SELECT * FROM `country` ORDER BY `name`;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `country_get_by_id`(IN p_id INT)
BEGIN
    SELECT * FROM `country` WHERE `id` = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `country_create`(
    IN p_name VARCHAR(100),
    IN p_capital VARCHAR(100),
    IN p_language VARCHAR(100),
    IN p_surface_area DECIMAL(15,2),
    IN p_population BIGINT
)
BEGIN
    INSERT INTO `country` (`name`, `capital`, `language`, `surface_area`, `population`)
    VALUES (p_name, p_capital, p_language, p_surface_area, p_population);
    
    SELECT LAST_INSERT_ID() AS new_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `country_update`(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_capital VARCHAR(100),
    IN p_language VARCHAR(100),
    IN p_surface_area DECIMAL(15,2),
    IN p_population BIGINT
)
BEGIN
    UPDATE `country`
    SET 
        `name` = p_name,
        `capital` = p_capital,
        `language` = p_language,
        `surface_area` = p_surface_area,
        `population` = p_population
    WHERE `id` = p_id;
    
    SELECT ROW_COUNT() AS affected_rows;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `country_delete`(IN p_id INT)
BEGIN
    DELETE FROM `country` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `country_search_by_name`(IN p_name_part VARCHAR(100))
BEGIN
    SELECT * FROM `country` 
    WHERE `name` LIKE CONCAT('%', p_name_part, '%')
    ORDER BY `name`;
END //
DELIMITER ;