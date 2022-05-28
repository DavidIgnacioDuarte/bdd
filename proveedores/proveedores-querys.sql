/*
  REQUERIMIENTOS:
  (1) Modifique la relación componente agregando como atributo la provincia de la ciudad de los Componentes.
  (2) Modifique la relación artículo agregando un atributo que permita guardar el número de serie de cada artículo.
  (3) Actualice la componente cambiando los colores rojos por violeta y los azules por marrón.
  (4) Actualice la definición de componente para que los colores posibles sean solamente {rojo, verde, azul, violeta o marrón}
  (5) Actualice la ciudad de los proveedores cuyos nombres son Carlos o Eva, y cambie su ciudad por Bahía Blanca.
  (6) Elimine todos los envios cuya cantidad esté entre 200 y 300.
  (7) Elimine los artículos de La Plata.
*/

-- Agregado de nuevo CAMPO:
ALTER TABLE componente
ADD COLUMN provincia VARCHAR(50);

ALTER TABLE articulo
ADD COLUMN nro_serie INT;

-- Actualiza cambiando colores:
UPDATE componente
SET color = CASE -- En caso de
			WHEN color = 'Rojo' -- que el color sea Rojo
			THEN 'Violeta' -- cambia a Violeta
			WHEN color = 'Azul' -- que el color sea Azul
			THEN 'Marrón' -- cambia a Marrón
			ELSE color -- Y sino es ninguno de los anteriores, lo deja como está.
			-- Si NO especificamos ELSE, el nuevo valor será NULL.
			END;

-- Restrinjo valores a sólo algunos válidos. Por ej, NO se pueden agregar componentes celestes:
ALTER TABLE componente
ADD CONSTRAINT ck_colores_validos
CHECK (color IN ('Rojo', 'Verde', 'Azul', 'Violeta', 'Marrón'));

-- Actualizo ciudades de Carlos y Eva:
UPDATE proveedor
SET ciudad = 'Bahía Blanca'
WHERE prov_nombre IN ('Carlos', 'Eva');

-- Elimina aquelos envíos cuya cantidad esté entre 200 y 300:
DELETE FROM envio
WHERE cantidad BETWEEN 200 AND 300


-- Para eliminar los artículos de La Plata, primero debo eliminar aquellos envíos de los mismos artículos.
-- Creo un TRIGGER que lo haga:
CREATE FUNCTION eliminar_envio_articulo() RETURNS TRIGGER AS $$
BEGIN
DELETE FROM envio WHERE envio.id_art = old.id_art;
RETURN OLD; -- Así, se devuelve el registro para eliminarlo con sentencia principal. Sino -> RETURN NULL, RETURN OLD;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER elimina_envio_articulo_BD
BEFORE DELETE ON articulo
FOR EACH ROW
EXECUTE PROCEDURE eliminar_envio_articulo();

-- Y así, puedo eliminar perfectamente cualquier artículo, eliminándose también su envío:
DELETE FROM articulo
WHERE ciudad = 'La Plata';



/*
  DML
*/


-- Obtener todos los detalles de todos los artículos de Bernal:
SELECT * FROM articulo
WHERE ciudad = 'Bernal';

-- Obtener todos los id_prov para proveedores que abastecen el artículo T1:
SELECT id_prov FROM
proveedor NATURAL JOIN envio
WHERE id_art = 'T1';

-- Obtener los id_art y ciudad donde el nombre de la ciudad acaba en D
-- O contiene al menos una E:
SELECT id_art, ciudad FROM articulo
WHERE ciudad LIKE '%D' OR ciudad LIKE '%e%';

-- Obtener los id_comp para los suministrados para cualquier artículo de Cap.Fed:
SELECT DISTINCT id_comp FROM
envio NATURAL JOIN componente
WHERE ciudad = 'Cap. Fed.';

-- Obtener el id_comp del (o los) componente/s con menor peso:
SELECT DISTINCT id_comp FROM componente
WHERE peso <= (SELECT min(peso) FROM componente);

-- Obtener id_prov para los proveedores que suministran para un artículo de
-- La Plata o Capital Federal, un componente Rojo:
SELECT id_prov FROM 
envio NATURAL JOIN componente
WHERE ciudad IN ('Cap. Fed.', 'La Plata') AND color = 'Rojo';

-- Obtener id_prov de los que nunca suministraron un componente verde:
SELECT id_prov FROM proveedor
WHERE id_prov NOT IN (SELECT id_prov FROM
					 envio NATURAL JOIN componente
					 WHERE color='Verde');
					 
-- Obtener, para los envíos del P2, el número de suministros de componentes realizados,
-- el de artículos distintos suministrados y la cantidad total.
SELECT id_prov, COUNT(DISTINCT id_comp) AS componentes_suministrados, 
				COUNT(DISTINCT id_art) AS artículos_suministrados,
				SUM(cantidad) AS cantidad_total_suministros
FROM envio
WHERE id_prov = 'P2' 
GROUP BY id_prov;

-- Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor:
SELECT id_prov, MAX(cantidad) AS maxima_cantidad
FROM envio
GROUP BY id_prov;

-- Para cada artículo y componente suministrado, obtener id_comp, id_art y la
-- cantidad total correspondiente:
-- OPCIÓN -> Sumando cantidades de cada objeto individualmente
SELECT id_comp AS id_objeto, SUM(cantidad) AS cantidad_total_suministrada
FROM envio
GROUP BY id_comp
UNION
SELECT id_art, SUM(cantidad) AS papa_frita
FROM envio
GROUP BY id_art
ORDER BY id_objeto;

-- Obtener los nombres de los componentes suministrados en una cant > 500:
SELECT comp_nombre, SUM(cantidad) AS cantidad_suministrada FROM
envio NATURAL JOIN componente
GROUP BY comp_nombre
HAVING SUM(cantidad) > 500;

-- Obtener los id_art para los que se ha suministrado algún componente del que se
-- haya suministrado una media superior a 420 artículos:
SELECT DISTINCT id_art FROM envio
GROUP BY id_art, id_comp
HAVING AVG(cantidad) > 420;

-- Obtener los id_prov que hayan realizado algún envío con cantidad mayor
-- que la media de los envíos realizados para el componente al que corresponda
-- dicho envío:
SELECT e1.id_prov FROM envio e1
GROUP BY e1.id_prov, e1.id_comp, e1.cantidad
HAVING e1.cantidad > (SELECT AVG(e2.cantidad) FROM envio e2
				  WHERE e1.id_comp = e2.id_comp);

-- Obtener los id_art para los cuales todos sus componentes se fabrican
-- en una misma ciudad:
SELECT e1.id_art FROM 
(envio NATURAL JOIN componente) e1
GROUP BY e1.id_art, e1.id_comp, e1.ciudad
HAVING e1.ciudad = ALL (SELECT e2.ciudad FROM
					(envio NATURAL JOIN componente) e2
					WHERE e1.id_art = e2.id_art);