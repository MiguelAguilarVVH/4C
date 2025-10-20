-- SCRIPT 1: CREACIÓN DE BD Y TABLAS CON CHECK

DROP DATABASE IF EXISTS tienda_demo;
CREATE DATABASE tienda_demo;
USE tienda_demo;

-- Tabla de categorías
DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    deleted TINYINT(1) NOT NULL DEFAULT 0 CHECK (deleted IN (0, 1)), -- CHECK agregado
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla de productos
DROP TABLE IF EXISTS producto;
CREATE TABLE producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(120) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0), -- CHECK agregado
    categoria_id INT NOT NULL,
    deleted TINYINT(1) NOT NULL DEFAULT 0 CHECK (deleted IN (0, 1)), -- CHECK agregado
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id) REFERENCES categoria(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
