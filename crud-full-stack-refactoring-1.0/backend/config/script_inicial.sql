/*****************TODA ESTA PRIMER PARTE SE DEBE EJECUTAR COMO ROOT************/
/*Crear la base de datos*/
CREATE DATABASE IF NOT EXISTS students
CHARACTER SET utf8 
COLLATE utf8_unicode_ci;

/*Crear usuario de la base de datos*/
CREATE USER 'student'@'localhost' IDENTIFIED BY '12345';

/*Otorgar todos los permisos sobre la base de datos*/
GRANT ALL PRIVILEGES ON students.* TO 'student'@'localhost';

/*Aplicar los cambios en los permisos​*/
FLUSH PRIVILEGES;​
/******************************************************************************/

/*************A PARTIR DE ACÁ SE PUEDE HACER COMO ROOT 
O PARA MAYOR SEGURIDAD CON EL USUARIO student****************************/
/*Usar la base de datos​ o ingresar en el Adminer o PHPMyAdmin a la base de datos*/
USE students;

/*Crear la tabla students*/
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    age INT NOT NULL
) ENGINE=INNODB;

/*Insertar algunos datos de prueba*/
INSERT INTO students (fullname, email, age) VALUES
('Ana García', 'ana@example.com', 21),
('Lucas Torres', 'lucas@example.com', 24),
('Marina Díaz', 'marina@example.com', 22);

/*Crear la tabla subjects*/
CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=INNODB;

/*Insertar materias de prueba*/
INSERT INTO subjects (name) VALUES 
('Tecnologías A'), 
('Tecnologías B'), 
('Algoritmos y Estructura de Datos I'), 
('Fundamentos de Informática');

/*Crear TABLA INTERMEDIA students_subjects
Constraints, o restricción UNIQUE(student_id, subject_id): garantiza que un estudiante
no tenga dos veces la misma materia*/
/*approved: si está aprobada la materia o no (por defecto FALSE).
ON DELETE CASCADE: si eliminás un estudiante o materia, se borra
su asignación automáticamente.*/
CREATE TABLE students_subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    approved BOOLEAN DEFAULT FALSE,
    UNIQUE (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=INNODB;

/*Insertar relaciones de prueba students_subjects*/
INSERT INTO students_subjects (student_id, subject_id, approved) VALUES
(1, 1, 1),
(2, 2, 0);

/*VOLVER TODO A CERO, BORRAR BASE DE DATOS Y USUARIO (SE DEBERÍA EJECUTAR COMO ROOT)*/
/*REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'student'@'localhost';
DROP USER 'student'@'localhost';
DROP DATABASE students;*/