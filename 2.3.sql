-- Muestra los empleados que no estan eliminados 
SELECT * FROM empleados
WHERE eliminado = FALSE;

SELECT e.* FROM empleados e
JOIN roles r ON e.rol_id = r.id
WHERE r.nombre_rol = 'Administrador';

SELECT * FROM empleados
WHERE nombre_completo LIKE 'C%';

SELECT * FROM empleados
WHERE creado_el BETWEEN '2025-01-01' AND '2025-04-30';

SELECT * FROM empleados
WHERE eliminado = FALSE AND creado_por = 1;

SELECT * FROM articulos
WHERE precio_unitario > 100000;

SELECT p.* FROM pedidos p
JOIN empleados e ON p.empleado_id = e.id
WHERE e.nombre_completo = 'Marta Soto';

SELECT * FROM articulos
WHERE nombre_articulo LIKE '%Notebook%';

SELECT * FROM detalle_pedidos
WHERE cantidad >= 10;