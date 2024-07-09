-- Galáxias (id_galaxia,id_cceleste,category,numstars)
-- corpo_celeste (id_cceleste,cod,name,mass,radius,galaxia)

INSERT INTO corpo_celeste VALUES (1,'GX-100','Lambda Lyrae',1.5e9,1.19e12,1);
INSERT INTO galaxia VALUES (1,1,'E',312);

INSERT INTO corpo_celeste VALUES (2,'GX-200','Omicron Eubuleus',20.5e9,14e12,2);
INSERT INTO galaxia VALUES (2,2,'I',1842);

INSERT INTO corpo_celeste VALUES (3,'GX-300','Milky Way',8e11,7.2e11,3);
INSERT INTO galaxia VALUES (3,3,'S',1);

INSERT INTO corpo_celeste VALUES (4,'TG-352','Adrômeda',1e12,7.1e12,4);
INSERT INTO galaxia VALUES (4,4,'E',1000);

INSERT INTO corpo_celeste VALUES (5,' NGC-3034','Messier 82',3e12,7.4e13,5);
INSERT INTO galaxia VALUES (5,5,'I',30);


-- Buracos Negros (id_cceleste,swcRadius,acRadius,Contem_)
-- corpo_celeste (id_cceleste,cod,name,mass,radius,buraco_negro)

INSERT INTO corpo_celeste  VALUES (41,'BX-100','Purpura Axiotheato',4e6,26,1);
INSERT INTO buraco_negro VALUES (41,13,32,1);

INSERT INTO corpo_celeste VALUES (51,'BX-200','Griseo-A',1232,1.1e-3,2);
INSERT INTO buraco_negro VALUES (51,9.1e-4,1.9e-3,1);

INSERT INTO corpo_celeste VALUES (61,'BX-300','Crescent Shadow',6,4.3e-5,3);
INSERT INTO buraco_negro VALUES (61,3.1e-5,5.3e-5,2);



-- Estrelas (id_estrela,id_cceleste,class,temp,contem_)
-- corpo_celeste (id_cceleste,cod,name,mass,radius,estrela)


INSERT INTO corpo_celeste VALUES (6,'EX-000','Sirius',2.0,1.7,1);
INSERT INTO estrela VALUES (1,6,'G',5523,1);

INSERT INTO corpo_celeste VALUES (7,'EX-100','Zeta Reticuli',2.1,2.8,1);
INSERT INTO estrela VALUES (2,7,'G',5523,1);

INSERT INTO corpo_celeste VALUES (8,'EX-200','40 Eridani',0.7,0.4,2);
INSERT INTO estrela VALUES (3,8,'K',4194,3);

INSERT INTO corpo_celeste VALUES (9,'EX-300','Coruscant',3.4,2.9,3);
INSERT INTO estrela VALUES (4,9,'F',6833,3);



-- Planetas (id_planeta,id_cceleste,habitable,orbitalradius,e_orbitado_) 
-- corpo_celeste (id_cceleste,cod,name,mass,radius,planeta)

INSERT INTO corpo_celeste VALUES (10,'PX-100','Dagobah',1,1,1);
INSERT INTO planeta VALUES (1,10,1,2.3,1);

INSERT INTO corpo_celeste VALUES (11,'PX-200','Gargantua-A',1,1,2);
INSERT INTO planeta VALUES (2,11,0,6.2,2);

INSERT INTO corpo_celeste VALUES (12,'PX-300','Krypton',1,1,3);
INSERT INTO planeta VALUES (3,12,1,0.6,2);



-- Satélites (id_cceleste,habitable,orbitalradius,e_orbitado_)
-- corpo_celeste (id_cceleste,cod,name,mass,radius,satelite)

INSERT INTO corpo_celeste VALUES (13,'SX-100','Europa',2.43e-8,2.24e-3,1);
INSERT INTO satelite VALUES (13,0,4.48e-3,1);

INSERT INTO corpo_celeste VALUES (14,'SX-200','Rinax',7.93e-11,1.74e-6,2);
INSERT INTO satelite VALUES (14,0,2.16e-3,1);

INSERT INTO corpo_celeste VALUES (15,'SX-300','Yavin IV',5.36e-7,1.53e-2,3);
INSERT INTO satelite VALUES (15,1,8.77e-3,3);




-- Agência Espacial (id_agespacial, name, local, foundt)

INSERT INTO agencia_espacial VALUES (1, 'NASA', 'Merrit Island, Florida, US', '1958-07-29');
INSERT INTO agencia_espacial VALUES (2, 'AEEUFRGS', ' Estr. Tramandai-Osorio, Tramandaí, BR', '2030-01-30');
INSERT INTO agencia_espacial VALUES (3, 'ESA', 'Espl. des Particules 1, 1211 Meyrin, CH', '1961-11-08');

-- Astronauta (id_astro, name, nationality, birthdt, e_morado_)

INSERT INTO astronauta VALUES (47583, 'Neil Armstrong', 'USA', '1930-03-12', 12);
INSERT INTO astronauta VALUES (48494, 'John Glenn', 'GER', '1921-02-20', 10); 
INSERT INTO astronauta VALUES (38475, 'Yuri Gagarin', 'RUS', '1932-03-14', 14); 
INSERT INTO astronauta VALUES (29151, 'Kim Enghusen', 'BRA', '1998-07-14', 11); 

-- Estação Espacial (id_estesp, name, maxcap, orbrad, e_orbitado_)

INSERT INTO estacao_espacial VALUES (1, 'ISS', 15, 408, 10);
INSERT INTO estacao_espacial VALUES (2, 'EEB', 30, 500, 14);
INSERT INTO estacao_espacial VALUES (3, 'RUSS', 25, 600, 12);
 
-- Foguete (id_foguete, cod, fabdt, specimp, fueltype, mass)

INSERT INTO foguete VALUES (1, 'Falcon9-100', '2040-11-25', 311, 'Liquid Oxigen', 68);
INSERT INTO foguete VALUES (2, 'Starship', '2045-08-20', 348 , 'Liquid Methane', 357);
INSERT INTO foguete VALUES (3, 'Yenisei', '2036-03-14', 405, 'Liquid Oxygen', 104);
INSERT INTO foguete VALUES (4, 'Falcon9-10', '2022-02-21', 311, 'Liquid Oxigen', 68);

-- Ponto de Lançamento (id_ptlanc, name, coord_lat, coord_long)

INSERT INTO ponto_de_lancamento VALUES (1, 'Cape navaveral', 28.396837, -80.605659);
INSERT INTO ponto_de_lancamento VALUES (2, 'Estação UFRGS', -29.972605, -50.228239);
INSERT INTO ponto_de_lancamento VALUES (3, 'Baikonur Cosmodrome', 45.964868, 63.30494);
INSERT INTO ponto_de_lancamento VALUES (4, 'Kennedy Space Center', 28.573682, -80.648980);

-- Missão (id_miss, name, launchdt, e_origem_, gerencia_)

INSERT INTO missao VALUES (1, 'Artemis-1', '2025-05-12', '1', '1');
INSERT INTO missao VALUES (2, 'STS', '2030-04-23', '1', '3');
INSERT INTO missao VALUES (3, 'Apollo-24', '2036-07-18', '3', '3');
INSERT INTO missao VALUES (4, 'Omega 1', '2022-09-11', '1', '1');

-- Carga (id_carga, e_propulsao_)

INSERT INTO carga VALUES (1,2);
INSERT INTO carga VALUES (2,3);
INSERT INTO carga VALUES (3,1);
INSERT INTO carga VALUES (4,4);

-- Nave Espacial (id_nespacial, cods, carrega_, fabdt, range, fueltype, mass)

INSERT INTO nave_espacial VALUES (1, 'OV-104', 2, '2066-11-25', 1280, 'Hydrogen', 549);
INSERT INTO nave_espacial VALUES (2, 'Millenium Falcon', 4,  '2050-10-03', 2308, 'Coaxium', 1528);
INSERT INTO nave_espacial VALUES (3, 'Radiant VII', 3, '2045-02-13', 8346, 'Coaxium', 2037);

-- Rover (id_rover, cods, carrega_, fabdt, funct, mass)

INSERT INTO rover VALUES (1, '2011-070A', null, '2011-05-15', 'DRL, XRAY, SPEC, PIC', 2350);
INSERT INTO rover VALUES (2, '4090XH', 1, '2035-03-09', 'DRL, SEIS, HDPIC', 3865);
INSERT INTO rover VALUES (3, '7950XHD', 2, '2050-03-26', 'HDPIC', 1049);

-- Contem (id_agespacial, id_ptlanc)

INSERT INTO contem VALUES (1,1);
INSERT INTO contem VALUES (2,2);
INSERT INTO contem VALUES (3,3);
INSERT INTO contem VALUES (1,4);

-- Destino (id_miss, id_cceleste, arrivaldt)

INSERT INTO destino VALUES (1, 41, '2025-07-20');
INSERT INTO destino VALUES (2, 13, '2030-12-15');
INSERT INTO destino VALUES (3, 15, '2037-01-03');
INSERT INTO destino VALUES (4, 10, '2022-12-22');

-- Tripulado (id_miss, id_astro)

INSERT INTO tripulado VALUES (1,29151);
INSERT INTO tripulado VALUES (1,48494);
INSERT INTO tripulado VALUES (2,47583);
INSERT INTO tripulado VALUES (3,38475);
INSERT INTO tripulado VALUES (4,29151);

-- Veiculo (id_carga, id_miss)

INSERT INTO veiculo VALUES (1,3);
INSERT INTO veiculo VALUES (2,2);
INSERT INTO veiculo VALUES (3,1);
INSERT INTO veiculo VALUES (4,4);
