-- -------------- create's----------------------

CREATE TABLE seleccion (
  nombre_seleccion varchar(25) NOT NULL PRIMARY KEY,
  director_tecnico varchar(35) NOT NULL,
  preparador_fisico varchar(35) NOT NULL
);

CREATE TABLE estadio (
  nombre varchar(25) NOT NULL PRIMARY KEY,
  capacidad INT NOT NULL,
  cantidad_butacas INT NOT NULL,
  cantidad_banderitas INT NOT NULL
);

CREATE TABLE jugador_de_seleccion (
  nombre varchar(35) NOT NULL PRIMARY KEY,
  posicion varchar(25) NOT NULL,
  posicion_auxiliar varchar(25) NOT NULL,
  edad INT,
  nombre_seleccion varchar(25) NOT NULL
);

CREATE TABLE partido (
  id_partido INT NOT NULL PRIMARY KEY,
  equipo_local varchar(25) NOT NULL,
  equipo_visitante varchar(25) NOT NULL,
  fecha DATE,
  nombre_arbitro varchar(35) NOT NULL,
  estadio varchar(25) NOT NULL,
  FOREIGN KEY (equipo_local) REFERENCES seleccion (nombre_seleccion),
  FOREIGN KEY (equipo_visitante) REFERENCES seleccion (nombre_seleccion),
  FOREIGN KEY (estadio) REFERENCES estadio (nombre)
);

CREATE TABLE gol (
  id_partido INT NOT NULL,
  nombre_goleador varchar(35) NOT NULL,
  minuto INT NOT NULL,
  PRIMARY KEY (id_partido, nombre_goleador, minuto),
  FOREIGN KEY (nombre_goleador) REFERENCES jugador_de_seleccion (nombre),
  FOREIGN KEY (id_partido) REFERENCES partido (id_partido)
);

CREATE TABLE tarjeta_amarilla (
  id_partido INT NOT NULL,
  nombre_amonestado varchar(35) NOT NULL,
  minuto INT NOT NULL,
  PRIMARY KEY (id_partido, nombre_amonestado, minuto),
  FOREIGN KEY (nombre_amonestado) REFERENCES jugador_de_seleccion (nombre),
  FOREIGN KEY (id_partido) REFERENCES partido (id_partido)
);

CREATE TABLE tarjeta_roja (
  id_partido INT NOT NULL,
  nombre_amonestado varchar(35) NOT NULL,
  minuto INT NOT NULL,
  PRIMARY KEY (id_partido, nombre_amonestado, minuto),
  FOREIGN KEY (nombre_amonestado) REFERENCES jugador_de_seleccion (nombre),
  FOREIGN KEY (id_partido) REFERENCES partido (id_partido)
);


-- -------------- seleccion ----------------------


INSERT INTO seleccion (nombre_seleccion,director_tecnico,preparador_fisico) 
VALUES 
('Argentina','Patrick Castaneda','Maxwell Slater'),
('Uruguay','Tanner Mcdaniel','Andrew Ward'),
('Paraguay','Garrison Keller','Joshua White'),
('Chile','Benjamin Farrell','Quentin Diaz'),
('Brasil','Igor Robertson','Brian Dennis'),
('Venezuela','Jonah Slater','Theodore Hopper'),
('Italia','Kadeem Ball','Kieran Crosby'),
('Espanha','Salvador Perkins','Abel Mcgowan'),
('Inglaterra','Timothy Padilla','Bruno Garrison'),
('Iran','Zephania Sweet','Edward Burns');

INSERT INTO seleccion (nombre_seleccion,director_tecnico,preparador_fisico) 
VALUES 
('Estados Unidos','George Dyer','Cruz Schmidt'),
('Canada','Rooney Strickland','Zeph Shaffer'),
('Argelia','Rahim Finch','Devin Pruitt'),
('Angola','Dane Rose','Nash Fulton'),
('Antigua y Barbuda','Keane Horne','Samson Campbell'),
('Australia','Jesse Solis','Camden Keller'),
('Belgica','Emery David','Andrew Witt'),
('China','Orson Mcgee','Lane Gardner'),
('Corea del Norte','Akeem Beach','Kuame Stewart'),
('Japon','Jared Alexander','Ian Hood');


INSERT INTO seleccion (nombre_seleccion,director_tecnico,preparador_fisico) 
VALUES 
('Colombia','Baker Anderson','Driscoll Camacho'),
('Croacia','Acton Mooney','Ryan Galloway'),
('Costa Rica','Lucas Pennington','Randall Mcmillan'),
('Ecuador','Jeremy Cole','Abraham Lang'),
('Grecia','Hamilton Mason','Otto Gould'),
('Haiti','Nolan Leblanc','Jin Gibson'),
('Israel','Salvador Hudson','Talon Turner'),
('Lituania','Fuller Ratliff','Ivor Mann'),
('Kuwait','Arsenio Wagner','Boris Roberson'),
('Serbia','Dexter Mckenzie','Dieter Shields');


-- -------------- estadio ----------------------

INSERT INTO estadio (nombre,capacidad,cantidad_butacas,cantidad_banderitas) 
VALUES 
('MARACANA',200000,73531,44758),
('MINERAO',67695,31656,46444),
('SAN PABLO',69546,36238,40294),
('NACIONAL',47961,55858,24598),
('ARENA PANTANAL',43224,56784,22800),
('ARENA DA BAIXADA',40294,48418,17037),
('CASTELAO',64243,44072,48407),
('ARENA AMAZONIA',42406,48499,31674),
('DAS DUNAS',54222,43070,49471),
('BEIRA RIO',50363,58757,34486),
('ARENA PERNAMBUCO',42557,41209,47024),
('ARENA FONTE NOVA',52793,51748,36762);

-- -------------- jugadores de futbol ------------


INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion) 
VALUES 
('Austin Kemp','Arquero','Arquero',20,'Argentina'),
('Colt Moody','Defensa','Defensa',22,'Argentina'),
('Abel Acosta','Defensa','Defensa',24,'Argentina'),
('Ashton Byrd','Defensa','Defensa',26,'Argentina'),
('Valentine Vincent','Volante','Volante',28,'Argentina'),
('Kasper Alston','Volante','Volante',18,'Argentina'),
('Mascherano','Volante','Volante',21,'Argentina'),
('Orlando Morris','Delantero','Delantero',30,'Argentina'),
('Keegan Skinner','Delantero','Delantero',36,'Argentina'),
('Messi','Delantero','Delantero',18,'Argentina');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion) 
VALUES 
('Vaughan Peck','Arquero','Arquero',20,'Inglaterra'),
('Timothy Decker','Defensa','Defensa',22,'Inglaterra'),
('Camden Roman','Defensa','Defensa',24,'Inglaterra'),
('Wyatt Mercer','Defensa','Defensa',26,'Inglaterra'),
('Wesley Koch','Volante','Volante',28,'Inglaterra'),
('Christian Serrano','Volante','Volante',30,'Inglaterra'),
('Jameson Campos','Volante','Volante',32,'Inglaterra'),
('Lester Fuller','Delantero','Delantero',34,'Inglaterra'),
('Kennedy Castro','Delantero','Delantero',36,'Inglaterra'),
('Stewart Joyce','Delantero','Delantero',38,'Inglaterra');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion)
VALUES 
('Beau Hawkins','Arquero','Arquero',40,'Brasil'),
('Calvin Charles','Defensa','Defensa',42,'Brasil'),
('Slade Matthews','Defensa','Defensa',34,'Brasil'),
('Vernon Browning','Defensa','Defensa',36,'Brasil'),
('Paul Banks','Volante','Volante',38,'Brasil'),
('Keegan Simmons','Volante','Volante',30,'Brasil'),
('Emmanuel Davis','Volante','Volante',32,'Brasil'),
('Bruce Merrill','Delantero','Delantero',34,'Brasil'),
('Linus Bell','Delantero','Delantero',36,'Brasil'),
('Aaron Ingram','Delantero','Delantero',38,'Brasil');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion)
VALUES 
('Timon Peters','Arquero','Arquero',30,'Italia'),
('Leonard Ortiz','Defensa','Defensa',32,'Italia'),
('Boris Lambert','Defensa','Defensa',34,'Italia'),
('Hayes Thornton','Defensa','Defensa',36,'Italia'),
('Simon Hansen','Volante','Volante',38,'Italia'),
('Tarik Henry','Volante','Volante',30,'Italia'),
('Denton Norris','Volante','Volante',32,'Italia'),
('Mannix Nielsen','Delantero','Delantero',34,'Italia'),
('Amery Houston','Delantero','Delantero',36,'Italia'),
('Reese Hutchinson','Delantero','Delantero',38,'Italia');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion) 
VALUES 
('Sylvester Fleming','Arquero','Arquero',20,'Uruguay'),
('Simon Mclaughlin','Defensa','Defensa',22,'Uruguay'),
('Grant Lambert','Defensa','Defensa',24,'Uruguay'),
('Ali Rhodes','Defensa','Defensa',23,'Uruguay'),
('Sebastian Hogan','Volante','Volante',25,'Uruguay'),
('Hiram Parker','Volante','Volante',27,'Uruguay'),
('Oscar Gaines','Volante','Volante',29,'Uruguay'),
('Aquila Avila','Delantero','Delantero',31,'Uruguay'),
('Giacomo Leblanc','Delantero','Delantero',33,'Uruguay'),
('Zachary Simmons','Delantero','Delantero',35,'Uruguay');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion)
VALUES 
('Mufutau Molina','Arquero','Arquero',39,'Espanha'),
('Beck Albert','Defensa','Defensa',37,'Espanha'),
('Hilel Church','Defensa','Defensa',21,'Espanha'),
('Moses Holloway','Defensa','Defensa',23,'Espanha'),
('Acton Ortega','Volante','Volante',25,'Espanha'),
('Russell Winters','Volante','Volante',27,'Espanha'),
('Seth Kirby','Volante','Volante',29,'Espanha'),
('Marshall Ellison','Delantero','Delantero',31,'Espanha'),
('Colton Rojas','Delantero','Delantero',33,'Espanha'),
('Myles Porter','Delantero','Delantero',35,'Espanha');


INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion)
VALUES 
('Holmes Pierce','Arquero','Arquero',37,'Paraguay'),
('Daquan Hutchinson','Defensa','Defensa',39,'Paraguay'),
('Elton Battle','Defensa','Defensa',21,'Paraguay'),
('Brenden Andrews','Defensa','Defensa',22,'Paraguay'),
('Eaton Franco','Volante','Volante',23,'Paraguay'),
('Tad Rosa','Volante','Volante',24,'Paraguay'),
('Donovan Woodward','Volante','Volante',25,'Paraguay'),
('Raymond Roach','Delantero','Delantero',26,'Paraguay'),
('Jerome Robinson','Delantero','Delantero',27,'Paraguay'),
('Colton Mcdaniel','Delantero','Delantero',28,'Paraguay');

INSERT INTO jugador_de_seleccion (nombre,posicion,posicion_auxiliar,edad,nombre_seleccion)
VALUES 
('Barclay Madden','Arquero','Arquero',29,'Croacia'),
('Norman Garner','Defensa','Defensa',30,'Croacia'),
('Adrian Beach','Defensa','Defensa',31,'Croacia'),
('Giacomo Velasquez','Defensa','Defensa',32,'Croacia'),
('Aladdin Huber','Volante','Volante',33,'Croacia'),
('Leonard Rush','Volante','Volante',34,'Croacia'),
('Rajah Sherman','Volante','Volante',35,'Croacia'),
('Lucian Giles','Delantero','Delantero',36,'Croacia'),
('Reuben Shepard','Delantero','Delantero',37,'Croacia'),
('Callum Coffey','Delantero','Delantero',38,'Croacia');

-- -------------- partido  ----------------------


INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio) 
VALUES 
(103240,'Argentina','Uruguay','2018-07-04','Berk Ray','MARACANA'),
(103241,'Argentina','Paraguay','2018-02-20','Alvin Burnett','MINERAO'),
(103242,'Argentina','Chile','2018-07-04','Cairo Potter','SAN PABLO'),
(103243,'Argentina','Inglaterra','2018-03-02','Rigel Medina','NACIONAL'),
(103244,'Argentina','Espanha','2018-09-04','Brian Marks','ARENA PANTANAL'),
(103245,'Japon','Argentina','2018-05-02','Jin Simpson','ARENA DA BAIXADA'),
(103246,'Canada','Argentina','2018-12-12','Harper Shelton','CASTELAO'),
(103247,'Argelia','Argentina','2018-10-20','Lance Gillespie','BEIRA RIO'),
(103248,'Angola','Argentina','2018-09-01','Curran Rivera','DAS DUNAS'),
(103249,'Corea del Norte','Argentina','2018-12-26','Silas Schneider','ARENA FONTE NOVA');


INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio) 
VALUES 
(103250,'Italia','Australia','2018-10-23','Jarrod Fields','MARACANA'),
(103251,'Italia','Belgica','2018-12-18','Brendan Hickman','MINERAO'),
(103252,'Italia','Colombia','2018-07-02','Tyrone Mcdonald','SAN PABLO'),
(103253,'Italia','Croacia','2018-05-04','Thaddeus Vazquez','NACIONAL'),
(103254,'Italia','Iran','2018-12-07','Rigel Hughes','ARENA PANTANAL'),
(103255,'Costa Rica','Italia','2018-02-11','John Byrd','ARENA DA BAIXADA'),
(103256,'Ecuador','Italia','2018-04-06','Thomas Sanford','CASTELAO'),
(103257,'Grecia','Italia','2018-07-06','Damon Carpenter','BEIRA RIO'),
(103258,'Haiti','Italia','2018-01-29','Elton Perez','DAS DUNAS'),
(103259,'Israel','Italia','2018-09-26','Baker Pollard','ARENA FONTE NOVA');

INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio)
VALUES 
(103260,'Uruguay','Serbia','2018-10-09','Dieter Palmer','MARACANA'),
(103261,'Uruguay','Lituania','2018-08-08','Victor Jensen','MINERAO'),
(103262,'Uruguay','Kuwait','2018-08-24','Kennan Page','SAN PABLO'),
(103263,'Uruguay','Canada','2018-04-30','Tucker Wilcox','NACIONAL'),
(103264,'Uruguay','Argelia','2018-09-17','Matthew Rice','ARENA PANTANAL'),
(103265,'Angola','Uruguay','2018-02-07','Perry Guzman','ARENA DA BAIXADA'),
(103266,'Corea del Norte','Uruguay','2018-05-06','Kadeem Herrera','CASTELAO'),
(103267,'Paraguay','Uruguay', '2018-11-01','Dieter Estrada','BEIRA RIO'),
(103268,'Chile','Uruguay','2018-06-26','Arden Haynes','DAS DUNAS'),
(103269,'Italia','Uruguay','2018-02-20','Solomon Summers','ARENA FONTE NOVA');

INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio) 
VALUES 
(103270,'Inglaterra','Uruguay','2018-03-24','Mufutau Skinner','MARACANA'),
(103271,'Inglaterra','Italia','2018-07-10','Stephen Silva','MINERAO'),
(103272,'Inglaterra','Paraguay','2018-07-15','Dalton Rivera','SAN PABLO'),
(103273,'Inglaterra','Chile','2018-12-14','Richard Morton','NACIONAL'),
(103274,'Inglaterra','Espanha','2018-04-16','Harlan Leblanc','ARENA PANTANAL'),
(103275,'Inglaterra','Japon','2018-08-14','Maxwell Kline','ARENA DA BAIXADA'),
(103276,'Canada','Inglaterra','2018-05-16','Zeus Gonzalez','CASTELAO'),
(103277,'Argelia','Inglaterra','2018-10-15','Forrest Douglas','BEIRA RIO'),
(103278,'Angola','Inglaterra','2018-01-16','Ali Mcdaniel','DAS DUNAS'),
(103279,'Corea del Norte','Inglaterra','2018-08-14','Connor Griffin','ARENA FONTE NOVA');

INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio) 
VALUES 
(103280,'Espanha','Australia','2018-09-11','Xavier Bishop','MARACANA'),
(103281,'Espanha','Belgica','2018-09-14','Dale Fields','MINERAO'),
(103282,'Espanha','Colombia','2018-02-16','Zane Wagner','SAN PABLO'),
(103283,'Espanha','Croacia','2018-09-12','Ray Barber','NACIONAL'),
(103284,'Espanha','Paraguay','2018-09-14','Keith Waters','ARENA PANTANAL'),
(103285,'Chile','Espanha','2018-02-16','Eagan Cox','ARENA DA BAIXADA'),
(103286,'Japon','Espanha','2018-09-15','Russell Short','CASTELAO'),
(103287,'Angola','Espanha','2018-09-10','Christian Russo','BEIRA RIO'),
(103288,'Lituania','Espanha','2018-01-15','Herrod Carlson','DAS DUNAS'),
(103289,'Estados Unidos','Espanha','2018-02-16','Lucian Oliver','ARENA FONTE NOVA');

INSERT INTO partido (id_partido,equipo_local,equipo_visitante,fecha,nombre_arbitro,estadio) 
VALUES 
(103290,'China','Estados Unidos','2018-06-21','Christopher Rivas','MARACANA'),
(103291,'China','Brasil','2018-10-06','Warren Chan','MINERAO'),
(103292,'China','Venezuela','2018-04-14','Dorian Barber','SAN PABLO'),
(103293,'China','Iran','2018-02-03','Elvis Norris','NACIONAL'),
(103294,'China','Canada','2018-01-13','Quentin Barlow','ARENA PANTANAL'),
(103295,'Argelia','China','2018-11-05','Vernon Hudson','ARENA DA BAIXADA'),
(103296,'Kuwait','China','2018-09-27','Evan Vargas','CASTELAO'),
(103297,'Belgica','China','2018-05-24','Jackson Hess','BEIRA RIO'),
(103298,'Lituania','China','2018-07-20','Reuben Collins','DAS DUNAS'),
(103299,'Costa Rica','China','2018-11-07','Kirk Mason','ARENA FONTE NOVA');

-- -------------- gol  ----------------------


INSERT INTO gol (id_partido,nombre_goleador,minuto) 
VALUES 
(103240,'Austin Kemp','1'),
(103241,'Colt Moody','2'),
(103242,'Abel Acosta','3'),
(103243,'Ashton Byrd','4'),
(103243,'Messi','23'),
(103243,'Messi','57'),
(103244,'Valentine Vincent','5'),
(103245,'Kasper Alston','6'),
(103246,'Mascherano','7'),
(103247,'Orlando Morris','8'),
(103248,'Keegan Skinner','9'),
(103249,'Messi','10'),
(103250,'Vaughan Peck','11'),
(103251,'Timothy Decker','12'),
(103251,'Camden Roman','13'),
(103251,'Wyatt Mercer','14'),
(103254,'Wesley Koch','15'),
(103255,'Christian Serrano','16'),
(103256,'Jameson Campos','17'),
(103257,'Lester Fuller','18'),
(103258,'Kennedy Castro','19'),
(103259,'Stewart Joyce','20'),
(103260,'Beau Hawkins','21'),
(103261,'Calvin Charles','22'),
(103261,'Slade Matthews','23'),
(103263,'Vernon Browning','24'),
(103264,'Paul Banks'	,'25'),
(103265,'Keegan Simmons','26'),
(103266,'Emmanuel Davis','27'),
(103267,'Bruce Merrill','28'),
(103268,'Linus Bell','29');

INSERT INTO gol (id_partido,nombre_goleador,minuto)
VALUES 
(103269,'Aaron Ingram','30'),
(103270,'Timon Peters','31'),
(103271,'Leonard Ortiz','32'),
(103272,'Boris Lambert','33'),
(103273,'Hayes Thornton','34'),
(103274,'Simon Hansen','35'),
(103277,'Tarik Henry','36'),
(103277,'Denton Norris','37'),
(103277,'Mannix Nielsen','38'),
(103278,'Amery Houston','39'),
(103279,'Reese Hutchinson','40'),
(103280,'Sylvester Fleming','41'),
(103281,'Simon Mclaughlin','42'),
(103282,'Grant Lambert','43'),
(103283,'Ali Rhodes','44'),
(103284,'Sebastian Hogan','45'),
(103285,'Hiram Parker','46'),
(103286,'Oscar Gaines','47'),
(103286,'Aquila Avila','48'),
(103286,'Giacomo Leblanc','49'),
(103289,'Zachary Simmons','50'),
(103290,'Mufutau Molina','51'),
(103291,'Beck Albert'	,'52'),
(103291,'Hilel Church','53'),
(103293,'Moses Holloway','54'),
(103294,'Acton Ortega','55'),
(103295,'Russell Winters','56'),
(103296,'Seth Kirby','57');

INSERT INTO gol (id_partido,nombre_goleador,minuto)
VALUES 
(103297,'Marshall Ellison','58'),
(103298,'Colton Rojas','59'),
(103299,'Myles Porter','60'),
(103240,'Holmes Pierce','61'),
(103241,'Daquan Hutchinson','62'),
(103242,'Elton Battle','63'),
(103243,'Brenden Andrews','64'),
(103244,'Eaton Franco','65'),
(103245,'Tad Rosa','66'),
(103246,'Donovan Woodward','67'),
(103246,'Raymond Roach','68'),
(103246,'Jerome Robinson','69'),
(103250,'Colton Mcdaniel','70'),
(103251,'Barclay Madden','71'),
(103252,'Norman Garner','72'),
(103253,'Adrian Beach','73'),
(103254,'Giacomo Velasquez','74'),
(103255,'Aladdin Huber','75'),
(103256,'Leonard Rush','76'),
(103257,'Rajah Sherman','77'),
(103257,'Lucian Giles','78'),
(103259,'Reuben Shepard','79'),
(103260,'Callum Coffey','80'),
(103261,'Colton Mcdaniel','81'),
(103262,'Barclay Madden','82'),
(103263,'Norman Garner','83'),
(103264,'Adrian Beach','84'),
(103265,'Giacomo Velasquez','85'),
(103266,'Aladdin Huber','86'),
(103267,'Leonard Rush','87'),
(103268,'Rajah Sherman','88'),
(103269,'Lucian Giles','89'),
(103269,'Reuben Shepard','90'),
(103269,'Callum Coffey','1'),
(103269,'Giacomo Leblanc','2'),
(103273,'Zachary Simmons','3'),
(103274,'Mufutau Molina','4'),
(103275,'Beck Albert','5'),
(103276,'Hilel Church','6'),
(103277,'Camden Roman','7'),
(103278,'Wyatt Mercer','8'),
(103279,'Wesley Koch','9');

-- -------------- tarjeta amarilla  ----------------------

INSERT INTO tarjeta_amarilla (id_partido,nombre_amonestado,minuto) 
VALUES 
(103251,'Wyatt Mercer','14'),
(103254,'Wesley Koch','15'),
(103255,'Christian Serrano','16'),
(103256,'Jameson Campos','17'),
(103257,'Lester Fuller','18'),
(103257,'Kennedy Castro','19'),
(103259,'Stewart Joyce','20'),
(103259,'Giacomo Leblanc','2'), ------------1
(103259,'Giacomo Leblanc','43'), -----------1
(103240,'Zachary Simmons','3'),
(103241,'Mufutau Molina','4'),
(103242,'Beck Albert','5'),
(103243,'Hilel Church','6'),
(103244,'Camden Roman','7'),
(103245,'Wyatt Mercer','8'),
(103246,'Wesley Koch','9'),
(103277,'Tarik Henry','36'),
(103277,'Denton Norris','37'),
(103277,'Mannix Nielsen','38');

INSERT INTO tarjeta_amarilla (id_partido,nombre_amonestado,minuto) 
VALUES 
(103278,'Amery Houston','39'),
(103279,'Reese Hutchinson','40'),
(103280,'Sylvester Fleming','41'),
(103281,'Simon Mclaughlin','12'), ---------2
(103281,'Simon Mclaughlin','38'),
(103282,'Grant Lambert','43'),
(103283,'Ali Rhodes','44'),
(103284,'Sebastian Hogan','45'),
(103285,'Hiram Parker','46'),
(103286,'Oscar Gaines','47'),
(103286,'Aquila Avila','48'),
(103286,'Giacomo Leblanc','49'),
(103289,'Zachary Simmons','50'), ----------3
(103289,'Zachary Simmons','63'),
(103290,'Mufutau Molina','51'),
(103291,'Beck Albert','17'), -----------4
(103291,'Beck Albert','52'),
(103291,'Hilel Church','53'),
(103293,'Moses Holloway','54'),
(103294,'Acton Ortega','55');


-- -------------- tarjeta roja  ----------------------


INSERT INTO tarjeta_roja (id_partido,nombre_amonestado,minuto)
VALUES 
(103240,'Mufutau Molina','4'),
(103241,'Beck Albert','5'),
(103242,'Hilel Church','6'),
(103243,'Camden Roman','7'),
(103244,'Wyatt Mercer','8'),
(103245,'Wesley Koch','9'),
(103277,'Tarik Henry'	,'36'),
(103277,'Denton Norris','37'),
(103277,'Mannix Nielsen','38'),
(103278,'Amery Houston','39'),
(103279,'Reese Hutchinson','40'),
(103280,'Sylvester Fleming','41'),
(103281,'Simon Mclaughlin','42'),
(103282,'Grant Lambert','43'),
(103283,'Ali Rhodes','44'),
(103284,'Sebastian Hogan','45'),
(103285,'Hiram Parker','46'),
(103286,'Oscar Gaines','47'),
(103241,'Colt Moody','2'),
(103242,'Abel Acosta','3'),
(103243,'Ashton Byrd','4'),
(103244,'Valentine Vincent','5'),
(103245,'Kasper Alston','6'),
(103246,'Giacomo Leblanc','43'),
(103246,'Mascherano','7'),
(103247,'Orlando Morris','8'),
(103248,'Keegan Skinner','9'),
(103249,'Messi','10'),
(103250,'Vaughan Peck','11'),
(103281,'Simon Mclaughlin','38'),
(103251,'Timothy Decker','12'),
(103251,'Camden Roman','13'),
(103251,'Wyatt Mercer','14'),
(103254,'Wesley Koch','15'),
(103255,'Christian Serrano','16'),
(103296,'Seth Kirby','57'),
(103289,'Zachary Simmons','63'),
(103297,'Marshall Ellison','58'),
(103298,'Colton Rojas','59'),
(103299,'Myles Porter','60'),
(103264,'Holmes Pierce','61'),
(103265,'Daquan Hutchinson','62'),
(103266,'Elton Battle','63'),
(103291,'Beck Albert'	,'52'),
(103267,'Brenden Andrews','64'),
(103268,'Eaton Franco','65');
