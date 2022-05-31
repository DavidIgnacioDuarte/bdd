-- Actualizo la dirección del comercio 42 con el valor 'Balcarce 50':
UPDATE comercio
SET direccion = 'Balcarce 50'
WHERE comercio = 42;

-- Listar productos que el contenido sea 'Choclo' y el tipo 'Enlatado',
-- o el contenido 'Pochoclo' y tipo 'Bolsa':
SELECT pid, tipo, contenido FROM producto
WHERE contenido = 'Choclo' AND  tipo = 'Enlatado'
UNION
SELECT pid, tipo, contenido FROM producto
WHERE contenido = 'Pochoclo' AND tipo = 'Bolsa';
-- Si sólo tiene que CONTENER pochoclos:
SELECT pid, tipo, contenido FROM producto
WHERE contenido = 'Choclo' AND  tipo = 'Enlatado'
UNION
SELECT pid, tipo, contenido FROM producto
WHERE contenido LIKE 'Pochoclo%' AND tipo = 'Bolsa';
-- Más óptimo:
SELECT *
FROM producto
WHERE (contenido = 'Choclo' AND tipo = 'Enlatado') 
OR (contenido LIKE 'Pochoclo%' AND tipo = 'Bolsa');

-- Precios del tomate vendido en Bernal:
SELECT precio FROM
precio NATURAL JOIN producto NATURAL JOIN comercio
WHERE contenido = 'Tomate' AND zona = 'Bernal';

-- Comercios que venden avellanas a +$50, y también frutas secas a -$40:
SELECT comercio, nombre FROM
comercio NATURAL JOIN precio NATURAL JOIN producto
WHERE contenido = 'Avellana' AND precio > 50.00
INTERSECT
SELECT comercio, nombre FROM
comercio NATURAL JOIN precio NATURAL JOIN producto
WHERE descripcion = 'Frutas Secas' AND precio < 40.00

-- Productos vendidos en Palermo, PERO NO en San Telmo:
SELECT pid, descripcion FROM
producto NATURAL JOIN precio NATURAL JOIN comercio
WHERE barrio = 'Palermo'
EXCEPT
SELECT pid, descripcion FROM
producto NATURAL JOIN precio NATURAL JOIN comercio
WHERE barrio = 'San Telmo';

-- Precio promedio de los productos ofrecidos en cada barrio:
SELECT avg(precio), barrio FROM
comercio NATURAL JOIN precio
GROUP BY barrio;

-- Precios actuales:
-- OPCIÓN 1: JOIN
SELECT precio.*
FROM precio
JOIN (SELECT pid, comercio, max(fecha_registro) AS ultima_fecha
    FROM precio
    GROUP BY pid, comercio) AS ult_act
ON precio.pid = ult_act.pid 
AND precio.comercio = ult_act.comercio 
AND precio.fecha_registro = ult_act.ultima_fecha;
-- OPCIÓN 2: NATURAL JOIN - más óptimo
SELECT precio.*
FROM precio
NATURAL JOIN (SELECT pid, comercio, max(fecha_registro) AS fecha_registro
    FROM precio
    GROUP BY pid, comercio) AS ult_act;

-- Productos que sufrieron un aumento entre dos fechas diferentes, NO necesariamente consecutivas:
SELECT *
FROM precio AS precio1
JOIN precio AS precio2
ON precio1.pid = precio2.pid 
AND precio1.comercio = precio2.comercio
WHERE precio1.fecha_registro > precio2.fecha_registro 
AND precio1.precio > precio2.precio;

