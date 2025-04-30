------------------------------- CONSULTAS -------------------------------
-- 1.Obtener el nombre y apellido de los clientes que hayan consumido un platillo específico
SELECT c.cnombre, c.capellido FROM Cliente AS c
JOIN Factura AS f ON f.id_cliente = c.id_cliente
JOIN Platillo AS p ON p.id_platillo = f.id_platillo
WHERE p.pnombre = 'Ceviche';

-- 2.Obtener el nombre y apellido de los clientes que hayan consumido arroz a la marinera
SELECT c.cnombre, c.capellido FROM Cliente AS c
JOIN Factura AS f ON f.id_cliente = c.id_cliente
JOIN Platillo AS p ON p.id_platillo = f.id_platillo
WHERE p.pnombre = 'Arroz a la marinera';

-- 3.Listar el nombre del mesero y la fecha en la que atendió una mesa 10 que se encuentra 
-- ubicada en el segundo piso del restautante
SELECT m.mnombre, m.mapellido1, m.mapellido2, f.fecha_factura FROM Mesero AS m
JOIN Factura AS f ON f.id_mesero = m.id_mesero
JOIN Mesa AS s ON s.id_mesa = f.id_mesa
WHERE s.num_comensales = 10 AND s.ubicacion = 'Segundo piso';

-- 4.Mostrar el nombre de los clientes junto con los nombres de las bebidas que consumieron 
-- en sus facturas
SELECT c.cnombre, c.capellido, b.bnombre FROM Cliente AS c
JOIN Factura AS f ON f.id_cliente = c.id_cliente
JOIN Bebida AS b ON b.id_bebida = f.id_bebida;

-- 5.Consultar todas las facturas que incluyan platillos con un importe mayor a $300000, 
-- incluyendo el nombre del cliente y del platillo
SELECT f.id_factura, c.cnombre, p.pnombre, p.pimporte FROM Factura AS f
JOIN Cliente AS c ON c.id_cliente  = f.id_cliente
JOIN Platillo AS p ON p.id_platillo = f.id_platillo
WHERE p.pimporte > 300000;

-- 6.Listar el total de consumo (importe de platillos y bebidas) del cliente llamado 
-- Manuel Pedroza Gonzalez
SELECT c.cnombre, c.capellido, SUM(p.pimporte + b.bimporte) AS total FROM Cliente c
JOIN Factura AS f ON f.id_cliente  = c.id_cliente
JOIN Platillo AS p ON p.id_platillo = f.id_platillo
JOIN Bebida AS b ON b.id_bebida = f.id_bebida
WHERE c.cnombre  = 'Manuel' AND c.capellido = 'Pedroza Gonzalez'
GROUP BY c.cnombre, c.capellido;

-- 7.Liste las mesas que han sido utilizadas al menos una vez, indicando su ubicación
-- y el número de comensales
SELECT m.id_mesa, m.ubicacion, m.num_comensales FROM Mesa AS m
JOIN Factura AS f ON f.id_mesa = m.id_mesa;