------------------------------- DML -------------------------------
-- Tuplas en tabla Cliente 
INSERT INTO Cliente
VALUES
	(1, 'Ana', 'Pérez', '3201234567', 'ana.perez@mail.com'),
	(2, 'Luis', 'Gómez', '3107654321', 'luis.gomez@mail.com'),
	(3, 'Nikol', 'Rivera', '3187654834', 'nikol.rivera@mail.com'),
	(4, 'Gross', 'Klein', '3152888277', 'gross.klein@mail.com'),
	(5, 'Juan', 'Cardenas', '3162788658', 'juan.cardenas@mail.com');

-- Tuplas en tabla Sucursal 
INSERT INTO Sucursal 
VALUES
	(1, 'Centro', 'Av. 1', 'Cra. 5', '10-20', 'Bogotá'),
	(2, 'Norte', 'Cl. 100','Cra. 11','25-30', 'Bogotá'),
	(3, 'Sur', NULL,'Cra. 86','23-40', 'Yumbo'),
	(4, 'Norte', 'Cl. 2', NULL,'82-A12', 'Cali');

-- Tuplas en tabla Vehiculo
INSERT INTO Vehiculo
VALUES
	('ABC-123', 'Toyota', 2020, TRUE, 1),
	('MIZ-246', 'Mercedes', 2023, TRUE, 2),
	('XYZ-789', 'Mazda',  2022, TRUE, 3),
	('HEL-359', 'Chevrolet',  2025, TRUE, 4);

INSERT INTO Alquiler
VALUES
	(1, DEFAULT, NULL, 4, 'ABC-123'),
	(2, DEFAULT, NULL, 3, 'MIZ-246'),
	(3, DEFAULT, NULL, 1, 'HEL-359'),
	(4, DEFAULT, NULL, 2, 'XYZ-789');

INSERT INTO Pagos 
VALUES
	(1, 2000000.00, DEFAULT, 1),
	(2, 350000.00, DEFAULT, 2),
	(3, 500000.00, DEFAULT, 3),
	(4, 1000000.00, DEFAULT, 4);

-------------------- Validación del Comportamiento DE FKs --------------------
--Probando restricciones:
-- NOT NULL:nombre de Cliente no puede ser NULL
-- Falla con violación de constraint NOT NULL
INSERT INTO Cliente(cid, nombre, apellido)
VALUES (10, NULL, 'Pérez');

-- CHECK: modelo_anho debe estar entre 2000 y 2025
-- Falla con violación de check constraint
INSERT INTO Vehiculo(placa, marca, modelo_anho, estado, sucursal_id)
VALUES ('ERR-001', 'Test', 1999, TRUE, 1);

-- CHECK monto > 0 en Pagos
-- Falla con violación de check constraint
INSERT INTO Pagos(pid, monto, fecha, aid)
VALUES (3, -50.00, DEFAULT, 1);

-- UNIQUE: email de Cliente debe ser único
-- Falla con violación de unique constraint
INSERT INTO Cliente(cid, nombre, apellido, numcel, email)
VALUES (6, 'Ana', 'Perezz', '3001112222', 'ana.perez@mail.com');

-- ON DELETE CASCADE 
-- 1. Inserto cliente y un alquiler asociado
INSERT INTO Cliente (cid, nombre, apellido, numcel, email)
VALUES (6, 'Test', 'Cascade', '3002223333', 'test.cascade@mail.com');
INSERT INTO Alquiler (aid, fecha_ini, fecha_fin, cid, placa)
VALUES (6, DEFAULT, NULL, 6, 'XYZ-789');
SELECT * FROM Alquiler WHERE aid = 6; 
-- 2. Borro el cliente 6 y verifico que su alquiler desaparece
DELETE FROM Cliente WHERE cid = 6;
SELECT * FROM Alquiler WHERE aid = 6; 

-- ON UPDATE CASCADE 
-- 1. Actualizo el PK de la sucursal 2 a 22
UPDATE Sucursal SET sucursal_id = 22 WHERE sucursal_id = 2;
SELECT * FROM Sucursal; 
-- 2. Verifico que el vehículo 'XYZ-789' haya cambiado su sucursal_id a 22
SELECT placa, sucursal_id FROM Vehiculo WHERE placa = 'MIZ-246';
