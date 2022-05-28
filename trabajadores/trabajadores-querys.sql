/*
  REQUERIMIENTOS:
  (1) Modifique la relación trabajador agregando la edad del mismo.
  (2) Modifique la relación edificio agregando un atributo que permita guardar la ciudad del edificio.
  (3) Actualice la relación asignaciones incrementando en 4 los números de dias en las asignaciones.
  (4) Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la categoría de 1 por 4.
  (5) Elimine todos los plomeros.
  (6) Elimine los edificios que son residencias.
*/

-- Agregar el campo -edad- a la relación -TRABAJADOR-: 
ALTER TABLE trabajador
ADD COLUMN edad INT;

-- Agregar atributo que permita guardar la ciudad del edificio:
ALTER TABLE edificio
ADD COLUMN ciudad_ed VARCHAR(30);

-- Actualizada relación -ASIGNACION-, incrementando el 4 el número de días de cada asignación:
UPDATE asignacion SET num_dias = num_dias + 4;

-- Actualizadas las oficinas, mejorando su nivel de calidad a 5 y su categoría a 4, en caso de que
-- los valores previos sean de 4 y 1, respectivamente:
UPDATE edificio
SET nivel_calidad=5,categoria=4
WHERE tipo='oficina' AND nivel_calidad=4 AND categoria=1


/*
  Para eliminar a todos los plomeros, primero debo eliminar las asignaciones de los mismos, ya que si no quedarán
  problemas de referencia, al tener asignaciones los plomeros que ya no existirán en la BBDD. ¿Y cómo hago esto?
  Mi solucion fue crear un TRIGGER, cuyo efecto es el de eliminar las asignaciones correspondientes, al eliminar
  un trabajador:
*/
-- Primero, creo la función que retorna un valor tipo TRIGGER, para ejecutarla desde el mismo objeto:
CREATE FUNCTION eliminar_asignacion_trabajador() RETURNS TRIGGER AS $$
BEGIN
DELETE FROM asignacion WHERE asignacion.legajo = old.legajo;
RETURN OLD; -- Así, se devuelve el registro para eliminarlo con sentencia principal. Sino -> RETURN NULL, RETURN OLD;
END
$$ LANGUAGE plpgsql;

-- Luego, creo el trigger asociado a la relación -TRABAJADOR-:
CREATE TRIGGER elimina_asignacion_BD
BEFORE DELETE ON trabajador
FOR EACH ROW
EXECUTE PROCEDURE eliminar_asignacion_trabajador();

-- Finalmente, sí puedo ejecutar la siguiente sentencia:
DELETE FROM trabajador
WHERE oficio='plomero';

-- Así, logro eliminar a todos los plomeros junto a sus asignaciones de la relación -ASIGNACION-.


/*
  Para eliminar a los edificios, hago de igual forma otro TRIGGER, así como con los trabajadores:
*/
CREATE FUNCTION eliminar_asignacion_edificio() RETURNS TRIGGER AS $$
BEGIN
DELETE FROM asignacion WHERE asignacion.id_e = old.id_e;
RETURN OLD; -- Así, se devuelve el registro para eliminarlo con sentencia principal. Sino -> RETURN NULL, RETURN OLD;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER elimina_asignacionE_BD
BEFORE DELETE ON edificio
FOR EACH ROW
EXECUTE PROCEDURE eliminar_asignacion_edificio();

DELETE FROM edificio
WHERE tipo = 'residencia';

-- Así, logro eliminar a todos los edificios junto a sus asignaciones de la relación -ASIGNACION-.

/*
  DML 
*/

-- Nombres de los trabajadores cuya tarifa está entre 10 y 12 pesos:
SELECT nombre FROM trabajador
WHERE tarifa BETWEEN 10 AND 12;

-- Cuáles son los oficios de los trabajadores asignados al edificio 435:
SELECT nombre, oficio FROM
trabajador NATURAL JOIN asignacion
WHERE id_e = 435;

-- Indicar el nombre del trabajador y el de su supervisor:
SELECT t1.nombre AS nombre_supervisado,
       t2.nombre AS nombre_supervisor
FROM trabajador t1 JOIN trabajador t2
ON t1.legajo_supv = t2.legajo;

-- Nombre de los trabajadores asignados a oficinas:
SELECT DISTINCT nombre FROM 
trabajador NATURAL JOIN asignacion
NATURAL JOIN edificio
WHERE tipo = 'oficina';

-- ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
SELECT t1.nombre AS nombre_supervisado,
	   t1.tarifa AS tarifa_supervisado,
       t2.nombre AS nombre_supervisor,
	   t2.tarifa AS tarifa_supervisor
FROM trabajador t1 JOIN trabajador t2
ON t1.legajo_supv = t2.legajo
WHERE t1.tarifa > t2.tarifa;

-- ¿Cuál es el número total de días que se han dedicado a plomería en el edificio 312?
SELECT COUNT(num_dias) AS dias_plomeria FROM
trabajador NATURAL JOIN asignacion
WHERE oficio='plomero' AND id_e=312;

-- ¿Cuántos tipos de oficios diferentes hay?
SELECT COUNT(DISTINCT oficio) AS cantidad_oficios 
FROM trabajador;

-- Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador que informa a ese supervisor?
SELECT legajo_supv, MAX(tarifa) AS tarifa_mas_alta_supervisado
FROM trabajador
GROUP BY legajo_supv
HAVING legajo_supv IS NOT NULL; -- Para no contemplar NULL

-- Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con categoría 1? 
-- Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad máximo no mayor que 3:
SELECT tipo, avg(nivel_calidad) AS promedio_nivel_calidad_c1
FROM edificio
WHERE categoria = 1 AND nivel_calidad <= 3
GROUP BY tipo;

-- ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?
SELECT nombre, tarifa
FROM trabajador
WHERE tarifa < (SELECT avg(tarifa) FROM trabajador)
GROUP BY nombre, tarifa;

-- Y así, puedo obtener el promedio de la tarifa:
SELECT ROUND(avg(tarifa), 2) FROM trabajador;

-- Obtener promedio de la tarifa por cada oficio:
SELECT oficio, avg(tarifa) AS promedio_tarifa
FROM trabajador
GROUP BY oficio;

-- ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores 
-- que tienen su mismo oficio?
SELECT nombre, tarifa
FROM trabajador t1
WHERE tarifa < (SELECT avg(tarifa) FROM trabajador t2
         WHERE t1.oficio = t2.oficio)
GROUP BY nombre, tarifa;

-- ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores 
-- que dependen del mismo supervisor que él?
SELECT nombre, tarifa
FROM trabajador t1
WHERE tarifa < (SELECT avg(tarifa) FROM trabajador t2
         WHERE t1.oficio = t2.oficio AND
         t1.legajo_supv = t2.legajo_supv)
GROUP BY nombre, tarifa;

-- Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
-- empezaron a trabajar en él.
SELECT nombre, fecha_inicio FROM
trabajador NATURAL JOIN asignacion
WHERE id_e = 435 AND oficio = 'electricista';

-- ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
-- 12 euros?
SELECT t1.nombre AS nombre_supervisor,
     t2.nombre AS nombre_supervisado
FROM trabajador t1 JOIN trabajador t2
ON t2.legajo_supv = t1.legajo
WHERE t2.tarifa > 12;

