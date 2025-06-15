CREATE DATABASE tienda_ropa;
USE tienda_ropa;

-- TABLAS ----

IF OBJECT_ID('Usuario') IS NOT NULL DROP TABLE Usuario;

CREATE TABLE Usuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    ape_paterno VARCHAR(50),
    ape_materno VARCHAR(50),
    correo_usuario VARCHAR(100) UNIQUE NOT NULL,
    pass_usuario VARBINARY(64),
    genero_usuario NVARCHAR(15),
    cargo_usuario NVARCHAR(20) NOT NULL,
    CONSTRAINT chk_genero CHECK (genero_usuario IN ('M', 'F')),
    CONSTRAINT chk_cargo CHECK (cargo_usuario IN ('Administrador', 'Almacenista', 'Vendedor'))
);

IF OBJECT_ID('Proveedor') IS NOT NULL DROP TABLE Proveedor;

CREATE TABLE Proveedor (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre_prov VARCHAR(100) NOT NULL,
    rfc_prov VARCHAR(13) UNIQUE,
    correo_prov VARCHAR(100),
    tel_prov VARCHAR(15),
    calle_prov VARCHAR(100),
    num_prov VARCHAR(10),
    col_prov VARCHAR(100),
    ciudad_prov VARCHAR(100),
    estado_prov VARCHAR(100),
    cp_prov VARCHAR(10)
);

IF OBJECT_ID('Producto') IS NOT NULL DROP TABLE Producto;

CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto TEXT,
    tipo_de_prenda VARCHAR(50),
    talla VARCHAR(10),
    color VARCHAR(30),
    precio_compra DECIMAL(10,2),
    precio_venta DECIMAL(10,2),
    stock INT DEFAULT 0,
	id_producto_proveedor INT
);


IF OBJECT_ID('Pedido') IS NOT NULL DROP TABLE Pedido;

CREATE TABLE Pedido (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    id_pedido_proveedor INT NOT NULL,
    id_pedido_producto INT NOT NULL,
    cantidad INT NOT NULL,
    estado_pedido VARCHAR(20) CHECK (estado_pedido IN ('Pendiente', 'Recibido', 'Cancelado'))
);


IF OBJECT_ID('Venta') IS NOT NULL DROP TABLE Venta;

CREATE TABLE Venta (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    id_venta_usuario INT NOT NULL,
    id_venta_producto INT NOT NULL,
    cantidad_venta INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    monto_venta AS (cantidad_venta * precio_venta) PERSISTED
);

-- Llaves foráneas 

ALTER TABLE Producto
	ADD CONSTRAINT FK_id_producto_proveedor
		FOREIGN KEY (id_producto_proveedor) REFERENCES Proveedor(id_proveedor);

ALTER TABLE Pedido
	ADD CONSTRAINT FK_id_pedido_proveedor FOREIGN KEY (id_pedido_proveedor) REFERENCES Proveedor(id_proveedor),
		CONSTRAINT FK_id_pedido_producto FOREIGN KEY (id_pedido_producto) REFERENCES Producto(id_producto);

ALTER TABLE Venta
	ADD CONSTRAINT FK_id_venta_usuario FOREIGN KEY (id_venta_usuario) REFERENCES Usuario (id_usuario),
		CONSTRAINT FK_id_venta_producto FOREIGN KEY (id_venta_producto) REFERENCES Producto(id_producto);

-- Procedimientos almacenados para insertar datos

-- 1.Usuario
GO
CREATE OR ALTER PROCEDURE InsertarUsuario
    @nombre_usuario VARCHAR(50),
    @ape_paterno VARCHAR(50),
    @ape_materno VARCHAR(50),
    @correo_usuario VARCHAR(100),
    @pass_usuario VARCHAR(100), -- Texto plano
    @genero_usuario CHAR(1),
    @cargo_usuario VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    IF @genero_usuario NOT IN ('M', 'F')
    BEGIN
        RAISERROR('El género debe ser M o F.', 16, 1);
        RETURN;
    END

    IF @cargo_usuario NOT IN ('Administrador', 'Vendedor', 'Almacenista')
    BEGIN
        RAISERROR('Cargo no válido. Debe ser Administrador, Vendedor o Almacenista.', 16, 1);
        RETURN;
    END

    INSERT INTO Usuario (
        nombre_usuario, ape_paterno, ape_materno, correo_usuario, pass_usuario,
        genero_usuario, cargo_usuario
    )
    VALUES (
        @nombre_usuario, @ape_paterno, @ape_materno, @correo_usuario,
        HASHBYTES('SHA2_256', CONVERT(VARBINARY(100), @pass_usuario)),
        @genero_usuario, @cargo_usuario
    );
END;
GO
-- 2.Proveedor
GO
CREATE PROCEDURE InsertarProveedor
    @nombre_prov NVARCHAR(100),
    @rfc_prov NVARCHAR(13),
    @correo_prov NVARCHAR(100),
    @tel_prov NVARCHAR(15),
    @calle_prov NVARCHAR(100),
    @num_prov NVARCHAR(10),
    @col_prov NVARCHAR(100),
    @ciudad_prov NVARCHAR(100),
    @estado_prov NVARCHAR(100),
    @cp_prov NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Proveedor (nombre_prov, rfc_prov, correo_prov, tel_prov, calle_prov, num_prov, col_prov, ciudad_prov, estado_prov, cp_prov)
    VALUES (@nombre_prov, @rfc_prov, @correo_prov, @tel_prov, @calle_prov, @num_prov, @col_prov, @ciudad_prov, @estado_prov, @cp_prov);
END;
GO
-- 3.Producto

GO
CREATE PROCEDURE InsertarProducto
    @nombre_producto NVARCHAR(100),
    @descripcion_producto NVARCHAR(255),
    @tipo_de_prenda NVARCHAR(50),
    @talla NVARCHAR(10),
    @color NVARCHAR(20),
    @precio_compra DECIMAL(10,2),
    @precio_venta DECIMAL(10,2),
    @stock INT,
    @id_producto_proveedor INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Producto (nombre_producto, descripcion_producto, tipo_de_prenda, talla, color, precio_compra, precio_venta, stock, id_producto_proveedor)
    VALUES (@nombre_producto, @descripcion_producto, @tipo_de_prenda, @talla, @color, @precio_compra, @precio_venta, @stock, @id_producto_proveedor);
END;
GO
-- 4.Pedido

GO
CREATE PROCEDURE InsertarPedido
    @fecha_pedido DATE,
    @id_pedido_proveedor INT,
    @id_pedido_producto INT,
    @cantidad INT,
    @estado_pedido NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    IF @estado_pedido NOT IN ('Pendiente', 'Recibido', 'Cancelado')
    BEGIN
        RAISERROR('El estado del pedido debe ser Pendiente, Recibido o Cancelado', 16, 1);
        RETURN;
    END

    INSERT INTO Pedido (fecha_pedido, id_pedido_proveedor, id_pedido_producto, cantidad, estado_pedido)
    VALUES (@fecha_pedido, @id_pedido_proveedor, @id_pedido_producto, @cantidad, @estado_pedido);
END;
GO

-- 5.Venta

GO
CREATE PROCEDURE InsertarVenta
    @fecha_venta DATE,
    @id_venta_usuario INT,
    @id_venta_producto INT,
    @cantidad_venta INT,
    @precio_venta DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Venta (fecha_venta, id_venta_usuario, id_venta_producto, cantidad_venta, precio_venta)
    VALUES (@fecha_venta, @id_venta_usuario, @id_venta_producto, @cantidad_venta, @precio_venta);
END;
GO

-- Inserción de registros

-- usuarios

EXEC InsertarUsuario 'Ana', 'Rodriguez', 'Lopez', 'anardguez@gmail.com', 'admin123', 'M', 'Administrador';
EXEC InsertarUsuario 'Sofia', 'Rodriguez', 'Martínez', 'sofirodri12@gmail.com', 'vendedor456', 'F', 'Vendedor';
EXEC InsertarUsuario 'Luis', 'Rodriguez', 'Santos', 'luisrguez@gmail.com', 'almacen789', 'M', 'Almacenista';

-- proveedores

EXEC InsertarProveedor 'Textiles Monterrey', 'TEXM891203AB1', 'contacto@textilesmonterrey.com', '8181234567', 'Av. Juárez', '123', 'Centro', 'Monterrey', 'Nuevo León', '64000';
EXEC InsertarProveedor 'Moda Urbana SA de CV', 'MUSA850621H77', 'ventas@modaurbana.mx', '5532123456', 'Insurgentes Sur', '456', 'Del Valle', 'Ciudad de México', 'CDMX', '03100';
EXEC InsertarProveedor 'Diseños Rivera', 'DIRI920112JH2', 'contacto@disenosrivera.com', '3312345678', 'Av. Patria', '654', 'Providencia', 'Guadalajara', 'Jalisco', '44630';
EXEC InsertarProveedor 'Calzado del Centro', 'CACN870512GT3', 'ventas@calzadocentro.com', '4423456789', '5 de Febrero', '789', 'Centro', 'Querétaro', 'Querétaro', '76000';
EXEC InsertarProveedor 'Fashion Supply', 'FASU781120KP8', 'pedidos@fashionsupply.com.mx', '5555432109', 'Reforma', '234', 'Juárez', 'Ciudad de México', 'CDMX', '06600';
EXEC InsertarProveedor 'Telas y Estilo', 'TESL930101R12', 'telas@telasestilo.mx', '8187654321', 'Av. Universidad', '321', 'Mitras Centro', 'Monterrey', 'Nuevo León', '64460';
EXEC InsertarProveedor 'Distribuidora Stylo', 'DISS800101YT4', 'stylo@distristylo.com', '5522233344', 'Av. División del Norte', '1098', 'Portales', 'Ciudad de México', 'CDMX', '03300';
EXEC InsertarProveedor 'Jeans Capital', 'JECA840412XT7', 'ventas@jeanscapital.com', '3311456789', 'Av. López Mateos', '876', 'Ladrón de Guevara', 'Guadalajara', 'Jalisco', '44600';
EXEC InsertarProveedor 'Ropa Juvenil Express', 'ROJU860715TR5', 'express@ropajuvenil.com.mx', '5544556677', 'Av. Tláhuac', '4567', 'Santa María Tomatlán', 'Ciudad de México', 'CDMX', '09860';
EXEC InsertarProveedor 'Accesorios Elite', 'ACEL901023GH1', 'elite@accesorios.com.mx', '2291122334', 'Av. Díaz Mirón', '789', 'Centro', 'Veracruz', 'Veracruz', '91700';
EXEC InsertarProveedor 'Boutique Mayorista', 'BOMA990802PV9', 'mayorista@boutique.com', '6868765432', 'Blvd. Lázaro Cárdenas', '1456', 'Centro Cívico', 'Mexicali', 'Baja California', '21000';
EXEC InsertarProveedor 'Uniformes Delta', 'UNDE830923MN6', 'delta@uniformes.com', '9933344556', 'Av. Universidad', '231', 'Tabasco 2000', 'Villahermosa', 'Tabasco', '86035';
EXEC InsertarProveedor 'Moda Étnica', 'MOET760530BJ3', 'contacto@modaetnica.mx', '4443214321', 'Av. Himno Nacional', '321', 'Universitaria', 'San Luis Potosí', 'San Luis Potosí', '78290';
EXEC InsertarProveedor 'Confecciones del Bajío', 'COBA891015ZL8', 'ventas@confebajio.com', '4611234567', 'Av. Tecnológico', '900', 'Los Álamos', 'Celaya', 'Guanajuato', '38060';
EXEC InsertarProveedor 'Telas y Moda Hidalgo', 'TEMO950312KT0', 'ventas@telasyhid.com', '7711122334', 'Carretera México - Pachuca', '111', 'Centro', 'Pachuca', 'Hidalgo', '42000';

-- Mediana

EXEC InsertarProducto 'Camisa formal blanca', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'M', 'Blanco', 180.00, 349.00, 5, 1;
EXEC InsertarProducto 'Camisa formal azul claro', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'M', 'Azul claro', 180.00, 349.00, 5, 1;

EXEC InsertarProducto 'Playera básica negra', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'M', 'Negro', 75.00, 159.00, 8, 2;
EXEC InsertarProducto 'Playera básica gris', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'M', 'Gris', 75.00, 159.00, 8, 2;

EXEC InsertarProducto 'Pantalón de mezclilla', 'Jeans corte recto, azul índigo, tela resistente.', 'Pantalón', '32', 'Azul', 210.00, 429.00, 6, 3;
EXEC InsertarProducto 'Pantalón de mezclilla claro', 'Jeans corte recto, azul claro, tela resistente.', 'Pantalón', '32', 'Azul claro', 210.00, 429.00, 6, 3;

EXEC InsertarProducto 'Blusa estampada', 'Blusa de manga corta con diseño floral.', 'Blusa', 'M', 'Multicolor', 120.00, 259.00, 4, 4;
EXEC InsertarProducto 'Blusa estampada pastel', 'Blusa de manga corta con flores en tonos pastel.', 'Blusa', 'M', 'Pastel', 120.00, 259.00, 4, 4;

EXEC InsertarProducto 'Short deportivo', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'M', 'Gris', 90.00, 179.00, 3, 5;
EXEC InsertarProducto 'Short deportivo azul', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'M', 'Azul marino', 90.00, 179.00, 3, 5;

EXEC InsertarProducto 'Chamarra ligera', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'M', 'Rojo', 300.00, 599.00, 2, 6;
EXEC InsertarProducto 'Chamarra ligera azul', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'M', 'Azul', 300.00, 599.00, 2, 6;

EXEC InsertarProducto 'Sudadera con capucha', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'M', 'Negro', 250.00, 499.00, 5, 7;
EXEC InsertarProducto 'Sudadera con capucha gris', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'M', 'Gris', 250.00, 499.00, 5, 7;

EXEC InsertarProducto 'Falda plisada', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'M', 'Verde oliva', 130.00, 279.00, 2, 8;
EXEC InsertarProducto 'Falda plisada beige', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'M', 'Beige', 130.00, 279.00, 5, 8;

EXEC InsertarProducto 'Vestido casual', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'M', 'Amarillo', 190.00, 399.00, 5, 9;
EXEC InsertarProducto 'Vestido casual coral', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'M', 'Coral', 190.00, 399.00, 3, 9;

EXEC InsertarProducto 'Pantalón de vestir', 'Pantalón slim fit para eventos formales.', 'Pantalón', '32', 'Negro', 240.00, 489.00, 20, 10;
EXEC InsertarProducto 'Pantalón de vestir gris oscuro', 'Pantalón slim fit para eventos formales.', 'Pantalón', '32', 'Gris oscuro', 240.00, 489.00, 10, 10;

EXEC InsertarProducto 'Top deportivo', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'M', 'Fucsia', 100.00, 219.00, 30, 11;
EXEC InsertarProducto 'Top deportivo morado', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'M', 'Morado', 100.00, 219.00, 30, 11;

EXEC InsertarProducto 'Camiseta estampada', 'Camiseta unisex con estampado moderno.', 'Playera', 'M', 'Blanco', 90.00, 199.00, 5, 12;
EXEC InsertarProducto 'Camiseta estampada azul', 'Camiseta unisex con estampado moderno.', 'Playera', 'M', 'Azul', 90.00, 199.00, 5, 12;

EXEC InsertarProducto 'Jeans skinny', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '32', 'Azul claro', 220.00, 449.00, 5, 13;
EXEC InsertarProducto 'Jeans skinny gris', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '32', 'Gris', 220.00, 449.00, 4, 13;

EXEC InsertarProducto 'Chaleco acolchonado', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'M', 'Negro', 200.00, 399.00, 10, 14;
EXEC InsertarProducto 'Chaleco acolchonado azul marino', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'M', 'Azul marino', 200.00, 399.00, 10, 14;

EXEC InsertarProducto 'Camisa casual a cuadros', 'Camisa de manga larga con diseño a cuadros.', 'Camisa', 'M', 'Rojo/Azul', 160.00, 339.00, 4, 15;
EXEC InsertarProducto 'Camisa casual a cuadros verde', 'Camisa de manga larga con diseño a cuadros en tonos verdes.', 'Camisa', 'M', 'Verde/Azul', 160.00, 339.00, 4, 15;

-- Chica

EXEC InsertarProducto 'Camisa formal blanca', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'CH', 'Blanco', 180.00, 349.00, 5, 1;
EXEC InsertarProducto 'Camisa formal celeste', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'CH', 'Celeste', 180.00, 349.00, 5, 1;

EXEC InsertarProducto 'Playera básica negra', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'CH', 'Negro', 75.00, 159.00, 20, 2;
EXEC InsertarProducto 'Playera básica gris', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'CH', 'Gris', 75.00, 159.00, 20, 2;

EXEC InsertarProducto 'Pantalón de mezclilla', 'Jeans corte recto, azul índigo, tela resistente.', 'Pantalón', '28', 'Azul', 210.00, 429.00, 20, 3;
EXEC InsertarProducto 'Pantalón de mezclilla negro', 'Jeans corte recto, color negro, tela resistente.', 'Pantalón', '28', 'Negro', 210.00, 429.00, 20, 3;

EXEC InsertarProducto 'Blusa estampada', 'Blusa de manga corta con diseño floral.', 'Blusa', 'CH', 'Multicolor', 120.00, 259.00, 10, 4;
EXEC InsertarProducto 'Blusa estampada tropical', 'Blusa de manga corta con diseño tropical.', 'Blusa', 'CH', 'Turquesa', 120.00, 259.00, 4, 4;

EXEC InsertarProducto 'Short deportivo', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'CH', 'Gris', 90.00, 179.00, 3, 5;
EXEC InsertarProducto 'Short deportivo azul', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'CH', 'Azul marino', 90.00, 179.00, 10, 5;

EXEC InsertarProducto 'Chamarra ligera', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'CH', 'Rojo', 300.00, 599.00, 10, 6;
EXEC InsertarProducto 'Chamarra ligera negra', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'CH', 'Negro', 300.00, 599.00, 20, 6;

EXEC InsertarProducto 'Sudadera con capucha', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'CH', 'Negro', 250.00, 499.00, 30, 7;
EXEC InsertarProducto 'Sudadera con capucha gris', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'CH', 'Gris', 250.00, 499.00, 35, 7;

EXEC InsertarProducto 'Falda plisada', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'CH', 'Verde oliva', 130.00, 279.00, 5, 8;
EXEC InsertarProducto 'Falda plisada vino', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'CH', 'Vino', 130.00, 279.00, 15, 8;

EXEC InsertarProducto 'Vestido casual', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'CH', 'Amarillo', 190.00, 399.00, 15, 9;
EXEC InsertarProducto 'Vestido casual coral', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'CH', 'Coral', 190.00, 399.00, 15, 9;

EXEC InsertarProducto 'Pantalón de vestir', 'Pantalón slim fit para eventos formales.', 'Pantalón', '28', 'Negro', 240.00, 489.00, 20, 10;
EXEC InsertarProducto 'Pantalón de vestir gris', 'Pantalón slim fit para eventos formales.', 'Pantalón', '28', 'Gris oscuro', 240.00, 489.00, 20, 10;

EXEC InsertarProducto 'Top deportivo', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'CH', 'Fucsia', 100.00, 219.00, 30, 11;
EXEC InsertarProducto 'Top deportivo negro', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'CH', 'Negro', 100.00, 219.00, 30, 11;

EXEC InsertarProducto 'Camiseta estampada', 'Camiseta unisex con estampado moderno.', 'Playera', 'CH', 'Blanco', 90.00, 199.00, 20, 12;
EXEC InsertarProducto 'Camiseta estampada negra', 'Camiseta unisex con estampado moderno.', 'Playera', 'CH', 'Negro', 90.00, 199.00, 20, 12;

EXEC InsertarProducto 'Jeans skinny', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '28', 'Azul claro', 220.00, 449.00, 5, 13;
EXEC InsertarProducto 'Jeans skinny gris', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '28', 'Gris', 220.00, 449.00, 5, 13;

EXEC InsertarProducto 'Chaleco acolchonado', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'CH', 'Negro', 200.00, 399.00, 10, 14;
EXEC InsertarProducto 'Chaleco acolchonado azul', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'CH', 'Azul marino', 200.00, 399.00, 10, 14;

EXEC InsertarProducto 'Camisa casual a cuadros', 'Camisa de manga larga con diseño a cuadros.', 'Camisa', 'CH', 'Rojo/Azul', 160.00, 339.00, 40, 15;
EXEC InsertarProducto 'Camisa casual a cuadros verde', 'Camisa de manga larga con diseño a cuadros en tonos verdes.', 'Camisa', 'CH', 'Verde/Azul', 160.00, 339.00, 40, 15;

-- Larga

EXEC InsertarProducto 'Camisa formal blanca', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'L', 'Blanco', 180.00, 349.00, 5, 1;
EXEC InsertarProducto 'Camisa formal azul', 'Camisa de manga larga con botones, ideal para oficina.', 'Camisa', 'L', 'Azul claro', 180.00, 349.00, 5, 1;

EXEC InsertarProducto 'Playera básica negra', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'L', 'Negro', 75.00, 159.00, 8, 2;
EXEC InsertarProducto 'Playera básica gris', 'Playera de algodón 100%, cuello redondo.', 'Playera', 'L', 'Gris', 75.00, 159.00, 8, 2;

EXEC InsertarProducto 'Pantalón de mezclilla', 'Jeans corte recto, azul índigo, tela resistente.', 'Pantalón', '36', 'Azul', 210.00, 429.00, 6, 3;
EXEC InsertarProducto 'Pantalón de mezclilla negro', 'Jeans corte recto, color negro, tela resistente.', 'Pantalón', '36', 'Negro', 210.00, 429.00, 6, 3;

EXEC InsertarProducto 'Blusa estampada', 'Blusa de manga corta con diseño floral.', 'Blusa', 'L', 'Multicolor', 120.00, 259.00, 4, 4;
EXEC InsertarProducto 'Blusa estampada celeste', 'Blusa de manga corta con diseño floral azul claro.', 'Blusa', 'L', 'Celeste', 120.00, 259.00, 4, 4;

EXEC InsertarProducto 'Short deportivo', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'L', 'Gris', 90.00, 179.00, 3, 5;
EXEC InsertarProducto 'Short deportivo azul', 'Short ligero con elástico, ideal para ejercicio.', 'Short', 'L', 'Azul marino', 90.00, 179.00, 2, 5;

EXEC InsertarProducto 'Chamarra ligera', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'L', 'Rojo', 300.00, 599.00, 2, 6;
EXEC InsertarProducto 'Chamarra ligera negra', 'Chamarra impermeable con cierre frontal.', 'Chamarra', 'L', 'Negro', 300.00, 599.00, 2, 6;

EXEC InsertarProducto 'Sudadera con capucha', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'L', 'Negro', 250.00, 499.00, 5, 7;
EXEC InsertarProducto 'Sudadera con capucha gris', 'Sudadera afelpada con gorro y bolsa frontal.', 'Sudadera', 'L', 'Gris', 250.00, 499.00, 5, 7;

EXEC InsertarProducto 'Falda plisada', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'L', 'Verde oliva', 130.00, 279.00, 5, 8;
EXEC InsertarProducto 'Falda plisada vino', 'Falda de tela ligera, corte por encima de la rodilla.', 'Falda', 'L', 'Vino', 130.00, 279.00, 5, 8;

EXEC InsertarProducto 'Vestido casual', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'L', 'Amarillo', 190.00, 399.00, 1, 9;
EXEC InsertarProducto 'Vestido casual coral', 'Vestido corto de algodón, ideal para verano.', 'Vestido', 'L', 'Coral', 190.00, 399.00, 5, 9;

EXEC InsertarProducto 'Pantalón de vestir', 'Pantalón slim fit para eventos formales.', 'Pantalón', '36', 'Negro', 240.00, 489.00, 2, 10;
EXEC InsertarProducto 'Pantalón de vestir gris', 'Pantalón slim fit para eventos formales.', 'Pantalón', '36', 'Gris oscuro', 240.00, 489.00, 2, 10;

EXEC InsertarProducto 'Top deportivo', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'L', 'Fucsia', 100.00, 219.00, 3, 11;
EXEC InsertarProducto 'Top deportivo negro', 'Top con soporte medio, ideal para entrenamiento.', 'Top', 'L', 'Negro', 100.00, 219.00, 13, 11;

EXEC InsertarProducto 'Camiseta estampada', 'Camiseta unisex con estampado moderno.', 'Playera', 'L', 'Blanco', 90.00, 199.00, 5, 12;
EXEC InsertarProducto 'Camiseta estampada negra', 'Camiseta unisex con estampado moderno.', 'Playera', 'L', 'Negro', 90.00, 199.00, 5, 12;

EXEC InsertarProducto 'Jeans skinny', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '36', 'Azul claro', 220.00, 449.00, 4, 13;
EXEC InsertarProducto 'Jeans skinny gris', 'Jeans entallados con stretch para mayor comodidad.', 'Pantalón', '36', 'Gris', 220.00, 449.00, 4, 13;

EXEC InsertarProducto 'Chaleco acolchonado', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'L', 'Negro', 200.00, 399.00, 10, 14;
EXEC InsertarProducto 'Chaleco acolchonado vino', 'Chaleco térmico con cierre y bolsillos.', 'Chaleco', 'L', 'Vino', 200.00, 399.00, 10, 14;

EXEC InsertarProducto 'Camisa casual a cuadros', 'Camisa de manga larga con diseño a cuadros.', 'Camisa', 'L', 'Rojo/Azul', 160.00, 339.00, 10, 15;
EXEC InsertarProducto 'Camisa casual a cuadros verde', 'Camisa de manga larga con diseño a cuadros en tonos verdes.', 'Camisa', 'L', 'Verde/Blanco', 160.00, 339.00, 20, 15;

-- pedidos

EXEC InsertarPedido '2025-06-18', 9, 17, 10, 'Pendiente';
EXEC InsertarPedido '2025-06-19', 9, 18, 10, 'Pendiente';
EXEC InsertarPedido '2025-06-20', 9, 48, 5, 'Pendiente';
EXEC InsertarPedido '2025-06-21', 9, 47, 20, 'Pendiente';
EXEC InsertarPedido '2025-06-22', 5, 40, 10, 'Pendiente';
EXEC InsertarPedido '2025-06-23', 14, 27, 20, 'Pendiente';
EXEC InsertarPedido '2025-06-24', 14, 28, 10, 'Pendiente';
EXEC InsertarPedido '2025-06-25', 10, 20, 5, 'Pendiente';
EXEC InsertarPedido '2025-06-26', 3, 35, 5, 'Pendiente';
EXEC InsertarPedido '2025-06-27', 3, 36, 10, 'Pendiente';

-- ventas

EXEC InsertarVenta '2025-03-05', 2, 3, 4, 159.00;    -- Playera básica negra
EXEC InsertarVenta '2025-03-10', 2, 15, 3, 279.00;   -- Falda plisada
EXEC InsertarVenta '2025-03-12', 2, 50, 2, 489.00;   -- Pantalón de vestir gris
EXEC InsertarVenta '2025-03-18', 2, 7, 5, 499.00;    -- Sudadera con capucha
EXEC InsertarVenta '2025-03-20', 2, 28, 2, 399.00;   -- Chaleco acolchonado azul marino
EXEC InsertarVenta '2025-04-02', 2, 8, 3, 259.00;    -- Blusa estampada pastel
EXEC InsertarVenta '2025-04-05', 2, 12, 5, 599.00;   -- Chamarra ligera azul
EXEC InsertarVenta '2025-04-08', 2, 29, 4, 339.00;   -- Camisa casual a cuadros
EXEC InsertarVenta '2025-04-10', 2, 40, 3, 179.00;   -- Short deportivo azul
EXEC InsertarVenta '2025-04-15', 2, 13, 4, 499.00;   -- Sudadera con capucha gris
EXEC InsertarVenta '2025-04-18', 2, 62, 5, 349.00;   -- Camisa formal azul
EXEC InsertarVenta '2025-04-22', 2, 84, 3, 199.00;   -- Camiseta estampada negra
EXEC InsertarVenta '2025-05-01', 2, 65, 2, 429.00;   -- Pantalón de mezclilla
EXEC InsertarVenta '2025-05-05', 2, 87, 3, 399.00;   -- Chaleco acolchonado
EXEC InsertarVenta '2025-05-07', 2, 18, 4, 399.00;   -- Vestido casual coral
EXEC InsertarVenta '2025-05-10', 2, 53, 2, 199.00;   -- Camiseta estampada
EXEC InsertarVenta '2025-05-13', 2, 77, 5, 399.00;   -- Vestido casual
EXEC InsertarVenta '2025-05-16', 2, 89, 3, 339.00;   -- Camisa casual a cuadros
EXEC InsertarVenta '2025-05-20', 2, 10, 4, 489.00;   -- Pantalón de vestir
EXEC InsertarVenta '2025-05-25', 2, 24, 3, 199.00;   -- Camiseta estampada azul

-- select * from Venta;

-- Práctica 5 

-- a. rol Administrador con todos lo privilegios

CREATE LOGIN login_admin WITH PASSWORD = 'adminTienda-789';

CREATE USER user_admin FOR LOGIN login_admin;

ALTER ROLE db_owner ADD MEMBER user_admin;

-- b. usuarios con jefatura y/o coordinación, con acceso a flujos de operacion importantes

CREATE LOGIN login_jefe_pedidos WITH PASSWORD = 'userPedidos-1';
CREATE LOGIN login_jefe_almacen WITH PASSWORD = 'userAlmacen-1';
CREATE LOGIN login_jefe_ventas WITH PASSWORD = 'userVentas-1';

CREATE USER user_jefe_pedidos FOR LOGIN login_jefe_pedidos;
CREATE USER user_jefe_almacen FOR LOGIN login_jefe_almacen;
CREATE USER user_jefe_ventas FOR LOGIN login_jefe_ventas;

-- otorgar permisos:

GRANT SELECT, INSERT, UPDATE ON Pedido TO user_jefe_pedidos;
GRANT SELECT, INSERT, UPDATE ON Producto TO user_jefe_almacen;
GRANT SELECT, INSERT, UPDATE ON Venta TO user_jefe_ventas;

-- c. rol Vendedor con acceso solo para insertar ventas

CREATE LOGIN login_vendedor WITH PASSWORD = 'vendedor-1';

CREATE USER user_vendedor FOR LOGIN login_vendedor;

GRANT INSERT ON Venta TO user_vendedor;
GRANT SELECT ON Producto TO user_vendedor;

-- d. rol Cliente con permisos de compra y validar compra

CREATE LOGIN login_cliente WITH PASSWORD = 'cliente-1!';

CREATE USER user_cliente FOR LOGIN login_cliente;

GRANT SELECT ON Producto TO user_cliente;
GRANT INSERT ON Venta TO user_cliente;
GRANT SELECT ON Venta TO user_cliente;

-- e. corroborar la vulnerabilidad de la base

EXECUTE AS USER = 'user_vendedor';
DELETE FROM Venta WHERE id_venta = 1;
REVERT;

EXECUTE AS USER = 'user_jefe_almacen';
SELECT * FROM Usuario;
REVERT;

EXECUTE AS USER = 'user_cliente';
SELECT * FROM Pedido;
REVERT;

EXECUTE AS USER = 'user_admin';
CREATE TABLE TablaPruebaPermisos (id INT);
DROP TABLE TablaPruebaPermisos;
REVERT;
