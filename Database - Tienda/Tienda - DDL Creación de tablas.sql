#DB y tablas

CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS producto (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    CONSTRAINT producto_pk PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    categoria VARCHAR(50) NOT NULL,
    CONSTRAINT empleado_pk PRIMARY KEY (id_empleado)
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    id_empleado INT NOT NULL,
    coste INT NOT NULL,
    ingreso INT NOT NULL,
    CONSTRAINT pedido_pk PRIMARY KEY (id_pedido),
    CONSTRAINT cliente_fk FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT producto_fk FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT empleado_fk FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

#DATOS

USE tienda;

#Clientes

DELIMITER $$
DROP PROCEDURE IF EXISTS poblar_clientes $$
CREATE PROCEDURE poblar_clientes(IN total INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= total DO
        INSERT INTO cliente (nombre, edad)
        VALUES (
            CONCAT(
                ELT(1+FLOOR(RAND()*30),
                    'Alejandro','Lucía','Sofía','Pablo','Martina','Daniel','Hugo','Emma','David','Paula',
                    'Javier','Sara','Adrián','Carmen','Mario','Elena','Iker','Valeria','Rubén','Noa',
                    'Diego','Alicia','Nicolás','Claudia','Mateo','Irene','Marco','Natalia','Sergio','Ana'
                ),
                ' ',
                ELT(1+FLOOR(RAND()*30),
                    'García','Martínez','López','Sánchez','Pérez','Gómez','Martín','Jiménez','Ruiz','Hernández',
                    'Díaz','Moreno','Muñoz','Álvarez','Romero','Alonso','Gutiérrez','Navarro','Torres','Domínguez',
                    'Vázquez','Ramos','Gil','Ramírez','Serrano','Blanco','Molina','Morales','Suárez','Ortega'
                )
            ),
            18 + FLOOR(RAND()*63)  -- Edades 18..80
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL poblar_clientes(500);
DROP PROCEDURE poblar_clientes;


#Productos

DELIMITER $$
DROP PROCEDURE IF EXISTS poblar_productos $$
CREATE PROCEDURE poblar_productos(IN total INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_categoria VARCHAR(50);

    WHILE i <= total DO
        SET v_categoria = ELT(1+FLOOR(RAND()*10),
            'Electrónica','Hogar','Jardín','Deportes','Moda',
            'Alimentación','Juguetes','Oficina','Belleza','Bricolaje'
        );

        INSERT INTO producto (nombre, categoria)
        VALUES (CONCAT('Producto ', LPAD(i,3,'0')), v_categoria);

        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL poblar_productos(50);
DROP PROCEDURE poblar_productos;


#Empleados

DELIMITER $$
DROP PROCEDURE IF EXISTS poblar_empleados $$
CREATE PROCEDURE poblar_empleados(IN total INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= total DO
        INSERT INTO empleado (nombre, categoria)
        VALUES (
            CONCAT(
                ELT(1+FLOOR(RAND()*30),
                    'Laura','Andrés','Marta','Carlos','Eva','Raúl','Patricia','Álvaro','Nuria','Iván',
                    'Beatriz','Óscar','Cristina','Fernando','Isabel','Alba','Héctor','Pilar','Antonio','Silvia',
                    'Manuel','Rocío','Gonzalo','Teresa','Jaime','Lorena','Víctor','Mónica','Rafael','Julia'
                ),
                ' ',
                ELT(1+FLOOR(RAND()*30),
                    'Santos','Crespo','Rey','Méndez','Aguilar','Castro','Delgado','Calvo','Cabrera','Santiago',
                    'Peña','León','Márquez','Cortés','Ibáñez','Vidal','Soler','Pascual','Hidalgo','Benítez',
                    'Arias','Herrera','Montero','Soto','Rivas','Esteban','Parra','Vicente','Campos','Fuentes'
                )
            ),
            ELT(1+FLOOR(RAND()*6), 'Ventas','Caja','Almacén','Reparto','Soporte','Gerencia')
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL poblar_empleados(100);
DROP PROCEDURE poblar_empleados;


#Pedidos

DELIMITER $$
DROP PROCEDURE IF EXISTS poblar_pedidos $$
CREATE PROCEDURE poblar_pedidos(IN total INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE c INT;  -- cliente
    DECLARE p INT;  -- producto
    DECLARE e INT;  -- empleado
    DECLARE v_coste INT;
    DECLARE v_ingreso INT;

    WHILE i <= total DO
        SET c = 1 + FLOOR(RAND()*500);
        SET p = 1 + FLOOR(RAND()*50);
        SET e = 1 + FLOOR(RAND()*100);

        -- Coste entre 5 y 500; Ingreso = Coste + margen [5..300]
        SET v_coste  = 5 + FLOOR(RAND()*496);
        SET v_ingreso = v_coste + 5 + FLOOR(RAND()*300);

        INSERT INTO pedido (id_cliente, id_producto, id_empleado, coste, ingreso)
        VALUES (c, p, e, v_coste, v_ingreso);

        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL poblar_pedidos(800);
DROP PROCEDURE poblar_pedidos;


