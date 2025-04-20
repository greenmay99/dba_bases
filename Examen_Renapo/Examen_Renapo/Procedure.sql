-- Insertar datos de forma más rápida
use Renapo;

CREATE TABLE Datos (
	id_dato INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	ap_pat 	VARCHAR(50) NOT NULL,
	ap_mat VARCHAR(50) NOT NULL,
	genero CHAR(1) NOT NULL CHECK (genero IN ('H', 'M')),
	edad INT NOT NULL
);


CREATE PROCEDURE InsertarDato
    @nombre VARCHAR(50),
    @ap_pat VARCHAR(50),
    @ap_mat VARCHAR(50),
    @genero CHAR(1),
    @edad INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validación opcional dentro del procedimiento
    IF @genero NOT IN ('H', 'M')
    BEGIN
        RAISERROR('El valor de género debe ser H o M.', 16, 1);
        RETURN;
    END

    INSERT INTO Datos (nombre, ap_pat, ap_mat, genero, edad)
    VALUES (@nombre, @ap_pat, @ap_mat, @genero, @edad);
END;


select * from Datos;

-- uso del PROCEDURE

EXEC InsertarDato 'Gerardo', 'Bautista', 'Garcia', 'H', 24;
EXEC InsertarDato 'Jecsan', 'Gutierrez', 'Martinez', 'H', 24;
EXEC InsertarDato 'Juventino', 'Lezama', 'Gramados', 'H', 22;
EXEC InsertarDato 'Sofia', 'Gomez', 'del Olmo', 'M', 25;
EXEC InsertarDato 'David', 'Huerta', 'Enriquez', 'H', 22;
EXEC InsertarDato 'Melanie', 'Perez', 'Gomez', 'M', 23;
EXEC InsertarDato 'Alan', 'Sanchez', 'Garcia', 'H', 22;
EXEC InsertarDato 'Uxue', 'Reyes', 'Ñuñez', 'H', 23;
EXEC InsertarDato 'Denisse', 'Perez', 'Trejo', 'M', 25;
EXEC InsertarDato 'Estrada', 'Estrada', 'Lechuga', 'H', 23;
EXEC InsertarDato 'José', 'Garcia', 'Hernandez', 'H', 23;
EXEC InsertarDato 'Angy', 'López', 'Pérez', 'M', 22;
EXEC InsertarDato 'Angel', 'Diaz', 'Campor', 'H', 20;
EXEC InsertarDato 'Roberto', 'Ruvalcaba', 'Buenrostro', 'H', 21;
EXEC InsertarDato 'Andrea', 'Romero', 'Lopez', 'M', 25;
EXEC InsertarDato 'Evelyn', 'Acevedo', 'Olvera', 'M', 25;
EXEC InsertarDato 'Carlos', 'Cortéz', 'Sanchez', 'H', 24;
EXEC InsertarDato 'Abraham', 'Navarro', 'Islas', 'H', 26;
EXEC InsertarDato 'David', 'Mejia', 'Sanchez', 'H', 25;
EXEC InsertarDato 'Leslie', 'Molina', 'Quesda', 'M', 24;
EXEC InsertarDato 'Vanesa', 'Salinas', 'Flores', 'M', 23;
EXEC InsertarDato 'Jocelyn', 'Perez', 'Cruz', 'M', 23;
EXEC InsertarDato 'Manuel', 'Romero', 'Ramirez', 'H', 26;
EXEC InsertarDato 'Dafne', 'Casillas', 'Garcia', 'M', 23;
EXEC InsertarDato 'Valeria', 'Hernandez', 'Gonzalez', 'M', 24;
EXEC InsertarDato 'Berenice', 'Mendoza', 'Reyes', 'M', 24;
EXEC InsertarDato 'Itzel', 'Perez', 'Cruz', 'M', 25;
EXEC InsertarDato 'Salma', 'Ocampo', 'Cordova', 'H', 23;
EXEC InsertarDato 'Ana', 'Garcia', 'Lopez', 'M', 24;
EXEC InsertarDato 'Areli', 'Chavez', 'Ortiz', 'M', 25;

select * from Datos;

-- mostrar ciertos numeros de datos

select * from Datos
WHERE id_dato > 20;

-- meter filtro  a una consulta donde saque el promedio de los primeros 15 registros

select AVG(edad) as edad_prom
FROM Datos
WHERE id_dato <=15;

-- generar reporte de diferentes tablas

SELECT @nombre, @ap_pat, FROM Datos
INNER JOIN 


select * from Nuevo_usuario;