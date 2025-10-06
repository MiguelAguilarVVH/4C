-- Crear la base de datos
CREATE DATABASE tienda_online;

-- Seleccionar la base de datos para trabajar con ella
USE tienda_online;

-- ==========================================
-- Creación de la tabla de usuarios
-- ==========================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único de usuario
    nombre VARCHAR(100) NOT NULL,               -- Nombre del usuario, no puede ser NULL
    email VARCHAR(100) UNIQUE NOT NULL,         -- Correo electrónico único
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Fecha de creación
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Fecha de última actualización
    eliminado BOOLEAN DEFAULT FALSE,            -- Campo de auditoría para indicar si está eliminado (0: No eliminado, 1: Eliminado)
    CHECK (CHAR_LENGTH(nombre) > 0),            -- Validar que el nombre no esté vacío
    CHECK (email LIKE '%@%')                     -- Validar formato básico de email
);

-- ==========================================
-- Creación de la tabla de productos
-- ==========================================
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único de producto
    nombre_producto VARCHAR(100) NOT NULL,       -- Nombre del producto, no puede ser NULL
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),  -- Asegurar que el precio es mayor que 0
    stock INT DEFAULT 0,                         -- Valor por defecto para el stock
    eliminado BOOLEAN DEFAULT FALSE,             -- Campo de auditoría para indicar si está eliminado
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Fecha de creación
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Fecha de última actualización
    CHECK (CHAR_LENGTH(nombre_producto) > 0)    -- Validar que el nombre del producto no esté vacío
);

-- ==========================================
-- Creación de la tabla de órdenes (ejemplo de relación entre usuarios y productos)
-- ==========================================
CREATE TABLE ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único de la orden
    id_usuario INT,                           -- Relación con el usuario que realiza la orden
    fecha_orden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Fecha en que se realiza la orden
    total DECIMAL(10, 2) CHECK (total > 0),     -- Total de la orden, debe ser mayor a 0
    eliminado BOOLEAN DEFAULT FALSE,           -- Campo de auditoría para indicar si está eliminada
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)  -- Relación con la tabla usuarios
);

-- ==========================================
-- Creación de la tabla de detalles de la orden (productos por orden)
-- ==========================================
CREATE TABLE detalles_orden (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único del detalle
    id_orden INT,                               -- Relación con la orden
    id_producto INT,                            -- Relación con el producto
    cantidad INT CHECK (cantidad > 0),           -- La cantidad de productos debe ser mayor que 0
    precio DECIMAL(10, 2) CHECK (precio > 0),    -- El precio del producto debe ser mayor que 0
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),  -- Relación con la tabla ordenes
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)  -- Relación con la tabla productos
);






-- ==========================================
-- Inserciones de datos
-- ==========================================
-- Insertar usuarios
INSERT INTO usuarios (nombre, email)
VALUES
('Juan Pérez', 'juan.perez@example.com'),
('Ana Gómez', 'ana.gomez@example.com'),
('Luis Martínez', 'luis.martinez@example.com');

-- Insertar productos
INSERT INTO productos (nombre_producto, precio, stock)
VALUES
('Camiseta', 20.50, 100),
('Zapatos', 45.00, 50),
('Gorra', 12.00, 200),
('Pantalón', 35.00, 80);

-- Insertar órdenes
INSERT INTO ordenes (id_usuario, total)
VALUES
(1, 70.50),  -- Orden de Juan Pérez
(2, 55.00),  -- Orden de Ana Gómez
(3, 90.00);  -- Orden de Luis Martínez

-- Insertar detalles de las órdenes
INSERT INTO detalles_orden (id_orden, id_producto, cantidad, precio)
VALUES
(1, 1, 2, 20.50),  -- 2 Camisetas en la orden de Juan Pérez
(1, 2, 1, 45.00),  -- 1 Zapato en la orden de Juan Pérez
(2, 3, 3, 12.00),  -- 3 Gorras en la orden de Ana Gómez
(2, 4, 1, 35.00),  -- 1 Pantalón en la orden de Ana Gómez
(3, 2, 2, 45.00);  -- 2 Zapatos en la orden de Luis Martínez

-- ==========================================
-- Consultas de prueba
-- ==========================================
-- Consultar todos los usuarios
SELECT * FROM usuarios;

-- Consultar usuarios activos (no eliminados)
SELECT * FROM usuarios WHERE eliminado = FALSE;

-- Consultar todos los productos
SELECT * FROM productos;

-- Consultar productos con stock mayor a 0
SELECT * FROM productos WHERE stock > 0;

-- Consultar productos con precio mayor a 30
SELECT * FROM productos WHERE precio > 30;

-- Consultar todas las órdenes
SELECT * FROM ordenes;

-- Consultar detalles de la orden 1
SELECT * FROM detalles_orden WHERE id_orden = 1;

-- Consultar productos de la orden 2
SELECT p.nombre_producto, d.cantidad, d.precio
FROM detalles_orden d
JOIN productos p ON d.id_producto = p.id_producto
WHERE d.id_orden = 2;

-- Consultar todas las órdenes con productos relacionados
SELECT o.id_orden, u.nombre, p.nombre_producto, d.cantidad, d.precio
FROM ordenes o
JOIN usuarios u ON o.id_usuario = u.id_usuario
JOIN detalles_orden d ON o.id_orden = d.id_orden
JOIN productos p ON d.id_producto = p.id_producto;