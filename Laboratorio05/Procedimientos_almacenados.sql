--Procedimientos almacenados --clientes
select * from clientes;

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'clientes';


-- Agregando la columna para que nos pueda ayudar con la eliminación lógica
ALTER TABLE Clientes
ADD Activo BIT NOT NULL DEFAULT 1;

-- SP insertar
CREATE PROCEDURE USP_InsertarCliente
    @idCliente VARCHAR(10),
    @NombreCompañia VARCHAR(100),
    @NombreContacto VARCHAR(100),
    @CargoContacto VARCHAR(100),
    @Direccion VARCHAR(100),
    @Ciudad VARCHAR(100),
    @Region VARCHAR(100),
    @CodPostal VARCHAR(20),
    @Pais VARCHAR(100),
    @Telefono VARCHAR(50),
    @Fax VARCHAR(50)
AS
BEGIN
    INSERT INTO dbo.clientes (
        idCliente, NombreCompañia, NombreContacto, CargoContacto,
        Direccion, Ciudad, Region, CodPostal, Pais,
        Telefono, Fax, Activo
    )
    VALUES (
        @idCliente, @NombreCompañia, @NombreContacto, @CargoContacto,
        @Direccion, @Ciudad, @Region, @CodPostal, @Pais,
        @Telefono, @Fax, 1
    );
END;

USP_InsertarCliente 'AAAAA', 'Nunez Company', 'Santiago Nuñez', 'Propietario', 'Cascanueces', 'Lima', 'Lima', '15011', 'Perú', '999000999','989898'


-- SP Actualizar Clientes
CREATE PROCEDURE USP_ActualizarCliente
    @idCliente VARCHAR(10),
    @NombreCompañia VARCHAR(100),
    @NombreContacto VARCHAR(100),
    @CargoContacto VARCHAR(100),
    @Direccion VARCHAR(100),
    @Ciudad VARCHAR(100),
    @Region VARCHAR(100),
    @CodPostal VARCHAR(20),
    @Pais VARCHAR(100),
    @Telefono VARCHAR(50),
    @Fax VARCHAR(50)
AS
BEGIN
    UPDATE dbo.clientes
    SET 
        NombreCompañia = @NombreCompañia,
        NombreContacto = @NombreContacto,
        CargoContacto = @CargoContacto,
        Direccion = @Direccion,
        Ciudad = @Ciudad,
        Region = @Region,
        CodPostal = @CodPostal,
        Pais = @Pais,
        Telefono = @Telefono,
        Fax = @Fax
    WHERE idCliente = @idCliente;
END;

USP_ActualizarCliente 'AAAAA', 'Nunez Company', 'Santiago Nuñez', 'Propietario', 'Cascanueces 123', 'Lima', 'Lima', '15011', 'Perú', '999000999','989898'

-- SP Eliminar, pero lógico :D

CREATE PROCEDURE USP_EliminarCliente
    @idCliente VARCHAR(10)
AS
BEGIN
    UPDATE dbo.clientes
    SET Activo = 0
    WHERE idCliente = @idCliente;
END;

USP_EliminarCliente 'ANTON'


-- SP Listar clientes

CREATE PROCEDURE USP_ListarClientes
AS
BEGIN
    SELECT 
        idCliente,
        NombreCompañia,
        NombreContacto,
        CargoContacto,
        Direccion,
        Ciudad,
        Region,
        CodPostal,
        Pais,
        Telefono,
        Fax
    FROM dbo.clientes
    WHERE Activo = 1;
END;

USP_ListarClientes

select * from clientes;

-- Procedimiento almacenado alterado para que pueda ver el campo activo

ALTER PROCEDURE USP_ListarClientes
AS
BEGIN
    SELECT 
        idCliente,
        NombreCompañia,
        NombreContacto,
        CargoContacto,
        Direccion,
        Ciudad,
        Region,
        CodPostal,
        Pais,
        Telefono,
        Fax,
		Activo
    FROM dbo.clientes
    WHERE Activo = 1;
END;

USP_ListarClientes

select * from clientes;