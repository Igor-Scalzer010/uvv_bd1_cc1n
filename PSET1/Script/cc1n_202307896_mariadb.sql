-- Excluindo o banco de dados uvv caso já exista
DROP DATABASE IF EXISTS uvv;

-- Excluindo o usuário Igor Scalzer caso já exista
DROP USER IF EXISTS 'Igor Scalzer'@'localhost';
 
-- Criando um usuário com o nome 'Igor Scalzer' e senha 'teste123'
CREATE USER 'Igor Scalzer'@'localhost' IDENTIFIED BY 'TESTE123';

-- Criando uma banco de dados uvv
CREATE DATABASE uvv;

-- Fornecendo privilegios para o usuário 'Igor Scalzer'
GRANT ALL PRIVILEGES ON uvv.* TO 'Igor Scalzer'@'localhost';
FLUSH PRIVILEGES;

-- Acessando o banco de dados
USE uvv;

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes LONGBLOB,
                imagem LONGBLOB,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                PRIMARY KEY (produto_id),
                CONSTRAINT produtos_preco_unitario_ck CHECK (preco_unitario >= 0)
);

ALTER TABLE produtos COMMENT 'Essa tabela serve para o cadastro dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Essa coluna é a indentificação (ID) dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'Essa coluna é o nome dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Essa coluna serve para o cadastro dos preços unitários dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'Essa coluna serve para especificar os detalhes dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'Essa coluna serve para colocar imagens dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'Essa coluna serve para colocar os tipos de extensão (identificação de tipos de dados) das imagens dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'Essa coluna serve para fornecer informações sobre as imagens dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Essa coluna serve para armazenar conjunto de caracteres associado à imagem dos produtos das lojas UVV.';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT 'Essa coluna serve para cadastrar as últimas atualizações referentes aos produtos das lojas UVV.';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                PRIMARY KEY (loja_id),
                CONSTRAINT lojas_endereco_web_e_endereco_fisico_ck CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL)
);

ALTER TABLE lojas COMMENT 'Essa tabela serve para o cadastro das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Essa coluna serve para a indentificação das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Essa coluna serve para o cadastro dos nomes das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'Essa coluna serve para o cadastro dos endereços na web das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Essa coluna serve para o cadastro dos endereços físicos na web das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT 'Essa coluna serve para o cadastro da latitude das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT 'Essa coluna serve para o cadastro da longitude das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'Essa coluna serve para guardar a logo (imagem) das jojas UVV.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'Essa coluna serve para os tipos de arquivos (extensões) das logos que pertencem as lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Essa coluna serve para fornecer informações sobre as logos das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'Essa coluna serve para armazenar conjunto de caracteres associado à imagem (logo) das lojas UVV.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Essa coluna serve para o cadastro da última atualização das lojas UVV.';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id),
                CONSTRAINT estoques_quantidade_ck CHECK (quantidade >= 0)
);

ALTER TABLE estoques COMMENT 'Essa coluna serve para o controle de estoque das lojas UVV.';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'Essa coluna é a identificação (ID) do stoque das lojas UVV.';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Essa coluna é uma FK. Serve para indentificar as lojas UVV e está fazendo um relacionamento com a tabela lojas, coluna "loja_id" que é a PK.';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Essa coluna é uma FK. Serve para identificar (ID) os produtos das lojas UVV e faz um relacionamento com tabela produtos, coluna "produto_id" que é a PK.';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Essa coluna serve para cadastrar a quantidade dos produtos das lojas UVV em estoque.';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT 'Essa Tabela serve para o cadastro dos usuários (clientes).';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Essa coluna serve para indentificação de cada usuário (cliente).';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Essa coluna serve para cadastrar os e-mails dos usuários (clientes).';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Essa coluna serve para cadastrar o nome de cada usuário (cliente).';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'Essa coluna serve para cadastrar os telefones dos usuários (clientes).';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id),
                CONSTRAINT envios_status_ck CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))
);

ALTER TABLE envios COMMENT 'Essa tabela serve para o controle de envios dos produtos das lojas UVV.';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Essa coluna é a identificação (ID) dos envios dos produtos das lojas UVV.';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Essa coluna é uma FK. Serve para a identificação das lojas UVV e faz um relacionamento com a tabela lojas, coluna "loja_id" que é a PK.';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Essa coluna é uma "FK". Faz uma relacionamento com a tabela clientes e coluna "cliente_id" que é a "PK".';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Essa coluna serve para cadastrar o endereço dos clientes.';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Essa coluna serve para colocar o status do pedido dos clientes.';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora DATETIME NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                PRIMARY KEY (pedido_id),
                CONSTRAINT pedidos_status_ck CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'))
);

ALTER TABLE pedidos COMMENT 'Essa tabela serve para administrar os pedidos dos usuários (clientes).';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Essa coluna serve para registrar a data e hora do pedido do usuário (cliente).';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Essa coluna serve para indentificação de cada usuário (cliente) e possui chave estrangeira que faz referência a chave PK da coluna cliente_id da tabela clientes.';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Essa coluna serve para verificar o status do pedido do usuário (cliente).';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Essa coluna é uma "FK". Serve para a indentificação das lojas UVV e faz referência com a tabela "lojas", coluna "loja_id" que é a "PK"';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id),
                CONSTRAINT pedidos_itens_preco_unitario_ck CHECK (preco_unitario >= 0),
                CONSTRAINT pedidos_itens_quantidade_ck CHECK (quantidade >= 0)
);

ALTER TABLE pedidos_itens COMMENT 'Essa tabela serve para cadastra os itens dos pedidos.';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Essa coluna é uma "PFK". Serve para cadastrar a identificação do pedido (ID) e faz um relacionamento com a tabela "pedidos", coluna "pedido_id" que é a "PK".';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Essa coluna é uma "PFK". Serve para cadastrar a identificação do produto (ID) e faz um relacionamento com a tabela "produtos", coluna "produto_id" que é a "PK".';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'Essa coluna serve para identificação única de cada item dentro do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Essa coluna serve para mostrar os preços únitarios dos produtos.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Essa coluna serve para cadastrar a quantidade dos pedidos.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Essa coluna é uma "FK". Serve para mostrar a identificação do envio do pedido (ID) e faz um relacionamento com a tabela "envios", coluna "envio_id" que é a "PK".';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
