------------------------------- DDL -------------------------------
-- Tabla Cliente
-- Almacena los datos de los clientes que alquilan vehículos
CREATE TABLE Cliente(
	cid SERIAL PRIMARY KEY,                
    nombre VARCHAR(100) NOT NULL,            
    apellido VARCHAR(100) NOT NULL,           
    numcel VARCHAR(15)  NOT NULL,            
    email VARCHAR(100) NOT NULL UNIQUE    -- Correo único por cliente
);

-- Tabla Sucursal
-- Registra las sucursales de MoveFast, con su dirección y ciudad
CREATE TABLE Sucursal(
	sucursal_id SERIAL PRIMARY KEY,
	snombre VARCHAR(100) NOT NULL,
	calle VARCHAR(20),
	carrera VARCHAR(20),
	numero VARCHAR(20),
	ciudad VARCHAR(20) NOT NULL
);

-- Tabla Vehiculo
-- Información de cada vehículo, su año, estado y sucursal actual
CREATE TABLE Vehiculo(
	placa VARCHAR(20) PRIMARY KEY,
	marca VARCHAR(100),
	modelo_anho INTEGER NOT NULL 
		CHECK(modelo_anho > 1999 and modelo_anho < 2026),
	estado BOOLEAN NOT NULL DEFAULT TRUE, -- TRUE = Disponible, FALSE = Ocupado
	sucursal_id INTEGER NOT NULL,
	FOREIGN KEY(sucursal_id) REFERENCES Sucursal(sucursal_id) 
		ON UPDATE CASCADE    -- Si cambia sucursal_id, se refleja
		ON DELETE CASCADE    -- Si borra la sucursal, borra sus vehículos
);

-- Tabla Alquiler
-- Registra cada operación de alquiler de un vehículo por un cliente
CREATE TABLE Alquiler(
	aid SERIAL PRIMARY KEY,
	fecha_ini  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin  TIMESTAMP,                         
	fecha TIMESTAMP NOT NULL,
	cid INTEGER NOT NULL,
	placa VARCHAR(20) NOT NULL,
	FOREIGN KEY(cid) REFERENCES Cliente(cid) 
	-- Eliminamos en cascada datos dependientes, así no quedan alquileres sin cliente
	ON DELETE CASCADE,     -- Si borra el cliente, borra sus alquileres
	FOREIGN KEY(placa) REFERENCES Vehiculo(placa)
	ON UPDATE CASCADE
	-- Mantengo el registro padre de Alquiler, pero limpio la referencia de vehículo borrado
	ON DELETE SET NULL     -- Si borra el vehículo, alquiler queda NULL
);
ALTER TABLE Alquiler DROP COLUMN fecha;

-- Tabla Pagos
-- Detalla los pagos asociados a cada alquiler
CREATE TABLE Pagos(
	pid SERIAL PRIMARY KEY,
	monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
	fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	aid INTEGER NOT NULL,
	FOREIGN KEY(aid) REFERENCES Alquiler(aid) ON UPDATE CASCADE
);



