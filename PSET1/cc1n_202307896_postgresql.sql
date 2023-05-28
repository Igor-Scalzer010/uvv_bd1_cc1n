-- Apagando o banco de dados "UVV" caso já exista.
DROP DATABASE IF EXISTS uvv;

-- Apagando usúario caso ele já exista.
DROP USER IF EXISTS "Igor Scalzer";

-- Criando usúario.
CREATE USER "Igor Scalzer"
	WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'teste123';

-- Criando banco de dados "UVV".
CREATE DATABASE uvv 
    WITH OWNER = "Igor Scalzer"
    TEMPLATE = template0
    ENCODING = "UTF8"
    LC_COLLATE = "pt_BR.UTF-8"
    LC_CTYPE = "pt_BR.UTF-8"
    ALLOW_CONNECTIONS = true;

COMMENT ON DATABASE uvv IS 'Esse é um banco de dados das lojas UVV ';

-- Acessando o banco de dados "UVV" com usuário "Igor Scalzer" e passando a senha do usúario.

\c "dbname=uvv user='Igor Scalzer' password=teste123";

-- Criando esquema chamado "lojas"
CREATE SCHEMA lojas AUTHORIZATION "Igor Scalzer";
COMMENT ON SCHEMA lojas IS 'Esse é o schema padrão que irá conter todos os objetos tabelas do banco de dados "UVV".';

-- Difinindo de forma permanente para o usuário no "search_path"
ALTER USER "Igor Scalzer"

-- Definindo o esquema "lojas" como padrão no banco de dados "UVV"
SET search_path TO lojas, "$user", public;

/* 
A tabela "produtos" possui duas "CONSTRAINT" sendo que, uma é para a coluna "preco_unitario" que está com apelido de "produtos_preco_unitario_ck", que no caso, o valor dentro dessa coluna não pode ser menor que zero.
*/
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id),
                CONSTRAINT produtos_preco_unitario_ck CHECK (preco_unitario >= 0)
);

COMMENT ON TABLE lojas.produtos IS 'Essa tabela serve para o cadastro dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Essa coluna é a indentificação (ID) dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Essa coluna é o nome dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Essa coluna serve para o cadastro dos preços unitários dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Essa coluna serve para especificar os detalhes dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Essa coluna serve para colocar imagens dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Essa coluna serve para colocar os tipos de extensão (identificação de tipos de dados) das imagens dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Essa coluna serve para fornecer informações sobre as imagens dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Essa coluna serve para armazenar conjunto de caracteres associado à imagem dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Essa coluna serve para cadastrar as últimas atualizações referentes aos produtos das lojas UVV.';


/* 
A tabela "lojas" possui duas "CONSTRAINT" sendo que, uma é para a coluna "endereco_web" e "endereco_fisico" que está com apelido de "lojas_endereco_web_e_endereco_fisico_ck", que no caso, pelo menos uma delas deve estar com um valor preenchido.
*/
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id),
                CONSTRAINT lojas_endereco_web_e_endereco_fisico_ck CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL)
);
COMMENT ON TABLE lojas.lojas IS 'Essa tabela serve para o cadastro das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Essa coluna serve para a indentificação das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Essa coluna serve para o cadastro dos nomes das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Essa coluna serve para o cadastro dos endereços na web das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Essa coluna serve para o cadastro dos endereços físicos na web das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Essa coluna serve para o cadastro da latitude das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Essa coluna serve para o cadastro da longitude das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Essa coluna serve para guardar a logo (imagem) das jojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Essa coluna serve para os tipos de arquivos (extensões) das logos que pertencem as lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Essa coluna serve para fornecer informações sobre as logos das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Essa coluna serve para armazenar conjunto de caracteres associado à imagem (logo) das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Essa coluna serve para o cadastro da última atualização das lojas UVV.';

/* 
A tabela "estoques" possui duas "CONSTRAINTS" sendo que, uma é para a coluna "quantidade" que está com apelido de "estoques_quantidade_ck", que no caso, o valor desta coluna não pode ser menor que zero.
*/
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id),
                CONSTRAINT estoques_quantidade_ck CHECK (quantidade >= 0)
);
COMMENT ON TABLE lojas.estoques IS 'Essa coluna serve para o controle de estoque das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Essa coluna é a identificação (ID) do stoque das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Essa coluna é uma FK. Serve para indentificar as lojas UVV e está fazendo um relacionamento com a tabela lojas, coluna "loja_id" que é a PK.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Essa coluna é uma FK. Serve para identificar (ID) os produtos das lojas UVV e faz um relacionamento com tabela produtos, coluna "produto_id" que é a PK.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Essa coluna serve para cadastrar a quantidade dos produtos das lojas UVV em estoque.';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Essa Tabela serve para o cadastro dos usuários (clientes).';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Essa coluna serve para indentificação de cada usuário (cliente).';
COMMENT ON COLUMN lojas.clientes.email IS 'Essa coluna serve para cadastrar os e-mails dos usuários (clientes).';
COMMENT ON COLUMN lojas.clientes.nome IS 'Essa coluna serve para cadastrar o nome de cada usuário (cliente).';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';

/* 
Essa tabela "envios" possui duas "CONSTRAINT" sendo que, uma é para a coluna "status" que está com apelido de "envios_status_ck" e só pode possuir os valores: CRIADO, ENVIADO, TRANSITO, e ENTREGUE.
*/
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id),
                CONSTRAINT envios_status_ck CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))
);
COMMENT ON TABLE lojas.envios IS 'Essa tabela serve para o controle de envios dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Essa coluna é a identificação (ID) dos envios dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Essa coluna é uma FK. Serve para a identificação das lojas UVV e faz um relacionamento com a tabela lojas, coluna "loja_id" que é a PK.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Essa coluna é uma "FK". Faz uma relacionamento com a tabela clientes e coluna "cliente_id" que é a "PK".';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Essa coluna serve para cadastrar o endereço dos clientes.';
COMMENT ON COLUMN lojas.envios.status IS 'Essa coluna serve para colocar o status do pedido dos clientes.';

/* 
Essa tabela "pedidos" possui duas "CONSTRAINT" sendo que, uma é para a coluna "status" que está com apelido de "pedidos_status_ck" e só pode possuir os valores: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO e ENVIADO.
*/
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id),
                CONSTRAINT pedidos_status_ck CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'))
);
COMMENT ON TABLE lojas.pedidos IS 'Essa tabela serve para administrar os pedidos dos usuários (clientes).';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Essa coluna serve para registrar a data e hora do pedido do usuário (cliente).';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Essa coluna serve para indentificação de cada usuário (cliente) e possui chave estrangeira que faz referência a chave PK da coluna cliente_id da tabela clientes.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Essa coluna serve para verificar o status do pedido do usuário (cliente).';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Essa coluna é uma "FK". Serve para a indentificação das lojas UVV e faz referência com a tabela "lojas", coluna "loja_id" que é a "PK"';

/* 
A tabela "pedidos_itens" possui tres "CONSTRAINT" sendo que, duas são para as colunas "preco_unitario" e "quantidade" onde os valores não podem ser menores que zero.
*/
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id),
                CONSTRAINT pedidos_itens_preco_unitario_ck CHECK (preco_unitario >= 0),
                CONSTRAINT pedidos_itens_quantidade_ck CHECK (quantidade >= 0)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Essa tabela serve para cadastra os itens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Essa coluna é uma "PFK". Serve para cadastrar a identificação do pedido (ID) e faz um relacionamento com a tabela "pedidos", coluna "pedido_id" que é a "PK".';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Essa coluna é uma "PFK". Serve para cadastrar a identificação do produto (ID) e faz um relacionamento com a tabela "produtos", coluna "produto_id" que é a "PK".';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Essa coluna serve para identificação única de cada item dentro do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Essa coluna serve para mostrar os preços únitarios dos produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Essa coluna serve para cadastrar a quantidade dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Essa coluna é uma "FK". Serve para mostrar a identificação do envio do pedido (ID) e faz um relacionamento com a tabela "envios", coluna "envio_id" que é a "PK".';


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;