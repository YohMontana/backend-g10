-- Asi se crea una base de datos
CREATE DATABASE IF NOT EXISTS practicas; 

USE practicas;
-- ahora procederemos a crear nuestra primera tabla
-- Tipos de datos: 

CREATE TABLE usuarios(
id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
nombre TEXT NOT NULL,
dni CHAR(8) UNIQUE
);