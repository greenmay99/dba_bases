--- Tabla Trabajador -----------

INSERT INTO Trabajador (nombre_Trab, ap_Trab, am_Trab, CURP_Trab, puesto_actual_Trab)
VALUES ('Mina', 'Myoi', 'Martinez', 'MYMM900101MDFRNT04', 'Ingeniería en Informática');

INSERT INTO Trabajador (nombre_Trab, ap_Trab, am_Trab, CURP_Trab, puesto_actual_Trab)
VALUES ('Rosé', 'Park', 'Morales', 'PAMR970211MDRRS05', 'Ingeniería en Sistemas');

DBCC CHECKIDENT ('Trabajador', RESEED, 0); --reiniciar el id a 1
DELETE FROM Trabajador
WHERE id_Trabajador=2;

SELECT * FROM Trabajador;


--- Tabla Representante -----------

INSERT INTO Representante (nombre_Rep, ap_Rep, am_Rep, estado_civil, puesto_laboral_actual, ingreso_mensual,
grado_academico, calle_Rep,	num_Rep, colonia_Rep, ciudad_ReP, CP_Rep)
VALUES ('Jun', 'Park', 'López', 'Casado', 'Director de marketing', 25000.00, 'Licenciatura', 
        'Av. Tesoro', '120', 'Camarones', 'Ciudad de México', '12001');

INSERT INTO Representante (nombre_Rep, ap_Rep, am_Rep, estado_civil, puesto_laboral_actual, ingreso_mensual,
grado_academico, calle_Rep,	num_Rep, colonia_Rep, ciudad_ReP, CP_Rep)
VALUES ('Justin', 'Kanemoto', 'Pérez', 'Soltero', 'Auditor de ventas', 35000.00, 'Licenciatura', 
        'Av. Grafito', '102', 'Naranja', 'Ciudad de México', '15150');

DBCC CHECKIDENT ('Representante', RESEED, 0);
DELETE FROM Representante
WHERE id_Representante=4;
SELECT * FROM Representante;


--- Tabla Empleado -----------

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('David', 'Kim', 'Gómez', '5504040404', 'M', 'KIGD900101MMV', 'Administrador de Base de Datos',
		'2020-04-01');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Travis', 'Watanabe', 'Montes', '5503030303', 'M', 'WAMT900101SDD', 'Analista de Datos',
		'2020-07-01');

INSERT INTO Empleado (nombre_Empleado, ap_Empleado, am_Empleado, numero_Empleado, genero_Empleado,
RFC_Empleado, puesto_Empleado, fecha_ingreso)
VALUES ('Sam', 'Kim', 'Torres', '5514141414', 'M', 'KITS041204FFF', 'Consultor técnico',
		'2023-02-01');

DBCC CHECKIDENT ('Empleado', RESEED, 0);
DELETE FROM Empleado
WHERE id_Empleado=1;
SELECT * FROM Empleado;


--- Tabla Vivienda -----------

INSERT INTO Vivienda (calle_Viv, num_Viv, colonia_Viv, ciudad_Viv, CP_Viv, total_miembros_habitan,
id_Rep_Viv, id_Trab_Viv)
VALUES ('Mapo', '397', 'Celeste', 'Ciudad de México', '08080', 4, 1, 2);

INSERT INTO Vivienda (calle_Viv, num_Viv, colonia_Viv, ciudad_Viv, CP_Viv, total_miembros_habitan, 
id_Trab_Viv)
VALUES ('Insadong', '654', 'Macaron', 'Ciudad de México', '01080', 5, 2);

INSERT INTO Vivienda (calle_Viv, num_Viv, colonia_Viv, ciudad_Viv, CP_Viv, total_miembros_habitan,
id_Trab_Viv)
VALUES ('Gangnam', '259', 'Yellow', 'Ciudad de México', '08080', 5, 2);

DBCC CHECKIDENT ('Representante', RESEED, 0);
DELETE FROM Vivienda
WHERE id_Vivienda IN (5,6,7,8,9,10);
SELECT * FROM Vivienda;

