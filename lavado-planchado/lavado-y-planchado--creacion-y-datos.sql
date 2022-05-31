CREATE TABLE empleado (
  apodo varchar(30) NOT NULL PRIMARY KEY,
  edad int NOT NULL,
  telefono varchar(30)
);

CREATE TABLE sucursal (
  idsucursal varchar(40) PRIMARY KEY,
  barrio varchar(50) NOT NULL
);

CREATE TABLE lavarropas (
  codlavarropas INT NOT NULL PRIMARY KEY,
  marca varchar(20) NOT NULL,
  origen varchar(3) NOT NULL default 'ARG',
  capacidad INT NOT NULL,
  idsucursal varchar(40),
  FOREIGN KEY (idsucursal) REFERENCES sucursal(idsucursal)
);


CREATE TABLE plancha (
  codplancha int PRIMARY KEY,
  fabricante varchar(20) NOT NULL,
  idsucursal varchar(40) NOT NULL,
  FOREIGN KEY (idsucursal) REFERENCES sucursal(idsucursal)
);


CREATE TABLE turno (
  fecha TIMESTAMP NOT NULL,
  plancha_id INT NOT NULL,
  apodo varchar(30) NOT NULL,
  horas INT NOT NULL,
  PRIMARY KEY(fecha,plancha_id),
  FOREIGN KEY (apodo) REFERENCES empleado(apodo),
  FOREIGN KEY (plancha_id) REFERENCES plancha(codplancha)
);

INSERT INTO empleado (apodo,edad,telefono) VALUES ('Maggy',22,'3724-8276'),('Leilani',23,'2339-0505'),('Mariko',24,'6846-5302'),('Kylynn',25,'9935-5690'),('Aubrey',26,'8753-5063'),('Victor',27,'3864-0949'),('Caldwell',28,'7651-4290'),('Guadalupe',29,'5869-5789'),('Ronan',30,'7617-5339'),('Jena',31,'1818-4780'),('Upton',32,'8658-3645'),('Yael',33,'1299-0809'),('Denise',34,'4853-3887'),('Jaime',35,'3652-9069'),('Ginger',36,'5782-4979'),('Hedda',37,'1374-9283'),('Nigel',38,'6803-6217'),('Damian',39,'7940-3060'),('Melodie',40,'9615-8055'),('Rodrigo',41,'3122-2593'),('Emmanuel',42,'6438-3045'),('Cara',43,'2913-3194'),('Justin',44,'3427-7083'),('Alan',45,'4123-7785'),('Claire',46,'6521-5766'),('Benjamin',47,'5831-1546'),('Bruno',48,'6311-2844'),('Fredericka',49,'8115-8914'),('Brady',50,'4353-6998'),('Shana',51,'7199-9571'),('Thane',52,'3120-2841'),('Nola',53,'8951-5317'),('Sopoline',54,'2016-1147'),('Edward',55,'2538-0428'),('Samantha',56,'3427-5413'),('Gaston',57,'7564-6650'),('Lucas',58,'3841-3360'),('Orlando',59,'7068-1359'),('Jada',60,'7356-2305'),('Fidel',61,'3998-7901'),('Sawyer',62,'4639-1725'),('Samson',63,'1275-5272'),('Hanna',64,'5668-7619'),('Marvin',65,'7310-8036'),('Ayanna',20,'3798-8105'),('Isaac',30,'5086-4371'),('Chadwick',40,'3724-1627'),('Keegan',50,'1520-4324'),('Gregory',21,'2338-6090'),('Adara',31,'5449-6107');
INSERT INTO empleado (apodo,edad,telefono) VALUES ('Kim',41,'5193-1429'),('Daria',51,'3534-5809'),('Dale',61,'5818-5472'),('Selma',22,'5446-9871'),('Hollee',31,'1342-8860'),('Christian',32,'2054-0995'),('May',42,'5805-5535'),('Jenette',52,'7317-4938'),('Perry',62,'6148-6343'),('Cheryl',33,'1764-5459'),('Zeus',23,'9229-2955'),('Margaret',43,'6022-8130'),('Felipe',53,'4343-3483'),('Rosali',44,'2626-9142'),('Johnny',32,'8354-8479'),('Veda',34,'6590-3004'),('Doris',88,'4610-0601'),('Amber',20,'8503-9886'),('Maryam',63,'3501-1119'),('Shea',44,'4304-8905'),('Gabriela',24,'9114-1240'),('Daphne',34,'2448-9246'),('Regan',54,'9285-8658'),('Homero',55,'9766-4033'),('Kathleen',64,'9529-5179'),('Camille',51,'3038-4627'),('Bartolomeo',25,'3203-8031'),('Marge',35,'6752-7075'),('Rose',45,'1963-8609'),('Daniel',55,'5207-1001'),('Odessa',26,'8343-7804'),('Willa',36,'2441-1666'),('Kelly',46,'6851-5989'),('Quinlan',56,'6251-5574'),('Holmes',27,'6239-5472'),('Pablo',28,'4304-0812'),('Brynn',37,'4907-1003'),('Dara',47,'4604-6735'),('Juan Manuel',57,'6398-4269'),('Jescie',28,'2496-9441'),('Hillary',38,'6013-8334'),('Nita',48,'6805-8178'),('Signe',58,'3405-0291'),('Quynn',29,'8531-1617'),('Aaron',39,'4559-6401'),('Hayfa',49,'9217-1089'),('Tatiana',59,'6150-6412'),('Chloe',22,'2217-1684'),('Armand',18,'3394-8536'),('Lisa',21,'8806-0743');


INSERT INTO sucursal (idsucursal,barrio) 
VALUES 
('1574','Bernal'),
('3886','Wilde'),
('6408','Avellaneda'),
('1698','Berazategui'),
('2213','Don Bosco'),
('3050','Bernal'),
('0635','Don Bosco'),
('5223','Don Bosco'),
('5336','Wilde'),
('2669','Berazategui'),
('0119','Bernal'),
('0060','Berazategui'),
('2889','Bernal'),
('5985','Sarandi'),
('8988','Villa Dominico');


INSERT INTO 
lavarropas (codlavarropas,marca,origen,capacidad,idsucursal) 
VALUES 
(1, 'DREAM',    'BRA',9, '2669'),
(2, 'ATMA',     'ARG',7, '1574'),
(3, 'DREAM',    'BRA',30,'0119'),
(4, 'LONGVIE',  'CHI',7, '2669'),
(5, 'AURORA',   'UYU',9, '3050'),
(6, 'WHIRLPOOL','ESP',9, '2213'),
(7, 'ATMA',     'CHI',21,'2669'),
(8, 'AURORA',   'ARG',5, '0060'),
(9, 'LG',       'ESP',27,'3050'),
(10,'WHIRLPOOL','ARG',9, '0060'),
(11,'WHIRLPOOL','BRA',9, '8988');


INSERT INTO plancha 
(codplancha,fabricante,idsucursal) 
VALUES 
(1, 'PEABODY',  '0635'),
(2, 'ATMA',     '3050'),
(3, 'PHILIPS',  '2213'),
(4, 'LG',       '2889'),
(5, 'PHILIPS',  '5985'),
(6, 'WHIRLPOOL','0060'),
(7, 'ATMA',     '3050'),
(8, 'PEABODY',  '0119'),
(9, 'LG',       '1698'),
(10,'PEABODY',  '5223'),
(11,'PHILIPS',  '3050'),
(12,'LG',       '1574'),
(13,'WHIRLPOOL','2213'),
(14,'LG',       '0119'),
(15,'PEABODY',  '5223');


INSERT INTO turno (fecha,plancha_id,apodo,horas) 
VALUES 
('2015-06-10 09:15:10',1,'Gabriela',6),
('2015-06-10 08:00:10',2,'Pablo',8),
('2015-06-10 17:15:10',3,'Homero',6),
('2015-06-10 17:20:10',10,'Felipe',5),
('2015-06-11 17:25:10',8,'Johnny',6),
('2010-06-13 17:15:10',4,'Gabriela',4),
('2015-06-11 17:40:10',6,'Johnny',7),
('2015-06-11 17:15:10',7,'Pablo',5),
('2015-06-11 17:50:10',8,'Homero',4),
('2015-06-12 17:15:10',9,'Gabriela',5),
('2015-06-12 17:10:10',15,'Bruno',5),
('2010-06-12 17:10:10',15,'Felipe',5),
('2015-06-12 17:15:10',11,'Johnny',5),
('2015-06-12 17:15:10',12,'Bruno',4),
('2015-06-13 17:15:10',12,'Gaston',7),
('2010-06-12 17:10:10',1,'Bruno',5),
('2015-06-10 10:15:10',7,'Rosali',6),
('2015-06-13 17:15:10',4,'Gabriela',4),
('2015-06-13 17:15:10',15,'Lisa',7);

