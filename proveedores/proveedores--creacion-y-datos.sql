-- representa los datos de proveedores de componentes para la fabricación de
-- artículos y su ciudad de residencia:
CREATE TABLE proveedor
(id_prov VARCHAR(2) PRIMARY KEY,
prov_nombre VARCHAR(30),
categoria INT,
ciudad VARCHAR(50));

-- indica la información de piezas utilizadas en la fabricación de artículos,
-- indicándose el lugar de fabricación de dichos componentes:
CREATE TABLE componente
(id_comp VARCHAR(2) PRIMARY KEY,
comp_nombre VARCHAR(3),
color VARCHAR(15),
peso INT,
ciudad VARCHAR(50));

-- provee información sobre los diferentes artículos que se fabrican y el lugar del
-- ensamblaje de los mismos:
CREATE TABLE articulo
(id_art VARCHAR(2) PRIMARY KEY,
art_nombre VARCHAR(30), 
ciudad VARCHAR(50));

-- representa los suministros realizados por los diferentes proveedores de determinadas 
-- cantidades de componentes asignadas para la elaboración del artículo correspondiente:
CREATE TABLE envio
(id_prov VARCHAR(2),
id_comp VARCHAR(2),
id_art VARCHAR(2),
cantidad INT,
PRIMARY KEY(id_prov, id_comp, id_art),
FOREIGN KEY (id_prov) REFERENCES proveedor(id_prov),
FOREIGN KEY (id_comp) REFERENCES componente(id_comp),
FOREIGN KEY (id_art) REFERENCES articulo(id_art));

INSERT INTO proveedor
	(id_prov, prov_nombre, categoria, ciudad)
VALUES
	('P1', 'Carlos', 20, 'La Plata'),
	('P2', 'Juan', 10, 'Cap. Fed.'),
	('P3', 'Jose', 30, 'La Plata'),
	('P4', 'Dora', 20, 'La Plata'),
	('P5', 'Eva', 30, 'Bernal')
;

INSERT INTO componente
	(id_comp, comp_nombre, color, peso, ciudad)
VALUES
	('C1', 'X3A', 'Rojo', 12, 'La Plata'),
	('C2', 'B85', 'Verde', 17, 'Cap. Fed.'),
	('C3', 'C4B', 'Azul', 17, 'Quilmes'),
	('C4', 'C4B', 'Rojo', 14, 'La Plata'),
	('C5', 'VT8', 'Azul', 12, 'Cap. Fed.'),
	('C6', 'C30', 'Rojo', 19, 'La Plata')
;

INSERT INTO articulo
	(id_art, art_nombre, ciudad)
VALUES
	('T1', 'Clasificadora', 'Cap. Fed.'),
	('T2', 'Perforadora', 'Quilmes'),
	('T3', 'Lectora', 'Bernal'),
	('T4', 'Consola', 'Bernal'),
	('T5', 'Mezcladora', 'La Plata'),
	('T6', 'Terminal', 'Berazategui'),
	('T7', 'Cinta', 'La Plata')
;

INSERT INTO envio
	(id_prov, id_comp, id_art, cantidad)
VALUES
	('P1', 'C1', 'T1', 200),
	('P1', 'C1', 'T4', 700),
	('P2', 'C3', 'T1', 400),
	('P2', 'C3', 'T2', 200),
	('P2', 'C3', 'T3', 200),
	('P2', 'C3', 'T4', 500),
	('P2', 'C3', 'T5', 600),
	('P2', 'C3', 'T6', 400),
	('P2', 'C3', 'T7', 800),
	('P2', 'C5', 'T2', 100),
	('P3', 'C3', 'T1', 200),
	('P3', 'C4', 'T2', 100),
	('P4', 'C6', 'T3', 300),
	('P4', 'C6', 'T7', 300),
	('P5', 'C2', 'T2', 200),
	('P5', 'C2', 'T4', 100),
	('P5', 'C5', 'T4', 500),
	('P5', 'C5', 'T7', 100),
	('P5', 'C6', 'T2', 200),
	('P5', 'C1', 'T4', 100),
	('P5', 'C3', 'T4', 200),
	('P5', 'C4', 'T4', 800),
	('P5', 'C5', 'T5', 400),
	('P5', 'C6', 'T4', 500)
;