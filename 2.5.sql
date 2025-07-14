-- 1. Obtener todos los usuarios que tengan el rol de "Cliente".
-- Mostramos su nombre de usuario, correo electrónico y el tipo de usuario.
SELECT u.username, u.email, t.nombre_tipo 
FROM usuarios u
INNER JOIN tipo_usuarios t ON u.id_tipo_usuario = t.id_tipo 
WHERE u.id_tipo_usuario = 2;

-- 2. Listar las personas que nacieron después del año 1990.
-- Incluimos su RUT, nombre completo, fecha de nacimiento y nombre de usuario.
SELECT p.rut, p.nombre_completo, p.fecha_nac, u.username 
FROM personas p 
INNER JOIN usuarios u ON u.id_usuario = p.id_usuario 
WHERE fecha_nac >= '1990-01-01';

-- 3. Mostrar los nombres de personas que comienzan con la letra "A".
-- Se muestran también sus correos electrónicos.
SELECT p.nombre_completo, u.email
FROM usuarios u
INNER JOIN personas p ON u.id_usuario = p.id_usuario
WHERE p.nombre_completo LIKE 'A%';

-- 4. Mostrar usuarios cuyo correo electrónico pertenezca al dominio "mail.com".
-- Se incluye su ID de usuario, nombre de usuario, nombre completo y email.
SELECT u.id_usuario, u.username, p.nombre_completo, u.email 
FROM usuarios u 
INNER JOIN personas p ON p.id_usuario = u.id_usuario
WHERE u.email LIKE '%mail.com%';

-- 5. Listar personas que no residen en la ciudad de Valparaíso.
-- Se muestra el nombre de usuario y la ciudad donde viven.
-- (ID 2 corresponde a Valparaíso según la tabla ciudad)
SELECT u.username, c.nombre_ciudad
FROM usuarios u 
INNER JOIN personas p ON p.id_usuario = u.id_usuario
INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad  
WHERE c.id_ciudad != 2;

-- 6. Mostrar usuarios cuyos nombres de usuario tengan más de 7 caracteres.
-- Incluye el ID, nombre de usuario, nombre completo y correo electrónico.
SELECT u.id_usuario, u.username, p.nombre_completo, u.email 
FROM usuarios u 
INNER JOIN personas p ON p.id_usuario = u.id_usuario 
WHERE LENGTH(u.username) > 7;

-- 7. Obtener usuarios nacidos entre los años 1990 y 1995 (inclusive).
-- Se muestra su nombre de usuario y fecha de nacimiento.
SELECT u.username, p.fecha_nac 
FROM usuarios u
INNER JOIN personas p ON p.id_usuario = u.id_usuario 
WHERE p.fecha_nac BETWEEN '1990-01-01' AND '1995-12-31';
