Use Renapo;

CREATE TABLE Empleado (
	id_Empleado INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- comenzará en 1 y se incrementará en 1 con cada nuevo registro insertado
	nombre_Empleado VARCHAR(50) NOT NULL,
	ap_Empleado VARCHAR(50) NOT NULL,
	am_Empleado VARCHAR(50) NOT NULL,
	numero_Empleado VARCHAR(10) NOT NULL,
	genero_Empleado VARCHAR(1) NOT NULL,
	RFC_Empleado VARCHAR(13) NOT NULL,
	puesto_Empleado	VARCHAR(50) NOT NULL,
	fecha_ingreso DATE NOT NULL
);

CREATE TABLE Representante (
	id_Representante INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_Rep VARCHAR(50) NOT NULL,
	ap_Rep VARCHAR(50) NOT NULL,
	am_Rep VARCHAR(50) NOT NULL,
	estado_civil VARCHAR(20) NOT NULL,
	puesto_laboral_actual VARCHAR(50) NOT NULL,
	ingreso_mensual DECIMAL(15,2) NOT NULL,
	grado_academico VARCHAR(50) NOT NULL,
	calle_Rep VARCHAR(50) NOT NULL,
	num_Rep VARCHAR(50) NOT NULL,
	colonia_Rep VARCHAR(50) NOT NULL,
	ciudad_ReP VARCHAR(50) NOT NULL,
	CP_Rep VARCHAR(5) NOT NULL
);

CREATE TABLE Trabajador (
	id_Trabajador INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_Trab VARCHAR(50) NOT NULL,
	ap_Trab VARCHAR(50) NOT NULL,
	am_Trab VARCHAR(50) NOT NULL,
	CURP_Trab VARCHAR(18) NOT NULL UNIQUE,
	puesto_actual_Trab VARCHAR(50) NOT NULL
);

CREATE TABLE Vivienda (
	id_Vivienda INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	calle_Viv VARCHAR(50) NOT NULL,
	num_Viv VARCHAR(50) NOT NULL,
	colonia_Viv VARCHAR(50) NOT NULL,
	ciudad_Viv VARCHAR(50) NOT NULL,
	CP_Viv VARCHAR(5) NOT NULL,
	total_miembros_habitan INT NOT NULL CHECK (total_miembros_habitan >= 0)
);