
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);


CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    perfil VARCHAR(30) NOT NULL, 
    id_cliente INT,
    
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


CREATE TABLE sistema (
    id_sistema SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    nome_sistema VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


CREATE TABLE modulo (
    id_modulo SERIAL PRIMARY KEY,
    id_sistema INT NOT NULL,
    nome_modulo VARCHAR(100) NOT NULL, 
    
    FOREIGN KEY (id_sistema) REFERENCES sistema(id_sistema)
);


CREATE TABLE tipo_manutencao (
    id_tipo SERIAL PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    descricao VARCHAR(200)
);


INSERT INTO tipo_manutencao (categoria, descricao) VALUES
('Corretiva', 'Bug crítico / Tela azul / Erros em produção'),
('Preventiva', 'Atualização de versão de biblioteca / Refatoração'),
('Adaptativa', 'Mudança na lei / Nova regra de imposto no sistema'),
('Perfectiva', 'Otimização de query lenta / Melhoria de usabilidade');

CREATE TABLE chamado (
    id_chamado SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descricao_inicial TEXT NOT NULL,
    status VARCHAR(30) DEFAULT 'ABERTO', -- ABERTO, EM_ANALISE, RESOLVIDO
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_fechamento TIMESTAMP,
    
    id_modulo INT NOT NULL,
    id_tipo INT NOT NULL,
    id_autor INT NOT NULL, 
    id_responsavel INT,    
    
    FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo),
    FOREIGN KEY (id_tipo) REFERENCES tipo_manutencao(id_tipo),
    FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_responsavel) REFERENCES usuario(id_usuario)
);


CREATE TABLE historico_interacao (
    id_historico SERIAL PRIMARY KEY,
    id_chamado INT NOT NULL,
    id_autor INT NOT NULL, 
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    flag_abuso BOOLEAN DEFAULT FALSE, 
    
    FOREIGN KEY (id_chamado) REFERENCES chamado(id_chamado),
    FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario)
);
