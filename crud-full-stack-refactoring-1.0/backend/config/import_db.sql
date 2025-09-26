-- Adminer 4.8.1 MySQL 5.5.5-10.3.39-MariaDB-0+deb10u2 dump
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `students`;
CREATE DATABASE `students` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `students`;

/*Crear usuario de la base de datos*/
CREATE USER 'student'@'localhost' IDENTIFIED BY '12345';

/*Otorgar todos los permisos sobre la base de datos*/
GRANT ALL PRIVILEGES ON students.* TO 'student'@'localhost';

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `students` (`id`, `fullname`, `email`, `age`) VALUES
(1,	'Ana García',	'ana@example.com',	21),
(2,	'Lucas Torres',	'lucas@example.com',	24),
(3,	'Marina Díaz',	'marina@example.com',	22);

DROP TABLE IF EXISTS `students_subjects`;
CREATE TABLE `students_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `approved` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`,`subject_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `students_subjects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `students_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `students_subjects` (`id`, `student_id`, `subject_id`, `approved`) VALUES
(1,	1,	1,	1),
(2,	2,	2,	0);

DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `subjects` (`id`, `name`) VALUES
(3,	'Algoritmos y Estructura de Datos I'),
(4,	'Fundamentos de Informática'),
(1,	'Tecnologías A'),
(2,	'Tecnologías B');

-- 2025-05-28 00:09:08