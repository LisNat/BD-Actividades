------------------------------- CONSULTAS -------------------------------
-- 1.Obtener los vehículos disponibles en una ciudad específica
SELECT v.placa, v.marca, v.modelo_anho, v.sucursal_id FROM Vehiculo AS v
JOIN Sucursal AS s ON v.sucursal_id = s.sucursal_id
WHERE s.ciudad = 'Bogotá' AND v.estado = TRUE;

-- 2.Listar los alquileres activos con información del cliente y vehículo
SELECT a.aid, c.nombre, c.apellido, v.placa, v.marca, a.fecha_ini FROM Alquiler AS a
JOIN Cliente AS c ON a.cid = c.cid
JOIN Vehiculo AS v ON a.placa = v.placa
WHERE a.fecha_fin IS NULL;

-- 3.Calcular los ingresos totales por sucursal considerando solo vehículos con más de 3 alquileres
SELECT a.placa, v.sucursal_id, SUM(p.monto) AS ing_totales FROM Alquiler AS a
JOIN Pagos AS p ON p.aid = a.aid
JOIN Vehiculo AS v ON v.placa  = a.placa
GROUP BY v.sucursal_id, a.placa
HAVING COUNT(*) > 3;

-- 4.Filtrar solo vehículos con más de 5 alquileres (usar subconsulta)
SELECT v.* FROM Vehiculo AS v 
WHERE v.placa IN(
  SELECT a.placa FROM Alquiler as a
  GROUP BY a.placa
  HAVING COUNT(*) > 5
);

-- 5.Sumar los montos de todos los pagos asociados
SELECT SUM(p.monto) AS total_pagos FROM Pagos AS p;