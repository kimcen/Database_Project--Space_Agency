import configparser
import psycopg2
import pandas as pd

config = configparser.ConfigParser()
config.read('db.ini')

# Conexão a base de dados
try:
    conn=psycopg2.connect(
        dbname=config['postgres']['db'],
        user=config['postgres']['user'],
        password=config['postgres']['pwd'],
        host=config['postgres']['host'],
        port=config['postgres']['port'])
except:
    raise Exception("Incapaz de se conectar ao banco de dados")

def demoteste_sem(conn):
    #  Exemplo sem parâmetros
    #Pandas pode formatar automaticamente o resultado da consulta
    result = pd.read_sql("SELECT * FROM corpo_celeste;", conn)
    print(result)
    #O próprio Pandas pode ser utilizado para restringir resultados
    #Mas acredito que é melhor fazer via SQL já que é o ponto da disciplina
    # Versão Pandas
    print(result.loc[result['cod']=='BX-200'])
    # Versão SQL
    result = pd.read_sql("SELECT * FROM corpo_celeste WHERE cod = 'BX-200';", conn)
    print(result)
    return True

def demoteste_com(conn):
    #  Exemplo com parâmetros
    cod = input("Parâmetro 1(código do corpo celeste): ")
    result = pd.read_sql("SELECT * FROM corpo_celeste WHERE cod = '"+cod+"';", conn)
    print(result)
    return True

def finaliza(conn):
    conn.close()
    return False

# Agrupar por categoria de galáxia(E - Elíptica, S - Espiral e I - Irregular)
# Contar número de estrelas de uma certa categoria(função de agregação COUNT)
# Filtrar categorias onde temos mais de N estrelas
def democonsulta1(conn):
	cod = input("N(número) = ")
	result = pd.read_sql("""SELECT galaxia.category, count(*) 
							FROM galaxia
							INNER JOIN estrela ON (estrela.contem_ = galaxia.id_galaxia)
							GROUP BY category
							HAVING count(*) > {};""".format(cod), conn)
	print(result)
	return True


# Contar número de missões das agências espaciais e o número de 
# corpos celestes explorados(ou que tiveram missões destinados a eles)
def democonsulta2(conn):
	result = pd.read_sql("""SELECT agencia_espacial.name as "Nome", 
								count(missao.id_miss) as "Número de Missões Executadas", 
								count(corpo_celeste.id_cceleste) as "Número de Corpos Explorado" 
							FROM agencia_espacial
							LEFT JOIN missao ON (agencia_espacial.id_agespacial = missao.gerencia_)
							LEFT JOIN destino ON (destino.id_miss = missao.id_miss)
							LEFT JOIN corpo_celeste ON (destino.id_cceleste = corpo_celeste.id_cceleste)
							GROUP BY agencia_espacial.name
							ORDER BY agencia_espacial.name;""", conn)
	print(result)
	return True


# Retornar todas as missões da agência espacial que mais teve missões
def democonsulta3(conn):
	result = pd.read_sql("""SELECT missao.name
							FROM missoesAgencias
							INNER JOIN agencia_espacial USING (id_agespacial)
							INNER JOIN missao ON (missao.gerencia_ = agencia_espacial.id_agespacial)
							WHERE miss_count = (SELECT MAX(miss_count)
												FROM missoesAgencias);""", conn)
	print(result)
	return True

# Astronautas que já utilizaram um (nave_espacial) estão residindo em torno de um buracos negro
def democonsulta4(conn):
	nave = input("Nave espacial(cods) = ")
	result = pd.read_sql("""SELECT astronauta.name FROM astronauta
							NATURAL JOIN tripulado 
							JOIN missao ON (tripulado.id_miss = missao.id_miss)
							JOIN destino ON (missao.id_miss = destino.id_miss)
							JOIN buraco_negro ON (buraco_negro.id_cceleste = destino.id_cceleste)
							WHERE astronauta.name in (  select astronauta.name FROM missao
														NATURAL JOIN tripulado 
														JOIN astronauta ON (tripulado.id_astro = astronauta.id_astro )
														JOIN veiculo ON (missao.id_miss = veiculo.id_miss)
														JOIN carga ON (veiculo.id_carga = carga.id_carga)
														JOIN nave_espacial ON (carga.id_carga = nave_espacial.carrega_)
														WHERE cods = '{}' );""".format(nave), conn)
	print(result)
	return True

# Os astronautas que tripularam todas as missões em que o rover 4090XH foi utilizado
def democonsulta5(conn):
	result = pd.read_sql("""SELECT astronauta.name
							FROM astronauta
							WHERE NOT EXISTS(
									SELECT id_miss
									FROM rover
									INNER JOIN carga ON (carga.id_carga = rover.carrega_)
									INNER JOIN veiculo ON (veiculo.id_carga = carga.id_carga)
									WHERE rover.cods = '4090XH' AND veiculo.id_miss NOT IN(
													SELECT tripulado.id_miss
													FROM tripulado
													WHERE id_astro = astronauta.id_astro));""", conn)
	print(result)
	return True

# O nome, sua classe e temperatura de todas as estrelas associadas a um corpo celeste destinado até então
def democonsulta6(conn):
	result = pd.read_sql("""(SELECT ExploredBodies.name, estrela.class, estrela.temp
								FROM ExploredBodies
								INNER JOIN estrela ON (ExploredBodies.id_cceleste = estrela.id_cceleste)
							)
							UNION
							(SELECT c2.name, estrela.class, estrela.temp
								FROM ExploredBodies
								INNER JOIN planeta ON (ExploredBodies.id_cceleste = planeta.id_cceleste)
								INNER JOIN estrela ON (planeta.e_orbitado_ = estrela.id_estrela)
								INNER JOIN corpo_celeste c2 ON (c2.id_cceleste = estrela.id_cceleste)
							)
							UNION
							(SELECT c2.name, estrela.class, estrela.temp
								FROM ExploredBodies
								INNER JOIN satelite ON (ExploredBodies.id_cceleste = satelite.id_cceleste)
								INNER JOIN planeta ON (satelite.e_orbitado_ = planeta.id_planeta)
								INNER JOIN estrela ON (planeta.e_orbitado_ = estrela.id_estrela)
							 	INNER JOIN corpo_celeste c2 ON (c2.id_cceleste = estrela.id_cceleste) );""", conn)
	print(result)
	return True

# Todas as missões que foram direcionadas ao satélite natural (satelite)
def democonsulta7(conn):
	satel = input("Satelite(nome) = ")
	result = pd.read_sql("""SELECT missao.name
							FROM satelite
							INNER JOIN corpo_celeste ON (corpo_celeste.id_cceleste = satelite.id_cceleste)
							INNER JOIN destino ON (destino.id_cceleste = corpo_celeste.id_cceleste)
							INNER JOIN missao ON (missao.id_miss = destino.id_miss)
							WHERE corpo_celeste.name = '{}';""".format(satel), conn)
	print(result)
	return True

# Soma das massas dos foguetes lançados em todas as missões da NASA
def democonsulta8(conn):
	result = pd.read_sql("""SELECT sum(foguete.mass) 
							FROM missao 
							NATURAL JOIN veiculo 
							NATURAL JOIN carga 
							JOIN agencia_espacial ON (missao.gerencia_ = agencia_espacial.id_agespacial)
							JOIN foguete ON (carga.e_propulsao_ = foguete.id_foguete)
							WHERE agencia_espacial."name" = 'NASA';""", conn)
	print(result)
	return True

# Astronautas que visitaram o planeta Dagobah
def democonsulta9(conn):
    planet = input("Planeta(nome) = ")
    result = pd.read_sql("""SELECT astronauta.name
							FROM astronauta
							INNER JOIN tripulado ON (tripulado.id_astro = astronauta.id_astro)
							INNER JOIN destino ON (destino.id_miss = tripulado.id_miss)
							INNER JOIN corpo_celeste ON (corpo_celeste.id_cceleste = destino.id_cceleste)
							WHERE corpo_celeste.name = '{}' and corpo_celeste.planeta IS NOT NULL;""".format(planet), conn)
    print(result)
    return True

# Todas as naves espaciais que partiram do ponto de lançamento Cape navaveral
def democonsulta10(conn):
    ptlan = input("Ponto de lançamento(nome) = ")
    result = pd.read_sql("""SELECT cods
							FROM nave_espacial
							INNER JOIN carga ON (carga.id_carga = nave_espacial.carrega_)
							INNER JOIN veiculo ON (veiculo.id_carga = carga.id_carga)
							INNER JOIN missao ON (missao.id_miss = veiculo.id_miss)
							INNER JOIN ponto_de_lancamento ptl ON (ptl.id_ptlanc = missao.e_origem_)
							WHERE ptl.name = '{}';""".format(ptlan), conn)
    print(result)
    return True

# Todos os satélites naturais associados às estrelas da galáxia Lambda Lyrae
def democonsulta11(conn):
    result = pd.read_sql("""SELECT corpo_celeste.name
							FROM LambdaLyraeStars
							INNER JOIN planeta ON (planeta.e_orbitado_ = LambdaLyraeStars.id_estrela)
							INNER JOIN satelite ON (satelite.e_orbitado_ = planeta.id_planeta)
							INNER JOIN corpo_celeste ON (corpo_celeste.id_cceleste = satelite.id_cceleste);""", conn)
    print(result)
    return True

def demoSQLinj(conn):
    planet = "Dagobah'; SELECT * FROM pg_catalog.pg_user --"
    print("Planeta = ",planet)
    result = pd.read_sql("""SELECT astronauta.name
							FROM astronauta
							INNER JOIN tripulado ON (tripulado.id_astro = astronauta.id_astro)
							INNER JOIN destino ON (destino.id_miss = tripulado.id_miss)
							INNER JOIN corpo_celeste ON (corpo_celeste.id_cceleste = destino.id_cceleste)
							WHERE corpo_celeste.name = '{}' and corpo_celeste.planeta IS NOT NULL;""".format(planet), conn)
    print(result)
    return True

def demoTrigger(conn):
    with conn.cursor() as cur:
        print("Forçar o gatilho a ser disparado(associar astronauta a uma missão sem nave espacial)\n")
        cmd = """
        SELECT nave_espacial.cods, veiculo.id_miss
        FROM nave_espacial
        INNER JOIN
        carga ON (nave_espacial.carrega_ = carga.id_carga)
        INNER JOIN
        veiculo ON (veiculo.id_carga = carga.id_carga)
        """
        print("Executando:\n",cmd)
        result = pd.read_sql(cmd,conn)
        print(result)
        cmd = "INSERT INTO tripulado VALUES (3,29151);"
        print("\nExecutando:\n",cmd)
        cur.execute(cmd)
    return True



cmds = {
    #'sem_param':{'func': demoteste_sem,'dsc':'testar consulta sem parâmetros'},
    #'com_param':{'func': demoteste_com,'dsc':'testar consulta com parâmetros'},
    'demo1':{'func': democonsulta1,'dsc':'Categorias de galáxias com mais de (N=0,1,2,...) estrelas'},
    'demo2':{'func': democonsulta2,'dsc':'Número de missões das agências espaciais e o número de corpos celestes explorados(ou que tiveram missões destinados a eles)'},
    'demo3':{'func': democonsulta3,'dsc':'Todas as missões da agência espacial que mais teve missões'},
    'demo4':{'func': democonsulta4,'dsc':'Astronautas que já utilizaram um (nave_espacial=OV-104, Millenium Falcon, Radiant VII) estão residindo em torno de um buracos negro'},
    'demo5':{'func': democonsulta5,'dsc':'Os astronautas que tripularam todas as missões em que o rover 4090XH foi utilizado'},
    'demo6':{'func': democonsulta6,'dsc':'O nome, sua classe e temperatura de todas as estrelas associadas a um corpo celeste destinado até então'},
    'demo7':{'func': democonsulta7,'dsc':'Todas as missões que foram direcionadas ao satélite natural (satelite=Europa, Rinax, Yavin IV)'},
    'demo8':{'func': democonsulta8,'dsc':'Soma das massas dos foguetes lançados em todas as missões da NASA'},
    'demo9':{'func': democonsulta9,'dsc':'Astronautas que visitaram o planeta (Planeta = Dagobah, Gargantua-A, Krypton)'},
    'demo10':{'func': democonsulta10,'dsc':'Todas as naves espaciais que partiram do ponto de lançamento (Ponto de Lançamento = Cape navaveral, Estação UFRGS, Baikonur Cosmodrome, Kennedy Space Center)'},
    'demo11':{'func': democonsulta11,'dsc':'Todos os satélites naturais associados às estrelas da galáxia Lambda Lyrae'},
    'demoSQLinj':{'func': demoSQLinj, 'dsc':'Exemplificando o problema de oferecer uma interface vulnerável a um usuário usando o demo9'},
    'demoTrigger':{'func': demoTrigger, 'dsc':'Demonstração do disparo do gatilho, deve gerar um erro apropriado para a inserção feita'},
    'fim':{'func': finaliza, 'dsc':'Finaliza o programa'}}


def print_cmds():
    for cmd in cmds:
        print(f"{cmd} - {cmds[cmd]['dsc']}")

def query_cmd(conn):
    opt = input("Diga opção: ")
    if opt in cmds:
        try:
            ret = cmds[opt]['func'](conn)
            print('\n')
        except Exception as e:
            print(f"Erro na execução do comando SQL\n{str(e)}")
            return False
        return ret
    else:
        print("\nOpção não reconhecida\n")
        print_cmds()
        return True

# Definição de um cursor para efetuar operações na base de dados
#cursor = conn.cursor()
#em vez de usar a biblioteca para execução dos comandos, podemos usar o pandas
#pandas formata automaticamente o resultado das consultas

# Informações do servidor(acredito que podemos remover, não é tão importante)

#print("PostgreSQL server information")
#print(conn.get_dsn_parameters(), "\n")

operando = True


# LEMBRANDO QUE
# As consultas com parâmetros devem utilizar necessariamente os recursos para manipulação de parâmetros da
# biblioteca usada (i.e. não se limite a tratar a string para incluir or parâmetros, use as funções específicas);
#
# Por causa disso podemos separar os inputs para junta-los num .execute()

print_cmds()
# Executando um comando
while operando:
    operando = query_cmd(conn)

