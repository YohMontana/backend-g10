USE practicas;

CREATE TABLE tareas(
	id				INT					AUTO_INCREMENT PRIMARY KEY,
    titulo			VARCHAR(100)		UNIQUE,
    descripcion		TEXT,
    usuario_id		INT,
    -- CREO LA RELACION ENTRE LAS TABLAS
    -- indico entre parentesis la columna de esta tabla y luego la tabla (su columna)
    FOREIGN KEY (usuario_id) ReFeRenCeS usuarios(id)
);

-- SUB LENGUAJES
-- DDL (Data Definition Language)
-- Es un lenguaje que sirve para definir estructuras de datos (Crear bd, crear tablas,
-- actualizar tablas, eliminar tablas)
-- CREATE (Crear)
-- ALTER (Actualizar)
-- DROP (Eliminar) elimina absoltamente TODO

-- DML (Data Manipulation Language)
-- Es un lenguaje que sirve para definir la informacion que ira dentro de las estructuras
-- Insertar datos, actualizar datos, eliminar datos y leer datos
-- INSERT (Insertar)
-- SELECT (Visualizar)
-- UPDATE (Actualizar)
-- DELETE (Eliminar)


INSERT INTO usuarios (nombre, dni) VALUES ('Eduardo', '73500746');

-- Si queremos utulizar el vlaor por defector de una columna
INSERT INTO usuarios (id, nombre, dni) VALUES (DEFAULT, 'Juana', '71589264');
INSERT INTO usuarios (id, nombre, dni) VALUES (DEFAULT, 'Roberto', '35269485'),
											  (DEFAULT, 'Maria', '29165148'),
                                              (DEFAULT, 'Roxana', '56236841');

INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES
			(DEFAULT, 'ir a la playa', 'ire a la playa el fin de semana', 1),
            (DEFAULT, 'ir a la piscina', 'ire a la piscina a mis clases de natacion', 2);

SELECT nombre FROM usuarios;

SELECT nombre, dni, id, id FROM usuarios;

INSERT INTO usuarios (id, nombre, dni) VALUES (DEFAULT, 'Juana', '33265946'), 
											  (DEFAULT, 'Maria', '52698524');
                                              
SELECT * FROM usuarios WHERE nombre='Juana' AND id=2;

-- Visualizar todas las tareas del usuario 1

SELECT descripcion FROM tareas WHERE usuario_id=1;

SELECT * FROM tareas WHERE usuario_id=1 or usuario_id=2;

INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES (DEFAULT, 'Ir a comer', 'Comer un sabroso pollito a la brasa', 1),
                                                                (DEFAULT, 'Comer pizza', 'Comer una sabrosa pizza con peperoni', 1);
                                                                
SELECT * FROM tareas WHERE usuario_id=1 AND titulo LIKE '%comer%';
SELECT * FROM usuarios WHERE nombre LIKE '%o';
SELECT * FROM usuarios WHERE nombre LIKE 'J%';
-- Si queremos hacer la distincion entre mayus y minus entonces antes de poner el texto colocaremos la palabra
-- BINARY y esto sirve para que haga la comparacion a nivel de numeros de caracteres (formato ASCII)
SELECT * FROM usuarios WHERE nombre LIKE BINARY  'J%';

SELECT * FROM usuarios WHERE nombre LIKE '_u%';

SELECT * FROM usuarios WHERE nombre NOT LIKE '__u%';

INSERT INTO tareas (id, titulo, descripcion, usuario_id) VALUES (DEFAULT, 'no hacer nada', 'no hacer nada porque es domingo', null);

SELECT * FROM tareas;
INSERT INTO tareas(id, titulo, descripcion, usuario_id) VALUES (DEFAULT, 'Jugar LOL', 'Jugar con mis amigos pros', 3);
-- Interseccion entre la tabla usuarios con la tabla tareas donde usuarios.id = tareas.usuario_id
SELECT * FROM usuarios INNER JOIN tareas ON usuarios.id = tareas.usuario_id;

SELECT * FROM usuarios LEFT JOIN tareas ON usuarios.id = tareas.usuario_id UNION
SELECT * FROM usuarios RIGHT JOIN tareas ON usuarios.id = tareas.usuario_id;

SELECT CONCAT(titulo, ' ', descripcion) AS 'nombre completo' FROM tareas;

-- 1. Devolver todos los usuarios cuyo dni contengan el numero 5

SELECT * FROM usuarios WHERE dni LIKE '%5%';

-- 2. Devolver todos los usuarios cuyo dni tengan el tercer digito 8

SELECT * FROM usuarios WHERE dni LIKE '__8%';

-- 3. Devolver todas las tareas del usuario 'Eduardo'

SELECT * FROM usuarios INNER JOIN tareas ON usuarios.id = tareas.usuario_id WHERE nombre='Eduardo';

