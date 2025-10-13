/* ===========================================
1) CREACIÓN DE LA BASE DE DATOS
=========================================== */
DROP DATABASE IF EXISTS tienda_demo;
CREATE DATABASE tienda_demo;
USE tienda_demo;

-- Creamos una base de datos nueva llamada 'tienda_demo'
-- Nos aseguramos de eliminarla antes si ya existía

/* ===========================================
2) CREACIÓN DE TABLAS: categoria y producto
=========================================== */
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS categoria;

-- Tabla de categorías (por ejemplo: Bebidas, Snacks...)
CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    deleted TINYINT(1) NOT NULL DEFAULT 0, -- 0 = activa, 1 = borrada lógicamente
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla de productos asociados a una categoría
CREATE TABLE producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria_id INT NOT NULL,
    deleted TINYINT(1) NOT NULL DEFAULT 0, -- 0 = activo, 1 = borrado
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id) REFERENCES categoria(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

/* ===========================================
3) INSERCIÓN DE CATEGORÍAS INICIALES
=========================================== */
-- Agregamos algunas categorías de ejemplo
INSERT INTO categoria(nombre) VALUES
('Bebidas'), 
('Snacks'), 
('Limpieza');

/* ===========================================
4) PROCEDIMIENTOS PARA PRODUCTOS
=========================================== */

-- 4.1 Insertar un producto
DELIMITER //
CREATE PROCEDURE sp_producto_insertar(
    IN p_nombre VARCHAR(120),
    IN p_precio DECIMAL(10,2),
    IN p_categoria_id INT
)
BEGIN
    INSERT INTO producto(nombre, precio, categoria_id, deleted)
    VALUES (p_nombre, p_precio, p_categoria_id, 0);
END//
DELIMITER ;

-- 4.2 Listar productos activos con su categoría (JOIN)
DELIMITER //
CREATE PROCEDURE sp_producto_listar_activos()
BEGIN
    SELECT
        p.id,
        p.nombre AS producto,
        p.precio,
        c.nombre AS categoria
    FROM producto p
    INNER JOIN categoria c ON p.categoria_id = c.id
    WHERE p.deleted = 0
    ORDER BY p.nombre;
END//
DELIMITER ;

-- 4.3 Borrado lógico de producto (no lo elimina físicamente, solo lo oculta)
DELIMITER //
CREATE PROCEDURE sp_producto_borrado_logico(
    IN p_id INT
)
BEGIN
    UPDATE producto
    SET deleted = 1
    WHERE id = p_id;
END//
DELIMITER ;

-- 4.4 Listar TODOS los productos (activos y borrados)
DELIMITER //
CREATE PROCEDURE sp_producto_listar_todo()
BEGIN
    SELECT
        p.id,
        p.nombre AS producto,
        p.precio,
        c.nombre AS categoria,
        p.deleted
    FROM producto p
    INNER JOIN categoria c ON p.categoria_id = c.id
    ORDER BY p.nombre;
END//
DELIMITER ;

/* ===========================================
5) PRUEBAS PARA PRODUCTOS
=========================================== */

-- Insertamos productos de prueba usando el procedimiento
CALL sp_producto_insertar('Agua 1.5L', 900, 1);      -- Categoría: Bebidas
CALL sp_producto_insertar('Galletas X', 1200, 2);    -- Categoría: Snacks
CALL sp_producto_insertar('Detergente', 2500, 3);    -- Categoría: Limpieza

-- 🔍 Ver todos los productos en la tabla
SELECT * FROM producto;

-- 🔍 Ver solo los productos activos
SELECT * FROM producto WHERE deleted = 0;

-- 🔍 Ver productos activos junto a su categoría (JOIN)
SELECT
    p.id, p.nombre AS producto, p.precio,
    c.nombre AS categoria
FROM producto p
INNER JOIN categoria c ON p.categoria_id = c.id
WHERE p.deleted = 0
ORDER BY p.nombre;

-- ✅ Probar procedimientos de listado
CALL sp_producto_listar_activos(); -- muestra solo activos
CALL sp_producto_listar_todo();    -- muestra todos, incluyendo borrados

-- ❌ Borrado lógico: ocultamos el producto con ID 1
CALL sp_producto_borrado_logico(1);

-- 🔁 Verificar que el producto con ID 1 ya no aparece en activos
CALL sp_producto_listar_activos(); -- no debería mostrar 'Agua 1.5L'
CALL sp_producto_listar_todo();    -- sí lo muestra con deleted = 1

/* ===========================================
6) PROCEDIMIENTOS PARA CATEGORÍAS
=========================================== */

-- 6.1 Insertar una nueva categoría
DELIMITER //
CREATE PROCEDURE sp_categoria_insertar(
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO categoria(nombre, deleted)
    VALUES (p_nombre, 0);
END//
DELIMITER ;

-- 6.2 Listar solo categorías activas
DELIMITER //
CREATE PROCEDURE sp_categoria_listar_activas()
BEGIN
    SELECT id, nombre
    FROM categoria
    WHERE deleted = 0
    ORDER BY nombre;
END//
DELIMITER ;

-- 6.3 Borrado lógico de categoría
DELIMITER //
CREATE PROCEDURE sp_categoria_borrado_logico(
    IN p_id INT
)
BEGIN
    UPDATE categoria
    SET deleted = 1
    WHERE id = p_id;
END//
DELIMITER ;

/* ===========================================
7) PRUEBAS PARA CATEGORÍAS
=========================================== */

-- Insertamos nuevas categorías usando el procedimiento
CALL sp_categoria_insertar('Panadería');
CALL sp_categoria_insertar('Lácteos');

-- 🔍 Ver todas las categorías activas
CALL sp_categoria_listar_activas();

-- ❌ Borramos lógicamente la categoría con ID 4 (Panadería)
CALL sp_categoria_borrado_logico(4);

-- 🔁 Verificar que ya no aparece en activas
CALL sp_categoria_listar_activas();

-- 🔍 Ver todas las categorías, incluyendo las borradas
SELECT * FROM categoria;

