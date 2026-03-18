-- 4 CONSULTAS
-- Consultar qué productos pertenecen a la categoría deportes
SELECT * FROM producto WHERE categoria='Deportes';

-- Consultar los pedidos que hayan costado menos de 50 y ordénalos de menor a mayor coste
SELECT * FROM pedido WHERE coste < 50 ORDER BY coste ASC;

-- Calcular la edad media de los clientes
SELECT AVG(EDAD) AS edad_media FROM cliente;

-- Calcular el beneficio de cada pedido (id_ pedido, beneficio(ingreso-coste))
select * from pedido;
select id_pedido, (ingreso - coste) as beneficio from pedido;

-- Consultar los clientes (nombre) que hayan hecho al menos 1 pedido y ordénalos de más a menos pedidos
select* from pedido;
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos FROM cliente C JOIN pedido P ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre ORDER BY total_pedidos DESC;

-- Calcular el número de pedidos para cada categoría
select pr.categoria, count(p.id_pedido) AS total_pedidos from pedido p 
JOIN producto pr ON p.id_producto = pr.id_producto GROUP BY pr.categoria ORDER BY num_pedidos DESC;

-- Consultar qué productos (nombre) no han sido pedidos todavía
SELECT pr.nombre FROM producto pr LEFT JOIN pedido p ON pr.id_producto = p.id_producto 
WHERE p.id_pedido IS NULL;

-- Consultar qué pedidos (id_ pedido, categoría) han tenido ingresos mayores a 50
Select p.id_pedido,pr.categoria from pedido p 
Join producto pr on p.id_producto = pr.id_producto where p.ingreso >50;

-- Consultar cuánto se ha ingresado por categoría
SELECT producto.categoria, SUM(pedido.ingreso) AS ingreso_total FROM pedido
JOIN producto ON pedido.id_producto = producto.id_producto
GROUP BY producto.categoria ORDER BY ingreso_total DESC;

-- Consultar la categoría que más beneficio ha generado
SELECT pr.categoria, SUM(p.ingreso - p.coste) AS beneficio_total FROM pedido p
JOIN producto pr ON p.id_producto = pr.id_producto
GROUP BY pr.categoria ORDER BY beneficio_total DESC LIMIT 1;

-- Haz una consulta que te devuelva una tabla con todos los clientes y un campo extra “adulto” que indique ‘sí’ o ‘no’ según el cliente tenga menos de 18 o 18 o más
SELECT 
    id_cliente,
    nombre,
    edad,
    CASE 
        WHEN edad >= 18 THEN 'sí'
        ELSE 'no'
    END AS adulto
FROM cliente;

-- Haz una consulta que te devuelva los empleados y un campo extra “objetivo cumplido” que indique ‘sí’ o ´no’ según haya intervenido o no en al menos 10 pedidos
SELECT 
    e.id_empleado,
    e.nombre,
    COUNT(p.id_pedido) AS num_pedidos,
    CASE 
        WHEN COUNT(p.id_pedido) >= 10 THEN 'sí'
        ELSE 'no'
    END AS `objetivo cumplido`
FROM empleado e
LEFT JOIN pedido p ON e.id_empleado = p.id_empleado
GROUP BY e.id_empleado, e.nombre
ORDER BY num_pedidos DESC;

-- Haz una consulta que te devuelva los productos agrupados por categoría y un campo extra “objetivo beneficio” 
-- que indique ‘sí’ o ‘no’ según haya o no un beneficio de al menos 1000 en el total de la categoría
SELECT 
    pr.categoria,
    COUNT(pr.id_producto) AS num_productos,
    SUM(p.ingreso - p.coste) AS beneficio_total,
    CASE 
        WHEN SUM(p.ingreso - p.coste) >= 1000 THEN 'sí'
        ELSE 'no'
    END AS `objetivo beneficio`
FROM producto pr
LEFT JOIN pedido p ON pr.id_producto = p.id_producto
GROUP BY pr.categoria
ORDER BY beneficio_total DESC;