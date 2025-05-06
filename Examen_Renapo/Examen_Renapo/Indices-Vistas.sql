-----1. Tabla "InformacionGeneral" --------------
use Renapo;

CREATE TABLE InformacionGeneral (
	id_info_gen INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_info_gen VARCHAR(50) NOT NULL,
	ap_info_gen VARCHAR(50) NOT NULL,
	am_info_gen VARCHAR(50) NOT NULL,
	genero_info_gen CHAR(1) NOT NULL CHECK (genero_info_gen IN ('H', 'M')),
	edad_info_gen INT NOT NULL,
);

---- 2. Agregar 10 registros 
-- a) edad de 18 a 25 años
-- b) genero femenino (M-Mujer)
TRUNCATE TABLE InformacionGeneral;--eliminar registros pero dejar la estructura y reinciar indices

select * from InformacionGeneral;

INSERT INTO InformacionGeneral (nombre_info_gen, ap_info_gen, am_info_gen, genero_info_gen, edad_info_gen)
SELECT TOP 10 nombre_Usuario, ap_Usuario, am_Usuario, genero_Usuario, edad_usuario
FROM Nuevo_usuario
WHERE edad_usuario BETWEEN 18 AND 25
  AND genero_Usuario = 'M';

---necesito mas datos en NuevoUsuario
select * from Nuevo_usuario;
GO
CREATE PROCEDURE InsertarNuevoUsuario
    @nombre_Usuario VARCHAR(50),
    @ap_Usuario VARCHAR(50),
    @am_Usuario VARCHAR(50),
    @numero_Usuario VARCHAR(10),
    @genero_Usuario VARCHAR(1),
	@edad_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validación opcional dentro del procedimiento
    IF @genero_Usuario NOT IN ('H', 'M')
    BEGIN
        RAISERROR('El valor de género debe ser H o M.', 16, 1);
        RETURN;
    END

    INSERT INTO Nuevo_usuario(nombre_Usuario,ap_Usuario,am_Usuario,numero_Usuario,genero_Usuario,edad_usuario)
    VALUES (@nombre_Usuario,@ap_Usuario,@am_Usuario,@numero_Usuario,@genero_Usuario,@edad_usuario);
END;
GO

-- 10 mujeres, edad entre 18 y 25
EXEC InsertarNuevoUsuario 'Carla', 'Gómez', 'Luna', '5512345670', 'M', 18;
EXEC InsertarNuevoUsuario 'Luisa', 'Hernández', 'Ramírez', '5512345671', 'M', 19;
EXEC InsertarNuevoUsuario 'Paola', 'Sánchez', 'Molina', '5512345672', 'M', 20;
EXEC InsertarNuevoUsuario 'Juliana', 'Díaz', 'Fernández', '5512345673', 'M', 21;
EXEC InsertarNuevoUsuario 'Renata', 'Cruz', 'Torres', '5512345674', 'M', 22;
EXEC InsertarNuevoUsuario 'Andrea', 'Pérez', 'Salinas', '5512345675', 'M', 23;
EXEC InsertarNuevoUsuario 'Fernanda', 'Morales', 'Escobar', '5512345676', 'M', 24;
EXEC InsertarNuevoUsuario 'Emilia', 'Reyes', 'Gallardo', '5512345677', 'M', 25;
EXEC InsertarNuevoUsuario 'Rosa', 'Vargas', 'Ibarra', '5512345678', 'M', 19;
EXEC InsertarNuevoUsuario 'Mina', 'Lara', 'Zamora', '5512345679', 'M', 20;
EXEC InsertarNuevoUsuario 'Ana', 'Martínez', 'Soto', '5512345680', 'H', 26;
EXEC InsertarNuevoUsuario 'Laura', 'García', 'Rojas', '5512345681', 'H', 30;
EXEC InsertarNuevoUsuario 'María', 'Lopez', 'Nava', '5512345682', 'H', 22;
EXEC InsertarNuevoUsuario 'Sofía', 'Ortiz', 'Peña', '5512345683', 'H', 25;
EXEC InsertarNuevoUsuario 'Elena', 'Castillo', 'Delgado', '5512345684', 'H', 24;


---- 3. Agregar 8 reistros
-- i) edad de 20 a 30
-- ii) genero masculino
-- iii) 80-20 entre trabajador RENAPO y Representante hogar

select * from InformacionGeneral;

INSERT INTO InformacionGeneral (nombre_info_gen, ap_info_gen, am_info_gen, genero_info_gen, edad_info_gen)
SELECT 
    nombre_Trab, ap_Trab, am_Trab, genero_Trabajador, edad_Trabajador
FROM Trabajador
WHERE genero_Trabajador = 'H' AND edad_Trabajador BETWEEN 20 AND 30
ORDER BY id_Trabajador
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;


INSERT INTO InformacionGeneral (nombre_info_gen, ap_info_gen, am_info_gen, genero_info_gen, edad_info_gen)
SELECT 
    nombre_Rep, ap_Rep, am_Rep, genero_Rep, edad_Rep
FROM Representante
WHERE genero_Rep = 'H' AND edad_Rep BETWEEN 20 AND 30
ORDER BY id_Representante
OFFSET 0 ROWS FETCH NEXT 6 ROWS ONLY;





-- agregar columnas de edad y genero
ALTER TABLE Trabajador
ADD 
    edad_Trabajador INT NULL,
    genero_Trabajador CHAR(1) NULL;

---procedure Trabajador
GO
CREATE PROCEDURE InsertarTrabajador
    @nombre_Trab VARCHAR(50),
    @ap_Trab VARCHAR(50),
    @am_Trab VARCHAR(50),
    @CURP_Trab VARCHAR(18),
    @puesto_actual_Trab VARCHAR(50),
    @id_Viv_Trab INT,
    @edad_Trabajador INT,
    @genero_Trabajador CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;

    IF @genero_Trabajador NOT IN ('H', 'M')
    BEGIN
        RAISERROR('El género debe ser H (hombre) o M (mujer).', 16, 1);
        RETURN;
    END

    INSERT INTO Trabajador (
        nombre_Trab, ap_Trab, am_Trab, CURP_Trab, puesto_actual_Trab, 
        id_Viv_Trab, edad_Trabajador, genero_Trabajador
    )
    VALUES (
        @nombre_Trab, @ap_Trab, @am_Trab, @CURP_Trab, @puesto_actual_Trab, 
        @id_Viv_Trab, @edad_Trabajador, @genero_Trabajador
    );
END;
GO

EXEC InsertarTrabajador 
    'Juan', 'Ramírez', 'Gómez', 'RAMJ900101HDFTRN09', 'Analista de Datos', 1, 25, 'H';

EXEC InsertarTrabajador 
    'Carlos', 'Martínez', 'Rivas', 'MARC920202HDFTRS03', 'Diseñador Gráfico', 2, 28, 'H';

EXEC InsertarTrabajador 
    'Luis', 'Fernández', 'Luna', 'FERL910303HDFTRL05', 'Administrador', 3, 30, 'H';

EXEC InsertarTrabajador 
    'Jorge', 'Perez', 'Rivas', 'MARC920202HDFTRS03', 'Diseñador Gráfico', 2, 28, 'H';

EXEC InsertarTrabajador 
    'Rafael', 'Mora', 'Luna', 'FERL910303HDFTRL05', 'Administrador', 3, 30, 'H';

UPDATE Trabajador
SET 
    id_Viv_Trab = CASE 
                    WHEN id_Trabajador = 1 THEN 1
                    WHEN id_Trabajador = 2 THEN 2
                    WHEN id_Trabajador = 3 THEN 3
                  END,
    edad_Trabajador = CASE 
                        WHEN id_Trabajador = 1 THEN 25
                        WHEN id_Trabajador = 2 THEN 28
                        WHEN id_Trabajador = 3 THEN 30
                      END,
    genero_Trabajador = 'M'
WHERE id_Trabajador IN (1, 2, 3);


UPDATE Trabajador
SET 
    id_Viv_Trab = 3,
    edad_Trabajador = 30,
    genero_Trabajador = 'H'
WHERE id_Trabajador = 10;


select * from Representante;
-- agregar columnas de edad y genero REPRESENTANTE
ALTER TABLE Representante
ADD 
    edad_Rep INT NULL,
    genero_Rep CHAR(1) NULL;


use Renapo;
GO
CREATE PROCEDURE InsertarRepresentante
    @nombre_Rep VARCHAR(50),
    @ap_Rep VARCHAR(50),
    @am_Rep VARCHAR(50),
    @estado_civil VARCHAR(20),
    @puesto_laboral_actual VARCHAR(50),
    @ingreso_mensual DECIMAL(15,2),
    @grado_academico VARCHAR(50),
    @calle_Rep VARCHAR(50),
    @num_Rep VARCHAR(50),
    @colonia_Rep VARCHAR(50),
    @ciudad_Rep VARCHAR(50),
    @CP_Rep VARCHAR(5),
    @id_Vivienda INT,
    @edad_Rep INT,
    @genero_Rep CHAR(1)
AS
BEGIN
    SET NOCOUNT ON;

    IF @genero_Rep NOT IN ('H', 'M')
    BEGIN
        RAISERROR('El género debe ser H (hombre) o M (mujer).', 16, 1);
        RETURN;
    END

    INSERT INTO Representante (
        nombre_Rep, ap_Rep, am_Rep, estado_civil, puesto_laboral_actual,
        ingreso_mensual, grado_academico, calle_Rep, num_Rep, colonia_Rep,
        ciudad_Rep, CP_Rep, id_Vivienda, edad_Rep, genero_Rep
    )
    VALUES (
        @nombre_Rep, @ap_Rep, @am_Rep, @estado_civil, @puesto_laboral_actual,
        @ingreso_mensual, @grado_academico, @calle_Rep, @num_Rep, @colonia_Rep,
        @ciudad_Rep, @CP_Rep, @id_Vivienda, @edad_Rep, @genero_Rep
    );
END;
GO

select * from Representante;

--EXEC InsertarRepresentante 'Luis', 'García', 'Torres', 'Soltero', 'Ingeniero', 18000.00, 'Licenciatura', 'Calle Uno', '123', 'Centro', 'Monterrey', '64000', 3, 25, 'H';
--EXEC InsertarRepresentante 'Carlos', 'Ramírez', 'López', 'Casado', 'Contador', 17000.00, 'Licenciatura', 'Calle Dos', '45', 'Del Valle', 'Guadalajara', '44100', 3, 28, 'H';
--EXEC InsertarRepresentante 'Miguel', 'Hernández', 'Soto', 'Soltero', 'Mecánico', 14000.00, 'Técnico', 'Calle Tres', '78', 'Obrera', 'León', '37000', 3, 22, 'H';
--EXEC InsertarRepresentante 'Jorge', 'Ruiz', 'Martínez', 'Divorciado', 'Abogado', 20000.00, 'Maestría', 'Calle Cuatro', '15', 'Industrial', 'Toluca', '50000', 4, 30, 'H';
EXEC InsertarRepresentante 'Antonio', 'Fernández', 'Ramos', 'Soltero', 'Docente', 16000.00, 'Licenciatura', 'Calle Cinco', '12B', 'Universidad', 'Mérida', '97000', 3, 23, 'H';
EXEC InsertarRepresentante 'Roberto', 'Morales', 'Vega', 'Casado', 'Ingeniero Civil', 21000.00, 'Licenciatura', 'Calle Seis', '99', 'Roma', 'CDMX', '06700', 4, 27, 'H';
EXEC InsertarRepresentante 'Hugo', 'Sánchez', 'Nava', 'Soltero', 'Diseñador', 15000.00, 'Licenciatura', 'Calle Siete', '18', 'Nápoles', 'CDMX', '03810', 4, 21, 'H';
EXEC InsertarRepresentante 'Alberto', 'Castillo', 'Reyes', 'Casado', 'Arquitecto', 19500.00, 'Maestría', 'Calle Ocho', '36', 'Insurgentes', 'Puebla', '72000', 3, 26, 'H';
EXEC InsertarRepresentante 'Francisco', 'Luna', 'Delgado', 'Soltero', 'Chef', 15500.00, 'Licenciatura', 'Calle Nueve', '8', 'Centro', 'Querétaro', '76000', 3, 24, 'H';
EXEC InsertarRepresentante 'David', 'Cruz', 'Ortiz', 'Casado', 'Enfermero', 14000.00, 'Técnico', 'Calle Diez', '321', 'Roma Norte', 'CDMX', '06700', 3, 29, 'H';
EXEC InsertarRepresentante 'Eduardo', 'Peña', 'Jiménez', 'Soltero', 'Analista', 17000.00, 'Licenciatura', 'Av. Reforma', '501', 'Juárez', 'CDMX', '06600', 3, 20, 'H';
EXEC InsertarRepresentante 'Sergio', 'Navarro', 'Gallardo', 'Casado', 'Consultor', 23000.00, 'Maestría', 'Av. Juárez', '72', 'San Pedro', 'Monterrey', '64000', 4, 30, 'H';
EXEC InsertarRepresentante 'Iván', 'Vargas', 'Flores', 'Soltero', 'Desarrollador', 18000.00, 'Ingeniería', 'Calle 11', '88', 'Tecnológico', 'Morelia', '58000', 4, 22, 'H';
EXEC InsertarRepresentante 'Oscar', 'Campos', 'Muñoz', 'Casado', 'Supervisor', 16000.00, 'Licenciatura', 'Calle 12', '19', 'Chapultepec', 'Tijuana', '22000', 4, 27, 'H';
EXEC InsertarRepresentante 'Raúl', 'Salazar', 'Medina', 'Soltero', 'Mercadólogo', 16500.00, 'Licenciatura', 'Calle 13', '300', 'Altavista', 'Toluca', '50100', 3, 26, 'H';
EXEC InsertarRepresentante 'Arturo', 'Mendoza', 'Bautista', 'Casado', 'Gerente', 25000.00, 'Maestría', 'Calle 14', '75A', 'Santa Fe', 'CDMX', '01210', 3, 28, 'H';


---- 4. Generar indice que indique regristos entre 20 y 25 años

CREATE INDEX Indice
ON InformacionGeneral (edad_info_gen)
WHERE edad_info_gen >= 20 AND edad_info_gen <= 25;




---- 5. guardar en otra tabla "NuevaInformacion"

CREATE TABLE NuevaInformacion (
    nombre_info_gen VARCHAR(50),
    ap_info_gen VARCHAR(50),
    am_info_gen VARCHAR(50),
    genero_info_gen CHAR(1),
    edad_info_gen INT
);

INSERT INTO NuevaInformacion (nombre_info_gen, ap_info_gen, am_info_gen, genero_info_gen, edad_info_gen)
SELECT nombre_info_gen, ap_info_gen, am_info_gen, genero_info_gen, edad_info_gen
FROM InformacionGeneral
WHERE edad_info_gen >= 20 AND edad_info_gen <= 25;


select * from NuevaInformacion;


---- 6. Generar vista del punto anterior

GO
CREATE VIEW Vista AS
SELECT 
    nombre_info_gen, 
    ap_info_gen, 
    am_info_gen, 
    genero_info_gen, 
    edad_info_gen
FROM InformacionGeneral
WHERE edad_info_gen >= 20 AND edad_info_gen <= 25;
GO

SELECT * FROM Vista;
