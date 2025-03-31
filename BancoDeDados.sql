CREATE DATABASE ans_dados;



-- Criar tabelas
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,                   
    data_registro DATE,                      -- Data da informação contábil
    reg_ans VARCHAR(20),                     -- Registro da operadora na ANS (chave estrangeira)
    cd_conta_contabil VARCHAR(50),           -- Código da conta contábil
    descricao VARCHAR(255),                  -- Nome da conta contábil (ex: despesas assistenciais)
    vl_saldo_final VARCHAR(50),            -- Saldo final (valor da conta no final do período)
    FOREIGN KEY (reg_ans) REFERENCES operadoras(registro_operadora) -- Relacionamento entre reg_ans e registro_operadora
);

CREATE TABLE IF NOT EXISTS operadoras (
    registro_operadora VARCHAR(6) PRIMARY KEY,  -- Identificador único da operadora
    cnpj VARCHAR(14) UNIQUE,                    -- CNPJ da operadora
    razao_social VARCHAR(140),                   -- Nome empresarial
    nome_fantasia VARCHAR(140),                  -- Nome de mercado
    modalidade VARCHAR(2),                     -- Tipo de operadora (Ex: Medicina de Grupo, Cooperativa, etc.)
    cidade VARCHAR(30),                         -- Cidade da operadora
    uf CHAR(2),                                  -- Estado (UF)
    telefone VARCHAR(20),                        -- Contato
    endereco_eletronico VARCHAR(255),            -- E-mail
    representante VARCHAR(50),                  -- Nome do representante legal
    cargo_representante VARCHAR(40),            -- Cargo do representante
    data_registro_ANS DATE(8)                       -- Data de registro na ANS
);



-- Arquivos
-- Extrai os arquivos pra uma nova pasta fora do formato Zip e RAR

COPY operadoras FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\Relatorio_cadop.csv' DELIMITER ';' CSV HEADER; -- Operadoras

COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\1T2023.csv' DELIMITER ';' CSV HEADER; -- DC_2023_T1
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\2T2023.csv' DELIMITER ';' CSV HEADER; -- DC_2023_T2
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\3T2023.csv' DELIMITER ';' CSV HEADER; -- DC_2023_T3
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\4T2023.csv' DELIMITER ';' CSV HEADER; -- DC_2023_T4
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\1T2024.csv' DELIMITER ';' CSV HEADER; -- DC_2024_T1
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\2T2024.csv' DELIMITER ';' CSV HEADER; -- DC_2024_T2
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\3T2024.csv' DELIMITER ';' CSV HEADER; -- DC_2024_T3
COPY demonstracoes_contabeis FROM 'C:\Users\Usuário\OneDrive\Documentos\ArquivosNv\4T2024.csv' DELIMITER ';' CSV HEADER; -- DC_2024_T4

-- 10 operadoras com maiores despesas no último trimestre
SELECT nome_operadora, SUM(despesas_eventos) AS total_despesas
FROM demonstracoes_contabeis
WHERE (ano = EXTRACT(YEAR FROM CURRENT_DATE) AND trimestre = CEIL(EXTRACT(MONTH FROM CURRENT_DATE) / 3.0)) -- Divisão por inteiro para saber em que semestre estamos
GROUP BY nome_operadora ORDER BY total_despesas DESC LIMIT 10;


-- 10 operadoras com maiores despesas no último ano
SELECT nome_operadora, SUM(despesas_eventos) AS total_despesas
FROM demonstracoes_contabeis
WHERE ano = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY nome_operadora ORDER BY total_despesas DESC LIMIT 10;
