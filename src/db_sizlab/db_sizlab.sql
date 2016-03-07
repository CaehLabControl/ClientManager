-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.17 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para db_sizlab
CREATE DATABASE IF NOT EXISTS `db_sizlab` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `db_sizlab`;


-- Volcando estructura para procedimiento db_sizlab.pto_get_items_menu
DROP PROCEDURE IF EXISTS `pto_get_items_menu`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_get_items_menu`(IN `pt_action` VARCHAR(50), IN `pt_pk_user` BIGINT, IN `pt_section` TINYINT)
BEGIN
	CASE pt_action
		WHEN "allItemsMenu"
			THEN
				SELECT
					tb_items_menu.pk_item_menu,
					tb_items_menu.fl_icon,
					tb_items_menu.fk_item_parent,
					tb_items_menu.fl_text,
					tb_items_menu.fl_expanded,
					tb_items_menu.fl_section
				FROM
					tb_items_menu
				WHERE TRUE
					AND fl_section=pt_section
				ORDER BY tb_items_menu.pk_item_menu;
		WHEN "groupBySection"
			THEN
				SELECT
					tb_items_menu.fl_section
				FROM
					tb_items_menu
				WHERE TRUE
				GROUP BY fl_section;
		ELSE
			SELECT "Case not found..." AS result;
	END CASE;
END//
DELIMITER ;


-- Volcando estructura para procedimiento db_sizlab.pto_get_laboratory
DROP PROCEDURE IF EXISTS `pto_get_laboratory`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_get_laboratory`(IN `pt_action` VARCHAR(50), IN `pt_pk_user` BIGINT, IN `pt_order` VARCHAR(50), IN `pt_type` VARCHAR(50))
BEGIN
	CASE pt_action
		WHEN "allLabaratoriesByUser"
			THEN
				SELECT
					tb_laboratories.pk_laboratory,
					tb_laboratories.fl_name,
					tb_laboratories.fl_description,
					tb_laboratories.fl_cant_computers,
					DATE_FORMAT(fl_row_create_date,'%d/%m/%Y %h:%i %p') AS fl_row_create_date,
					DATE_FORMAT(fl_row_update_date,'%d/%m/%Y %h:%i %p') AS fl_row_update_date,
					tb_laboratories.fk_user
				FROM
					tb_laboratories
				WHERE TRUE
					AND tb_laboratories.fk_user=pt_pk_user
				ORDER BY IF(pt_order="fl_name",fl_name,IF(pt_order="fl_row_create_date",fl_row_create_date,IF(pt_order="fl_row_update_date",fl_row_update_date,pk_laboratory)));
		ELSE
			SELECT "Case not found..." AS result;
	END CASE;
END//
DELIMITER ;


-- Volcando estructura para procedimiento db_sizlab.pto_get_login
DROP PROCEDURE IF EXISTS `pto_get_login`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_get_login`(IN `pt_action` VARCHAR(50), IN `pt_user_name` VARCHAR(50), IN `pt_password` VARCHAR(50))
BEGIN
	CASE pt_action
		WHEN "login"
			THEN
				SELECT
					pk_user,
					fl_user_name,
					fl_mail,
					fl_status_acount
				FROM
					tb_users
				WHERE TRUE
					AND fl_user_name=pt_user_name
					AND fl_password=AES_ENCRYPT(pt_password,"sizlab");
		WHEN "userValidate"
			THEN
				SELECT
					COUNT(*) AS result
				FROM
					tb_users
				WHERE TRUE
					AND fl_user_name=pt_user_name;
		WHEN "mailValidate"
			THEN
				SELECT
					COUNT(*) AS result
				FROM
					tb_users
				WHERE TRUE
					AND fl_mail=pt_user_name;
		WHEN "userRequestNewPassword"
			THEN
				SELECT
					COUNT(*) AS result
				FROM
					tb_users
				WHERE TRUE
					AND (fl_mail=pt_user_name OR fl_user_name=pt_user_name);
		ELSE
			SELECT "Case not found..." AS result;
	END CASE;
END//
DELIMITER ;


-- Volcando estructura para procedimiento db_sizlab.pto_get_user
DROP PROCEDURE IF EXISTS `pto_get_user`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_get_user`(IN `pt_action` VARCHAR(50), IN `pt_pk_user` BIGINT, IN `pt_user_name` VARCHAR(50), IN `pt_count_change_password` INT)
BEGIN
	CASE pt_action
		WHEN "userByUserName"
			THEN
				SELECT
					*
				FROM
					tb_users
				WHERE TRUE
					AND (fl_mail=pt_user_name OR fl_user_name=pt_user_name);
		WHEN "userKeyRequestNewPassword"
			THEN
				SELECT
					ISNULL(fl_key_request_new_password)=(fl_password_changed_count=pt_count_change_password) AS result
				FROM
					tb_users
				WHERE TRUE
					AND (fl_mail=pt_user_name OR fl_user_name=pt_user_name);
		ELSE
			SELECT "Case not found..." AS request;
	END CASE;	
END//
DELIMITER ;


-- Volcando estructura para procedimiento db_sizlab.pto_set_laboratory
DROP PROCEDURE IF EXISTS `pto_set_laboratory`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_set_laboratory`(IN `pt_action` VARCHAR(50), IN `pt_pk_laboratory` BIGINT, IN `pt_name` VARCHAR(50), IN `pt_description` TEXT, IN `pt_fk_user` BIGINT)
BEGIN
	CASE pt_action
		WHEN "insert"
			THEN
				INSERT 
					INTO
						tb_laboratories(fl_name, fl_description, fk_user) 
					VALUES (pt_name, pt_description, pt_fk_user);
		WHEN "update"
			THEN
				UPDATE tb_laboratories
					SET 
						fl_name=pt_name,
						fl_description=pt_description
				WHERE  TRUE
					AND pk_user=pt_pk_user;
		WHEN "delete"
			THEN
				DELETE 
				FROM 
					tb_laboratories
				WHERE TRUE
					AND pk_laboratory=pt_pk_laboratory;
		ELSE
			SELECT "Case not found..." AS request;
	END CASE;
END//
DELIMITER ;


-- Volcando estructura para procedimiento db_sizlab.pto_set_user
DROP PROCEDURE IF EXISTS `pto_set_user`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pto_set_user`(IN `pt_action` VARCHAR(50), IN `pt_pk_user` BIGINT, IN `pt_user_name` VARCHAR(50), IN `pt_password` VARCHAR(50), IN `pt_mail` VARCHAR(50), IN `pt_real_name` VARCHAR(50), IN `pt_patern_name` VARCHAR(50), IN `pt_matern_name` VARCHAR(50))
BEGIN
	CASE pt_action
		WHEN "insert"
			THEN
				INSERT 
					INTO
						db_sizlab.tb_users(fl_user_name, fl_password, fl_mail) 
					VALUES (pt_user_name, AES_ENCRYPT(pt_password,"sizlab"), pt_mail);
		WHEN "update"
			THEN
				UPDATE db_sizlab.tb_users
					SET 
						fl_real_name=pt_real_name,
						fl_patern_name=pt_patern_name,
						fl_matern_name=pt_matern_name
				WHERE  TRUE
					AND pk_user=pt_pk_user;
		WHEN "changePassword"
			THEN
				UPDATE db_sizlab.tb_users
					SET 
						fl_password=AES_ENCRYPT(pt_password,"sizlab")
				WHERE  TRUE
					AND fl_user_name=pt_user_name;
				IF(EXISTS(SELECT * FROM tb_users WHERE fl_user_name=pt_user_name))
					THEN
						IF(!(SELECT ISNULL(fl_key_request_new_password) FROM tb_users WHERE fl_user_name=pt_user_name))
							THEN
								UPDATE db_sizlab.tb_users
									SET 
										fl_key_request_new_password=NULL
								WHERE  TRUE
									AND fl_user_name=pt_user_name;
								SELECT "keyWasReseted" AS result;
							ELSE
								SELECT "keyIsNowNull" AS result;
						END IF;		
					ELSE
						SELECT "userNotExist" AS result;
				END IF;		
		WHEN "activateAcount"
			THEN
				UPDATE db_sizlab.tb_users
					SET 
						fl_status_acount=1,
						fl_mail_validated=fl_mail
				WHERE  TRUE
					AND fl_user_name=pt_user_name;
		WHEN "requestNewPassword"
			THEN
				IF(EXISTS(SELECT * FROM tb_users WHERE fl_user_name=pt_user_name))
					THEN
						IF((SELECT ISNULL(fl_key_request_new_password) FROM tb_users WHERE fl_user_name=pt_user_name))
							THEN
								UPDATE db_sizlab.tb_users
									SET 
										fl_key_request_new_password=AES_ENCRYPT(NOW(),"sizlab"),
										fl_password_changed_count=fl_password_changed_count+1
								WHERE  TRUE
									AND fl_user_name=pt_user_name;
								SELECT "newKeyGenerated" AS result;
							ELSE
								SELECT "lastKeyGenerated" AS result;
						END IF;		
					ELSE
						SELECT "userNotExist" AS result;
				END IF;		
		WHEN "resetKeyRequestNewPassword"
			THEN
				IF(EXISTS(SELECT * FROM tb_users WHERE fl_user_name=pt_user_name))
					THEN
						IF(!(SELECT ISNULL(fl_key_request_new_password) FROM tb_users WHERE fl_user_name=pt_user_name))
							THEN
								UPDATE db_sizlab.tb_users
									SET 
										fl_key_request_new_password=NULL
								WHERE  TRUE
									AND fl_user_name=pt_user_name;
								SELECT "keyWasReseted" AS result;
							ELSE
								SELECT "keyIsNowNull" AS result;
						END IF;		
					ELSE
						SELECT "userNotExist" AS result;
				END IF;		
		WHEN "delete"
			THEN		
				DELETE 
				FROM 
					db_sizlab.tb_users
				WHERE TRUE
					AND pk_user=pt_pk_user;
		ELSE
			SELECT "Case not found..." AS request;
	END CASE;
END//
DELIMITER ;


-- Volcando estructura para tabla db_sizlab.tb_computers
DROP TABLE IF EXISTS `tb_computers`;
CREATE TABLE IF NOT EXISTS `tb_computers` (
  `pk_computer` int(11) NOT NULL AUTO_INCREMENT,
  `fl_name` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fk_laboratory` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk_computer`),
  KEY `fk_tb_computers_tb_laboratories` (`fk_laboratory`),
  CONSTRAINT `fk_tb_computers_tb_laboratories` FOREIGN KEY (`fk_laboratory`) REFERENCES `tb_laboratories` (`pk_laboratory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla db_sizlab.tb_computers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tb_computers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_computers` ENABLE KEYS */;


-- Volcando estructura para tabla db_sizlab.tb_computers_equipment
DROP TABLE IF EXISTS `tb_computers_equipment`;
CREATE TABLE IF NOT EXISTS `tb_computers_equipment` (
  `pk_computer_equipment` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pk_computer_equipment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla db_sizlab.tb_computers_equipment: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tb_computers_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_computers_equipment` ENABLE KEYS */;


-- Volcando estructura para tabla db_sizlab.tb_items_menu
DROP TABLE IF EXISTS `tb_items_menu`;
CREATE TABLE IF NOT EXISTS `tb_items_menu` (
  `pk_item_menu` bigint(20) NOT NULL AUTO_INCREMENT,
  `fl_icon` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `fk_item_parent` bigint(20) NOT NULL DEFAULT '-1',
  `fl_text` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fl_expanded` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fl_section` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`pk_item_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla db_sizlab.tb_items_menu: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `tb_items_menu` DISABLE KEYS */;
REPLACE INTO `tb_items_menu` (`pk_item_menu`, `fl_icon`, `fk_item_parent`, `fl_text`, `fl_expanded`, `fl_section`) VALUES
	(1, 'content/pictures-system/icon-menu/computer.png', -1, 'Operaciones', 'true', 0),
	(2, 'content/pictures-system/icon-menu/monitoring.png', 1, 'Monitorear', '', 0),
	(3, 'content/pictures-system/icon-menu/services.png', 1, 'Servicios', '', 0),
	(4, 'content/pictures-system/icon-menu/distributor-report.png', -1, 'Reportes', 'true', 1),
	(5, 'content/pictures-system/icon-menu/student.png', 4, 'Alumnos', '', 1),
	(6, 'content/pictures-system/icon-menu/teachers.png', 4, 'Profesores', '', 1),
	(7, 'content/pictures-system/icon-menu/inventory.png', 4, 'Inventaio', '', 1),
	(8, 'content/pictures-system/icon-menu/maintenance.png', 4, 'Mantenimiento', '', 1),
	(9, 'content/pictures-system/icon-menu/admin.png', -1, 'Administración', 'true', 2),
	(10, 'content/pictures-system/icon-menu/laboratory-add.png', 9, 'Centros de computo', 'true', 2),
	(11, 'content/pictures-system/icon-menu/note.png', 9, 'Notas', '', 2),
	(12, 'content/pictures-system/icon-menu/settings.png', 9, 'Configuraciones', '', 2),
	(13, 'content/pictures-system/icon-menu/user-acount.png', 9, 'Ajustes', '', 2),
	(15, 'content/pictures-system/icon-menu/monitoring.png', 2, 'd', '', 0);
/*!40000 ALTER TABLE `tb_items_menu` ENABLE KEYS */;


-- Volcando estructura para tabla db_sizlab.tb_laboratories
DROP TABLE IF EXISTS `tb_laboratories`;
CREATE TABLE IF NOT EXISTS `tb_laboratories` (
  `pk_laboratory` int(11) NOT NULL AUTO_INCREMENT,
  `fl_name` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fl_description` varchar(500) COLLATE utf8_spanish_ci NOT NULL,
  `fl_cant_computers` tinyint(4) NOT NULL DEFAULT '0',
  `fl_row_create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fl_row_update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fk_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk_laboratory`),
  KEY `fk_tb_laboratories_tb_users` (`fk_user`),
  CONSTRAINT `fk_tb_laboratories_tb_users` FOREIGN KEY (`fk_user`) REFERENCES `tb_users` (`pk_user`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla db_sizlab.tb_laboratories: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `tb_laboratories` DISABLE KEYS */;
REPLACE INTO `tb_laboratories` (`pk_laboratory`, `fl_name`, `fl_description`, `fl_cant_computers`, `fl_row_create_date`, `fl_row_update_date`, `fk_user`) VALUES
	(4, 'nombre', 'desc', 0, '2016-03-06 11:54:27', '2016-03-06 12:00:45', NULL),
	(131, 'Laboratorio 1', 'Este es un laboratorio', 0, '2016-03-06 21:47:11', '2016-03-06 21:47:11', 20);
/*!40000 ALTER TABLE `tb_laboratories` ENABLE KEYS */;


-- Volcando estructura para tabla db_sizlab.tb_users
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE IF NOT EXISTS `tb_users` (
  `pk_user` int(11) NOT NULL AUTO_INCREMENT,
  `fl_date_created_acount` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fl_user_name` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fl_password` mediumblob COMMENT 'AES Encryption Estandar Key is sizlab',
  `fl_mail` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fl_mail_validated` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fl_real_name` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `fl_patern_name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fl_matern_name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fl_status_acount` tinyint(4) DEFAULT '0' COMMENT '0=Not active, 1=Active, 2=Disabled',
  `fl_key_request_new_password` mediumblob,
  `fl_password_changed_count` int(11) DEFAULT '0',
  PRIMARY KEY (`pk_user`),
  UNIQUE KEY `fl_user_name` (`fl_user_name`),
  UNIQUE KEY `fl_mail` (`fl_mail`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla db_sizlab.tb_users: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
REPLACE INTO `tb_users` (`pk_user`, `fl_date_created_acount`, `fl_user_name`, `fl_password`, `fl_mail`, `fl_mail_validated`, `fl_real_name`, `fl_patern_name`, `fl_matern_name`, `fl_status_acount`, `fl_key_request_new_password`, `fl_password_changed_count`) VALUES
	(20, '2016-02-28 08:46:43', 'carlos', _binary 0xF6E0C8A5337B5AA023738343B1A62E21, 'karlos.antoni-1994@hotmail.com', 'karlos.antoni-1994@hotmail.com', '', NULL, NULL, 1, NULL, 0);
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;


-- Volcando estructura para disparador db_sizlab.tb_laboratories_before_insert
DROP TRIGGER IF EXISTS `tb_laboratories_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tb_laboratories_before_insert` BEFORE INSERT ON `tb_laboratories` FOR EACH ROW BEGIN
	SELECT
		COUNT(fl_name)
		INTO @count_equals_names
	FROM
		tb_laboratories
	WHERE TRUE
		AND fl_name=NEW.fl_name
		AND fk_user=NEW.fk_user;
	IF(@count_equals_names>0)
		THEN
			SET NEW.fl_name=CONCAT(NEW.fl_name,' (',@count_equals_names+1,')');
	END IF;	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
