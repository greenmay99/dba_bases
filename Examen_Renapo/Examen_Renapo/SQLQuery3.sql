-- 1a Tabla Nuevo Usuario

CREATE TABLE Nuevo_usuario (
	id_nUsuario INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_Usuario VARCHAR(50) NOT NULL,
	ap_Usuario VARCHAR(50) NOT NULL,
	am_Usuario VARCHAR(50) NOT NULL,
	numero_Usuario VARCHAR(10) NOT NULL,
	genero_Usuario VARCHAR(1) NOT NULL,
);

-- 2 Leer los ultimo 3 registros guardadps en la BD

SELECT * FROM Trabajador WHERE id_Trabajador>7;

-- 2a Consultar 4 registros cualesquiera

SELECT * FROM Trabajador WHERE puesto_actual_Trab = 'Ingeniería en Informática'
and id_Trabajador>2;

-- 3 Modificar Tabla Nuevo_usuario

ALTER TABLE Nuevo_usuario
DROP COLUMN edad_usuario;

ALTER TABLE Nuevo_usuario
ADD edad_usuario INT NULL;
SELECT * FROM Nuevo_usuario;

-- 3a Actualizar 9 registros de Empleado

SELECT * FROM Empleado;

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Denisse', 'Perez', 'Trejo', '5589898989', 'M', 'PETD900101MMV', 'Administrador de Base de Datos',
		'2020-04-08');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Estrada', 'Estrada', 'Lechuga', '5647484946', 'M', 'ESLE900101ASD', 'Administrador de Proyectos',
		'2020-04-08');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('José', 'Garcia', 'Hernandez', '5546464646', 'H', 'GAHJ900101SDF', 'Administrador de Base de Datos',
		'2020-04-08');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Angy', 'López', 'Pérez', '5514141416', 'M', 'LOPA040101QWE', 'Analista',
		'2020-04-08');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Angel', 'Diaz', 'Campor', '5503030303', 'H', 'DICA900101KJF', 'Administrador de Base de Datos',
		'2020-04-08');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Roberto', 'Ruvalcaba', 'Buenrostro', '5621212121', 'M', 'RUBR900101MMV', 'Administrador de Base de Datos',
		'2020-04-08');

-- 3a Actualizar registros de Empleado
SELECT * FROM Empleado;

UPDATE Empleado
SET fecha_ingreso = '2020-04-07'
WHERE id_Empleado = 1;

UPDATE Empleado
SET fecha_ingreso = '2020-04-08'
WHERE id_Empleado = 2;

UPDATE Empleado
SET fecha_ingreso = '2020-04-08'
WHERE id_Empleado = 3;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 4;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 5;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 6;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 7;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 8;

UPDATE Empleado
SET fecha_ingreso = '2020-03-08'
WHERE id_Empleado = 9;

-- 4 Eliminar 7 registros de las bd cualesquiera

SELECT * FROM Trabajador;


DELETE FROM Trabajador
WHERE id_Trabajador IN (3, 4, 5, 6, 7, 8, 9);

-- 5 Filtrar 10 registros mujeres entre 16 y 39

-- ingreso de datos a Nuevo_usuario

INSERT INTO Nuevo_usuario (nombre_Usuario, ap_Usuario, am_Usuario, numero_Usuario, genero_Usuario)
VALUES
('Evelyn', 'Acevedo', 'Olvera', '5548484848', 'F'),
('Carlos', 'Cortéz', 'Sanchez ', '5550101011', 'M'),
('Abraham', 'Navarro', 'Islas', '5550101012', 'M'),
('David', 'Mejia', 'Sanchez', '5564646464', 'M'),
('Leslie', 'Molina', 'Quesda', '5550101014', 'F'),
('Vanesa', 'Salinas', 'Flores', '5512121212', 'F'),
('Atenas', 'Perez', 'Cruz', '5584848484', 'F'),
('Manuel', 'Romero', 'Ramirez', '5550101017', 'M'),
('Dafne', 'Casillas', 'Garcia', '5599996666', 'F'),
('Valeria', 'Hernandez', 'Gonzalez', '5501020304', 'F');

INSERT INTO Nuevo_usuario (edad_usuario) 
VALUES (25), (24), (26), (25), (24), (23), (23), (26), (23), (24);

UPDATE Nuevo_usuario
SET edad_usuario = 0  -- O cualquier valor válido como 18, 25, etc.
WHERE edad_usuario IS NULL;



SELECT * FROM Nuevo_usuario;

-- mujeres entre 16 y 39

SELECT * FROM Nuevo_usuario
WHERE genero_Usuario = 'M'
AND edad_usuario BETWEEN 16 AND 39;


-- 6 filtrat 12 registros

INSERT INTO Nuevo_usuario (nombre_Usuario, ap_Usuario, am_Usuario, numero_Usuario, genero_Usuario, edad_usuario)
VALUES
('Berenice', 'Mendoza', 'Reyes', '5548484848', 'M', 24),
('Itzel', 'Perez', 'Cruz ', '5550101011', 'M', 25);

SELECT * FROM Nuevo_usuario;

SELECT * FROM Nuevo_usuario
WHERE genero_Usuario = 'H'
AND edad_usuario BETWEEN 17 AND 40;



