-- Creación de tablas, -relaciones-:
CREATE TABLE tipo (
	tipo VARCHAR(40) PRIMARY KEY,
	descripcion VARCHAR(100));

CREATE TABLE producto (
	pid INT PRIMARY KEY,
	descripcion VARCHAR(70),
	tipo VARCHAR(40),
	contenido VARCHAR(40),
	CONSTRAINT fk_tipo FOREIGN KEY(tipo)
	REFERENCES tipo(tipo));

CREATE TABLE comercio (
	comercio INT PRIMARY KEY,
	nombre VARCHAR(100),
	direccion VARCHAR(250),
	barrio VARCHAR(50),
	zona VARCHAR(60));

CREATE TABLE precio (
	pid INT,
	comercio INT,
	fecha_registro DATE,
	precio DECIMAL(10,2),
	PRIMARY KEY(pid, comercio, fecha_registro),
	CONSTRAINT fk_pid FOREIGN KEY(pid)
	REFERENCES producto(pid),
	CONSTRAINT fk_comercio FOREIGN KEY(comercio)
	REFERENCES comercio(comercio));

---------------- productos ----------------------

INSERT INTO producto
(pid,descripcion,tipo,contenido)
VALUES
(100,'Pera','Bolsa','Pera'),
(110,'Zanahoria','Bolsa','Zanahoria'),
(120,'Papa','Bolsa','Papa'),
(130,'Tomate','Bolsa','Tomate'),
(140,'Avellana','Bolsa','Avellana'),
(150,'Leche','Sachet','Leche'),
(160,'Frutas Secas','Paquete','Nueces'),
(170,'Pollo','Bandeja','Pollo'),
(180,'Huevo','Paquete','Huevo'),
(190,'Muzzarella','Paquete','Muzzarella');


INSERT INTO producto
(pid,descripcion,tipo,contenido)
VALUES
(200,'Bife ancho','Bolsa','Carne vacuna'),
(210,'Asado','Bolsa','Carne vacuna'),
(220,'Choclo','Enlatado','Choclo'),
(420,'Tarta de Choclo','Paquete','Choclo'),
(430,'Pasta de Choclo','Enlatado','Choclo'),
(440,'Empanadas','Paquete','Choclo'),
(450,'Empanadas','Paquete','Carne'),
(230,'Pomelo','Bolsa','Pomelo'),
(240,'Manzana','Bolsa','Manzana'),
(250,'Pochoclo','Bolsa','Paquete'),
(460,'Pochoclo dulce Caramelo','Bolsa','Pochoclo, caramelo'),
(480,'Pochoclo dulce Chocolate','Paquete','Pochoclo, chocolate'),
(470,'Pochoclo salado','Bolsa','Pochoclo, sal'),
(260,'Fideos','Paquete','Fideos'),
(270,'Galletitas','Paquete','Galletitas'),
(280,'Criollitas','Paquete','Galletitas de agua'),
(290,'Yogur','Sachet','Yogur');


INSERT INTO producto
(pid,descripcion,tipo,contenido)
VALUES
(300,'Cerveza','Botella','Cerveza'),
(310,'Azucar','Paquete','Azucar'),
(320,'Yerba','Paquete','Yerba'),
(330,'Arvejas','Enlatado','Arvejas'),
(340,'Ricota','Bolsa','Ricota'),
(350,'Vino','Botella','Vino'),
(360,'Aceite','Botella','Aceite'),
(370,'Papas Fritas','Caja','papas, aceite'),
(380,'Mayonesa','Frasco','limon, huevo'),
(390,'Lentejas','Enlatado','Lentejas'),
(400,'Mermelada','Frasco','fruta, azucar'),
(410,'Dulce de Leche','Frasco','leche, azucar');

-- -------------- tipos ----------------------

INSERT INTO tipo (tipo,descripcion)
VALUES
('Enlatado','Descripcion de Enlatado'),
('Bolsa','Descripcion de Bolsa'),
('Sachet','Descripcion de Sachet'),
('Frasco','Descripcion de Frasco'),
('Paquete','Descripcion de Paquete'),
('Caja','Descripcion de Caja'),
('Sobre','Descripcion de Sobre'),
('Botella','Descripcion de Botella'),
('Envase Retornable','Descripcion de Envase Retornable'),
('Bandeja','Descripcion de Bandeja');

-- -------------- comercios ----------------------

INSERT INTO comercio (comercio,nombre,direccion,barrio,zona)
VALUES
(1,'Abbot','Montevideo 82 Av.','Duluth','MN'),
(2,'Denton','34715 Ac Road','San Telmo','Vienna'),
(3,'Ross',' 6304 Amet, St.','Fort Smith','Bernal'),
(4,'Aquila',', 3583 Id Road','Palermo','Moreno'),
(5,'Benedict','Las Flores Elementum Road','Vienna','Bernal'),
(6,'Beau','450 Dui. St.','Quilmes','North Island'),
(7,'Addison','Ap #603- Risus. Ave','Avellaneda','MA'),
(8,'Zephania','P.O. Box 547, 4332 Donec Road','San Telmo','Mississippi'),
(9,'Shad','3910 Molestie St.','Akron','OH'),
(10,'Howard','704 Odio. Ave','Constitucion','zaraza');

INSERT INTO comercio (comercio,nombre,direccion,barrio,zona)
VALUES
(42,'Abbot','Montevideo 82 Av.','Duluth','MN'),
(12,'Luis y Hnos','34715 Ac Road','San Telmo','Vienna'),
(13,'El padrecito',' 6304 Amet, St.','Fort Smith','Bernal'),
(14,'Aquila',', 3583 Id Road','Palermo','ON'),
(15,'Benedict','Las Flores Elementum Road','Vienna','Wilde'),
(16,'Beau','450 Dui. St.','Quilmes','North Island'),
(17,'Addison','Ap #603- Risus. Ave','Avellaneda','MA'),
(18,'Zephania','P.O. Box 547, 4332 Donec Road','Berazategui','Mississippi'),
(19,'Shad','3910 Molestie St.','Palermo','OH'),
(20,'Howard','704 Odio. Ave','Constitucion','zaraza');

-- -------------- precios ----------------------

INSERT INTO precio
(pid,comercio,fecha_registro,precio)
VALUES
(110,1,'2013-03-02','6.73'),
(120,2,'2015-05-29','13.13'),
(130,3,'2013-03-14','11.24'),
(140,4,'2015-03-30','6.42'),
(140,10,'2015-03-30','60.42'),
(140,17,'2014-08-07','54.99'),
(140,8,'2015-11-03','19.00'),
(140,3,'2014-08-07','79.80'),
(150,5,'2013-10-02','11.08'),
(160,4,'2015-09-03','6.42'),
(160,10,'2015-04-03','60.42'),
(160,17,'2014-08-07','54.99'),
(160,8,'2015-02-03','19.00'),
(160,3,'2014-08-07','79.80'),
(160,6,'2014-07-07','13.60'),
(160,13,'2014-07-07','31.20'),
(170,7,'2015-07-01','8.79'),
(180,8,'2014-01-06','12.50'),
(190,9, '2014-03-10','8.60'),
(100,10,'2014-06-12','10.80');

INSERT INTO precio
(pid,comercio,fecha_registro,precio)
VALUES
(130,3,'2013-05-04','11.99'),
(130,5,'2015-03-10','13.64'),
(130,13,'2013-10-20','13.31'),
(130,14,'2014-06-28','9.49'),
(130,15,'2015-12-05','7.53'),
(130,16,'2015-11-30','6.59'),
(130,17,'2015-08-23','8.03'),
(110,42,'2013-05-04','11.99'),
(120,12,'2015-03-10','13.64'),
(130,13,'2013-12-01','13.31'),
(140,14,'2014-12-06','9.49'),
(150,15,'2015-10-05','7.53'),
(160,16,'2015-03-11','6.59'),
(170,17,'2015-02-08','8.03'),
(180,18,'2014-11-12-','10.12'),
(190,19,'2012-11-21','8.88'),
(200,20,'2015-05-24-','14.16');


INSERT INTO precio (pid,comercio,fecha_registro,precio)
VALUES
(210,4,'2012-01-04','10.10'),
(220,14,'2014-11-12','10.10'),
(230,19,'2015-03-10','9.11'),
(240,4,'2012-07-24','8.66'),
(250,14,'2014-12-09','10.30'),
(260,19,'2015-05-05','10.60'),
(270,4,'2012-09-05','11.00'),
(280,14,'2012-09-02','11.60'),
(290,19,'2015-08-08','13.40'),
(300,4,'2015-10-10','9.64');

INSERT INTO precio
(pid,comercio,fecha_registro,precio)
VALUES
(310,2,'2014-02-09','8.86'),
(320,8,'2011-01-05','8.90'),
(330,12,'2011-01-01','5.92'),
(340,2,'2015-01-12','9.17'),
(350,8,'2014-09-07','10.10'),
(260,12,'2015-06-07','4.72'),
(270,2,'2014-08-07','8.44'),
(280,8,'2014-07-11','14.80'),
(290,12,'2015-04-08','11.30'),
(300,2,'2015-05-11','7.29');
