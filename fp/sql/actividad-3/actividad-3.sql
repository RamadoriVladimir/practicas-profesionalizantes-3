CREATE DATABASE IF NOT EXISTS `actividad3`
CHARACTER SET utf8
COLLATE utf8_bin;

USE `actividad3`;

CREATE TABLE IF NOT EXISTS `actividad3`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`name`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad3`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(128),
  PRIMARY KEY (`id`),
  UNIQUE (`name`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad3`.`action` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(128),
  PRIMARY KEY (`id`),
  UNIQUE (`name`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad3`.`web_api` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_action` INT NOT NULL,
  `url` VARCHAR(256) NOT NULL,
  `http_method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_web_api_action`
    FOREIGN KEY (`id_action`) REFERENCES `action` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad3`.`user_groups` (
  `id_user` INT NOT NULL,
  `id_group` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_group`),
  FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`id_group`) REFERENCES `group` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad3`.`group_permissions` (
  `id_group` INT NOT NULL,
  `id_action` INT NOT NULL,
  PRIMARY KEY (`id_group`, `id_action`),
  FOREIGN KEY (`id_group`) REFERENCES `group` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`id_action`) REFERENCES `action` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

/*
    INSERTAR DATOS
*/
INSERT INTO `user` (`name`, `password`) VALUES
('admin', 'admin123'),
('moderator', 'mod456'),
('user1', 'userpass1'),
('user2', 'userpass2');

INSERT INTO `group` (`name`, `description`) VALUES
('Administrators', 'Full access to the system'),
('Moderators', 'Can ban users, delete videos'),
('RegularUsers', 'Can upload videos, comment, like');

INSERT INTO `action` (`name`, `description`) VALUES
('Upload Video', 'Allows user to upload a video'),
('Delete Video', 'Allows deletion of a video'),
('Suspend User', 'Allows suspension of user accounts'),
('Comment Video', 'Allows user to comment on a video'),
('Like Video', 'Allows user to like a video'),
('Get User Videos', 'Allows user to get videos from a user');

INSERT INTO `web_api` (`id_action`, `url`, `http_method`) VALUES
((SELECT id FROM `action` WHERE name = 'Upload Video'), '/api/uploadVideo', 'POST'),
((SELECT id FROM `action` WHERE name = 'Delete Video'), '/api/deleteVideo', 'POST'),
((SELECT id FROM `action` WHERE name = 'Suspend User'), '/api/suspendUser', 'POST'),
((SELECT id FROM `action` WHERE name = 'Comment Video'), '/api/commentOnVideo', 'POST'),
((SELECT id FROM `action` WHERE name = 'Like Video'), '/api/likeVideo', 'POST'),
((SELECT id FROM `action` WHERE name = 'Get User Videos'), '/api/getUserVideos', 'POST');

INSERT INTO `user_groups` (`id_user`, `id_group`) VALUES
((SELECT id FROM `user` WHERE name = 'admin'), (SELECT id FROM `group` WHERE name = 'Administrators')),
((SELECT id FROM `user` WHERE name = 'moderator'), (SELECT id FROM `group` WHERE name = 'Moderators')),
((SELECT id FROM `user` WHERE name = 'user1'), (SELECT id FROM `group` WHERE name = 'RegularUsers')),
((SELECT id FROM `user` WHERE name = 'user2'), (SELECT id FROM `group` WHERE name = 'RegularUsers'));

INSERT INTO `group_permissions` (`id_group`, `id_action`)
SELECT g.id, a.id
FROM `group` g, `action` a
WHERE g.name = 'Administrators';

INSERT INTO `group_permissions` (`id_group`, `id_action`)
SELECT g.id, a.id
FROM `group` g
JOIN `action` a ON a.name IN ('Suspend User', 'Delete Video')
WHERE g.name = 'Moderators';

INSERT INTO `group_permissions` (`id_group`, `id_action`)
SELECT g.id, a.id
FROM `group` g
JOIN `action` a ON a.name IN ('Upload Video', 'Comment Video', 'Like Video', 'Get User Videos')
WHERE g.name = 'RegularUsers';

/*
    ABM 
*/
DELIMITER //
CREATE PROCEDURE `user_create`(
    IN p_name VARCHAR(45),
    IN p_password VARCHAR(128)
)
BEGIN
    INSERT INTO `user` (`name`, `password`) VALUES (p_name, p_password);
    SELECT LAST_INSERT_ID() AS new_id;
END //

CREATE PROCEDURE `user_read_all`()
BEGIN
    SELECT `id`, `name` FROM `user`; 
END //

CREATE PROCEDURE `user_update`(
    IN p_id INT,
    IN p_name VARCHAR(45),
    IN p_password VARCHAR(128)
)
BEGIN
    UPDATE `user` SET `name` = p_name, `password` = p_password WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `user_delete`(
    IN p_id INT
)
BEGIN
    DELETE FROM `user` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

/*
  PROCEDIMIENTOS GROUP
*/
CREATE PROCEDURE `group_create`(
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    INSERT INTO `group` (`name`, `description`) VALUES (p_name, p_description);
    SELECT LAST_INSERT_ID() AS new_id;
END //

CREATE PROCEDURE `group_read_all`()
BEGIN
    SELECT * FROM `group`;
END //

CREATE PROCEDURE `group_update`(
    IN p_id INT,
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    UPDATE `group` SET `name` = p_name, `description` = p_description WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `group_delete`(
    IN p_id INT
)
BEGIN
    DELETE FROM `group` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

/*
  PROCEDIMIENTOS ACTION
*/
CREATE PROCEDURE `action_create`(
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    INSERT INTO `action` (`name`, `description`) VALUES (p_name, p_description);
    SELECT LAST_INSERT_ID() AS new_id;
END //

CREATE PROCEDURE `action_read_all`()
BEGIN
    SELECT * FROM `action`;
END //

CREATE PROCEDURE `action_update`(
    IN p_id INT,
    IN p_name VARCHAR(45),
    IN p_description VARCHAR(128)
)
BEGIN
    UPDATE `action` SET `name` = p_name, `description` = p_description WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `action_delete`(
    IN p_id INT
)
BEGIN
    DELETE FROM `action` WHERE `id` = p_id;
    SELECT ROW_COUNT() AS affected_rows;
END //

/*
  PROCEDIMIENTOS PARA ASIGNACIÓN DE GRUPOS A USUARIOS
*/
CREATE PROCEDURE `user_group_assign`(
    IN p_id_user INT,
    IN p_id_group INT
)
BEGIN
    INSERT IGNORE INTO `user_groups` (`id_user`, `id_group`) VALUES (p_id_user, p_id_group);
    SELECT ROW_COUNT() AS affected_rows; 
END //

CREATE PROCEDURE `user_group_unassign`(
    IN p_id_user INT,
    IN p_id_group INT
)
BEGIN
    DELETE FROM `user_groups` WHERE `id_user` = p_id_user AND `id_group` = p_id_group;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `user_group_read_by_user_id`(
    IN p_id_user INT
)
BEGIN
    SELECT g.id, g.name, g.description
    FROM `group` g
    INNER JOIN `user_groups` ug ON g.id = ug.id_group
    WHERE ug.id_user = p_id_user;
END //

/*
  PROCEDIMIENTOS PARA ASIGNACIÓN DE PERMISOS A GRUPOS
*/
CREATE PROCEDURE `group_permission_assign`(
    IN p_id_group INT,
    IN p_id_action INT
)
BEGIN
    INSERT IGNORE INTO `group_permissions` (`id_group`, `id_action`) VALUES (p_id_group, p_id_action);
    SELECT ROW_COUNT() AS affected_rows; 
END //

CREATE PROCEDURE `group_permission_unassign`(
    IN p_id_group INT,
    IN p_id_action INT
)
BEGIN
    DELETE FROM `group_permissions` WHERE `id_group` = p_id_group AND `id_action` = p_id_action;
    SELECT ROW_COUNT() AS affected_rows;
END //

CREATE PROCEDURE `group_permission_read_by_group_id`(
    IN p_id_group INT
)
BEGIN
    SELECT a.id, a.name, a.description
    FROM `action` a
    INNER JOIN `group_permissions` gp ON a.id = gp.id_action
    WHERE gp.id_group = p_id_group;
END //

/*
  PROCEDIMIENTOS PARA VERIFICAR PERMISOS 
*/
CREATE PROCEDURE `check_user_permission`(
    IN p_user_id INT,
    IN p_action_name VARCHAR(45)
)
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM `user` u
        INNER JOIN `user_groups` ug ON u.id = ug.id_user
        INNER JOIN `group_permissions` gp ON ug.id_group = gp.id_group
        INNER JOIN `action` a ON gp.id_action = a.id
        WHERE u.id = p_user_id AND a.name = p_action_name
    ) AS has_permission;
END //

CREATE PROCEDURE `get_user_permissions`(
    IN p_user_id INT
)
BEGIN
    SELECT DISTINCT a.id, a.name, a.description
    FROM `user` u
    INNER JOIN `user_groups` ug ON u.id = ug.id_user
    INNER JOIN `group_permissions` gp ON ug.id_group = gp.id_group
    INNER JOIN `action` a ON gp.id_action = a.id
    WHERE u.id = p_user_id;
END //

CREATE PROCEDURE `check_user_permission_by_url`(
    IN p_user_id INT,
    IN p_url VARCHAR(256),
    IN p_http_method VARCHAR(10)
)
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM `user` u
        INNER JOIN `user_groups` ug ON u.id = ug.id_user
        INNER JOIN `group_permissions` gp ON ug.id_group = gp.id_group
        INNER JOIN `web_api` wa ON gp.id_action = wa.id_action
        WHERE u.id = p_user_id 
          AND wa.url = p_url 
          AND wa.http_method = p_http_method
    ) AS has_permission;
END //

DELIMITER ;