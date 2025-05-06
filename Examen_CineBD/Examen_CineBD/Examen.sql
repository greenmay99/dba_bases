-- Crear la base de datos Cine
CREATE DATABASE Cine;
USE Cine;

----- TABLAS ------------------------------------

CREATE TABLE Cliente (
	id_cliente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_cliente VARCHAR (50) NOT NULL,
	apePat_cliente VARCHAR (50) NOT NULL,
	apeMat_cliente VARCHAR (50) NOT NULL,
	correo_cliente VARCHAR (50) NOT NULL,
	telefono_cliente VARCHAR (10) NOT NULL,
	fechaNac_cliente DATE NOT NULL,
	genero_cliente CHAR(1) NOT NULL CHECK(genero_cliente IN ('M', 'F')),
	calle_cliente VARCHAR (50) NOT NULL,
	numero_cliente VARCHAR (20) NOT NULL,
	colonia_cliente VARCHAR (50) NOT NULL,
	ciudad_cliente VARCHAR (50) NOT NULL,
	estado_cliente VARCHAR (50) NOT NULL,
	cp_cliente VARCHAR (5) NOT NULL
);

CREATE TABLE Proveedor (
	id_proveedor INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_proveedor VARCHAR (50) NOT NULL,
	rfc_proveedor VARCHAR (13) NOT NULL,
	correo_proveedor VARCHAR (50) NOT NULL,
	telefono_proveedor VARCHAR (10) NOT NULL,
	fechaNac_proveedor DATE NOT NULL,
	calle_proveedor VARCHAR (50) NOT NULL,
	numero_proveedor VARCHAR (20) NOT NULL,
	colonia_proveedor VARCHAR (50) NOT NULL,
	ciudad_proveedor VARCHAR (50) NOT NULL,
	estado_proveedor VARCHAR (50) NOT NULL,
	cp_proveedor VARCHAR (5) NOT NULL
);

CREATE TABLE Empleado (
	id_empleado INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_empleado VARCHAR (50) NOT NULL,
	apePat_empleado VARCHAR (50) NOT NULL,
	apeMat_empleado VARCHAR (50) NOT NULL,
	correo_empleado VARCHAR (50) NOT NULL,
	telefono_empleado VARCHAR (10) NOT NULL,
	fechaNac_empleado DATE NOT NULL,
	genero_empleado CHAR(1) NOT NULL CHECK(genero_empleado IN ('M', 'F')),
	calle_empleado VARCHAR (50) NOT NULL,
	numero_empleado VARCHAR (20) NOT NULL,
	colonia_empleado VARCHAR (50) NOT NULL,
	ciudad_empleado VARCHAR (50) NOT NULL,
	estado_empleado VARCHAR (50) NOT NULL,
	cp_empleado VARCHAR (5) NOT NULL,
	rfc_empleado VARCHAR (13) NOT NULL,
	puesto_empleado VARCHAR (50) NOT NULL,
	turno_empleado CHAR(1) NOT NULL CHECK(turno_empleado IN ('M', 'V')),
	id_sucursal_empleado INT NOT NULL
);

CREATE TABLE Sucursal (
	id_sucursal INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_sucursal VARCHAR (50) NOT NULL,
	calle_sucursal VARCHAR (50) NOT NULL,
	numero_sucursal VARCHAR (20) NOT NULL,
	colonia_sucursal VARCHAR (50) NOT NULL,
	ciudad_sucursal VARCHAR (50) NOT NULL,
	estado_sucursal VARCHAR (50) NOT NULL,
	cp_sucursal VARCHAR (5) NOT NULL
);

CREATE TABLE Venta (
	id_venta INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha_venta DATE NOT NULL,
	hora_venta TIME NOT NULL,
	id_pelicula_venta INT NOT NULL,
	id_funcion_venta INT NOT NULL,
	id_promocion_venta INT NOT NULL,
	id_empleado_venta INT NOT NULL,
	total_venta DECIMAL(10,2) NOT NULL
);

CREATE TABLE Funcion (
	id_funcion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha_funcionn DATE NOT NULL,
	hora_funcion TIME NOT NULL,
	sala_funcion CHAR (4) NOT NULL,
	tipo_funcion VARCHAR (30) NOT NULL,
	precio_funcion DECIMAL (10,2) NOT NULL,
	id_sucursal_funcion INT NOT NULL
);

CREATE TABLE Pelicula (
	id_pelicula INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	titulo_pelicula VARCHAR (50) NOT NULL,
	genero_pelicula VARCHAR (50) NOT NULL,
	clasificacion_pelicula VARCHAR (50) NOT NULL,
	duracion_pelicula VARCHAR (20) NOT NULL,
	idioma_original_pelicula VARCHAR (50) NOT NULL,
	traduccion_esp_pelicula CHAR(1) NOT NULL CHECK(traduccion_esp_pelicula IN ('S', 'N')),
	fechaEstreno_pelicula DATE NOT NULL
);

CREATE TABLE Promocion (
	id_promocion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_promocion VARCHAR (50) NOT NULL,
	descripcion_promocion VARCHAR (50) NOT NULL,
	vigencia_promocion DATE NOT NULL,
	descuento_promocion DECIMAL (10,2) NOT NULL,
	id_pelicula_promocion INT NOT NULL
);

-- Agregar claves foráneas para establecer relaciones entre tablas

ALTER TABLE Empleado
	ADD CONSTRAINT FK_id_sucursal_empleado
		FOREIGN KEY (id_sucursal_empleado) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Venta
	ADD CONSTRAINT FK_id_pelicula_venta FOREIGN KEY (id_pelicula_venta) REFERENCES Pelicula (id_pelicula),
		CONSTRAINT FK_id_funcion_venta FOREIGN KEY (id_funcion_venta) REFERENCES Funcion (id_funcion),
		CONSTRAINT FK_promocion_venta FOREIGN KEY (id_promocion_venta) REFERENCES Promocion (id_promocion),
		CONSTRAINT FK_empleado_venta FOREIGN KEY (id_empleado_venta) REFERENCES Empleado (id_empleado);

ALTER TABLE Funcion
	ADD CONSTRAINT FK_id_sucursal_funcion
		FOREIGN KEY (id_sucursal_funcion) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Promocion
	ADD CONSTRAINT FK_id_pelicula_promocion
		FOREIGN KEY (id_pelicula_promocion) REFERENCES Pelicula (id_pelicula);

-- Procedimientos almacenados para insertar datos
GO
CREATE PROCEDURE InsertarCliente 
	@nombre_cliente VARCHAR(50),
	@apePat_cliente VARCHAR(50),
	@apeMat_cliente VARCHAR(50),
	@correo_cliente VARCHAR(50),
	@telefono_cliente VARCHAR(10),
	@fechaNac_cliente DATE,
	@genero_cliente CHAR(1),
	@calle_cliente VARCHAR(50),
	@numero_cliente VARCHAR(20),
	@colonia_cliente VARCHAR(50),
	@ciudad_cliente VARCHAR(50),
	@estado_cliente VARCHAR(50),
	@cp_cliente VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
	IF @genero_cliente NOT IN ('M', 'F')
	BEGIN
		RAISERROR ('El valor de género debe ser M o F', 16,1 );
		RETURN;
	END
	INSERT INTO Cliente (nombre_cliente,apePat_cliente,apeMat_cliente,correo_cliente,telefono_cliente,
	fechaNac_cliente,genero_cliente,calle_cliente,numero_cliente,colonia_cliente,ciudad_cliente,estado_cliente,
	cp_cliente)
	VALUES (@nombre_cliente,@apePat_cliente,@apeMat_cliente,@correo_cliente,@telefono_cliente,@fechaNac_cliente,
	@genero_cliente,@calle_cliente,@numero_cliente,@colonia_cliente,@ciudad_cliente,@estado_cliente,@cp_cliente);
END;
GO

CREATE PROCEDURE InsertarProveedor 
	@nombre_proveedor VARCHAR(50),
	@rfc_proveedor VARCHAR(13),
	@correo_proveedor VARCHAR(50),
	@telefono_proveedor VARCHAR(10),
	@fechaNac_proveedor DATE,
	@calle_proveedor VARCHAR(50),
	@numero_proveedor VARCHAR(20),
	@colonia_proveedor VARCHAR(50),
	@ciudad_proveedor VARCHAR(50),
	@estado_proveedor VARCHAR(50),
	@cp_proveedor VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Proveedor (nombre_proveedor,rfc_proveedor,correo_proveedor,telefono_proveedor,fechaNac_proveedor,
	calle_proveedor,numero_proveedor,colonia_proveedor,ciudad_proveedor,estado_proveedor, cp_proveedor)
	VALUES (@nombre_proveedor,@rfc_proveedor,@correo_proveedor,@telefono_proveedor,@fechaNac_proveedor,
	@calle_proveedor,@numero_proveedor,@colonia_proveedor,@ciudad_proveedor,@estado_proveedor,@cp_proveedor);
END;

CREATE PROCEDURE InsertarSucursal
	@nombre_sucursal VARCHAR(50),
	@calle_sucursal VARCHAR(50),
	@numero_sucursal VARCHAR(20),
	@colonia_sucursal VARCHAR(50),
	@ciudad_sucursal VARCHAR(50),
	@estado_sucursal VARCHAR(50),
	@cp_sucursal VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Sucursal (nombre_sucursal,calle_sucursal,numero_sucursal,colonia_sucursal,ciudad_sucursal,
	estado_sucursal,cp_sucursal)
	VALUES (@nombre_sucursal,@calle_sucursal,@numero_sucursal,@colonia_sucursal,@ciudad_sucursal,
	@estado_sucursal,@cp_sucursal);
END;

CREATE PROCEDURE InsertarPelicula
	@titulo_pelicula VARCHAR(50),
	@genero_pelicula VARCHAR(50),
	@clasificacion_pelicula VARCHAR(50),
	@duracion_pelicula VARCHAR(20),
	@idioma_original_pelicula VARCHAR(50),
	@traduccion_esp_pelicula CHAR(1),
	@fechaEstreno_pelicula DATE
AS
BEGIN
	SET NOCOUNT ON;
	IF @traduccion_esp_pelicula NOT IN ('S', 'N')
	BEGIN
		RAISERROR ('El valor de traducción debe ser S o N', 16,1 );
		RETURN;
	END
	INSERT INTO Pelicula (titulo_pelicula,genero_pelicula,clasificacion_pelicula,duracion_pelicula,
	idioma_original_pelicula,traduccion_esp_pelicula,fechaEstreno_pelicula)
	VALUES (@titulo_pelicula,@genero_pelicula,@clasificacion_pelicula,@duracion_pelicula,
	@idioma_original_pelicula,@traduccion_esp_pelicula,@fechaEstreno_pelicula);
END;

GO
CREATE PROCEDURE InsertarEmpleado
	@nombre_empleado VARCHAR(50),
	@apePat_empleado VARCHAR(50),
	@apeMat_empleado VARCHAR(50),
	@correo_empleado VARCHAR(50),
	@telefono_empleado VARCHAR(10),
	@fechaNac_empleado DATE,
	@genero_empleado CHAR(1),
	@calle_empleado VARCHAR(50),
	@numero_empleado VARCHAR(20),
	@colonia_empleado VARCHAR(50),
	@ciudad_empleado VARCHAR(50),
	@estado_empleado VARCHAR(50),
	@cp_empleado VARCHAR(5),
	@rfc_empleado VARCHAR(13),
	@puesto_empleado VARCHAR(50),
	@turno_empleado CHAR(1),
	@id_sucursal_empleado INT
AS
BEGIN
	SET NOCOUNT ON;
	IF @genero_empleado NOT IN ('M', 'F')
	BEGIN
		RAISERROR ('El valor de género debe ser M o F', 16,1 );
		RETURN;
	END
	IF @turno_empleado NOT IN ('M', 'V')
	BEGIN
		RAISERROR('El valor de turno debe ser M o V', 16, 1);
		RETURN;
	END
	INSERT INTO Empleado (nombre_empleado,apePat_empleado,apeMat_empleado,correo_empleado,telefono_empleado,
	fechaNac_empleado,genero_empleado,calle_empleado,numero_empleado,colonia_empleado,ciudad_empleado,
	estado_empleado,cp_empleado,rfc_empleado,puesto_empleado,turno_empleado,id_sucursal_empleado)
	VALUES (@nombre_empleado,@apePat_empleado,@apeMat_empleado,@correo_empleado,@telefono_empleado,
	@fechaNac_empleado,@genero_empleado,@calle_empleado,@numero_empleado,@colonia_empleado,@ciudad_empleado,
	@estado_empleado,@cp_empleado,@rfc_empleado,@puesto_empleado,@turno_empleado,@id_sucursal_empleado);
END;
GO

CREATE PROCEDURE InsertarFuncion
	@fecha_funcionn DATE,
	@hora_funcion TIME,
	@sala_funcion CHAR(4),
	@tipo_funcion VARCHAR(30),
	@precio_funcion DECIMAL(10,2),
	@id_sucursal_funcion INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Funcion(fecha_funcionn,hora_funcion,sala_funcion,tipo_funcion,precio_funcion,id_sucursal_funcion)
	VALUES (@fecha_funcionn,@hora_funcion,@sala_funcion,@tipo_funcion,@precio_funcion,@id_sucursal_funcion);
END;

CREATE PROCEDURE InsertarPromocion
	@tipo_promocion VARCHAR (50),
	@descripcion_promocion VARCHAR (50),
	@vigencia_promocion DATE,
	@descuento_promocion DECIMAL (10,2),
	@id_pelicula_promocion INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Promocion(tipo_promocion,descripcion_promocion,vigencia_promocion,descuento_promocion,
	id_pelicula_promocion)
	VALUES (@tipo_promocion,@descripcion_promocion,@vigencia_promocion,@descuento_promocion,
	@id_pelicula_promocion);
END;

CREATE PROCEDURE InsertarVenta
	@fecha_venta DATE,
	@hora_venta TIME,
	@id_pelicula_venta INT,
	@id_funcion_venta INT,
	@id_promocion_venta INT,
	@id_empleado_venta INT,
	@total_venta DECIMAL(10,2)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Venta (fecha_venta,hora_venta,id_pelicula_venta,id_funcion_venta,id_promocion_venta,
	id_empleado_venta,total_venta)
	VALUES (@fecha_venta,@hora_venta,@id_pelicula_venta,@id_funcion_venta,@id_promocion_venta,
	@id_empleado_venta,@total_venta);
END;

---Registros de Prueba
EXEC InsertarCliente 'Carlos', 'Gomez', 'Lopez', 'carlos.gomez@example.com', '5551234567', '1990-05-10', 'M', 'Avenida Reforma', '101', 'Juárez', 'Ciudad de México', 'Ciudad de México', '06600';
EXEC InsertarCliente 'María', 'Fernandez', 'Soto', 'maria.fernandez@example.com', '5559876543', '1988-08-25', 'F', 'Calle Hidalgo', '202', 'Centro', 'Guadalajara', 'Jalisco', '44100';
EXEC InsertarCliente 'Luis', 'Hernandez', 'Martinez', 'luis.hernandez@example.com', '5551112233', '1995-12-15', 'M', 'Calle Madero', '303', 'Centro', 'Monterrey', 'Nuevo León', '64000';
EXEC InsertarCliente 'Ana', 'Ramirez', 'Diaz', 'ana.ramirez@example.com', '5554445566', '1992-03-05', 'F', 'Calle Zaragoza', '404', 'Centro', 'Puebla', 'Puebla', '72000';
EXEC InsertarCliente 'Jorge', 'Morales', 'Nava', 'jorge.morales@example.com', '5556667788', '1998-09-20', 'M', 'Boulevard Belisario Domínguez', '505', 'Centro', 'Tuxtla Gutiérrez', 'Chiapas', '29000';
EXEC InsertarCliente 'Lucía', 'Castillo', 'Reyes', 'lucia.castillo@example.com', '5557778899', '1993-11-30', 'F', 'Avenida Universidad', '606', 'San Lorenzo', 'Toluca', 'Estado de México', '50100';
EXEC InsertarCliente 'Diego', 'Vega', 'Flores', 'diego.vega@example.com', '5558889900', '1997-06-12', 'M', 'Calle Juárez', '707', 'Centro', 'Mérida', 'Yucatán', '97000';
EXEC InsertarCliente 'Fernanda', 'Cruz', 'Paredes', 'fernanda.cruz@example.com', '5559990011', '1991-02-18', 'F', 'Avenida 5 de Febrero', '808', 'Centro Sur', 'Querétaro', 'Querétaro', '76000';
EXEC InsertarCliente 'Ricardo', 'Mendez', 'Sanchez', 'ricardo.mendez@example.com', '5551113344', '1989-07-22', 'M', 'Boulevard Colosio', '909', 'Industrial', 'Hermosillo', 'Sonora', '83000';
EXEC InsertarCliente 'Sofía', 'Ortega', 'Gutiérrez', 'sofia.ortega@example.com', '5552224455', '1996-01-02', 'F', 'Calle Miguel Hidalgo', '1010', 'Centro', 'Oaxaca de Juárez', 'Oaxaca', '68000';

--------------------
EXEC InsertarProveedor 'Distribuidora MX', 'DPM850101ABC', 'contacto@peliculasmx.com', '5543214567', '1985-01-01', 'Av. Insurgentes Sur', '100', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100';
EXEC InsertarProveedor 'Snacks y Dulces', 'SDN900202DEF', 'ventas@snacksnorte.com', '5556547890', '1990-02-02', 'Calle Hidalgo', '200', 'Centro', 'Ciudad de México', 'Ciudad de México', '64000';
EXEC InsertarProveedor 'Servicios Seguridad', 'SSA980505MNO', 'contacto@seguridadacapulco.com', '5553217890', '1998-05-05', 'Av. Costera', '500', 'Centro', 'Ciudad de México', 'Ciudad de México', '39300';
EXEC InsertarProveedor 'Lácteos y Botanas', 'LBM910606PQR', 'ventas@lacteosbotanasmorelia.com', '5557891234', '1991-06-06', 'Calle Madero', '600', 'Centro', 'Ciudad de México', 'Ciudad de México', '58000';
EXEC InsertarProveedor 'Publicidad Carteles', 'PCQ930707STU', 'info@publicidadqueretaro.com', '5554563210', '1993-07-07', 'Boulevard Bernardo', '700', 'Centro', 'Ciudad de México', 'Ciudad de México', '76000';
EXEC InsertarProveedor 'Proyecciones Digitales', 'PDM920808GHI', 'contacto@proyeccionesmx.com', '5551112233', '1992-08-08', 'Av. Universidad', '101', 'Copilco', 'Ciudad de México', 'Ciudad de México', '04360';
EXEC InsertarProveedor 'Limpieza Integral', 'LIC950909JKL', 'servicios@limpiezacine.com', '5552223344', '1995-09-09', 'Calle Río Churubusco', '202', 'Coyoacán', 'Ciudad de México', 'Ciudad de México', '04100';
EXEC InsertarProveedor 'Palomitas del Valle', 'PDV870707LMN', 'ventas@palomitasvalle.com', '5553334455', '1987-07-07', 'Av División Norte', '303', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100';
EXEC InsertarProveedor 'Tecnología Cinemática', 'TCM880505XYZ', 'ventas@tecnocine.mx', '5554445566', '1988-05-05', 'Calzada Tlalpan', '404', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300';
EXEC InsertarProveedor 'Refrigeración Toluca', 'RCT990101QWE', 'contacto@climastoluca.com', '7225556677', '1999-01-01', 'Calle Lerdo', '505', 'Centro', 'Toluca', 'Estado de México', '50000';

------------------
EXEC InsertarSucursal 'Plaza Universidad', 'Av. Universidad', '1000', 'Santa Cruz', 'Ciudad de México', 'Ciudad de México', '03310';
EXEC InsertarSucursal 'Plaza Satélite', 'Circuito Centro Comercial', '2251', 'Ciudad Satélite', 'Ciudad de México', 'Ciudad de México', '53100';
EXEC InsertarSucursal 'Parque Delta', 'Av. Cuauhtémoc', '462', 'Piedad Narvarte', 'Ciudad de México', 'Ciudad de México', '03000';
EXEC InsertarSucursal 'Perisur', 'Anillo Periférico Sur', '4690', 'Jardines Pedregal', 'Ciudad de México', 'Ciudad de México', '04500';
EXEC InsertarSucursal 'Mítikah', 'Av. Río Churubusco', '601', 'Xoco', 'Ciudad de México', 'Ciudad de México', '03330';
EXEC InsertarSucursal 'La Mexicana', 'Av. Toluca', '777', 'Santa Fe', 'Ciudad de México', 'Ciudad de México', '01219';
EXEC InsertarSucursal 'Galerías', 'Blvd. Puerto Aéreo', '888', 'Venustiano Carranza', 'Ciudad de México', 'Ciudad de México', '15520';
EXEC InsertarSucursal 'La Comer', 'Calle 16 de Septiembre', '999', 'Centro', 'Toluca', 'Estado de México', '50000';
EXEC InsertarSucursal 'Plaza Cuernavaca', 'Av. Morelos', '111', 'Chapultepec', 'Cuernavaca', 'Morelos', '62000';
EXEC InsertarSucursal 'Outlet Coyoacán', 'Calle Ayuntamiento', '222', 'Del Carmen', 'Ciudad de México', 'Ciudad de México', '04100';

-----------
EXEC InsertarPelicula 'Dune: Parte Dos', 'Ciencia Ficción', 'PG-13', '165 minutos', 'Inglés', 'S', '2024-03-01';
EXEC InsertarPelicula 'Intensamente 2', 'Animación', 'PG', '100 minutos', 'Inglés', 'S', '2024-06-14';
EXEC InsertarPelicula 'Deadpool & Wolverine', 'Acción', 'R', '127 minutos', 'Inglés', 'S', '2024-07-26';
EXEC InsertarPelicula 'Misión: Imposible 8', 'Acción', 'PG-13', '150 minutos', 'Inglés', 'S', '2025-05-23';
EXEC InsertarPelicula 'La Sombra del Futuro', 'Thriller', 'PG-13', '118 minutos', 'Inglés', 'N', '2025-10-17';
EXEC InsertarPelicula 'Zootopia 2', 'Animación', 'PG', '110 minutos', 'Inglés', 'S', '2024-09-10';
EXEC InsertarPelicula 'El Gran Robo', 'Crimen', 'R', '140 minutos', 'Inglés', 'S', '2024-11-05';
EXEC InsertarPelicula 'Amor en París', 'Romance', 'PG-13', '120 minutos', 'Francés', 'N', '2025-01-20';
EXEC InsertarPelicula 'Galaxia Perdida', 'Ciencia Ficción', 'PG-13', '130 minutos', 'Inglés', 'S', '2025-04-15';
EXEC InsertarPelicula 'Magia y Hechizo', 'Fantasía', 'PG', '125 minutos', 'Inglés', 'N', '2025-08-10';

-------
EXEC InsertarEmpleado 'Carlos', 'Ramírez', 'Hernández', 'carlos.ramirez@email.com', '5512345678', '1990-04-12', 'M', 'Av. Reforma', '123', 'Centro', 'Ciudad de México', 'Ciudad de México', '06000', 'CARH900412HDFMRN03', 'Gerente', 'M', 1;
EXEC InsertarEmpleado 'María', 'Gómez', 'Sánchez', 'maria.gomez@email.com', '5598765432', '1995-09-30', 'F', 'Calle Juárez', '456', 'Doctores', 'Ciudad de México', 'Ciudad de México', '06720', 'GOSM950930MDFMNR07', 'Taquillera', 'V', 1;
EXEC InsertarEmpleado 'Luis', 'Fernández', 'Pérez', 'luis.fernandez@email.com', '5532124598', '1988-01-25', 'M', 'Insurgentes Sur', '789', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100', 'FEPL880125HDFRLS05', 'Proyeccionista', 'M', 1;
EXEC InsertarEmpleado 'Ana', 'Martínez', 'López', 'ana.martinez@email.com', '5546781234', '1992-07-15', 'F', 'Av. Universidad', '321', 'Copilco', 'Ciudad de México', 'Ciudad de México', '04360', 'MOLA920715MDFRPN04', 'Vendedora', 'V', 1;
EXEC InsertarEmpleado 'José', 'Hernández', 'Ramírez', 'jose.hernandez@email.com', '5567812345', '1985-11-05', 'M', 'Eje Central', '654', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300', 'HEJR851105HDFRMS09', 'Encargado de Dulcería', 'M', 1;
EXEC InsertarEmpleado 'Valeria', 'Torres', 'Jiménez', 'valeria.torres@email.com', '5544123366', '1996-03-22', 'F', 'Calle Oaxaca', '111', 'Roma Norte', 'Ciudad de México', 'Ciudad de México', '06700', 'TOJV960322MDFRML03', 'Taquillera', 'V', 2;
EXEC InsertarEmpleado 'Andrés', 'López', 'González', 'andres.lopez@email.com', '5551239876', '1993-08-10', 'M', 'Calle Morelos', '222', 'Centro', 'Ciudad de México', 'Ciudad de México', '06010', 'LOGA930810HDFPNR08', 'Proyeccionista', 'M', 2;
EXEC InsertarEmpleado 'Paola', 'Mendoza', 'Ríos', 'paola.mendoza@email.com', '5567894561', '1997-06-05', 'F', 'Av. Insurgentes Norte', '333', 'San Rafael', 'Ciudad de México', 'Ciudad de México', '06470', 'MERP970605MDFRLS02', 'Vendedora', 'V', 2;
EXEC InsertarEmpleado 'Iván', 'García', 'Delgado', 'ivan.garcia@email.com', '5554327890', '1990-12-18', 'M', 'Calz. Tlalpan', '444', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300', 'GADI901218HDFRNV04', 'Encargado de Dulcería', 'M', 2;
EXEC InsertarEmpleado 'Sofía', 'Ruiz', 'Navarro', 'sofia.ruiz@email.com', '5543216789', '1994-02-14', 'F', 'Av. División del Norte', '555', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100', 'RUNS940214MDFLZF03', 'Taquillera', 'M', 2;

-------
EXEC InsertarFuncion '2025-05-01', '10:00', 'A001', 'Estreno', 150.00, 1;
EXEC InsertarFuncion '2025-05-07', '13:00', 'A002', 'General', 120.00, 2;
EXEC InsertarFuncion '2025-05-07', '17:00', 'B001', '3D', 180.00, 3;
EXEC InsertarFuncion '2025-05-16', '20:00', 'B002', 'Estreno', 200.00, 4;
EXEC InsertarFuncion '2025-05-16', '12:00', 'C001', 'General', 130.00, 5;
EXEC InsertarFuncion '2025-06-01', '15:00', 'C002', '3D', 160.00, 1;
EXEC InsertarFuncion '2025-06-10', '19:00', 'A003', 'Estreno', 180.00, 2;
EXEC InsertarFuncion '2025-06-12', '21:00', 'A004', 'Especial', 140.00, 3;
EXEC InsertarFuncion '2025-06-15', '11:00', 'B003', 'General', 120.00, 4;
EXEC InsertarFuncion '2025-06-20', '14:00', 'B004', '3D', 170.00, 5;

----------
EXEC InsertarPromocion 'Descuento', '10% en boletos para todos', '2025-05-15', 10.00, 1;
EXEC InsertarPromocion 'Combo', 'Combo 2 boletos + palomitas', '2025-05-20', 15.00, 2;
EXEC InsertarPromocion 'Estreno', '20% descuento estreno', '2025-06-01', 20.00, 3;
EXEC InsertarPromocion 'Familiar', '2 boletos adultos + 2 niños mitad precio', '2025-06-05', 50.00, 4;
EXEC InsertarPromocion 'Lunes de descuento', '30% descuento lunes', '2025-06-07', 30.00, 5;
EXEC InsertarPromocion 'Pareja', '15% descuento pareja', '2025-06-10', 15.00, 6;
EXEC InsertarPromocion 'Estudiantes', '25% descuento estudiantes', '2025-06-15', 25.00, 7;
EXEC InsertarPromocion 'Tarde especial', '10% descuento tardes', '2025-06-20', 10.00, 8;
EXEC InsertarPromocion 'Festival cine', 'Descuento festival', '2025-06-25', 40.00, 9;
EXEC InsertarPromocion 'Navidad', '20% descuento navidad', '2025-12-20', 20.00, 10;
--------
EXEC InsertarVenta '2025-05-10', '15:30:00', 1, 1, 1, 1, 180.00;
EXEC InsertarVenta '2025-05-11', '18:00:00', 2, 2, 2, 2, 220.00;
EXEC InsertarVenta '2025-05-12', '20:00:00', 3, 3, 3, 3, 250.00;
EXEC InsertarVenta '2025-05-13', '14:30:00', 1, 4, 4, 4, 300.00;
EXEC InsertarVenta '2025-05-14', '16:45:00', 2, 5, 5, 5, 200.00;
EXEC InsertarVenta '2025-06-01', '17:00:00', 6, 6, 6, 6, 230.00;
EXEC InsertarVenta '2025-06-05', '19:30:00', 7, 7, 7, 7, 210.00;
EXEC InsertarVenta '2025-06-10', '21:00:00', 8, 8, 8, 8, 190.00;
EXEC InsertarVenta '2025-06-15', '13:00:00', 9, 9, 9, 9, 240.00;
EXEC InsertarVenta '2025-06-20', '15:15:00', 10, 10, 10, 10, 260.00;


-- b) Insertar un total de 45 registros distribuidos en Cliente, Empleado y Proveedor

-- Insertar 15 Clientes 
EXEC InsertarCliente 'Carlos', 'Gomez', 'Lopez', 'carlos.gomez@example.com', '5551234567', '1990-05-10', 'M', 'Avenida Reforma', '101', 'Juárez', 'Ciudad de México', 'Ciudad de México', '06600';
EXEC InsertarCliente 'María', 'Fernandez', 'Soto', 'maria.fernandez@example.com', '5559876543', '1988-08-25', 'F', 'Calle Hidalgo', '202', 'Centro', 'Guadalajara', 'Jalisco', '44100';
EXEC InsertarCliente 'Luis', 'Hernandez', 'Martinez', 'luis.hernandez@example.com', '5551112233', '1995-12-15', 'M', 'Calle Madero', '303', 'Centro', 'Monterrey', 'Nuevo León', '64000';
EXEC InsertarCliente 'Ana', 'Ramirez', 'Diaz', 'ana.ramirez@example.com', '5554445566', '1992-03-05', 'F', 'Calle Zaragoza', '404', 'Centro', 'Puebla', 'Puebla', '72000';
EXEC InsertarCliente 'Jorge', 'Morales', 'Nava', 'jorge.morales@example.com', '5556667788', '1998-09-20', 'M', 'Boulevard Belisario Domínguez', '505', 'Centro', 'Tuxtla Gutiérrez', 'Chiapas', '29000';
EXEC InsertarCliente 'Lucía', 'Castillo', 'Reyes', 'lucia.castillo@example.com', '5557778899', '1993-11-30', 'F', 'Avenida Universidad', '606', 'San Lorenzo', 'Toluca', 'Estado de México', '50100';
EXEC InsertarCliente 'Diego', 'Vega', 'Flores', 'diego.vega@example.com', '5558889900', '1997-06-12', 'M', 'Calle Juárez', '707', 'Centro', 'Mérida', 'Yucatán', '97000';
EXEC InsertarCliente 'Fernanda', 'Cruz', 'Paredes', 'fernanda.cruz@example.com', '5559990011', '1991-02-18', 'F', 'Avenida 5 de Febrero', '808', 'Centro Sur', 'Querétaro', 'Querétaro', '76000';
EXEC InsertarCliente 'Ricardo', 'Mendez', 'Sanchez', 'ricardo.mendez@example.com', '5551113344', '1989-07-22', 'M', 'Boulevard Colosio', '909', 'Industrial', 'Hermosillo', 'Sonora', '83000';
EXEC InsertarCliente 'Sofía', 'Ortega', 'Gutiérrez', 'sofia.ortega@example.com', '5552224455', '1996-01-02', 'F', 'Calle Miguel Hidalgo', '1010', 'Centro', 'Oaxaca de Juárez', 'Oaxaca', '68000';
EXEC InsertarCliente 'Felipe', 'Ramón', 'Delgado', 'felipe.ramon@example.com', '5553334456', '1991-08-16', 'M', 'Calle Emiliano Zapata', '1001', 'Centro', 'Tlaxcala', 'Tlaxcala', '90000';
EXEC InsertarCliente 'Laura', 'Sanchez', 'Mendez', 'laura.sanchez@example.com', '5554445566', '1993-05-22', 'F', 'Av 16 de Septiembre', '1112', 'Zona Centro', 'Morelia', 'Michoacan', '58000';
EXEC InsertarCliente 'Mario', 'Rojas', 'Lopez', 'mario.rojas@example.com', '5555556677', '1990-11-30', 'M', 'Calle 5 de Mayo', '1213', 'Centro', 'Guadalajara', 'Jalisco', '44100';
EXEC InsertarCliente 'Pamela', 'Diaz', 'Suarez', 'pamela.diaz@example.com', '5556667788', '1995-04-05', 'F', 'Av. Hidalgo', '1314', 'Centro', 'Monterrey', 'Nuevo León', '64000';
EXEC InsertarCliente 'Ricardo', 'Vargas', 'Pérez', 'ricardo.vargas@example.com', '5557778899', '1992-09-15', 'M', 'Paseo de la Reforma', '1415', 'Juarez', 'Ciudad de México', 'Ciudad de México', '06600';

-- Insertar 15 Empleados
EXEC InsertarEmpleado 'Alejandro', 'Mendoza', 'Torres', 'alejandro.mendoza@email.com', '5512341122', '1990-03-10', 'M', 'Av. Reforma', '301', 'Centro', 'Ciudad de México', 'Ciudad de México', '06000', 'AMTO900310HDFMRN01', 'Gerente', 'M', 1;
EXEC InsertarEmpleado 'Beatriz', 'Lopez', 'Soto', 'beatriz.lopez@email.com', '5523452233', '1992-07-14', 'F', 'Calle Juárez', '302', 'Doctores', 'Ciudad de México', 'Ciudad de México', '06720', 'BLSO920714MDFMNR02', 'Taquillera', 'V', 1;
EXEC InsertarEmpleado 'Camilo', 'Gutierrez', 'Diaz', 'camilo.gutierrez@email.com', '5534563344', '1988-12-20', 'M', 'Insurgentes Sur', '303', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100', 'CGDI881220HDFRLS03', 'Proyeccionista', 'M', 1;
EXEC InsertarEmpleado 'Daniela', 'Ramirez', 'Vargas', 'daniela.ramirez@email.com', '5545674455', '1993-05-25', 'F', 'Av. Universidad', '304', 'Copilco', 'Ciudad de México', 'Ciudad de México', '04360', 'DRVA930525MDFRPN04', 'Vendedora', 'V', 1;
EXEC InsertarEmpleado 'Ernesto', 'Perez', 'Ramos', 'ernesto.perez@email.com', '5556785566', '1985-10-18', 'M', 'Eje Central', '305', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300', 'EPRR851018HDFRMS05', 'Encargado de Dulcería', 'M', 1;
EXEC InsertarEmpleado 'Fernanda', 'Torres', 'Juarez', 'fernanda.torres@email.com', '5567896677', '1994-08-22', 'F', 'Calle Oaxaca', '306', 'Roma Norte', 'Ciudad de México', 'Ciudad de México', '06700', 'FTJJ940822MDFRML06', 'Taquillera', 'V', 2;
EXEC InsertarEmpleado 'Gabriel', 'Mendoza', 'Alvarez', 'gabriel.mendoza@email.com', '5578907788', '1991-03-15', 'M', 'Calle Morelos', '307', 'Centro', 'Ciudad de México', 'Ciudad de México', '06010', 'GMAA910315HDFPNR07', 'Proyeccionista', 'M', 2;
EXEC InsertarEmpleado 'Helena', 'Martinez', 'Sanchez', 'helena.martinez@email.com', '5589018899', '1996-11-05', 'F', 'Av. Insurgentes Norte', '308', 'San Rafael', 'Ciudad de México', 'Ciudad de México', '06470', 'HMSN961105MDFRLS08', 'Vendedora', 'V', 2;
EXEC InsertarEmpleado 'Ignacio', 'Gomez', 'Ruiz', 'ignacio.gomez@email.com', '5590129900', '1990-01-25', 'M', 'Calz. Tlalpan', '309', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300', 'IGRR900125HDFRNV09', 'Encargado de Limpieza', 'M', 2;
EXEC InsertarEmpleado 'Jessica', 'Ruiz', 'Navarro', 'jessica.ruiz@email.com', '5501231011', '1994-07-17', 'F', 'Av. División del Norte', '310', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100', 'JRND940717MDFLZF10', 'Taquillera', 'M', 3;
EXEC InsertarEmpleado 'Kevin', 'Cruz', 'Hernandez', 'kevin.cruz@email.com', '5512342122', '1991-06-11', 'M', 'Calle Durango', '311', 'Roma Sur', 'Ciudad de México', 'Ciudad de México', '06760', 'KCHJ910611HDFNRD11', 'Proyeccionista', 'V', 3;
EXEC InsertarEmpleado 'Laura', 'Santos', 'Luna', 'laura.santos@email.com', '5523453233', '1998-08-19', 'F', 'Eje 6 Sur', '312', 'Narvarte', 'Ciudad de México', 'Ciudad de México', '03020', 'LSLN980819MDFLNR12', 'Vendedora', 'M', 3;
EXEC InsertarEmpleado 'Mario', 'Reyes', 'Ponce', 'mario.reyes@email.com', '5534564344', '1989-02-14', 'M', 'Av. Revolución', '313', 'Tacubaya', 'Ciudad de México', 'Ciudad de México', '11870', 'MRPR890214HDFLNS13', 'Encargado de Limpieza', 'V', 3;
EXEC InsertarEmpleado 'Natalia', 'Peña', 'Castañeda', 'natalia.pena@email.com', '5545675455', '1993-12-04', 'F', 'Av. Patriotismo', '314', 'Escandón', 'Ciudad de México', 'Ciudad de México', '11800', 'NPCD931204MDFRRN14', 'Supervisora', 'M', 3;
EXEC InsertarEmpleado 'Oscar', 'Moreno', 'Salas', 'oscar.moreno@email.com', '5556786566', '1987-04-22', 'M', 'Av. Coyoacán', '315', 'Del Valle Centro', 'Ciudad de México', 'Ciudad de México', '03100', 'OMSS870422HDFNRS15', 'Gerente', 'V', 3;

-- Insertar 15 Proveedor
EXEC InsertarProveedor 'Proveedor1', 'RFC100000001', 'proveedor1@email.com', '5511001001', '1970-01-01', 'Calle Uno', '101', 'Colonia1', 'Ciudad1', 'Estado1', '01000';
EXEC InsertarProveedor 'Proveedor2', 'RFC100000002', 'proveedor2@email.com', '5511001002', '1971-02-02', 'Calle Dos', '102', 'Colonia2', 'Ciudad2', 'Estado2', '02000';
EXEC InsertarProveedor 'Proveedor3', 'RFC100000003', 'proveedor3@email.com', '5511001003', '1972-03-03', 'Calle Tres', '103', 'Colonia3', 'Ciudad3', 'Estado3', '03000';
EXEC InsertarProveedor 'Proveedor4', 'RFC100000004', 'proveedor4@email.com', '5511001004', '1973-04-04', 'Calle Cuatro', '104', 'Colonia4', 'Ciudad4', 'Estado4', '04000';
EXEC InsertarProveedor 'Proveedor5', 'RFC100000005', 'proveedor5@email.com', '5511001005', '1974-05-05', 'Calle Cinco', '105', 'Colonia5', 'Ciudad5', 'Estado5', '05000';
EXEC InsertarProveedor 'Proveedor6', 'RFC100000006', 'proveedor6@email.com', '5511001006', '1975-06-06', 'Calle Seis', '106', 'Colonia6', 'Ciudad6', 'Estado6', '06000';
EXEC InsertarProveedor 'Proveedor7', 'RFC100000007', 'proveedor7@email.com', '5511001007', '1976-07-07', 'Calle Siete', '107', 'Colonia7', 'Ciudad7', 'Estado7', '07000';
EXEC InsertarProveedor 'Proveedor8', 'RFC100000008', 'proveedor8@email.com', '5511001008', '1977-08-08', 'Calle Ocho', '108', 'Colonia8', 'Ciudad8', 'Estado8', '08000';
EXEC InsertarProveedor 'Proveedor9', 'RFC100000009', 'proveedor9@email.com', '5511001009', '1978-09-09', 'Calle Nueve', '109', 'Colonia9', 'Ciudad9', 'Estado9', '09000';
EXEC InsertarProveedor 'Proveedor10', 'RFC100000010', 'proveedor10@email.com', '5511001010', '1979-10-10', 'Calle Diez', '110', 'Colonia10', 'Ciudad10', 'Estado10', '10000';
EXEC InsertarProveedor 'Proveedor11', 'RFC100000011', 'proveedor11@email.com', '5511001011', '1980-11-11', 'Calle Once', '111', 'Colonia11', 'Ciudad11', 'Estado11', '11000';
EXEC InsertarProveedor 'Proveedor12', 'RFC100000012', 'proveedor12@email.com', '5511001012', '1981-12-12', 'Calle Doce', '112', 'Colonia12', 'Ciudad12', 'Estado12', '12000';
EXEC InsertarProveedor 'Proveedor13', 'RFC100000013', 'proveedor13@email.com', '5511001013', '1982-01-13', 'Calle Trece', '113', 'Colonia13', 'Ciudad13', 'Estado13', '13000';
EXEC InsertarProveedor 'Proveedor14', 'RFC100000014', 'proveedor14@email.com', '5511001014', '1983-02-14', 'Calle Catorce', '114', 'Colonia14', 'Ciudad14', 'Estado14', '14000';
EXEC InsertarProveedor 'Proveedor15', 'RFC100000015', 'proveedor15@email.com', '5511001015', '1984-03-15', 'Calle Quince', '115', 'Colonia15', 'Ciudad15', 'Estado15', '15000';

-- c) Crear vistas con los últimos 3 registros de Cliente, Empleado y Proveedor
GO
CREATE OR ALTER VIEW VistaCliente AS
SELECT TOP 3 * FROM Cliente ORDER BY id_cliente DESC;
GO
GO
CREATE OR ALTER VIEW VistaCliente AS
SELECT TOP 3 * FROM Empleado ORDER BY id_empleado DESC;
GO
GO
CREATE OR ALTER VIEW VistaCliente AS
SELECT TOP 3 * FROM Proveedor ORDER BY id_proveedor DESC;
GO
-- d) Crear tabla Reporte1 y guardar 5 registros aleatorios de cada tabla Cliente, Empleado y Proveedor

IF OBJECT_ID('Reporte1') IS NOT NULL DROP TABLE Reporte1;

CREATE TABLE Reporte1 (
    id__reporte1 INT IDENTITY(1,1) PRIMARY KEY,
    nombre_reporte1 VARCHAR(150),
    correo_reporte1 VARCHAR(100),
    telefono_reporte1 VARCHAR(15),
    fecha_nac_reporte1 DATE,
    genero_reporte1 CHAR(1),
	tipo_reporte1 VARCHAR(20),
	id_original_reporte1 INT,
);

select * from Reporte1;

-- Insertar 5 clientes aleatorios
INSERT INTO Reporte1 (nombre_reporte1,correo_reporte1,telefono_reporte1,fecha_nac_reporte1,genero_reporte1,tipo_reporte1,id_original_reporte1)
SELECT nombre_cliente, correo_cliente, telefono_cliente, fechaNac_cliente, genero_cliente,'Cliente',id_cliente
FROM Cliente
ORDER BY NEWID()
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Insertar 5 empleados aleatorios
INSERT INTO Reporte1 (nombre_reporte1,correo_reporte1,telefono_reporte1,fecha_nac_reporte1,genero_reporte1,tipo_reporte1,id_original_reporte1)
SELECT nombre_empleado, correo_empleado, telefono_empleado, fechaNac_empleado, genero_empleado,'Empleado',id_empleado
FROM Empleado
ORDER BY NEWID()
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Insertar 5 proveedores aleatorios
INSERT INTO Reporte1 (nombre_reporte1,correo_reporte1,telefono_reporte1,fecha_nac_reporte1,genero_reporte1,tipo_reporte1,id_original_reporte1)
SELECT nombre_proveedor, correo_proveedor, telefono_proveedor, fechaNac_proveedor, NULL,'Proveedor',id_proveedor
FROM Proveedor
ORDER BY NEWID()
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- e) Crear tabla ListaDomicilio con últimos 5 registros de Cliente, Empleado y Proveedor 

IF OBJECT_ID('ListaDomicilio') IS NOT NULL DROP TABLE ListaDomicilio;

CREATE TABLE ListaDomicilio (
    id_registro INT IDENTITY(1,1) PRIMARY KEY,
    tipo VARCHAR(20),
    id_original INT,
    nombre VARCHAR(150),
    calle VARCHAR(100),
    numero VARCHAR(20),
    colonia VARCHAR(50),
    ciudad VARCHAR(50),
    estado VARCHAR(50),
    cp VARCHAR(10)
);

select * from ListaDomicilio;

-- Insertar últimos 5 clientes
INSERT INTO ListaDomicilio (tipo, id_original, nombre, calle, numero, colonia, ciudad, estado, cp)
SELECT 'Cliente', id_cliente, nombre_cliente, calle_cliente, numero_cliente, colonia_cliente, ciudad_cliente, estado_cliente, cp_cliente
FROM Cliente
ORDER BY id_cliente DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Insertar últimos 5 empleados
INSERT INTO ListaDomicilio (tipo, id_original, nombre, calle, numero, colonia, ciudad, estado, cp)
SELECT 'Empleado', id_empleado, nombre_empleado, calle_empleado, numero_empleado, colonia_empleado, ciudad_empleado, estado_empleado, cp_empleado
FROM Empleado
ORDER BY id_empleado DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Insertar últimos 5 proveedores
INSERT INTO ListaDomicilio (tipo, id_original, nombre, calle, numero, colonia, ciudad, estado, cp)
SELECT 'Proveedor', id_proveedor, nombre_proveedor, calle_proveedor, numero_proveedor, colonia_proveedor, ciudad_proveedor, estado_proveedor, cp_proveedor
FROM Proveedor
ORDER BY id_proveedor DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- f) Crear tabla NuevoRegistro y unir la información de Reporte1 y ListaDomicilio

IF OBJECT_ID('NuevoRegistro') IS NOT NULL DROP TABLE NuevoRegistro;

CREATE TABLE NuevoRegistro (
    id_nregistro INT IDENTITY(1,1) PRIMARY KEY,
    tipo_nregistro VARCHAR(20),--r
    id_original_nregistro INT,--r
    nombre_nregistro VARCHAR(150),--r
    correo_nregistro VARCHAR(100) NULL,--r
    telefono_nregistro VARCHAR(15) NULL,-- r
    calle_nregistro VARCHAR(100),--l
    numero_nregistro VARCHAR(20),
    colonia_nregistro VARCHAR(50),
    ciudad_nregistro VARCHAR(50),
    estado_nregistro VARCHAR(50),
    cp_nregistro VARCHAR(10)
);

select * from NuevoRegistro;

-- Insertar datos de Reporte1 y ListaDomicilio
INSERT INTO NuevoRegistro (tipo_nregistro, id_original_nregistro,nombre_nregistro,correo_nregistro,telefono_nregistro,
calle_nregistro,numero_nregistro,colonia_nregistro,ciudad_nregistro,estado_nregistro,cp_nregistro)
SELECT 
	r.tipo_reporte1,
	r.id_original_reporte1,
    r.nombre_reporte1,
    r.correo_reporte1,
    r.telefono_reporte1,
    l.calle,
    l.numero,
    l.colonia,
    l.ciudad,
    l.estado,
    l.cp    
FROM Reporte1 r
INNER JOIN ListaDomicilio l
    ON r.nombre_reporte1 = l.nombre
    AND r.tipo_reporte1 = l.tipo;

-- g) Crear índice en la tabla NuevoRegistro

CREATE NONCLUSTERED INDEX IDX_NuevoRegistro_Tipo ON NuevoRegistro(tipo_nregistro);
CREATE NONCLUSTERED INDEX IDX_NuevoRegistro_IdOriginal ON NuevoRegistro(id_original_nregistro);

-- h) Crear vistas para las nuevas tablas
GO
CREATE OR ALTER VIEW VistaReporte1 AS
SELECT * FROM VistaReporte1;
GO
GO
CREATE OR ALTER VIEW VistaListaDomicilio AS
SELECT * FROM VistaListaDomicilio;
GO
GO
CREATE OR ALTER VIEW VistaNuevoRegistro AS
SELECT * FROM VistaNuevoRegistro;
GO

-- i) Crear tabla Registro2 con condiciones para registros de hombres y mujeres entre 25 y 31 años y con últimos registros de domicilio de Cliente, Empleado y Proveedor

IF OBJECT_ID('Registro2') IS NOT NULL DROP TABLE Registro2;

CREATE TABLE Registro2 (
    id_registro2 INT IDENTITY(1,1) PRIMARY KEY,
    tipo_registro2 VARCHAR(20),
    id_original_registro2 INT,
    nombre_registro2 VARCHAR(150),
    fecha_nac_registro2 DATE,
    genero_registro2 CHAR(1),
    calle_registro2 VARCHAR(100),
    numero_registro2 VARCHAR(20),
    colonia_registro2 VARCHAR(50),
    ciudad_registro2 VARCHAR(50),
    estado_registro2 VARCHAR(50),
    cp_registro2 VARCHAR(10)
);

select * from Registro2;

-- Insertar registros que cumplen la edad y género y últimos domicilios

-- De Cliente
INSERT INTO Registro2 (tipo_registro2, id_original_registro2, nombre_registro2, fecha_nac_registro2, genero_registro2, 
calle_registro2, numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2)
SELECT 'Cliente', id_cliente, nombre_cliente, fechaNac_cliente, genero_cliente, calle_cliente, numero_cliente, colonia_cliente, ciudad_cliente, estado_cliente, cp_cliente
FROM (
	SELECT *, ROW_NUMBER() OVER (ORDER BY id_cliente DESC) as rn
	FROM Cliente
	WHERE genero_cliente IN ('M', 'F') 
	AND DATEDIFF(year, fechaNac_cliente, GETDATE()) BETWEEN 25 AND 31
) as sub
ORDER BY id_cliente DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- De Empleado
INSERT INTO Registro2 (tipo_registro2, id_original_registro2, nombre_registro2, fecha_nac_registro2, genero_registro2, 
calle_registro2, numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2)
SELECT 'Empleado', id_empleado, nombre_empleado, fechaNac_empleado, genero_empleado, calle_empleado, numero_empleado, colonia_empleado, ciudad_empleado, estado_empleado, cp_empleado
FROM (
	SELECT *, ROW_NUMBER() OVER (ORDER BY id_empleado DESC) as rn
	FROM Empleado
	WHERE genero_empleado IN ('M', 'F') 
	AND DATEDIFF(year, fechaNac_empleado, GETDATE()) BETWEEN 25 AND 31
) as sub
ORDER BY id_empleado DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- De Proveedor 
INSERT INTO Registro2 (tipo_registro2, id_original_registro2, nombre_registro2, fecha_nac_registro2, genero_registro2, 
calle_registro2, numero_registro2, colonia_registro2, ciudad_registro2, estado_registro2, cp_registro2)
SELECT 'Proveedor', id_proveedor, nombre_proveedor, fechaNac_proveedor, NULL, calle_proveedor, numero_proveedor, colonia_proveedor, ciudad_proveedor, estado_proveedor, cp_proveedor
FROM (
	SELECT *, ROW_NUMBER() OVER (ORDER BY id_proveedor DESC) as rn
	FROM Proveedor
) as sub
ORDER BY id_proveedor DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;


-- iii. Realizar una copia de la tabla Registro2
SELECT * INTO Registro2_copia FROM Registro2;

-- Verificar que se copió correctamente
SELECT * FROM Registro2_copia;

-- iv. Regresar a la versión original de la tabla
DROP TABLE Registro2;
EXEC sp_rename 'Registro2_copia', 'Registro2';

select * from Registro2;

