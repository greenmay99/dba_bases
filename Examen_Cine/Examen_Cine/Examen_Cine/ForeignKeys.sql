----- ALTER TABLES ----------------------
use Cine;

ALTER TABLE Empleado
ADD CONSTRAINT FK_id_sucursal_empleado
FOREIGN KEY (id_sucursal_empleado) REFERENCES Sucursal (id_sucursal);


ALTER TABLE Venta
ADD CONSTRAINT FK_id_pelicula_venta FOREIGN KEY (id_pelicula_venta) REFERENCES Pelicula (id_pelicula),
	CONSTRAINT FK_id_funcion_venta FOREIGN KEY (id_funcion_venta) REFERENCES Funcion (id_funcion),
	CONSTRAINT FK_promocion_venta FOREIGN KEY (id_promocion_venta) REFERENCES Promocion (id_promocion),
	CONSTRAINT FK_empleado_venta FOREIGN KEY (id_empleado_venta) REFERENCES Empleado (id_empleado)
;

ALTER TABLE Funcion
ADD CONSTRAINT FK_id_sucursal_funcion 
	FOREIGN KEY (id_sucursal_funcion) REFERENCES Sucursal (id_sucursal)
;

ALTER TABLE Promocion
ADD CONSTRAINT FK_id_pelicula_promocion
	FOREIGN KEY (id_pelicula_promocion) REFERENCES Pelicula (id_pelicula)
;