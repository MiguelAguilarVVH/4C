-- SCRIPT 2: INSERCIÓN DE DATOS Y CONSULTAS SIMPLES

USE tienda_demo;

-- Inserciones directas en la tabla categoria
INSERT INTO categoria(nombre) VALUES
('Bebidas'), 
('Snacks'), 
('Limpieza');

-- Inserciones directas en la tabla producto
INSERT INTO producto(nombre, precio, categoria_id) VALUES
('Agua 1.5L', 900, 1),
('Galletas X', 1200, 2),
('Detergente', 2500, 3);

-- Consultas simples

-- Ver todas las categorías
SELECT * FROM categoria;

-- Ver todos los productos
SELECT * FROM producto;

-- Ver productos activos con su categoría
SELECT
    p.id, p.nombre AS producto, p.precio,
    c.nombre AS categoria
FROM producto p
INNER JOIN categoria c ON p.categoria_id = c.id
WHERE p.deleted = 0
ORDER BY p.nombre;
