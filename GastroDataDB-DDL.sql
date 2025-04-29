------------------------------- DDL -------------------------------
-- Tabla Cliente
-- Guarda la información de cada cliente que realiza pedidos en el restaurante
CREATE TABLE Cliente(
	id_cliente SERIAL PRIMARY KEY,
	cnombre VARCHAR(45) NOT NULL,
	capellido VARCHAR(45) NOT NULL,
	observaciones VARCHAR(45) DEFAULT NULL
);

-- Tabla Mesero
-- Registra a los meseros que atienden las mesas
CREATE TABLE Mesero(
	id_mesero SERIAL PRIMARY KEY,
	mnombre VARCHAR(45) NOT NULL,
	mapellido1 VARCHAR(45) NOT NULL,
	mapellido2 VARCHAR(45)
);

-- Tabla Platillo
-- Almacena los platillos del menú y su precio
CREATE TABLE Platillo(
	id_platillo SERIAL PRIMARY KEY,
	pnombre VARCHAR(45) NOT NULL,
	pimporte INTEGER NOT NULL CHECK (pimporte >= 0)
);

-- Tabla Bebida
-- Almacena las bebidas del menú y su precio
CREATE TABLE Bebida(
	id_bebida SERIAL PRIMARY KEY,
	bnombre VARCHAR(45) NOT NULL,
	bimporte INTEGER NOT NULL CHECK (bimporte >= 0)
);

-- Tabla Mesa
-- Registra las mesas disponibles en el restaurante, su número y ubicación
CREATE TABLE Mesa(
	id_mesa SERIAL PRIMARY KEY,
	num_comensales INT NOT NULL CHECK (num_comensales > 0),
	ubicacion VARCHAR(45) NOT NULL
);

-- Tabla Factura
-- Registra cada transacción de consumo: fecha, cliente, mesero, mesa,
-- platillo y bebida asociados
CREATE TABLE Factura(
	id_factura SERIAL PRIMARY KEY,
	-- Fecha de emisión de la factura (por defecto, fecha actual)
	fecha_factura DATE NOT NULL DEFAULT CURRENT_DATE,
	-- Llaves foráneas
	id_cliente INTEGER,
	id_mesero INTEGER,
	id_mesa INTEGER,
	id_platillo INTEGER,
	id_bebida INTEGER,
    -- Se usa ON UPDATE CASCADE por si cambia la PK del padre, se actualiza aquí
    -- Se usa ON DELETE SET NULL por si se borra un padre, en factura queda NULL
	FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
    ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_mesero) REFERENCES Mesero(id_mesero)
	ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_mesa) REFERENCES Mesa(id_mesa)
    ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_platillo) REFERENCES Platillo(id_platillo)
    ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida)
    ON UPDATE CASCADE ON DELETE SET NULL
);
