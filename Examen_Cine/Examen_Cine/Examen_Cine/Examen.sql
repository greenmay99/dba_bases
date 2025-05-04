--- c) vistas de los ultimos 3 registros Cliente, Empleado, Proveedor 
use Cine;

--- Vista Cliente ----------
CREATE VIEW VistaCliente AS
SELECT TOP 3 *
FROM Cliente
ORDER BY id_cliente DESC;

SELECT * FROM VistaCliente;

--- Vista Empleado ----------
CREATE VIEW VistaEmpleado AS
SELECT TOP 3 *
FROM Empleado
ORDER BY id_empleado DESC;

SELECT * FROM VistaEmpleado;

--- Vista Proveedor ----------
CREATE VIEW VistaProveedor AS
SELECT TOP 3 *
FROM Proveedor
ORDER BY id_proveedor DESC;

SELECT * FROM VistaProveedor;


--- d) tabla Reporte1

CREATE TABLE Reporte1 (
    id_reporte1 INT IDENTITY(1,1) PRIMARY KEY,
    nombre_reporte1 VARCHAR(50),
    correo_reporte1 VARCHAR(50),
	telefono_reporte1 VARCHAR(10),
    tipo_reporte1 VARCHAR(20) -- 'Cliente', 'Empleado', o 'Proveedor'
);

select * from Reporte1;

---5 registros por cada

-- Clientes 
INSERT INTO Reporte1 (nombre_reporte1, correo_reporte1, telefono_reporte1, tipo_reporte1)
SELECT TOP 5 nombre_cliente, correo_cliente, telefono_cliente, 'Cliente'
FROM Cliente
ORDER BY NEWID();

-- Empleados
INSERT INTO Reporte1 (nombre_reporte1, correo_reporte1, telefono_reporte1, tipo_reporte1)
SELECT TOP 5 nombre_empleado, correo_empleado, telefono_empleado, 'Empleado'
FROM Empleado
ORDER BY NEWID();

-- Proveedores 
INSERT INTO Reporte1 (nombre_reporte1, correo_reporte1, telefono_reporte1, tipo_reporte1)
SELECT TOP 5 nombre_proveedor, correo_proveedor, telefono_proveedor, 'Proveedor'
FROM Proveedor
ORDER BY NEWID();

---- e) tabla ListaDomicilio

CREATE TABLE ListaDomicilio (
    id_domicilio INT IDENTITY(1,1) PRIMARY KEY,
    nombre_domicilio VARCHAR(50),
    calle_domicilio VARCHAR(50),
    numero_domicilio VARCHAR(10),
    colonia_domicilio VARCHAR(50),
    ciudad_domicilio VARCHAR(50),
    estado_domicilio VARCHAR(50),
    cp_domicilio VARCHAR(10),
    tipo_domicilio VARCHAR(20) -- 'Cliente', 'Empleado', 'Proveedor'
);

select * from ListaDomicilio;

INSERT INTO ListaDomicilio (nombre_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, estado_domicilio, cp_domicilio, tipo_domicilio)
SELECT TOP 5 nombre_cliente, calle_cliente, numero_cliente, colonia_cliente, ciudad_cliente, estado_cliente, cp_cliente, 'Cliente'
FROM Cliente
ORDER BY id_cliente DESC;


INSERT INTO ListaDomicilio (nombre_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, estado_domicilio, cp_domicilio, tipo_domicilio)
SELECT TOP 5 nombre_empleado, calle_empleado, numero_empleado, colonia_empleado, ciudad_empleado, estado_empleado, cp_empleado, 'Empleado'
FROM Empleado
ORDER BY id_empleado DESC;


INSERT INTO ListaDomicilio (nombre_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, estado_domicilio, cp_domicilio, tipo_domicilio)
SELECT TOP 5 nombre_proveedor, calle_proveedor, numero_proveedor, colonia_proveedor, ciudad_proveedor, estado_proveedor, cp_proveedor, 'Proveedor'
FROM Proveedor
ORDER BY id_proveedor DESC;


---- f) tabla "NuevoRegistro"

CREATE TABLE NuevoRegistro (
    id_nuevoregistro INT IDENTITY(1,1) PRIMARY KEY,
    nombre_nuevoregistro VARCHAR(50),
    correo_nuevoregistro VARCHAR(50),
    telefono_nuevoregistro VARCHAR(10),
    calle_nuevoregistro VARCHAR(50),
    numero_nuevoregistro VARCHAR(10),
    colonia_nuevoregistro VARCHAR(50),
    ciudad_nuevoregistro VARCHAR(50),
    estado_nuevoregistro VARCHAR(50),
    cp_nuevoregistro VARCHAR(10),
    tipo_nuevoregistro VARCHAR(20)
);

select * from NuevoRegistro;

INSERT INTO NuevoRegistro (nombre_nuevoregistro, correo_nuevoregistro, telefono_nuevoregistro, 
calle_nuevoregistro, numero_nuevoregistro, colonia_nuevoregistro, ciudad_nuevoregistro, 
estado_nuevoregistro, cp_nuevoregistro, tipo_nuevoregistro)
SELECT 
    r.nombre_reporte1,
    r.correo_reporte1,
    r.telefono_reporte1,
    l.calle_domicilio,
    l.numero_domicilio,
    l.colonia_domicilio,
    l.ciudad_domicilio,
    l.estado_domicilio,
    l.cp_domicilio,
    r.tipo_reporte1
FROM Reporte1 r
INNER JOIN ListaDomicilio l
    ON r.nombre_reporte1 = l.nombre_domicilio
    AND r.tipo_reporte1 = l.tipo_domicilio;

---- g) Indice NuevoRegistro

CREATE INDEX IndiceNuevoRegistro
ON NuevoRegistro(nombre_nuevoregistro, tipo_nuevoregistro);


--- h) vistas Report1, ListaDomicilio, NuevoRegistro

CREATE VIEW VistaReporte1 AS
SELECT * FROM Reporte1;

SELECT * FROM VistaReporte1;
select * from Reporte1;


CREATE VIEW VistaListaDomicilio AS
SELECT * FROM ListaDomicilio;

SELECT * FROM VistaListaDomicilio;


CREATE VIEW VistaNuevoRegistro AS
SELECT * FROM NuevoRegistro;

SELECT * FROM VistaListaDomicilio;

--- i) tabla Registro2

-- agregar columna de edad para cada tabla
ALTER TABLE Cliente ADD edad_cliente INT;
ALTER TABLE Empleado ADD edad_empleado INT;
ALTER TABLE Proveedor ADD edad_proveedor VARCHAR(10);

-- llenado de datos de la columna 'edad'

UPDATE Cliente
SET edad_cliente = FLOOR(RAND(CHECKSUM(NEWID())) * 21) + 20;

select nombre_cliente, edad_cliente from Cliente;

UPDATE Empleado
SET edad_empleado = FLOOR(RAND(CHECKSUM(NEWID())) * 21) + 20;

select nombre_empleado, edad_empleado from Empleado;

UPDATE Proveedor
SET edad_proveedor = 'No aplica';

select nombre_proveedor, edad_proveedor from Proveedor;


--- crar tabla Registro2

CREATE TABLE Registro2 (
    id_registro2 INT IDENTITY(1,1) PRIMARY KEY,
    nombre_registro2 VARCHAR(50),
    edad_registro2 INT,
	genero_registro2 VARCHAR(1),
    calle_registro2 VARCHAR(50),
    numero_registro2 VARCHAR(10),
    colonia_registro2 VARCHAR(50),
    ciudad_registro2 VARCHAR(50),
    estado_registro2 VARCHAR(50),
    cp_registro2 VARCHAR(5),
    tipo_registro2 VARCHAR(20) -- 'Cliente', 'Empleado', o 'Proveedor'
);



-- llaves foraneas a ListaDomicilio
ALTER TABLE ListaDomicilio
ADD id_cliente_domicilio INT NULL,
    id_empleado_domicilio INT NULL,
    id_proveedor_domicilio INT NULL;

-- insert de id respectivamente

UPDATE ListaDomicilio
SET id_cliente_domicilio = 20
WHERE id_domicilio = 1;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 19
WHERE id_domicilio = 2;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 18
WHERE id_domicilio = 3;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 17
WHERE id_domicilio = 4;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 16
WHERE id_domicilio = 5;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 15
WHERE id_domicilio = 6;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 14
WHERE id_domicilio = 7;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 13
WHERE id_domicilio = 8;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 12
WHERE id_domicilio = 9;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 11
WHERE id_domicilio = 10;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 10
WHERE id_domicilio = 11;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 9
WHERE id_domicilio = 12;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 8
WHERE id_domicilio = 13;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 7
WHERE id_domicilio = 14;

UPDATE ListaDomicilio
SET id_cliente_domicilio = 6
WHERE id_domicilio = 15;

select * from Proveedor;

-- Insertar registros de Cliente

-- Agregar la llave foránea para Cliente
ALTER TABLE ListaDomicilio
ADD CONSTRAINT FK_id_cliente_domicilio
FOREIGN KEY (id_cliente_domicilio) REFERENCES Cliente(id_cliente);


INSERT INTO Registro2 (nombre_registro2, edad_registro2, genero_registro2, calle_registro2, 
numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2, tipo_registro2)
SELECT c.nombre_cliente, c.edad_cliente, c.genero_cliente, d.calle_domicilio, d.numero_domicilio, 
d.colonia_domicilio, d.ciudad_domicilio, d.estado_domicilio, d.cp_domicilio, 'Cliente'
FROM Cliente c
JOIN (
    SELECT id_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, 
	estado_domicilio, cp_domicilio
    FROM ListaDomicilio
    WHERE tipo_domicilio = 'Cliente'
) d ON c.id_cliente = d.id_domicilio
WHERE c.edad_cliente BETWEEN 25 AND 31;

select * from Empleado;
select * from Registro2;

-- aqui me quedé 04/05/25

-- Insertar registros de Empleado
INSERT INTO Registro2 (nombre_registro2, edad_registro2, genero_registro2, calle_registro2, 
numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2, tipo_registro2)
SELECT e.nombre_empleado, e.edad_empleado, e.genero_empleado, d.calle_domicilio, d.numero_domicilio, 
d.colonia_domicilio, d.ciudad_domicilio, d.estado_domicilio, d.cp_domicilio, 'Empleado'
FROM Empleado e
JOIN (
    SELECT id_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, 
	estado_domicilio, cp_domicilio
    FROM ListaDomicilio
    WHERE tipo_domicilio = 'Empleado'
) d ON e.id_empleado = d.id_domicilio
WHERE e.edad_empleado BETWEEN 25 AND 31;



-- Insertar registros de Proveedor
INSERT INTO Registro2 (nombre_registro2, edad_registro2, genero_registro2, calle_registro2, 
numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2, tipo_registro2)
SELECT p.nombre_proveedor, NULL AS edad_proveedor, 'N' AS genero_proveedor, d.calle_domicilio, 
d.numero_domicilio, d.colonia_domicilio, d.ciudad_domicilio, d.estado_domicilio, d.cp_domicilio, 'Proveedor'
FROM Proveedor p
JOIN (
    SELECT id_domicilio, calle_domicilio, numero_domicilio, colonia_domicilio, ciudad_domicilio, 
	estado_domicilio, cp_domicilio
    FROM ListaDomicilio
    WHERE tipo_domicilio = 'Proveedor'
) d ON p.id_proveedor = d.id_domicilio;


--- copia tabla Registro2

SELECT *
INTO Registro2_Copia
FROM Registro2;

select* from Registro2;