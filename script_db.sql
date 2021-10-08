create database db_teste;
use db_teste;


CREATE TABLE IF NOT EXISTS tbl_Clientes(
id_cliente smallint primary key auto_increment not null,
nome_cliente varchar (50) not null,
cidade_cliente	varchar(70) not null,
uf_cliente	char(2) not null
);

create index idx_nome_cliente on tbl_clientes (nome_cliente);

CREATE TABLE IF NOT EXISTS tbl_Produtos(
id_produtos smallint primary key auto_increment not null,
codigo_produto varchar(20) not null,
descricao_produto varchar (100) not null,
preco_venda	numeric(15,2) not null default 0.00
);

create index idx_descricao_produto on tbl_Produtos (descricao_produto);

CREATE TABLE IF NOT EXISTS tbl_PedidosDadosGerais(
numero_pedido smallint primary key auto_increment not null,
data_emissao date,
id_cliente smallint not null,
valor_total	numeric(15,2) not null default 0.00
);

create index idx_id_cliente on tbl_PedidosDadosGerais (id_cliente);


CREATE TABLE IF NOT EXISTS tbl_PedidosProdutos(
id_pedidosprodutos smallint primary key auto_increment not null,
idNumeroPedido smallint not null,
codigo_produto varchar(20) not null,
qtd integer not null,
valor_unitario numeric(15,2) not null default 0.00,
valor_total	numeric(15,2) not null default 0.00,
constraint fk_numero_pedido foreign key (idNumeroPedido) references tbl_PedidosDadosGerais(numero_pedido) on delete cascade on update cascade
);

create index idx_codigo_produto on tbl_PedidosProdutos (codigo_produto);

INSERT INTO tbl_clientes (nome_cliente, cidade_cliente, uf_cliente ) values ('ALAN DAVID DOS SANTOS CARVALHO','NATAL','RN'),('ALEXSANDRA LOPES DA PAIVA','SAO PAULO','SP'),
('CAMILA ARAUJO DANTAS','MOSSORO','RN'),('DOUGLAS CARLOS LINO DA SILVA','RIO DE JANEIRO','RJ'),
('EDNALVA MARCELINO','MANAUS','AM'),('ESTELLA SARAIVA FRANÇA','GUARULHOS','SP'),
('GREYCIANE DE SOUZA','SAO LUIS','MA'),('BRENO LOPES DE ARAUJO','RECIFE','PE'),
('LIGIA TAMIZE','JOAO PESSOA','PB'),('MARCIO FERNANDES','NATAL','RN'),
('MARIA DE FÁTIMA','SOLANEA','PB'),('JANAINA DE SOUSA ARAUJO','SALVADOR','BA'),
('RENATO GOMES','SAO MIGUEL DO GOSTOSO','RN'),('NARA BESSA','CACHOEIRA PAULISTA','SP'),
('ROSEANE XAVIER','PIPA','RN'),('RYCHARD SANTOS','LORENA','SP'),
('SAMARA DE ARAUJO DIAS','PARNAMIRIM','RN'),('ROMÁRIO DA SILVA','NITEROI','RJ'),
('WOBER RONALD DE SOUZA SILVA SOARES','EXTREMOZ','RN'),('PAULA NOBRE','SAO JOSE DOS CAMPOS','SP'),('NAYARA PEREIRA SOARES','MONTE ALEGRE','RN');



INSERT INTO tbl_produtos (codigo_produto, descricao_produto, preco_venda) values ('101','TRIDENT FRESH CEREJA','1.99'),('102','VICK BABYRUB LATA 12G','17.21'),
('103','ZOCOR 20 MG C/30 CPR','149.65'),('104','TOALA PAMPERS REGULAR C/48UN LAVANDA','12.51'),('105','TROPINAL 20CPR EMS','17.69'),
('106','TRIDENT MELANCIA','1.99'),('107','VAGOSTESYL 30 DRG','14.55'),('108','TESTE GRAVIDEZ CLEARBLUE DIGITAL','41.81'),
('109','SUNDOWN TODO DIA FPS 30 220ML','47.34'),('110','SAB PROTEX 1 SUAVE','2.40'),('111','SAB PROTEX BALANCE REFIL 200ML','8.62'),
('112','SAB PROTEX COMPLETE REFIL 200ML','8.61'),('113','SAB PROTEX VITAMINA E','2.40'),
('114','SH HEAD&SHOULDERS  3EM1 MASC 200ML','13.62'),('115','SH J&J BABY 200ML','9.90'),
('116','SAB LIQ J&J HORA DO SONO 200ML','13.49'),('117','PHARMATON 100CPS','226.27'),
('118','PERLUTAN INJ 1ML','17.81'),('119','NUTREN ACTIVE CHOCOLATE 400GR','47.35'),
('120','LISTERINE CUIDADO TOTAL 500ML','18.80'),('121','LEITE NINHO FASES 1','17.99');






