CREATE DATABASE ans_dados;

CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,                   
    data_registro DATE,                    
    reg_ans VARCHAR(20),                     
    cd_conta_contabil VARCHAR(50),           
    descricao VARCHAR(255),                
    vl_saldo_final VARCHAR(50),            
    FOREIGN KEY (reg_ans) REFERENCES operadoras(registro_operadora) 
);

CREATE TABLE IF NOT EXISTS operadoras (
    registro_operadora VARCHAR(6) PRIMARY KEY,  
    cnpj VARCHAR(14) UNIQUE,                    
    razao_social VARCHAR(140),                   
    nome_fantasia VARCHAR(140),                  
    modalidade VARCHAR(2),                     
    cidade VARCHAR(30),                         
    uf CHAR(2),                                  
    telefone VARCHAR(20),                        
    endereco_eletronico VARCHAR(255),            
    representante VARCHAR(50),                  
    cargo_representante VARCHAR(40),            
    data_registro_ANS DATE(8)                       
);


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
