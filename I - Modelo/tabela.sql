-- Database Section
-- ________________ 

create database Modelo_Fisico;


-- Tables Section
-- _____________ 

create table Agencia_espacial (
     ID_agEspacial numeric(10) not null,
     name varchar(50) not null,
     local varchar(50) not null,
     foundt date not null,
     constraint ID_Agencia_espacial_ID primary key (ID_agEspacial),
     constraint SID_Agencia_espacial unique (name));

comment on table Agencia_espacial is 'Organização responsável pelas missões espaciais. Gerencia todo aspecto da missão de exploração: escolhe o ponto de lançamento, a carga, os tripulantes e o destino a ser explorado. Possui um ou mais pontos de lançamento.';
comment on column Agencia_espacial.name is 'Nome da agência espacial.';
comment on column Agencia_espacial.local is 'Localização da sede da agência espacial.';
comment on column Agencia_espacial.foundt is 'Data de fundação da agência espacial.';

create table Astronauta (
     ID_astro numeric(10) not null,
     name varchar(50) not null,
     nationality varchar(50) not null,
     birthdt date not null,
     E_morado_ numeric(10),
     constraint ID_Astronauta primary key (ID_astro));

comment on table Astronauta is 'O explorador dessa nova era de descobrimentos. O astronauta pode trabalhar em grupos de um ou mais astronautas. Sua função é explorar corpos celestes. Eles são designados em missões associados a uma carga (Ex: foguete, nave espacial, rover etc.) e uma agência espacial. Dentre as várias características que podemos retirar, podemos extrair o seu nome, nacionalidade e data de nascimento para o nosso modelo. ';
comment on column Astronauta.name is 'Nome completo do astronauta.';
comment on column Astronauta.nationality is 'Nacionalidade(país de origem) do astronauta.';
comment on column Astronauta.birthdt is 'Data de nascimento do astronauta.';

create table Buraco_Negro (
     ID_cCeleste numeric(10) not null,
     swcRadius float(10) not null,
     acRadius float(10) not null,
     Contem_ numeric(10) not null,
     constraint ID_bNegro_cCeleste_ID primary key (ID_cCeleste));

comment on table Buraco_Negro is 'Uma estrela que colapsou em sua própria massa. Frequentemente possui um disco de massa em sua orbita, tornando a sua exploração uma das mais arriscadas. É tão massivo que chega a curvar o caminho da luz, sendo possível ver a parte do disco atrás do corpo. Em um certo ponto de sua orbita, nada que ultrapasse o seu raio de Schwartzchild poderá escapar. Este raio não é a sua superfície, tecnicamente um buraco negro não possui uma superfície, mas apenas um ponto em seu centro onde toda a massa é concentrada.';
comment on column Buraco_Negro.swcRadius is 'Raio de Schwartzschild em múltiplos de raio solar.';
comment on column Buraco_Negro.acRadius is 'Raio do disco de acreção em múltiplos de raio solar.';

create table Carga (
     ID_carga numeric(10) not null,
     E_propulsao_ numeric(10) not null,
     constraint ID_Carga primary key (ID_carga),
     constraint SID_carga_foguete_ID unique (E_propulsao_));

comment on table Carga is 'Entidade associativa representado uma "carga".';

create table Corpo_Celeste (
     ID_cCeleste numeric(10) not null,
     cod varchar(99) not null,
     name varchar(50),
     mass float(10) not null,
     radius float(10) not null,
     Satelite numeric(10),
     Planeta numeric(10),
     Galaxia numeric(10),
     Estrela numeric(10),
     Buraco_Negro numeric(10),
     constraint ID_Corpo_Celeste primary key (ID_cCeleste),
     constraint SID_Corpo_Celeste unique (cod));

comment on table Corpo_Celeste is 'Corpo celeste é um termo genérico usado em astronomia para designar as matérias existentes no espaço sideral. Desse modo, ele pode ser aplicado para referir-se a estrelas, planetas, asteroides, cometas, e satélites naturais. Embora todos os corpos descobertos tenham um código, alguns recebem um nome para facilitar a comunicação.';
comment on column Corpo_Celeste.cod is 'Código único de cada astro. Normalmente definido com base da sua localização no céu.';
comment on column Corpo_Celeste.name is 'Nome informal do corpo.';
comment on column Corpo_Celeste.mass is 'Massa do corpo em múltiplos de massa solar.';
comment on column Corpo_Celeste.radius is 'Raio em múltiplos de raio solar.';

create table Estacao_Espacial (
     ID_estEsp numeric(10) not null,
     name varchar(50) not null,
     maxcap numeric(10) not null,
     orbrad float(10) not null,
     E_orbitado_ numeric(10),
     constraint ID_Estacao_Espacial_ID primary key (ID_estEsp));

comment on table Estacao_Espacial is 'Um satélite artificial construído para residir humanos. Pode ser usado para realizar experimentos em situações de zero gravidade, ou treinar astronautas para participarem em missões além do planeta terra. Em casos de uma missão ser tripulada ter como destino um corpo celeste em que não é possível pousar, uma estação espacial pode ser utilizada para realizar análises longas.';
comment on column Estacao_Espacial.name is 'Nome da estação espacial.';
comment on column Estacao_Espacial.maxcap is 'Capacidade máxima de astronautas.';
comment on column Estacao_Espacial.orbrad is 'Raio orbital em Km.';

create table Estrela (
     ID_estrela numeric(10) not null,
     ID_cCeleste numeric(10) not null,
     class varchar(50) not null,
     temp numeric(10) not null,
     Contem_ numeric(10) not null,
     constraint ID_Estrela primary key (ID_estrela),
     constraint SID_estrela_cCeleste_ID unique (ID_cCeleste));

comment on table Estrela is 'Um corpo celeste que produz luz própria. Orbita uma galáxia e pode ser orbitada por um ou mais planetas. Pode ser classificada dependendo de sua temperatura, raio e massa.';
comment on column Estrela.class is 'Classe da estrela.';
comment on column Estrela.temp is 'Temperatura efetiva da estrela (em Kelvin).';

create table Foguete (
     ID_foguete numeric(10) not null,
     cods varchar(50) not null,
     fabdt date not null,
     specimp numeric(10) not null,
     fueltype varchar(30) not null,
     mass numeric(10) not null,
     constraint ID_Foguete primary key (ID_foguete),
     constraint SID_Foguete unique (cods));

comment on table Foguete is 'A função principal do foguete é fornecer a energia cinética suficiente para retirar cargas do planeta Terra para o espaço. No escopo de exploração espacial, exercem a função de levar uma nave espacial com os astronautas e(ou) um rover para os corpos celestes. Partem de um ponto de lançamento.';
comment on column Foguete.cods is 'Modelo do foguete.';
comment on column Foguete.fabdt is 'Data de fabricação.';
comment on column Foguete.specimp is 'Impulso específico do motor de propulsão em segundos.';
comment on column Foguete.fueltype is 'Tipo de combustível.';
comment on column Foguete.mass is 'Massa do motor do foguete em kg.';

create table Galaxia (
     ID_galaxia numeric(10) not null,
     ID_cCeleste numeric(10) not null,
     category varchar(30) not null,
     numStars numeric(10) not null,
     constraint ID_Galaxia primary key (ID_galaxia),
     constraint SID_galaxia_cCeleste_ID unique (ID_cCeleste));

comment on table Galaxia is 'Um corpo celeste definido como um conjunto de corpos celestes unidos pela atração gravitacional dos mesmos. Ao contrário do conhecimento popular, nem todas as galáxias possuem um buraco negro supermassivo no seu centro.';
comment on column Galaxia.category is 'Categoria da galáxia.';
comment on column Galaxia.numStars is 'Número estimado de estrelas em bilhões.';

create table Missao (
     ID_miss numeric(10) not null,
     name varchar(50) not null,
     launchdt date not null,
     E_origem_ numeric(10) not null,
     Gerencia_ numeric(10) not null,
     constraint ID_Missao_ID primary key (ID_miss),
     constraint SID_Missao unique (launchdt));

comment on table Missao is 'Todo lançamento de foguete é uma missão. Seja tripulada ou não, a complexidade da operação requer que as informações do evento sejam bem documentadas na base de dados. É necessário que o ponto de origem, os tripulantes, a carga, o destino e a agência que gerencia a missão sejam bem definidos para que não haja problemas de agendamento.';
comment on column Missao.name is 'Nome da missão espacial.';
comment on column Missao.launchdt is 'Data de lançamento.';

create table Contem (
     ID_agEspacial numeric(10) not null,
     ID_ptLanc numeric(10) not null,
     constraint ID_Contem primary key (ID_ptLanc, ID_agEspacial));

create table Destino (
     ID_miss numeric(10) not null,
     ID_cCeleste numeric(10) not null,
     arrivaldt date,
     constraint ID_Destino primary key (ID_miss, ID_cCeleste));

comment on column Destino.arrivaldt is 'Data de chegada.';

create table Nave_Espacial (
     ID_nEspacial numeric(10) not null,
     cods varchar(50) not null,
     Carrega_ numeric(10),
     fabdt date not null,
     range numeric(10) not null,
     fueltype varchar(30) not null,
     mass numeric(10) not null,
     constraint ID_Nave_Espacial primary key (ID_nEspacial),
     constraint SID_Nave_Espacial unique (cods),
     constraint SID_nEspacial_carga_ID unique (Carrega_));

comment on table Nave_Espacial is 'Veículo de transporte para astronautas, pelo menos um astronauta. Além disso, as naves espaciais transportam cargas pequenas como suprimentos e ferramentas de exploração para os astronautas. Podem ser transportados entre outras coisas por um foguete.';
comment on column Nave_Espacial.cods is 'Modelo da nave espacial.';
comment on column Nave_Espacial.fabdt is 'Data de fabricação.';
comment on column Nave_Espacial.range is 'Alcance da nave espacial em km.';
comment on column Nave_Espacial.fueltype is 'Tipo de combustível.';
comment on column Nave_Espacial.mass is 'Massa da nave espacial sem carga em toneladas.';

create table Planeta (
     ID_planeta numeric(10) not null,
     ID_cCeleste numeric(10) not null,
     habitable char not null,
     orbitalRadius float(10) not null,
     E_orbitado_ numeric(10) not null,
     constraint ID_Planeta primary key (ID_planeta),
     constraint SID_planeta_cCeleste_ID unique (ID_cCeleste));

comment on table Planeta is 'Um planeta orbita apenas uma estrela e pode ser considerado habitável ou não. As condições para decidir esse atributo vão além da complexidade do trabalho.';
comment on column Planeta.habitable is 'Descreve se o planeta possui atmosfera habitável ou não.';
comment on column Planeta.orbitalRadius is 'Raio em que o planeta orbita a estrela em unidades astronômicas (distância entre a terra e o sol).';

create table Ponto_de_Lancamento (
     ID_ptLanc numeric(10) not null,
     name varchar(50) not null,
     coord_lat numeric(8,6) not null,
     coord_long numeric(9,6) not null,
     constraint ID_Ponto_de_Lancamento_ID primary key (ID_ptLanc),
     constraint SID_Ponto_de_Lancamento unique (coord_lat, coord_long));

comment on table Ponto_de_Lancamento is 'O ponto de partida de todas as missões. Um ponto de lançamento pode estar associado a uma ou mais agências espaciais.';
comment on column Ponto_de_Lancamento.name is 'Nome do ponto de lançamento.';
comment on column Ponto_de_Lancamento.coord_lat is 'Latitude.';
comment on column Ponto_de_Lancamento.coord_long is 'Longitude.';

create table Residencia (
     ID_estEsp numeric(10) not null,
     ID_astro numeric(10) not null,
     constraint ID_Residencia primary key (ID_estEsp, ID_astro));

create table Rover (
     ID_rover numeric(10) not null,
     cods varchar(50) not null,
     Carrega_ numeric(10),
     fabdt date not null,
     funct varchar(50) not null,
     mass numeric(10) not null,
     constraint ID_Rover primary key (ID_rover),
     constraint SID_Rover unique (cods),
     constraint SID_rover_carga_ID unique (Carrega_));

comment on table Rover is 'Um astromóvel autônomo. Responsável pela exploração da superfície de um planeta, coletando informações sobre as rochas e o terreno. Pode ser transportado por um foguete.';
comment on column Rover.cods is 'Modelo do rover.';
comment on column Rover.fabdt is 'Data de fabricação.';
comment on column Rover.funct is 'Descrição das funções do rover(sensores e instrumentos).';
comment on column Rover.mass is 'Massa do rover em kg.';

create table Satelite (
     ID_cCeleste numeric(10) not null,
     habitable char not null,
     orbitalRadius float(10) not null,
     E_orbitado_ numeric(10) not null,
     constraint ID_satelite_cCeleste_ID primary key (ID_cCeleste));

comment on table Satelite is 'Um satélite natural que orbita necessariamente um planeta.';
comment on column Satelite.habitable is 'Descreve se o satélite possui atmosfera habitável ou não.';
comment on column Satelite.orbitalRadius is 'Raio em que o satélite orbita a estrela em unidades astronômicas (distância entre a terra e o sol).';

create table Tripulado (
     ID_miss numeric(10) not null,
     ID_astro numeric(10) not null,
     constraint ID_Tripulado primary key (ID_astro, ID_miss));

create table Veiculo (
     ID_carga numeric(10) not null,
     ID_miss numeric(10) not null,
     constraint ID_Veiculo primary key (ID_carga, ID_miss));


-- Constraints Section
-- ___________________ 

--Not implemented
--alter table Agencia_espacial add constraint ID_Agencia_espacial_CHK
--     check(exists(select * from Contem
--                  where Contem.ID_agEspacial = ID_agEspacial)); 

alter table Astronauta add constraint REF_astro_cCeleste_FK
     foreign key (E_morado_)
     references Corpo_Celeste
	 ON DELETE SET NULL
	 ON UPDATE CASCADE;

alter table Buraco_Negro add constraint ID_bNegro_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Buraco_Negro add constraint REF_bNegro_galaxia_FK
     foreign key (Contem_)
     references Galaxia
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Carga add constraint SID_carga_foguete_FK
     foreign key (E_propulsao_)
     references Foguete
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Corpo_Celeste add constraint EXTONE_Corpo_Celeste
     check((Satelite is not null and Planeta is null and Estrela is null and Galaxia is null and Buraco_Negro is null)
           or (Satelite is null and Planeta is not null and Estrela is null and Galaxia is null and Buraco_Negro is null)
           or (Satelite is null and Planeta is null and Estrela is not null and Galaxia is null and Buraco_Negro is null)
           or (Satelite is null and Planeta is null and Estrela is null and Galaxia is not null and Buraco_Negro is null)
           or (Satelite is null and Planeta is null and Estrela is null and Galaxia is null and Buraco_Negro is not null)); 

--Not implemented
--alter table Estacao_Espacial add constraint ID_Estacao_Espacial_CHK
--     check(exists(select * from Residencia
--                  where Residencia.ID_estEsp = ID_estEsp)); 

alter table Estacao_Espacial add constraint REF_estEsp_cCeleste_FK
     foreign key (E_orbitado_)
     references Corpo_Celeste
	 ON DELETE SET NULL
	 ON UPDATE CASCADE;

alter table Estrela add constraint SID_estrela_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Estrela add constraint REF_estrela_galaxia_FK
     foreign key (Contem_)
     references Galaxia
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Galaxia add constraint SID_galaxia_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

--Not implemented
--alter table Missao add constraint ID_Missao_CHK
--     check(exists(select * from Destino
--                  where Destino.ID_miss = ID_miss)); 

alter table Missao add constraint REF_miss_ptLanc_FK
     foreign key (E_origem_)
     references Ponto_de_Lancamento
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Missao add constraint REF_miss_agEspacial_FK
     foreign key (Gerencia_)
     references Agencia_espacial
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Contem add constraint EQU_contLan_ptLanc_FK
     foreign key (ID_ptLanc)
     references Ponto_de_Lancamento
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Contem add constraint EQU_contLan_agEspacial_FK
     foreign key (ID_agEspacial)
     references Agencia_espacial
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Destino add constraint REF_dest_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Destino add constraint EQU_dest_miss_FK
     foreign key (ID_miss)
     references Missao
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Nave_Espacial add constraint SID_nEspacial_carga_FK
     foreign key (Carrega_)
     references Carga
	 ON DELETE SET NULL
	 ON UPDATE CASCADE;

alter table Planeta add constraint SID_planeta_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Planeta add constraint REF_planeta_estrela_FK
     foreign key (E_orbitado_)
     references Estrela
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

--Not implemented
--alter table Ponto_de_Lancamento add constraint ID_Ponto_de_Lancamento_CHK
--     check(exists(select * from Contem
--                  where Contem.ID_ptLanc = ID_ptLanc)); 

alter table Residencia add constraint REF_residEst_astro_FK
     foreign key (ID_astro)
     references Astronauta
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Residencia add constraint EQU_residEst_estEsp_FK
     foreign key (ID_estEsp)
     references Estacao_Espacial
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Rover add constraint SID_rover_carga_FK
     foreign key (Carrega_)
     references Carga
	 ON DELETE SET NULL
	 ON UPDATE CASCADE;

alter table Satelite add constraint REF_satelite_planeta_FK
     foreign key (E_orbitado_)
     references Planeta
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Satelite add constraint ID_satelite_cCeleste_FK
     foreign key (ID_cCeleste)
     references Corpo_Celeste
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Tripulado add constraint REF_tripu_astro_FK
     foreign key (ID_astro)
     references Astronauta
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Tripulado add constraint REF_tripu_miss_FK
     foreign key (ID_miss)
     references Missao
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Veiculo add constraint REF_veic_miss_FK
     foreign key (ID_miss)
     references Missao
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;

alter table Veiculo add constraint REF_veic_carga_FK
     foreign key (ID_carga)
     references Carga
	 ON DELETE CASCADE
	 ON UPDATE CASCADE;


-- Index Section
-- _____________ 

create index REF_astro_cCeleste_IND
     on Astronauta (E_morado_);

create index REF_bNegro_galaxia_IND
     on Buraco_Negro (Contem_);

create index REF_estEsp_cCeleste_IND
     on Estacao_Espacial (E_orbitado_);

create index REF_estrela_galaxia_IND
     on Estrela (Contem_);

create index REF_miss_ptLanc_IND
     on Missao (E_origem_);

create index REF_miss_agEspacial_IND
     on Missao (Gerencia_);

create index EQU_contLan_ptLanc_IND
     on Contem (ID_ptLanc);

create index EQU_contLan_agEspacial_IND
     on Contem (ID_agEspacial);

create index REF_dest_cCeleste_IND
     on Destino (ID_cCeleste);

create index EQU_dest_miss_IND
     on Destino (ID_miss);

create index REF_planeta_estrela_IND
     on Planeta (E_orbitado_);

create index REF_residEst_astro_IND
     on Residencia (ID_astro);

create index EQU_residEst_estEsp_IND
     on Residencia (ID_estEsp);

create index REF_satelite_planeta_IND
     on Satelite (E_orbitado_);

create index REF_tripu_astro_IND
     on Tripulado (ID_astro);

create index REF_tripu_miss_IND
     on Tripulado (ID_miss);

create index REF_veic_miss_IND
     on Veiculo (ID_miss);

create index REF_veic_carga_IND
     on Veiculo (ID_carga);

