-- 1. Insertar 2 clientes, 1 pedido, 1 producto y 1 empleado

INSERT INTO cliente (nombre, edad) VALUES ('Isidoro Gordillo',34),('Beatriz Rios', 31);

INSERT INTO producto (nombre, categoria) VALUES ('PS5','Juguetes');

INSERT INTO empleado (nombre, categoria) VALUES ('Ramiro','Almacén');

INSERT INTO pedido (id_cliente, id_producto, id_empleado, coste, ingreso) VALUES (1, 1, 1, 50, 80);

-- 2. Modificar 1 cliente, 1 empleado y 1 producto

select * from producto;

UPDATE producto SET 
nombre= 'Don Pérignon Rose Gold', 
categoria='Hogar'
WHERE ID_producto =1;

-- 3.Borrar 1 cliente, 1 producto y 1 un pedido
Select * from producto;

DELETE FROM pedido WHERE id_cliente=3;
DELETE FROM cliente WHERE id_cliente=3;
DELETE FROM producto WHERE id_producto=52;