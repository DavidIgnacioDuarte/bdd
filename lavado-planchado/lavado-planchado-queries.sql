/*
  REQUERIMIENTOS
  (1) Obtener todos los (cod_plancha, fabricante) de las planchas instaladas en sucursales que no tengan
  lavarropas ESPañoles.
  (2) Obtener todos los (cod_lavarropas, marca) de los lavarropas fabricados en BRA o que
  en la sucursal donde está instalado trabaje el empleado “johnny”
  (3) Obtener la (id_sucursal, cantidad) de lavarropas por sucursal.
  (4) Obtener el promedio de horas trabajadas por empleado, de aquellos empleados que trabajan en sucursales que
  tienen lavarropas con capacidad de más de 20 kg y cuyo promedio de horas trabajadas sea mayor a 5.
  (5) Obtener los empleados que trabajaron solamente con planchas del fabricante “Atma”.
*/

-- Planchas instaladas en sucursales en las que no hay lavarropas ESPañoles:
-- Todas las planchas instaladas - Las planchas instaladas donde hay lavarropas ESPañoles
-- OPCIÓN 1:
SELECT DISTINCT codplancha, fabricante FROM
plancha NATURAL JOIN sucursal
NATURAL JOIN lavarropas
WHERE codplancha NOT IN (SELECT codplancha
                  FROM plancha NATURAL JOIN sucursal NATURAL JOIN lavarropas
                  WHERE origen = 'ESP');

-- OPCIÓN 2:
SELECT DISTINCT codplancha, fabricante FROM
plancha NATURAL JOIN sucursal
NATURAL JOIN lavarropas
EXCEPT (SELECT codplancha, fabricante
                  FROM plancha NATURAL JOIN sucursal NATURAL JOIN lavarropas
                  WHERE origen = 'ESP');

-- OPCIÓN 3:
-- NO funciona, ya que seguirán obteniéndose planchas aún si están instaladas en sucursales donde hay
-- lavarropas españoles (se obtiene sólo si un lavarropas NO es español)
SELECT DISTINCT codplancha, fabricante FROM
plancha NATURAL JOIN sucursal
NATURAL JOIN lavarropas
WHERE origen <> 'ESP';


-- Lavarropas fabricados en BRAsil, o instalados en la sucursal donde trabaja "Johnny":
SELECT DISTINCT codlavarropas, marca
FROM lavarropas
WHERE origen = 'BRA'
UNION
SELECT DISTINCT codlavarropas, marca
FROM lavarropas NATURAL JOIN sucursal NATURAL JOIN plancha
NATURAL JOIN turno
WHERE apodo = 'Johnny';


-- Cantidad de lavarropas por cada sucursal
SELECT idsucursal, COUNT(codlavarropas) AS cantidad_lavarropas FROM
sucursal NATURAL JOIN lavarropas
GROUP BY idsucursal;

-- Promedio de horas trabajadas por empleado, donde
-- (1) la sucursal tiene lavarropas con capacidad de más de 20kg (sólamente)
-- (2) su promedio de horas trabajadas sea mayor a 5:
SELECT apodo, avg(horas) FROM
empleado NATURAL JOIN turno NATURAL JOIN plancha
NATURAL JOIN sucursal NATURAL JOIN lavarropas
WHERE capacidad > 20
GROUP BY apodo
HAVING avg(horas) > 5;

-- Empleados que solamente trabajaron con planchas 'ATMA':
-- Los que trabajaron con planchas ATMA - los que trabajaron con planchas NO ATMA:
-- OPCIÓN 1:
SELECT DISTINCT apodo FROM empleado NATURAL JOIN
turno JOIN plancha ON plancha_id = codplancha
WHERE fabricante = 'ATMA' AND
   apodo NOT IN (SELECT DISTINCT apodo FROM empleado
           NATURAL JOIN turno JOIN plancha ON plancha_id = codplancha
           WHERE fabricante <> 'ATMA');

-- OPCIÓN 2:
SELECT DISTINCT apodo FROM empleado NATURAL JOIN
turno JOIN plancha ON plancha_id = codplancha
WHERE fabricante = 'ATMA'
EXCEPT (SELECT DISTINCT apodo FROM empleado
           NATURAL JOIN turno JOIN plancha ON plancha_id = codplancha
           WHERE fabricante <> 'ATMA');




