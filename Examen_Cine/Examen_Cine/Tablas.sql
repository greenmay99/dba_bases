CREATE DATABASE Cine;

use Cine;

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
)

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
)

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
---- foreign key -----
	id_sucursal_empleado INT NOT NULL
)

CREATE TABLE Sucursal (
	id_sucursal INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_sucursal VARCHAR (50) NOT NULL,
	calle_sucursal VARCHAR (50) NOT NULL,
	numero_sucursal VARCHAR (20) NOT NULL,
	colonia_sucursal VARCHAR (50) NOT NULL,
	ciudad_sucursal VARCHAR (50) NOT NULL,
	estado_sucursal VARCHAR (50) NOT NULL,
	cp_sucursal VARCHAR (5) NOT NULL
)

CREATE TABLE Venta (
	id_venta INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha_venta DATE NOT NULL,
	hora_venta TIME NOT NULL,
---- foreign key -----
	id_pelicula_venta INT NOT NULL,
	id_funcion_venta INT NOT NULL,
	id_promocion_venta INT NOT NULL,
	id_empleado_venta INT NOT NULL,
---- fin foreign key -----
	total_venta DECIMAL(10,2) NOT NULL
)

CREATE TABLE Funcion (
	id_funcion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	fecha_funcionn DATE NOT NULL,
	hora_funcion TIME NOT NULL,
	sala_funcion CHAR (4) NOT NULL,
	tipo_funcion VARCHAR (30) NOT NULL,
	precio_funcion DECIMAL (10,2) NOT NULL,
---- foreign key -----
	id_sucursal_funcion INT NOT NULL
)

CREATE TABLE Pelicula (
	id_pelicula INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	titulo_pelicula VARCHAR (50) NOT NULL,
	genero_pelicula VARCHAR (50) NOT NULL,
	clasificacion_pelicula VARCHAR (50) NOT NULL,
	duracion_pelicula VARCHAR (20) NOT NULL,
	idioma_original_pelicula VARCHAR (50) NOT NULL,
	traduccion_esp_pelicula CHAR(1) NOT NULL CHECK(traduccion_esp_pelicula IN ('S', 'N')),
	fechaEstreno_pelicula DATE NOT NULL
)

CREATE TABLE Promocion (
	id_promocion INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_promocion VARCHAR (50) NOT NULL,
	descripcion_promocion VARCHAR (50) NOT NULL,
	vigencia_promocion DATE NOT NULL,
	descuento_promocion DECIMAL (10,2) NOT NULL,
---- foreign key -----	
	id_pelicula_promocion INT NOT NULL
)


----------- TABLAS BASE (4) ------------------
----- CREACION DE PROCEDURE Cliente ----------------------
select * from Cliente;
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


EXEC InsertarCliente 
	'Carlos', 'Gomez', 'Lopez', 'carlos.gomez@example.com', '5551234567', '1990-05-10', 'M', 
	'Avenida Reforma', '101', 'Juárez', 'Ciudad de México', 'Ciudad de México', '06600';

EXEC InsertarCliente 
	'María', 'Fernandez', 'Soto', 'maria.fernandez@example.com', '5559876543', '1988-08-25', 'F', 
	'Calle Hidalgo', '202', 'Centro', 'Guadalajara', 'Jalisco', '44100';

EXEC InsertarCliente 
	'Luis', 'Hernandez', 'Martinez', 'luis.hernandez@example.com', '5551112233', '1995-12-15', 'M', 
	'Calle Madero', '303', 'Centro', 'Monterrey', 'Nuevo León', '64000';

EXEC InsertarCliente 
	'Ana', 'Ramirez', 'Diaz', 'ana.ramirez@example.com', '5554445566', '1992-03-05', 'F', 
	'Calle Zaragoza', '404', 'Centro', 'Puebla', 'Puebla', '72000';

EXEC InsertarCliente 
	'Jorge', 'Morales', 'Nava', 'jorge.morales@example.com', '5556667788', '1998-09-20', 'M', 
	'Boulevard Belisario Domínguez', '505', 'Centro', 'Tuxtla Gutiérrez', 'Chiapas', '29000';

EXEC InsertarCliente 
	'Lucía', 'Castillo', 'Reyes', 'lucia.castillo@example.com', '5557778899', '1993-11-30', 'F', 
	'Avenida Universidad', '606', 'San Lorenzo', 'Toluca', 'Estado de México', '50100';

EXEC InsertarCliente 
	'Diego', 'Vega', 'Flores', 'diego.vega@example.com', '5558889900', '1997-06-12', 'M', 
	'Calle Juárez', '707', 'Centro', 'Mérida', 'Yucatán', '97000';

EXEC InsertarCliente 
	'Fernanda', 'Cruz', 'Paredes', 'fernanda.cruz@example.com', '5559990011', '1991-02-18', 'F', 
	'Avenida 5 de Febrero', '808', 'Centro Sur', 'Querétaro', 'Querétaro', '76000';

EXEC InsertarCliente 
	'Ricardo', 'Mendez', 'Sanchez', 'ricardo.mendez@example.com', '5551113344', '1989-07-22', 'M', 
	'Boulevard Colosio', '909', 'Industrial', 'Hermosillo', 'Sonora', '83000';

EXEC InsertarCliente 
	'Sofía', 'Ortega', 'Gutiérrez', 'sofia.ortega@example.com', '5552224455', '1996-01-02', 'F', 
	'Calle Miguel Hidalgo', '1010', 'Centro', 'Oaxaca de Juárez', 'Oaxaca', '68000';

EXEC InsertarCliente 
	'Elena', 'Suárez', 'Navarro', 'elena.suarez@example.com', '5553332211', '1994-04-11', 'F',
	'Calle Independencia', '111', 'Del Valle', 'San Luis Potosí', 'San Luis Potosí', '78200';

EXEC InsertarCliente 
	'Roberto', 'Salinas', 'Treviño', 'roberto.salinas@example.com', '5554443322', '1987-10-03', 'M',
	'Avenida Revolución', '222', 'Obrera', 'Saltillo', 'Coahuila', '25000';

EXEC InsertarCliente 
	'Valeria', 'Rojas', 'Montes', 'valeria.rojas@example.com', '5555554433', '1990-06-17', 'F',
	'Calle Victoria', '333', 'Centro', 'Colima', 'Colima', '28000';

EXEC InsertarCliente 
	'Andrés', 'Pérez', 'Gómez', 'andres.perez@example.com', '5556665544', '1992-09-09', 'M',
	'Avenida Central', '444', 'Las Palmas', 'Culiacán', 'Sinaloa', '80000';

EXEC InsertarCliente 
	'Patricia', 'Medina', 'Luna', 'patricia.medina@example.com', '5557776655', '1985-12-29', 'F',
	'Calle Hidalgo', '555', 'Mirador', 'Chihuahua', 'Chihuahua', '31000';

EXEC InsertarCliente 
	'Emilio', 'Garza', 'Ortiz', 'emilio.garza@example.com', '5558887766', '1998-01-05', 'M',
	'Callejón del Beso', '666', 'Centro Histórico', 'Guanajuato', 'Guanajuato', '36000';

EXEC InsertarCliente 
	'Daniela', 'Quintero', 'Zavala', 'daniela.quintero@example.com', '5559998877', '1993-07-14', 'F',
	'Calle Matamoros', '777', 'Zona Norte', 'Tijuana', 'Baja California', '22000';

EXEC InsertarCliente 
	'Ernesto', 'Vargas', 'Cordero', 'ernesto.vargas@example.com', '5551112234', '1986-11-08', 'M',
	'Boulevard Las Torres', '888', 'Campestre', 'Morelia', 'Michoacán', '58000';

EXEC InsertarCliente 
	'Adriana', 'López', 'Silva', 'adriana.lopez@example.com', '5552223345', '1999-05-21', 'F',
	'Avenida Insurgentes', '999', 'Roma Norte', 'Ciudad de México', 'Ciudad de México', '06700';

EXEC InsertarCliente 
	'Felipe', 'Ramón', 'Delgado', 'felipe.ramon@example.com', '5553334456', '1991-08-16', 'M',
	'Calle Emiliano Zapata', '1001', 'Centro', 'Tlaxcala', 'Tlaxcala', '90000';




----- CREACION DE PROCEDURE Proveedor ----------------------
--select * from Proveedor;

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
GO

EXEC InsertarProveedor 
	'Distribuidora de Películas MX', 'DPM850101ABC', 'contacto@peliculasmx.com', '5543214567', '1985-01-01', 
	'Av. Insurgentes Sur', '100', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100';

EXEC InsertarProveedor 
	'Snacks y Dulces', 'SDN900202DEF', 'ventas@snacksnorte.com', '5556547890', '1990-02-02', 
	'Calle Hidalgo', '200', 'Centro', 'Ciudad de México', 'Ciudad de México', '64000';

EXEC InsertarProveedor 
	'Servicios de Seguridad', 'SSA980505MNO', 'contacto@seguridadacapulco.com', '5553217890', '1998-05-05', 
	'Av. Costera Miguel Alemán', '500', 'Centro', 'Ciudad de México', 'Ciudad de México', '39300';

EXEC InsertarProveedor 
	'Lácteos y Botanas', 'LBM910606PQR', 'ventas@lacteosbotanasmorelia.com', '5557891234', '1991-06-06', 
	'Calle Madero', '600', 'Centro', 'Ciudad de México', 'Ciudad de México', '58000';

EXEC InsertarProveedor 
	'Publicidad y Carteles', 'PCQ930707STU', 'info@publicidadqueretaro.com', '5554563210', '1993-07-07', 
	'Boulevard Bernardo ', '700', 'Centro', 'Ciudad de México', 'Ciudad de México', '76000';

EXEC InsertarProveedor 
	'Proyecciones Digitales MX', 'PDM920808GHI', 'contacto@proyeccionesmx.com', '5551112233', '1992-08-08',
	'Avenida Universidad', '101', 'Copilco', 'Ciudad de México', 'Ciudad de México', '04360';

EXEC InsertarProveedor 
	'Limpieza Integral Cine', 'LIC950909JKL', 'servicios@limpiezacine.com', '5552223344', '1995-09-09',
	'Calle Río Churubusco', '202', 'Coyoacán', 'Ciudad de México', 'Ciudad de México', '04100';

EXEC InsertarProveedor 
	'Palomitas del Valle', 'PDV870707LMN', 'ventas@palomitasvalle.com', '5553334455', '1987-07-07',
	'Avenida División del Norte', '303', 'Del Valle', 'Ciudad de México', 'Ciudad de México', '03100';

EXEC InsertarProveedor 
	'Tecnología Cinemática', 'TCM880505XYZ', 'ventas@tecnocine.mx', '5554445566', '1988-05-05',
	'Calzada de Tlalpan', '404', 'Portales', 'Ciudad de México', 'Ciudad de México', '03300';

EXEC InsertarProveedor 
	'Refrigeración y Climas Toluca', 'RCT990101QWE', 'contacto@climastoluca.com', '7225556677', '1999-01-01',
	'Calle Lerdo', '505', 'Centro', 'Toluca', 'Estado de México', '50000';


----- CREACION DE PROCEDURE Sucursal ----------------------
--select * from Sucursal;

GO
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
GO

EXEC InsertarSucursal 
	'Plaza Universidad', 'Av. Universidad', '1000', 'Santa Cruz Atoyac', 'Ciudad de México', 'Ciudad de México', '03310';

EXEC InsertarSucursal 
	'Plaza Satélite', 'Circuito Centro Comercial', '2251', 'Ciudad Satélite', 'Ciudad de México', 'Ciudad de México', '53100';

EXEC InsertarSucursal 
	'Parque Delta', 'Av. Cuauhtémoc', '462', 'Piedad Narvarte', 'Ciudad de México', 'Ciudad de México', '03000';

EXEC InsertarSucursal 
	'Perisur', 'Anillo Periférico Sur', '4690', 'Jardines del Pedregal', 'Ciudad de México', 'Ciudad de México', '04500';

EXEC InsertarSucursal 
	'Mítikah', 'Av. Río Churubusco', '601', 'Xoco', 'Ciudad de México', 'Ciudad de México', '03330';



----- CREACION DE PROCEDURE Pelicula ----------------------
--select * from Pelicula;

GO
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

EXEC InsertarPelicula 
	'Dune: Parte Dos', 'Ciencia Ficción', 'PG-13', '165 minutos', 'Inglés', 'S', '2024-03-01';

EXEC InsertarPelicula 
	'Intensamente 2', 'Animación', 'PG', '100 minutos', 'Inglés', 'S', '2024-06-14';

EXEC InsertarPelicula 
	'Deadpool & Wolverine', 'Acción', 'R', '127 minutos', 'Inglés', 'S', '2024-07-26';

EXEC InsertarPelicula 
	'Misión: Imposible 8', 'Acción', 'PG-13', '150 minutos', 'Inglés', 'S', '2025-05-23';

EXEC InsertarPelicula 
	'La Sombra del Futuro', 'Thriller', 'PG-13', '118 minutos', 'Inglés', 'N', '2025-10-17';


---------TABLAS DEPENDIENTES (4)------------------
----- CREACION DE PROCEDURE Empleado ----------------------
select * from Empleado;
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
	-- Validar género
	IF @genero_empleado NOT IN ('M', 'F')
	BEGIN
		RAISERROR ('El valor de género debe ser M o F', 16,1 );
		RETURN;
	END
	-- Validar turno
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

EXEC InsertarEmpleado 
	'Carlos', 'Ramírez', 'Hernández', 'carlos.ramirez@email.com', '5512345678',
	'1990-04-12', 'M', 'Av. Reforma', '123', 'Centro', 'Ciudad de México',
	'Ciudad de México', '06000', 'CARH900412HDFMRN03', 'Gerente', 'M', '1';

EXEC InsertarEmpleado 
	'María', 'Gómez', 'Sánchez', 'maria.gomez@email.com', '5598765432',
	'1995-09-30', 'F', 'Calle Juárez', '456', 'Doctores', 'Ciudad de México',
	'Ciudad de México', '06720', 'GOSM950930MDFMNR07', 'Taquillera', 'V', '1';

EXEC InsertarEmpleado 
	'Luis', 'Fernández', 'Pérez', 'luis.fernandez@email.com', '5532124598',
	'1988-01-25', 'M', 'Insurgentes Sur', '789', 'Del Valle', 'Ciudad de México',
	'Ciudad de México', '03100', 'FEPL880125HDFRLS05', 'Proyeccionista', 'M', '1';

EXEC InsertarEmpleado 
	'Ana', 'Martínez', 'López', 'ana.martinez@email.com', '5546781234',
	'1992-07-15', 'F', 'Av. Universidad', '321', 'Copilco', 'Ciudad de México',
	'Ciudad de México', '04360', 'MOLA920715MDFRPN04', 'Vendedora', 'V', '1';

EXEC InsertarEmpleado 
	'José', 'Hernández', 'Ramírez', 'jose.hernandez@email.com', '5567812345',
	'1985-11-05', 'M', 'Eje Central', '654', 'Portales', 'Ciudad de México',
	'Ciudad de México', '03300', 'HEJR851105HDFRMS09', 'Encargado de Dulcería', 'M', '1';

EXEC InsertarEmpleado 
	'Valeria', 'Torres', 'Jiménez', 'valeria.torres@email.com', '5544123366',
	'1996-03-22', 'F', 'Calle Oaxaca', '111', 'Roma Norte', 'Ciudad de México',
	'Ciudad de México', '06700', 'TOJV960322MDFRML03', 'Taquillera', 'V', 2;

EXEC InsertarEmpleado 
	'Andrés', 'López', 'González', 'andres.lopez@email.com', '5551239876',
	'1993-08-10', 'M', 'Calle Morelos', '222', 'Centro', 'Ciudad de México',
	'Ciudad de México', '06010', 'LOGA930810HDFPNR08', 'Proyeccionista', 'M', 2;

EXEC InsertarEmpleado 
	'Paola', 'Mendoza', 'Ríos', 'paola.mendoza@email.com', '5567894561',
	'1997-06-05', 'F', 'Av. Insurgentes Norte', '333', 'San Rafael', 'Ciudad de México',
	'Ciudad de México', '06470', 'MERP970605MDFRLS02', 'Vendedora', 'V', 2;

EXEC InsertarEmpleado 
	'Iván', 'García', 'Delgado', 'ivan.garcia@email.com', '5554327890',
	'1990-12-18', 'M', 'Calz. Tlalpan', '444', 'Portales', 'Ciudad de México',
	'Ciudad de México', '03300', 'GADI901218HDFRNV04', 'Encargado de Dulcería', 'M', 2;

EXEC InsertarEmpleado 
	'Sofía', 'Ruiz', 'Navarro', 'sofia.ruiz@email.com', '5543216789',
	'1994-02-14', 'F', 'Av. División del Norte', '555', 'Del Valle', 'Ciudad de México',
	'Ciudad de México', '03100', 'RUNS940214MDFLZF03', 'Taquillera', 'M', 2;

EXEC InsertarEmpleado 
	'Rodrigo', 'Cruz', 'Molina', 'rodrigo.cruz@email.com', '5567123490',
	'1991-10-29', 'M', 'Calle Durango', '666', 'Roma Sur', 'Ciudad de México',
	'Ciudad de México', '06760', 'CUMR911029HDFNRD01', 'Proyeccionista', 'V', 3;

EXEC InsertarEmpleado 
	'Daniela', 'Santos', 'Luna', 'daniela.santos@email.com', '5534567812',
	'1998-04-03', 'F', 'Eje 6 Sur', '777', 'Narvarte', 'Ciudad de México',
	'Ciudad de México', '03020', 'SALD980403MDFLNR08', 'Vendedora', 'M', 3;

EXEC InsertarEmpleado 
	'Fernando', 'Reyes', 'Ponce', 'fernando.reyes@email.com', '5523456789',
	'1989-09-09', 'M', 'Av. Revolución', '888', 'Tacubaya', 'Ciudad de México',
	'Ciudad de México', '11870', 'REFP890909HDFLNS05', 'Encargado de Limpieza', 'V', 3;

EXEC InsertarEmpleado 
	'Monserrat', 'Peña', 'Castañeda', 'monserrat.pena@email.com', '5547651234',
	'1993-11-11', 'F', 'Av. Patriotismo', '999', 'Escandón', 'Ciudad de México',
	'Ciudad de México', '11800', 'PECM931111MDFRRN03', 'Supervisora', 'M', 3;

EXEC InsertarEmpleado 
	'Javier', 'Moreno', 'Salas', 'javier.moreno@email.com', '5567891230',
	'1987-01-07', 'M', 'Av. Coyoacán', '1010', 'Del Valle Centro', 'Ciudad de México',
	'Ciudad de México', '03100', 'MOSJ870107HDFNRS06', 'Gerente', 'V', 3;



----- CREACION DE PROCEDURE Funcion ----------------------
select * from Funcion;
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
GO

EXEC InsertarFuncion 
    '2025-05-01', '10:00', 'A001', 'Estreno', 150.00, 1;

EXEC InsertarFuncion 
    '2025-05-07', '13:00', 'A002', 'General', 120.00, 2;

EXEC InsertarFuncion 
    '2025-05-07', '17:00', 'B001', '3D', 180.00, 3;

EXEC InsertarFuncion 
    '2025-05-16', '20:00', 'B002', 'Estreno', 200.00, 4;

EXEC InsertarFuncion 
    '2025-05-16', '12:00', 'C001', 'General', 130.00, 5;



----- CREACION DE PROCEDURE Promocion ----------------------
select * from Promocion;
GO
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
GO


EXEC InsertarPromocion 
    'Descuento', '10% en boletos para todos', '2025-05-15', 10.00, 1;

EXEC InsertarPromocion 
    'Combo', 'Combo de 2 boletos + palomitas', '2025-05-20', 15.00, 2;

EXEC InsertarPromocion 
    'Estreno', 'Promoción de estreno: 20% de descuento', '2025-06-01', 20.00, 3;

EXEC InsertarPromocion 
    'Familiar', '2 boletos para adultos y 2 para niños a mitad de precio', '2025-06-05', 50.00, 4;

EXEC InsertarPromocion 
    'Lunes de descuento', 'Descuento de 30% en boletos todos los lunes', '2025-06-07', 30.00, 5;


----- CREACION DE PROCEDURE Venta ----------------------
select * from Venta;
GO
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
GO

EXEC InsertarVenta 
    '2025-05-10', '15:30:00', 1, 1, 1, 2, 180.00;

EXEC InsertarVenta 
    '2025-05-11', '18:00:00', 2, 1, 2, 2, 220.00;

EXEC InsertarVenta 
    '2025-05-12', '20:00:00', 3, 3, 3, 2, 
    @total_venta = 250.00;

EXEC InsertarVenta 
    '2025-05-13', '14:30:00', 1, 4, 4, 2, 300.00;

EXEC InsertarVenta 
    '2025-05-14', '16:45:00', 1, 4, 5, 2, 200.00;

	
