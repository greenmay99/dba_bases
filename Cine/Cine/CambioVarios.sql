USE Cine;

----- ALTER TABLE telefono -----

ALTER TABLE Cliente
ALTER COLUMN telefono_cliente VARCHAR(10);

ALTER TABLE Proveedor
ALTER COLUMN telefono_proveedor VARCHAR(10);

ALTER TABLE Empleado
ALTER COLUMN telefono_empleado VARCHAR(10);

----- ALTER rfc -----------------

ALTER TABLE Empleado
ALTER COLUMN rfc_empleado VARCHAR(13);

ALTER TABLE Proveedor
ALTER COLUMN rfc_proveedor VARCHAR(13);


------ ALTER drop columna ----------
use Cine;

ALTER TABLE Proveedor
DROP CONSTRAINT CK__Proveedor__gener__4CA06362;

ALTER TABLE Proveedor
DROP COLUMN genero_proveedor;

-- cambiar foregin key en tabla Empleado
use Cine;
ALTER TABLE Empleado
DROP COLUMN nombre_sucursal_empleado;

select * from Empleado;

ALTER TABLE Empleado
ADD id_sucursal_empleado INT NOT NULL;



--- CAMBIO DE NOMBRE COLUMNAS TABLA Empleado 

EXEC sp_rename 'Empleado.nombre_cliente', 'nombre_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.apePat_cliente', 'apePat_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.apeMat_cliente', 'apeMat_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.correo_cliente', 'correo_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.telefono_cliente', 'telefono_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.fechaNac_cliente', 'fechaNac_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.genero_cliente', 'genero_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.calle_cliente', 'calle_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.numero_cliente', 'numero_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.colonia_cliente', 'colonia_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.ciudad_cliente', 'ciudad_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.estado_cliente', 'estado_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.cp_cliente', 'cp_empleado', 'COLUMN';
EXEC sp_rename 'Empleado.rfc_proveedor', 'rfc_empleado', 'COLUMN';

EXEC sp_rename 'Proveedor.cp_cliente', 'cp_proveedor', 'COLUMN';

SELECT name
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Empleado');

ALTER TABLE Empleado
DROP CONSTRAINT CK__Empleado__genero__4F7CD00D;

EXEC sp_rename 'Empleado.genero_cliente', 'genero_empleado', 'COLUMN';

ALTER TABLE Empleado
ADD CONSTRAINT CK_genero_empleado CHECK (genero_empleado IN ('H', 'M'));




--SELECT * 
--FROM INFORMATION_SCHEMA.TABLES
--WHERE TABLE_NAME = 'Cliente';

--SELECT name, state_desc
--FROM sys.databases
--WHERE name = 'Cine';

--SELECT *
--FROM fn_my_permissions('dbo.Cliente', 'OBJECT');