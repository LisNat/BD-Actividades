------------------------------- DML -------------------------------
-- Tuplas en tabla Cliente 
INSERT INTO Cliente(id_cliente, cnombre, capellido, observaciones)
VALUES
	(1,'Manuel', 'Pedroza Gonzalez', 'Cliente VIP'),
	(2,'Liseth', 'Rivera', NULL),
	(3,'Nikol', 'Córdoba', 'Cliente VIP'),
	(4,'Ricardo','Ovalle', NULL);

-- Tuplas en tabla Mesero
INSERT INTO Mesero(id_mesero, mnombre, mapellido1, mapellido2) 
VALUES
	(1,'Carlos', 'Hernández', 'López'),
	(2,'María',  'Gómez', 'Londoño');

-- Tuplas en tabla Platillo
INSERT INTO Platillo(id_platillo, pnombre, pimporte) 
VALUES
	(1,'Arroz a la marinera', 350000),
	(2,'Arroz mixto', 50000),
	(3,'Bandeja paisa', 750000),
	(4,'Ceviche', 30000);

-- Tuplas en tabla Bebida
INSERT INTO Bebida(id_bebida, bnombre, bimporte) 
VALUES
	(1,'Agua mineral', 5000),
	(2,'Jugo natural', 18000),
	(3,'Refresco', 5000);

-- Tuplas en tabla Mesa 
INSERT INTO Mesa(id_mesa, num_comensales, ubicacion) VALUES
	(1, 4,  'Planta baja'),
	(2, 10, 'Segundo piso'),
	(3, 2,  'Terraza');

-- Tuplas en tabla Factura
--  una factura de Manuel con arroz y jugo en mesa 10 con Carlos
INSERT INTO Factura(id_factura, id_cliente, id_mesero, id_mesa, id_platillo, id_bebida)
VALUES
	(1, 1, 2, 2, 1, 2),
	(2, 2, 1, 1, 2, 3),
	(3, 3, 2, 3, 3, 2),
	(4, 4, 1, 1, 4, 1);

-- Probando restricciones
-- NOT NULL 
INSERT INTO Cliente(id_cliente, cnombre, capellido)
VALUES (10, NULL, 'Pérez');

-- CHECK
INSERT INTO Platillo(id_platillo, pnombre, pimporte)
VALUES (10, 'Prueba negativa', -50);

-- UNIQUE
INSERT INTO Mesero(id_mesero, mnombre, mapellido1)
VALUES (1, 'Juan', 'García');

-- FOREIGN KEY + ON DELETE SET NULL
-- Elimina el cliente 2 (Liseth)
DELETE FROM Cliente WHERE id_cliente = 2;
-- Comprueba en Factura
SELECT * FROM Factura WHERE id_factura = 2;