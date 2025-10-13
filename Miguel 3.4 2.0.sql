-- ==============================================================
-- BASE DE DATOS: Reciclaje
-- ==============================================================

CREATE DATABASE IF NOT EXISTS reciclaje_normalizado;
USE reciclaje_normalizado;

-- ==============================================================
-- 1. ROLES
-- ==============================================================

CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(150)
);

-- ==============================================================
-- 2. USUARIOS
-- ==============================================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    id_rol INT,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- ==============================================================
-- 3. ZONAS
-- ==============================================================

CREATE TABLE zonas (
    id_zona INT AUTO_INCREMENT PRIMARY KEY,
    nombre_zona VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    comuna VARCHAR(100),
    deleted BOOLEAN DEFAULT FALSE
);

-- ==============================================================
-- 4. PUNTOS DE RECOLECCIÓN
-- ==============================================================

CREATE TABLE puntos_recoleccion (
    id_punto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_punto VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    id_zona INT,
    capacidad_kg DECIMAL(10,2) DEFAULT 0.00,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona)
);

-- ==============================================================
-- 5. MATERIALES
-- ==============================================================

CREATE TABLE materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre_material VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor_kg DECIMAL(10,2) DEFAULT 0.00,
    deleted BOOLEAN DEFAULT FALSE
);

-- ==============================================================
-- 6. RECOLECCIONES Y DETALLES
-- ==============================================================

CREATE TABLE recolecciones (
    id_recoleccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_punto INT,
    fecha_recoleccion DATE,
    total_peso DECIMAL(10,2) DEFAULT 0.00,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_punto) REFERENCES puntos_recoleccion(id_punto)
);

CREATE TABLE detalles_recoleccion (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_recoleccion INT,
    id_material INT,
    cantidad_kg DECIMAL(10,2) NOT NULL,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_recoleccion) REFERENCES recolecciones(id_recoleccion),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);

-- ==============================================================
-- 7. TRANSPORTISTAS Y VEHÍCULOS
-- ==============================================================

CREATE TABLE transportistas (
    id_transportista INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    licencia VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    patente VARCHAR(20) UNIQUE NOT NULL,
    tipo ENUM('Camión','Camioneta','Triciclo','Otro') DEFAULT 'Camioneta',
    capacidad_kg DECIMAL(10,2) DEFAULT 0.00,
    id_transportista INT,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_transportista) REFERENCES transportistas(id_transportista)
);

-- ==============================================================
-- 8. PAGOS
-- ==============================================================

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_recoleccion INT,
    monto_total DECIMAL(10,2),
    metodo_pago ENUM('Efectivo','Transferencia','Crédito') DEFAULT 'Efectivo',
    fecha_pago DATE,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_recoleccion) REFERENCES recolecciones(id_recoleccion)
);

-- ==============================================================
-- INSERT DE DATOS REPRESENTATIVOS
-- ==============================================================

-- Roles
INSERT INTO roles (nombre_rol, descripcion) VALUES
('Administrador','Gestiona todo el sistema'),
('Recolector','Encargado de recolectar materiales'),
('Centro','Centro de acopio');

-- Usuarios
INSERT INTO usuarios (nombre,email,id_rol,telefono) VALUES
('Ana Pérez','ana@example.com',1,'+56911111111'),
('Juan Torres','juan@example.com',2,'+56922222222'),
('Centro Verde','centroverde@example.com',3,'+56933333333');

-- Zonas
INSERT INTO zonas (nombre_zona,region,comuna) VALUES
('Zona Norte','Antofagasta','Calama'),
('Zona Centro','RM','Santiago');

-- Puntos de recolección
INSERT INTO puntos_recoleccion (nombre_punto,direccion,id_zona,capacidad_kg) VALUES
('EcoPlaza','Av. Verde 123',2,1500),
('ReciclaNorte','Ruta 5 km 8',1,2000);

-- Materiales
INSERT INTO materiales (nombre_material,categoria,tipo,valor_kg) VALUES
('Botellas PET','Plástico','Duro',150),
('Latas de Aluminio','Metal','Duro',300),
('Vidrio Transparente','Vidrio','Duro',100);

-- Transportistas
INSERT INTO transportistas (nombre,licencia,telefono) VALUES
('Carlos Muñoz','LIC-1234','+56944444444');

-- Vehículos
INSERT INTO vehiculos (patente,tipo,capacidad_kg,id_transportista) VALUES
('ABCD-11','Camión',3000,1);

-- Recolecciones
INSERT INTO recolecciones (id_usuario,id_punto,fecha_recoleccion,total_peso) VALUES
(2,1,'2025-10-10',25.5),
(2,2,'2025-10-11',30.0);

-- Detalles de recolección
INSERT INTO detalles_recoleccion (id_recoleccion,id_material,cantidad_kg) VALUES
(1,1,10.5),
(1,2,15.0),
(2,3,30.0);

-- Pagos
INSERT INTO pagos (id_recoleccion,monto_total,metodo_pago,fecha_pago) VALUES
(1,5000,'Transferencia','2025-10-10'),
(2,3000,'Efectivo','2025-10-11');

-- ==============================================================
-- CONSULTAS DE VERIFICACIÓN Y JOIN
-- ==============================================================

-- Mostrar todos los registros
SELECT * FROM usuarios;
SELECT * FROM materiales;
SELECT * FROM recolecciones;
SELECT * FROM detalles_recoleccion;
SELECT * FROM pagos;

-- Mostrar registros activos
SELECT * FROM usuarios WHERE deleted = 0;
SELECT * FROM materiales WHERE deleted = 0;

-- JOIN: usuario con sus recolecciones y pagos
SELECT u.nombre AS Usuario, r.fecha_recoleccion, r.total_peso, p.monto_total, p.metodo_pago
FROM usuarios u
JOIN recolecciones r ON u.id_usuario = r.id_usuario
LEFT JOIN pagos p ON r.id_recoleccion = p.id_recoleccion;

-- JOIN: materiales recolectados por punto
SELECT pr.nombre_punto, m.nombre_material, dr.cantidad_kg
FROM detalles_recoleccion dr
JOIN materiales m ON dr.id_material = m.id_material
JOIN recolecciones r ON dr.id_recoleccion = r.id_recoleccion
JOIN puntos_recoleccion pr ON r.id_punto = pr.id_punto;

-- JOIN: total de peso por zona
SELECT z.nombre_zona, SUM(r.total_peso) AS total_peso_zona
FROM recolecciones r
JOIN puntos_recoleccion pr ON r.id_punto = pr.id_punto
JOIN zonas z ON pr.id_zona = z.id_zona
GROUP BY z.nombre_zona;
