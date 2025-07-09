-- Creación de la base de datos
CREATE DATABASE ejemploSelect;
USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    nombre_tipo VARCHAR(50) NOT NULL CHECK (LENGTH(nombre_tipo) >= 3), -- CHECK: exige que el nombre tenga al menos 3 caracteres
    descripcion_tipo VARCHAR(200) NOT NULL,
    created_by INT,
    updated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: usuarios (se añade campo created_at con valor por defecto)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    contrasenna VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'), -- CHECK: exige que el email contenga un '@' y un punto
    created_by INT,
    updated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT FALSE,
    id_tipo_usuario INT,
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo)
);

-- Tabla: ciudad (nueva)
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL,
    region VARCHAR(100) CHECK (region IN ('Metropolitana', 'Valparaíso', 'Biobío', 'Los Lagos', 'Coquimbo')), -- CHECK: solo permite regiones específicas
    created_by INT,
    updated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT FALSE
);

-- Tabla: personas (relacionada con usuarios y ciudad)
CREATE TABLE personas (
    rut VARCHAR(13) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nac DATE CHECK (fecha_nac >= '1900-01-01'), -- CHECK: solo permite fechas de nacimiento desde 1900-01-01 en adelante
    created_by INT,
    updated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT FALSE,
    id_usuario INT,
    id_ciudad INT,
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);


USE ejemploselect;

-- 1.-  Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
SELECT u.username, u.email, t.nombre_tipo
FROM usuarios u, tipo_usuarios t
WHERE u.id_tipo_usuario = 2
AND u.id_tipo_usuario = t.id_tipo;

-- 2.-  Mostrar Personas nacidas despues del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username.
SELECT p.nombre_completo, p.fecha_nac, u.username
FROM personas p, usuarios u
WHERE p.fecha_nac > '1990-12-31'
AND p.id_usuario = u.id_usuario;

-- 3.- Seleccionar nombres de personas que comiencen con la 
-- letra A - Seleccionar nombre y correo la persona.
SELECT p.nombre_completo, u.email
FROM personas p, usuarios u
WHERE p.nombre_completo LIKE 'A%'
AND p.id_usuario = u.id_usuario;

-- 4.- Mostrar usuarios cuyos dominios de correo sean
-- mail.commit LIKE '%mail.com%'
SELECT u.username, u.email
FROM usuarios u
WHERE u.email LIKE '%mail.com%';

-- 5.- Mostrar todas las personas que no viven en 
 -- Valparaiso y su usuario + ciudad.
 -- select * from ciudad; -- ID 2 VALPARAISO
SELECT p.nombre_completo, c.region, u.username, c.nombre_ciudad
FROM personas p, ciudad c,usuarios u
WHERE p.id_ciudad = c.id_ciudad
AND p.id_usuario = u.id_usuario
AND c.id_ciudad != 2;

-- 6.- Mostrar usuarios que contengan más de 7 
-- carácteres de longitud.
SELECT u.username
FROM usuarios u
WHERE LENGTH(username) > 7;

-- 7.- Mostrar username de personas nacidas entre
-- 1990 y 1995
SELECT u.username, p.fecha_nac
FROM usuarios u, personas p
WHERE fecha_nac BETWEEN '1990-01-01' AND '1995-12-31'
AND u.id_usuario = p.id_usuario;