-- Visões

CREATE VIEW ExploredBodies
AS
SELECT id_cceleste, name
FROM missao
JOIN
destino USING (id_miss);

CREATE VIEW LambdaLyraeStars
AS
SELECT estrela.id_cceleste, id_estrela
FROM estrela
JOIN
galaxia ON galaxia.id_galaxia = estrela.contem_
WHERE id_galaxia = 1;

CREATE VIEW MilkyWayStars
AS
SELECT estrela.id_cceleste, id_estrela
FROM estrela
JOIN
galaxia ON galaxia.id_galaxia = estrela.contem_
WHERE id_galaxia = 3;

CREATE VIEW missoesAgencias
AS
SELECT agencia_espacial.id_agespacial, COUNT(*) AS miss_count
FROM missao
INNER JOIN
agencia_espacial ON (agencia_espacial.id_agespacial = missao.gerencia_)
GROUP BY
agencia_espacial.id_agespacial;

DROP VIEW ExploredBodies;
DROP VIEW LambdaLyraeStars;
DROP VIEW MilkyWayStars;
DROP VIEW missoesAgencias;




-- Consulta 1(GROUP BY, HAVING)
--Agrupar por categoria de galáxia(E - Elíptica, S - Espiral e I - Irregular)
--Contar número de estrelas de uma certa categoria(função de agregação COUNT)
--Filtrar categorias onde temos mais de 1 estrelas
select galaxia.category, count(*) 
from 
galaxia
INNER JOIN
estrela ON (estrela.contem_ = galaxia.id_galaxia)
group by category
having count(*) > 1




-- Consulta 2(GROUP BY)
-- Contar número de missões das agências espaciais e o número de corpos celestes explorados(ou que tiveram missões destinados a eles)

select agencia_espacial.name as "Nome", 
	count(missao.id_miss) as "Número de Missões Executadas", 
	count(corpo_celeste.id_cceleste) as "Número de Corpos Explorado" 
from agencia_espacial
left join missao on (agencia_espacial.id_agespacial = missao.gerencia_)
left join destino on (destino.id_miss = missao.id_miss)
left join corpo_celeste on (destino.id_cceleste = corpo_celeste.id_cceleste)
group by agencia_espacial.name
order by "Nome"





-- Consulta 3(subconsultas e uma visão)
--Retornar todas as missões da agência espacial que mais teve missões
SELECT missao.name
FROM 
missoesAgencias
INNER JOIN
agencia_espacial USING (id_agespacial)
INNER JOIN
missao ON (missao.gerencia_ = agencia_espacial.id_agespacial)
WHERE miss_count = (
	SELECT MAX(miss_count)
	FROM 
	missoesAgencias)




-- Consulta 4(subconsultas)
-- Astronautas que já utilizaram um millenium falcon estão residindo em torno de um buracos negro
select astronauta.name from astronauta
natural join tripulado 
join missao on (tripulado.id_miss = missao.id_miss)
join destino on (missao.id_miss = destino.id_miss)
join buraco_negro on (buraco_negro.id_cceleste = destino.id_cceleste)
where astronauta.name in (
	select astronauta.name from missao
	natural join tripulado 
	join astronauta on (tripulado.id_astro = astronauta.id_astro )
	join veiculo on (missao.id_miss = veiculo.id_miss)
	join carga on (veiculo.id_carga = carga.id_carga)
	join nave_espacial on (carga.id_carga = nave_espacial.carrega_)
	where cods = 'Millenium Falcon'
);



-- Consulta 5(NOT EXISTS)
-- Os astronautas que tripularam todas as missões em que o rover 4090XH foi utilizado.
SELECT astronauta.name
FROM
astronauta
WHERE
NOT EXISTS(
	SELECT id_miss
	FROM
	rover
	INNER JOIN
	carga ON (carga.id_carga = rover.carrega_)
	INNER JOIN
	veiculo ON (veiculo.id_carga = carga.id_carga)
	WHERE
	rover.cods = '4090XH' AND veiculo.id_miss NOT IN(
					SELECT tripulado.id_miss
					FROM
					tripulado
					WHERE
					id_astro = astronauta.id_astro
	));






-- Consulta 6(uma visão)
-- Mostrar o nome, sua classe e temperatura de todas as estrelas associadas a um corpo celeste destinado até então
(SELECT ExploredBodies.name, estrela.class, estrela.temp
	FROM
	ExploredBodies
	INNER JOIN
	estrela ON (ExploredBodies.id_cceleste = estrela.id_cceleste)
)
UNION
(SELECT c2.name, estrela.class, estrela.temp
	FROM
	ExploredBodies
	INNER JOIN
	planeta ON (ExploredBodies.id_cceleste = planeta.id_cceleste)
	INNER JOIN
	estrela ON (planeta.e_orbitado_ = estrela.id_estrela)
	INNER JOIN
	corpo_celeste c2 ON (c2.id_cceleste = estrela.id_cceleste)
)
UNION
(SELECT c2.name, estrela.class, estrela.temp
	FROM
	ExploredBodies
	INNER JOIN
	satelite ON (ExploredBodies.id_cceleste = satelite.id_cceleste)
	INNER JOIN
	planeta ON (satelite.e_orbitado_ = planeta.id_planeta)
	INNER JOIN
	estrela ON (planeta.e_orbitado_ = estrela.id_estrela)
 	INNER JOIN
 	corpo_celeste c2 ON (c2.id_cceleste = estrela.id_cceleste)
);




-- Consulta 7
-- Listar todas as missões que foram direcionadas ao satélite natural Europa
SELECT missao.name
FROM
satelite
INNER JOIN
corpo_celeste ON (corpo_celeste.id_cceleste = satelite.id_cceleste)
INNER JOIN
destino ON (destino.id_cceleste = corpo_celeste.id_cceleste)
INNER JOIN
missao ON (missao.id_miss = destino.id_miss)
WHERE corpo_celeste.name = 'Europa';




-- Consulta 8 - Soma das massas dos foguetes lançados em todas as missões da NASA

select sum(foguete.mass) from missao 
natural join veiculo 
natural join carga 
join agencia_espacial on (missao.gerencia_ = agencia_espacial.id_agespacial)
join foguete on (carga.e_propulsao_ = foguete.id_foguete)
WHERE agencia_espacial."name" = 'NASA'

-- OU
-- Astronautas que visitaram o planeta Dagobah

SELECT astronauta.name
FROM
astronauta
INNER JOIN
tripulado ON (tripulado.id_astro = astronauta.id_astro)
INNER JOIN
destino ON (destino.id_miss = tripulado.id_miss)
INNER JOIN
corpo_celeste ON (corpo_celeste.id_cceleste = destino.id_cceleste)
WHERE
corpo_celeste.name = 'Dagobah' and corpo_celeste.planeta IS NOT NULL




-- Consulta 9
-- Todas as naves espaciais que partiram do ponto de lançamento Cape navaveral
SELECT cods
FROM
nave_espacial
INNER JOIN
carga ON (carga.id_carga = nave_espacial.carrega_)
INNER JOIN
veiculo ON (veiculo.id_carga = carga.id_carga)
INNER JOIN
missao ON (missao.id_miss = veiculo.id_miss)
INNER JOIN
ponto_de_lancamento ptl ON (ptl.id_ptlanc = missao.e_origem_)
WHERE
ptl.name = 'Cape navaveral'




-- Consulta 10
-- Listar todos os satélites naturais associados às estrelas da galáxia Lambda Lyrae
SELECT corpo_celeste.name
FROM
LambdaLyraeStars
INNER JOIN
planeta ON (planeta.e_orbitado_ = LambdaLyraeStars.id_estrela)
INNER JOIN
satelite ON (satelite.e_orbitado_ = planeta.id_planeta)
INNER JOIN
corpo_celeste ON (corpo_celeste.id_cceleste = satelite.id_cceleste)





-- Gatilho e Procedimento Armazenado
-- Ideia: gatilho de inserção para verificar se é possível associar novos astronautas em missões com nave espacial(o transporte dos astronautas)

CREATE FUNCTION trip_check()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS 
$$
BEGIN
	IF NOT EXISTS(
		SELECT *
		FROM nave_espacial
		INNER JOIN
		carga ON (nave_espacial.carrega_ = carga.id_carga)
		INNER JOIN
		veiculo ON (veiculo.id_carga = carga.id_carga)
		WHERE
		id_miss = NEW.id_miss
	) THEN
		RAISE EXCEPTION 'Não é possível adicionar astronauta em uma missão sem uma nave espacial.';
	ELSE
		RETURN NEW;
	END IF;
END;
$$

CREATE TRIGGER VerificaTripulantes
BEFORE INSERT ON tripulado
FOR EACH ROW EXECUTE FUNCTION trip_check();