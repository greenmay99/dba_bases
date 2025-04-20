-- 7. filtrados 
use Renapo;

select * from Nuevo_usuario;

-- mujeres entre 16 y 39

SELECT * FROM Nuevo_usuario
WHERE genero_Usuario = 'M'
AND edad_usuario BETWEEN 16 AND 39;


--hombres entre 17 y 40

SELECT * FROM Nuevo_usuario
WHERE genero_Usuario = 'H'
AND edad_usuario BETWEEN 17 AND 40;


-- tabla Filtrados

CREATE TABLE Filtrados (
	id_Filtrado INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre_Filtrado VARCHAR(50) NOT NULL,
	ap_Filtrado VARCHAR(50) NOT NULL,
	am_Filtrado VARCHAR(50) NOT NULL,
	numero_Filtrado VARCHAR(10) NOT NULL,
	genero_Filtrado VARCHAR(1) NOT NULL,
	edad_Filtrado INT NOT NULL
);

select * from Filtrados;

--insertar promedio de los filtrados anteriores, total=6 registros
-- 3 mujeres
INSERT INTO Filtrados (nombre_Filtrado, ap_Filtrado, am_Filtrado, numero_Filtrado, genero_Filtrado, edad_Filtrado)
SELECT TOP 3 
    nombre_Usuario,
    ap_Usuario,
    am_Usuario,
    numero_Usuario,
    genero_Usuario,
    edad_usuario
FROM Nuevo_usuario
WHERE genero_Usuario = 'M' AND edad_usuario BETWEEN 16 AND 39
ORDER BY NEWID(); -- Aleatorio

-- 3 hombres
INSERT INTO Filtrados (nombre_Filtrado, ap_Filtrado, am_Filtrado, numero_Filtrado, genero_Filtrado, edad_Filtrado)
SELECT TOP 3 
    nombre_Usuario,
    ap_Usuario,
    am_Usuario,
    numero_Usuario,
    genero_Usuario,
    edad_usuario
FROM Nuevo_usuario
WHERE genero_Usuario = 'H' AND edad_usuario BETWEEN 17 AND 40
ORDER BY NEWID(); -- Aleatorio
