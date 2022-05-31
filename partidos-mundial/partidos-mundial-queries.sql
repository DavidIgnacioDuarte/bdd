/*
  REQUERIMIENTOS:
  (1) Agregar 3 tuplas a la tabla tarjeta_amarilla.
  (2) Actualizar la cantidad de banderitas del Minerao a 3000 banderitas.
  (3) Obtener la cantidad de goles convertidos por el jugador “Messi” en el partido 103243.
  (4) Obtener nombre y cantidad de banderitas de los estadios donde haya dirigido algún
  árbitro que haya sacado tarjeta roja y al menos una tarjeta amarilla.
  (5) Obtener el nombre de los jugadores que hayan recibidos tarjetas amarillas pero no tarjetas rojas.
  (6) Obtener los nombres de las selecciones con arqueros goleadores y defensores goleadores.
  (7) Obtener los nombres de jugadores expulsados por doble amarilla.
  (8) Obtener la tabla de equipos ordenados de mayor a menor de acuerdo a la cantidad de goles que convirtieron.
*/

-- Insertadas tarjetas amarillas respetando referencias a partidos existentes, y jugadores existentes:
INSERT INTO tarjeta_amarilla VALUES
(103251, 'Messi', 45),
(103294, 'Mascherano', 23),
(103283, 'Boris Lambert', 66);

-- Actualizadas banderitas de 'MINERAO':
UPDATE estadio
SET cantidad_banderitas = 3000
WHERE nombre = 'MINERAO';

-- Goles de Messi en el partido 103243:
SELECT count(id_partido) AS goles_messi_p103243
FROM gol
WHERE nombre_goleador = 'Messi' AND id_partido = 103243;

-- Estadios donde se sacó alguna tarjeta amarilla y alguna roja:
SELECT DISTINCT nombre, cantidad_banderitas FROM
estadio NATURAL JOIN partido
NATURAL JOIN tarjeta_amarilla NATURAL JOIN tarjeta_roja;

-- Jugadores que recibieron tarjetas amarillas Y NO rojas:
SELECT nombre_amonestado
FROM tarjeta_amarilla
EXCEPT -- Diferencia -> Los que recibieron tarjetas amarillas - Los que recibieron rojas
SELECT nombre_amonestado
FROM tarjeta_roja;
-- OPCIÓN 2:
SELECT nombre_amonestado
FROM tarjeta_amarilla -- Amonestados que recibieron amarillas Y NO rojas:
WHERE nombre_amonestado NOT IN (SELECT nombre_amonestado
							    FROM tarjeta_roja);

-- Selecciones con algún defensor goleador Y algún arquero goleador:
SELECT nombre_seleccion FROM
jugador_de_seleccion JOIN gol
ON nombre = nombre_goleador
WHERE posicion = 'Defensa'
INTERSECT
SELECT nombre_seleccion FROM
jugador_de_seleccion JOIN gol
ON nombre = nombre_goleador
WHERE posicion = 'Arquero';


-- Jugadores que recibieron 2 amarillas en un mismo partido:
SELECT DISTINCT t1.nombre_amonestado
FROM tarjeta_amarilla t1
WHERE 2 = (SELECT COUNT(t2.nombre_amonestado) FROM tarjeta_amarilla t2
		  WHERE t1.nombre_amonestado = t2.nombre_amonestado
		  AND t1.id_partido = t2.id_partido);

-- Equipos ordenados con sus respectivos goles en todos los partidos:
SELECT nombre_seleccion, COUNT(nombre_seleccion) AS goles FROM
gol JOIN jugador_de_seleccion ON nombre = nombre_goleador
GROUP BY nombre_seleccion
ORDER BY COUNT(id_partido) DESC;