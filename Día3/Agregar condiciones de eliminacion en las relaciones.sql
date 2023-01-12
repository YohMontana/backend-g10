CREATE DATABASE pruebas;

USE minimarket;
SELECT * FROM categorias;

ALTER TABLE almancen_producto DROP FOREIGN KEY almacen_producto_ibfk_2;

ALTER TABLE almacen_producto ADD FOREIGN KEY relacion_1 (producto_id) REFERENCES productos(id) ON DELETE CASCADE;

