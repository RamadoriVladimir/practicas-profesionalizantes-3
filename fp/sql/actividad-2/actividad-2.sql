CREATE DATABASE IF NOT EXISTS `World`
CHARACTER SET utf8
COLLATE utf8_bin;

USE World;

CREATE TABLE IF NOT EXISTS `World`.`Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `language` VARCHAR(100) NOT NULL,
  `surface_area` DECIMAL(15,2) NOT NULL,
  `population` BIGINT NOT NULL,
  `capital_city_id` INT NULL, 
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `capital_city_id_UNIQUE` (`capital_city_id` ASC) 
)
ENGINE = InnoDB;

INSERT INTO `Country` (`name`, `language`, `surface_area`, `population`, `capital_city_id`) VALUES
('Argentina', 'Spanish', 2780400.00, 45376763, NULL),
('Brazil', 'Portuguese', 8515767.00, 215313498, NULL),
('Chile', 'Spanish', 756096.00, 19116201, NULL),
('Uruguay', 'Spanish', 176215.00, 3473730, NULL),
('Paraguay', 'Spanish', 406752.00, 7132538, NULL),
('Bolivia', 'Spanish', 1098581.00, 11673021, NULL),
('Peru', 'Spanish', 1285216.00, 32971854, NULL),
('Ecuador', 'Spanish', 283561.00, 17643054, NULL),
('Colombia', 'Spanish', 1141748.00, 50882891, NULL),
('Venezuela', 'Spanish', 916445.00, 28435940, NULL),
('United States', 'English', 9833517.00, 331002651, NULL),
('Canada', 'English', 9984670.00, 37742154, NULL),
('Mexico', 'Spanish', 1964375.00, 128932753, NULL),
('France', 'French', 643801.00, 65273511, NULL),
('Germany', 'German', 357022.00, 83783942, NULL),
('Italy', 'Italian', 301340.00, 60461826, NULL),
('Spain', 'Spanish', 505370.00, 46754778, NULL),
('United Kingdom', 'English', 243610.00, 67886011, NULL),
('Japan', 'Japanese', 377915.00, 126476461, NULL),
('China', 'Chinese', 9596960.00, 1439323776, NULL);

CREATE TABLE IF NOT EXISTS `World`.`City` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `population` BIGINT NOT NULL,
  `surface_area` DECIMAL(15,2) NOT NULL,
  `postal_code` INT NOT NULL,
  `is_coastal` TINYINT(1) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_City_Country_idx` (`country_id`),
  CONSTRAINT `fk_City_Country`
    FOREIGN KEY (`country_id`)
    REFERENCES `World`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

INSERT INTO `City` (`name`, `population`, `surface_area`, `postal_code`, `is_coastal`, `country_id`) VALUES
('Buenos Aires', 15250000, 203.00, 1000, 0, (SELECT id FROM Country WHERE name = 'Argentina')),
('Brasília', 3094325, 5802.00, 70000, 0, (SELECT id FROM Country WHERE name = 'Brazil')),
('Santiago', 6257516, 641.40, 8320000, 0, (SELECT id FROM Country WHERE name = 'Chile')),
('Montevideo', 1319108, 201.00, 11000, 1, (SELECT id FROM Country WHERE name = 'Uruguay')),
('Asunción', 525297, 117.00, 1000, 0, (SELECT id FROM Country WHERE name = 'Paraguay')),
('Sucre', 295415, 1768.00, 1000, 0, (SELECT id FROM Country WHERE name = 'Bolivia')),
('Lima', 11000000, 2672.00, 15000, 1, (SELECT id FROM Country WHERE name = 'Peru')),
('Quito', 2700000, 372.00, 170101, 0, (SELECT id FROM Country WHERE name = 'Ecuador')),
('Bogotá', 7743955, 1775.00, 110111, 0, (SELECT id FROM Country WHERE name = 'Colombia')),
('Caracas', 2989081, 1930.00, 1010, 0, (SELECT id FROM Country WHERE name = 'Venezuela')),
('Washington D.C.', 712816, 177.00, 20001, 0, (SELECT id FROM Country WHERE name = 'United States')),
('Ottawa', 1017449, 2778.00, 1000, 0, (SELECT id FROM Country WHERE name = 'Canada')),
('Mexico City', 22000000, 1485.00, 1000, 0, (SELECT id FROM Country WHERE name = 'Mexico')),
('Paris', 2141000, 105.40, 75001, 0, (SELECT id FROM Country WHERE name = 'France')),
('Berlin', 3769000, 891.80, 10115, 0, (SELECT id FROM Country WHERE name = 'Germany')),
('Rome', 2872800, 1285.00, 10018, 0, (SELECT id FROM Country WHERE name = 'Italy')),
('Madrid', 3339000, 604.30, 28001, 0, (SELECT id FROM Country WHERE name = 'Spain')),
('London', 8982000, 1572.00, 1000, 0, (SELECT id FROM Country WHERE name = 'United Kingdom')),
('Tokyo', 13960000, 2194.00, 100, 1, (SELECT id FROM Country WHERE name = 'Japan')),
('Beijing', 21540000, 16410.00, 100000, 0, (SELECT id FROM Country WHERE name = 'China'));

INSERT INTO `City` (`name`, `population`, `surface_area`, `postal_code`, `is_coastal`, `country_id`) VALUES
('La Plata', 193144, 926.00, 1900, 0, (SELECT id FROM Country WHERE name = 'Argentina')),
('Rio de Janeiro', 6748000, 1200.00, 20000, 1, (SELECT id FROM Country WHERE name = 'Brazil')),
('Valparaíso', 295113, 401.60, 2340000, 1, (SELECT id FROM Country WHERE name = 'Chile')),
('Punta del Este', 127000, 40.00, 20100, 1, (SELECT id FROM Country WHERE name = 'Uruguay')),
('Encarnación', 132300, 274.00, 6000, 0, (SELECT id FROM Country WHERE name = 'Paraguay')),
('Santa Cruz', 1453545, 535.01, 7000, 0, (SELECT id FROM Country WHERE name = 'Bolivia')),
('Cusco', 437538, 385.10, 8000, 0, (SELECT id FROM Country WHERE name = 'Peru')),
('Guayaquil', 2690000, 344.50, 9000, 1, (SELECT id FROM Country WHERE name = 'Ecuador')),
('Medellín', 2569000, 380.64, 5000, 0, (SELECT id FROM Country WHERE name = 'Colombia')),
('Maracaibo', 1215000, 557.60, 4000, 1, (SELECT id FROM Country WHERE name = 'Venezuela')),
('New York', 8419600, 783.80, 10001, 1, (SELECT id FROM Country WHERE name = 'United States')),
('Vancouver', 675218, 114.97, 1100, 1, (SELECT id FROM Country WHERE name = 'Canada')),
('Guadalajara', 1460148, 187.91, 44100, 0, (SELECT id FROM Country WHERE name = 'Mexico')),
('Nice', 341032, 71.92, 6000, 1, (SELECT id FROM Country WHERE name = 'France')),
('Munich', 1471508, 310.70, 80331, 0, (SELECT id FROM Country WHERE name = 'Germany')),
('Florence', 382258, 102.41, 50122, 0, (SELECT id FROM Country WHERE name = 'Italy')),
('Barcelona', 1620343, 101.35, 8000, 1, (SELECT id FROM Country WHERE name = 'Spain'));

UPDATE `Country` co
SET `capital_city_id` = (SELECT ci.id FROM `City` ci WHERE ci.name =
    CASE co.name
        WHEN 'Argentina' THEN 'Buenos Aires'
        WHEN 'Brazil' THEN 'Brasília'
        WHEN 'Chile' THEN 'Santiago'
        WHEN 'Uruguay' THEN 'Montevideo'
        WHEN 'Paraguay' THEN 'Asunción'
        WHEN 'Bolivia' THEN 'Sucre'
        WHEN 'Peru' THEN 'Lima'
        WHEN 'Ecuador' THEN 'Quito'
        WHEN 'Colombia' THEN 'Bogotá'
        WHEN 'Venezuela' THEN 'Caracas'
        WHEN 'United States' THEN 'Washington D.C.'
        WHEN 'Canada' THEN 'Ottawa'
        WHEN 'Mexico' THEN 'Mexico City'
        WHEN 'France' THEN 'Paris'
        WHEN 'Germany' THEN 'Berlin'
        WHEN 'Italy' THEN 'Rome'
        WHEN 'Spain' THEN 'Madrid'
        WHEN 'United Kingdom' THEN 'London'
        WHEN 'Japan' THEN 'Tokyo'
        WHEN 'China' THEN 'Beijing'
        ELSE NULL
    END
AND ci.country_id = co.id);

ALTER TABLE `World`.`Country`
ADD CONSTRAINT `fk_Country_CapitalCity`
  FOREIGN KEY (`capital_city_id`)
  REFERENCES `World`.`City` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*
    PROCEDIMIENTOS PAIS
*/
DELIMITER //

CREATE PROCEDURE `country_get_all`()
BEGIN
    SELECT
        co.id,
        co.name,
        ci.name AS capital_name, 
        co.language,
        co.surface_area,
        co.population
    FROM `Country` co
    INNER JOIN `City` ci ON co.capital_city_id = ci.id 
    ORDER BY co.name;
END //

CREATE PROCEDURE `country_get_by_id`(IN p_id INT)
BEGIN
    SELECT
        co.id,
        co.name,
        ci.name AS capital_name, 
        co.language,
        co.surface_area,
        co.population
    FROM `Country` co
    INNER JOIN `City` ci ON co.capital_city_id = ci.id 
    WHERE co.id = p_id;
END //

CREATE PROCEDURE `country_create`(
    IN p_name VARCHAR(100),
    IN p_capital_city_id INT,
    IN p_language VARCHAR(100),
    IN p_surface_area DECIMAL(15,2),
    IN p_population BIGINT
)
BEGIN
    INSERT INTO `country` (`name`, `capital_city_id`, `language`, `surface_area`, `population`)
    VALUES (p_name, p_capital_city_id, p_language, p_surface_area, p_population);

    SELECT LAST_INSERT_ID() AS new_id;
END //

CREATE PROCEDURE `country_update`(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_capital_city_id INT, 
    IN p_language VARCHAR(100),
    IN p_surface_area DECIMAL(15,2),
    IN p_population BIGINT
)
BEGIN
    UPDATE `country`
    SET
        `name` = p_name,
        `capital_city_id` = p_capital_city_id, 
        `language` = p_language,
        `surface_area` = p_surface_area,
        `population` = p_population
    WHERE `id` = p_id;

    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `country_delete`(IN p_id INT)
BEGIN
    DELETE FROM `country` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `country_search_by_name`(IN p_name_part VARCHAR(100))
BEGIN
    SELECT
        co.id,
        co.name,
        ci.name AS capital_name, 
        co.language,
        co.surface_area,
        co.population
    FROM `Country` co
    INNER JOIN `City` ci ON co.capital_city_id = ci.id 
    WHERE co.name LIKE CONCAT('%', p_name_part, '%')
    ORDER BY co.name;
END //

/*
    PROCEDIMIENTOS CIUDAD
*/

CREATE PROCEDURE `city_get_all`()
BEGIN
    SELECT * FROM `City` ORDER BY `name`;
END //

CREATE PROCEDURE `city_get_by_id`(IN p_id INT)
BEGIN
    SELECT * FROM `City` WHERE `id` = p_id;
END //

CREATE PROCEDURE `city_create`(
    IN p_name VARCHAR(100),
    IN p_population BIGINT,
    IN p_surface_area DECIMAL(15,2),
    IN p_postal_code INT,
    IN p_is_coastal TINYINT(1),
    IN p_country_id INT
)
BEGIN
    INSERT INTO `City` (`name`, `population`, `surface_area`, `postal_code`, `is_coastal`, `country_id`)
    VALUES (p_name, p_population, p_surface_area, p_postal_code, p_is_coastal, p_country_id);

    SELECT LAST_INSERT_ID() AS new_id;
END //

CREATE PROCEDURE `city_update`(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_population BIGINT,
    IN p_surface_area DECIMAL(15,2),
    IN p_postal_code INT,
    IN p_is_coastal TINYINT(1),
    IN p_country_id INT
)
BEGIN
    UPDATE `City`
    SET
        `name` = p_name,
        `population` = p_population,
        `surface_area` = p_surface_area,
        `postal_code` = p_postal_code,
        `is_coastal` = p_is_coastal,
        `country_id` = p_country_id
    WHERE `id` = p_id;

    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `city_delete`(IN p_id INT)
BEGIN
    DELETE FROM `City` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

/*
    PROCEDIMIENTOS ADICIONALES
*/

CREATE PROCEDURE `get_most_populated_country`()
BEGIN
    SELECT co.name AS country_name
    FROM City c
    INNER JOIN Country co ON co.id = c.country_id
    ORDER BY c.population DESC
    LIMIT 1;
END //

CREATE PROCEDURE `get_coastal_country_over_1m`()
BEGIN
    SELECT DISTINCT co.name AS country_name
    FROM City c
    INNER JOIN Country co ON co.id = c.country_id
    WHERE c.is_coastal = 1 AND c.population > 1000000
    ORDER BY co.name;
END //

CREATE PROCEDURE `get_highest_density_country`()
BEGIN
    SELECT co.name AS country_name, c.name AS city_name
    FROM City c
    INNER JOIN Country co ON co.id = c.country_id
    ORDER BY (c.population / c.surface_area) DESC
    LIMIT 1;
END //

DELIMITER ;