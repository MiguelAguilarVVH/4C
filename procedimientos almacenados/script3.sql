-- SCRIPT 3: PROCEDIMIENTOS ALMACENADOS

USE tienda_demo;

-- =========================
-- PRODUCTO
-- =========================

-- Insertar producto
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

-- Borrado lógico producto
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

-- Listar productos activos
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

-- Listar todos los productos (activos y borrados)
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

-- =========================
-- CATEGORÍA
-- =========================

-- Insertar categoría
DELIMITER //
CREATE PROCEDURE sp_categoria_insertar(
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO categoria(nombre, deleted)
    VALUES (p_nombre, 0);
END//
DELIMITER ;

-- Borrado lógico categoría
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

-- Listar categorías activas
DELIMITER //
CREATE PROCEDURE sp_categoria_listar_activas()
BEGIN
    SELECT id, nombre
    FROM categoria
    WHERE deleted = 0
    ORDER BY nombre;
END//
DELIMITER ;

-- ✅ FALTANTE: Listar todas las categorías (activas y borradas)
DELIMITER //
CREATE PROCEDURE sp_categoria_listar_todo()
BEGIN
    SELECT id, nombre, deleted, created_at
    FROM categoria
    ORDER BY nombre;
END//
DELIMITER ;
