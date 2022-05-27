/*
  Comandos DDL (Data Definition Language) / DML (Data Manipulation Language)

  REQUERIMIENTOS:
  (1) Modifique la relación “ejemplar” agregando como atributo el año de la Edición.
  (2) Modifique la relación “socio” agregando un atributo que permita guardar el domicilio del Socio.
  (3) Modifique la relación “socio” agregando un atributo que permita guardar el domicilio del Socio.
  (4) Actualice la relación “socio” incrementando en 10 pesos el monto de la cuota.
  (5) Actualice la nacionalidades de Amy Farrah Fowler a Mexicana y la de Howard Wolowitz a Colombiana.
  (6) Elimine la nacionalidad Peruana.
  (7) Elimine todos los ejemplares que sean de la 3ra Edición de cualquier Libro.
*/

-- Agrega nuevo atributo -> anio_edicion <- CAMPO:
ALTER TABLE ejemplar 
ADD COLUMN anio_edicion INT;

-- Agrega nuevo atributo -> domicilio:
ALTER TABLE socio
ADD COLUMN domicilio VARCHAR(50);

-- Actualiza el atributo -monto_cuota- de la relación -socio-, incrementándolo en 10:
UPDATE socio 
SET monto_cuota=monto_cuota + 10;

-- Cambia el país de 'Amy Farrah Fowler' a 'México', y por ende su nacionalidad a 'Mexicana':
UPDATE socio
SET pais='Mexico'
WHERE nombre_y_apellido='Amy Farrah Fowler';


-- Para cambiar tipo de dato -> Agrego más longitud, sino NO entra 'Colombiana':
ALTER TABLE nacionalidad
ALTER COLUMN nacionalidad 
SET DATA TYPE VARCHAR(18);
-- Y agrego el nuevo registro a -nacionalidad- -> nueva tupla:
INSERT INTO nacionalidad(nombre_pais, nacionalidad)
VALUES('Colombia', 'Colombiana');

-- Cambia el país de 'Howard Wolowitz' a 'Colombia', y por ende su nacionalidad a 'Colombiana':
UPDATE socio
SET pais='Colombia'
WHERE nombre_y_apellido='Howard Wolowitz';

-- Elimina la nacionalidad 'Peruana':
DELETE FROM nacionalidad
WHERE nacionalidad='Peruana';

-- Necesito eliminar todos los ejemplares de la 3ra edición, pero primero debo "eliminar los préstamos" de los mismos:
DELETE FROM PRESTAMO
WHERE cod_ejemplar IN
   (SELECT cod_ejemplar
	FROM ejemplar
	WHERE edicion=3);
-- Y finalmente, sí podré eliminar los ejemplares de la 3ra edición. Sin problemas de referencias:
DELETE FROM ejemplar
WHERE edicion=3;



/*
  DML 
*/


-- PROYECCIONES -> Obtener datos de columnas en específico --

SELECT cod_socio FROM prestamo -- Proyecta el atributo -cod_socio-

SELECT cod_ejemplar FROM prestamo -- Proyecta el atributo -cod_ejemplar-

SELECT cod_ejemplar,cod_socio FROM prestamo -- Proyecta los atributos -cod_ejemplar- y -cod_socio-

SELECT nombre_y_apellido FROM socio -- Proyecta los nombres y apellidos
SELECT DISTINCT nombre_y_apellido FROM socio -- sin repetidos



-- ATRIBUTOS CALCULADOS -> Cálculos en base a atributo/s --

-- Obtiene la duración en días de cada prestamo. Proyecta 3 atributos, y el último siendo el calculado:
SELECT DISTINCT cod_ejemplar, cod_socio, 
  fecha_devolucion - fecha_prestamo 
  AS días_prestamo
FROM prestamo;
-- Otra alternativa usando -COALESCE-, en el caso en que NO haya -fecha_devolucion-(NULL):
SELECT DISTINCT cod_ejemplar, cod_socio,
  COALESCE(fecha_devolucion, CURRENT_DATE) - fecha_prestamo 
  AS DiasPrestamo
FROM prestamo;

-- Obtiene cuánto paga cada socio por año, contando la matrícula:
SELECT *, 
  monto_cuota * 12 + matricula 
  AS pago_por_anio
FROM socio;



-- SELECCIÓN -> Obtención de datos en base a una condición de atibuto/s --

-- Obtención de los ISBN de ejemplares de segunda O tercera edición:
SELECT isbn_libro FROM ejemplar
WHERE edicion = 2 OR edicion = 3;
-- ALTERNATIVA
SELECT isbn_libro FROM ejemplar
WHERE edicion IN (2, 3);

-- Obtención de los códigos de socios a los que se les prestó un libro a partir de febrero 2012:
SELECT cod_socio FROM prestamo 
WHERE fecha_prestamo>'31/01/2012'

-- Obtención de los códigos de ejemplares que fueron prestados a partir de febrero 2012:
SELECT cod_ejemplar FROM prestamo 
WHERE fecha_prestamo>'31/01/2012'



-- JOIN NATURAL -> Combinar dos tablas en base a un atributo en común --

-- Campo en común = -cod_ejemplar- --
SELECT * FROM 
prestamo NATURAL JOIN ejemplar
-- Alternativa con INNER JOIN -> Más código --
SELECT * FROM 
prestamo INNER JOIN ejemplar
USING (cod_ejemplar);

-- Campo en común = -cod_socio- --
SELECT * FROM 
prestamo NATURAL JOIN socio

-- NO tienen campo en común. Por eso especifico que -isbn- = -isbn_libro-:
SELECT * FROM 
libro JOIN ejemplar ON isbn = isbn_libro;

-- Obtención de nombres de libros con ejemplares de 2da O 3ra edición:
SELECT titulo, edicion FROM 
libro JOIN ejemplar ON isbn = isbn_libro
WHERE edicion IN (2,3);

-- Obtención de cantidad de prestamos hechos a socios registrados:
SELECT COUNT(*) FROM
socio NATURAL JOIN prestamo

-- Obtención de socios junto a cantidad de préstamos que tienen:
SELECT cod_socio, nombre_y_apellido, COUNT(cod_socio) AS prestamos FROM
socio NATURAL JOIN prestamo
GROUP BY cod_socio;














