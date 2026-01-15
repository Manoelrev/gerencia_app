-- ============================================
-- SISTEMA DE GERENCIAMENTO DE FUNCIONÁRIOS
-- ============================================

-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS sistema_rh;
USE sistema_rh;

-- ============================================
-- 1. TABELA DE GERENTES
-- ============================================
CREATE TABLE gerentes (
    gerente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    setor VARCHAR(80) NOT NULL,
    cargo VARCHAR(80) NOT NULL,
    data_entrada DATE NOT NULL,
    INDEX idx_setor (setor),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 2. TABELA DE FUNCIONÁRIOS
-- ============================================
CREATE TABLE funcionarios (
    funcionario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    numero_cracha VARCHAR(20) NOT NULL UNIQUE,
    cargo VARCHAR(80) NOT NULL,
    setor VARCHAR(80) NOT NULL,
    data_entrada DATE NOT NULL,
    observacoes TEXT,
    gerente_id INT,
    FOREIGN KEY (gerente_id) REFERENCES gerentes(gerente_id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    INDEX idx_cracha (numero_cracha),
    INDEX idx_setor_func (setor),
    INDEX idx_gerente (gerente_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 3. TABELA DE HIERARQUIA (ORGANOGRAMA)
-- ============================================
CREATE TABLE hierarquia (
    funcionario_id INT NOT NULL,
    supervisor_id INT NOT NULL,
    data_inicio_supervisao DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (funcionario_id, supervisor_id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (supervisor_id) REFERENCES funcionarios(funcionario_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    INDEX idx_supervisor (supervisor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 4. TABELA DE REGISTRO DE PONTO
-- ============================================
CREATE TABLE registro_ponto (
    ponto_id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT NOT NULL,
    data_registro DATE NOT NULL,
    hora_entrada TIME,
    hora_saida TIME,
    horas_trabalhadas DECIMAL(5,2),
    horas_extras DECIMAL(5,2) DEFAULT 0.00,
    faltas BOOLEAN DEFAULT FALSE,
    atrasos INT DEFAULT 0 COMMENT 'Atraso em minutos',
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    INDEX idx_data_registro (data_registro),
    INDEX idx_funcionario_ponto (funcionario_id),
    UNIQUE KEY uk_funcionario_data (funcionario_id, data_registro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 5. TABELA DE ESCALAS E TURNOS
-- ============================================
CREATE TABLE escalas_turnos (
    escala_id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    tipo_turno ENUM('Diurno', 'Noturno', 'Misto') NOT NULL,
    ferias_vencidas BOOLEAN DEFAULT FALSE,
    observacoes TEXT,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    INDEX idx_funcionario_escala (funcionario_id),
    INDEX idx_periodo (data_inicio, data_fim),
    CHECK (data_fim >= data_inicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- INSERÇÃO DE DADOS DE EXEMPLO
-- ============================================

-- Inserir Gerentes
INSERT INTO gerentes (nome_completo, email, setor, cargo, data_entrada) VALUES
('Maria Silva Santos', 'maria.silva@empresa.com', 'Tecnologia da Informação', 'Gerente de TI', '2020-03-15'),
('João Paulo Oliveira', 'joao.oliveira@empresa.com', 'Recursos Humanos', 'Gerente de RH', '2019-01-10'),
('Ana Carolina Ferreira', 'ana.ferreira@empresa.com', 'Financeiro', 'Gerente Financeira', '2021-06-01');

-- Inserir Funcionários
INSERT INTO funcionarios (nome_completo, numero_cracha, cargo, setor, data_entrada, observacoes, gerente_id) VALUES
('Carlos Eduardo Souza', 'CR001234', 'Desenvolvedor Sênior', 'Tecnologia da Informação', '2021-07-01', 'Especialista em Java e Python', 1),
('Fernanda Lima Costa', 'CR001235', 'Analista de Sistemas', 'Tecnologia da Informação', '2022-02-15', 'Formação em Análise de Sistemas', 1),
('Ricardo Almeida Rocha', 'CR001236', 'Estagiário de TI', 'Tecnologia da Informação', '2024-03-01', 'Cursando Ciência da Computação', 1),
('Juliana Martins Pereira', 'CR002001', 'Analista de RH', 'Recursos Humanos', '2020-11-20', 'Responsável por recrutamento', 2),
('Pedro Henrique Santos', 'CR002002', 'Assistente de RH', 'Recursos Humanos', '2023-05-10', NULL, 2),
('Luciana Barbosa Dias', 'CR003001', 'Analista Financeira', 'Financeiro', '2022-08-15', 'MBA em Finanças', 3);

-- Inserir Hierarquia (Supervisões entre funcionários)
-- Carlos (Desenvolvedor Sênior) supervisiona Fernanda e Ricardo
INSERT INTO hierarquia (funcionario_id, supervisor_id, data_inicio_supervisao) VALUES
(2, 1, '2022-02-15'),  -- Fernanda supervisionada por Carlos
(3, 1, '2024-03-01'),  -- Ricardo supervisionado por Carlos
(5, 4, '2023-05-10');  -- Pedro supervisionado por Juliana

-- Inserir Registros de Ponto
INSERT INTO registro_ponto (funcionario_id, data_registro, hora_entrada, hora_saida, horas_trabalhadas, horas_extras, faltas, atrasos) VALUES
-- Carlos - semana completa
(1, '2026-01-13', '08:00:00', '18:30:00', 9.50, 1.50, FALSE, 0),
(1, '2026-01-14', '08:05:00', '17:00:00', 8.92, 0.00, FALSE, 5),
-- Fernanda
(2, '2026-01-13', '09:00:00', '18:00:00', 8.00, 0.00, FALSE, 0),
(2, '2026-01-14', '09:00:00', '18:00:00', 8.00, 0.00, FALSE, 0),
-- Ricardo - teve uma falta
(3, '2026-01-13', NULL, NULL, 0.00, 0.00, TRUE, 0),
(3, '2026-01-14', '08:00:00', '17:00:00', 8.00, 0.00, FALSE, 0),
-- Juliana
(4, '2026-01-13', '08:00:00', '17:00:00', 8.00, 0.00, FALSE, 0),
(4, '2026-01-14', '08:00:00', '19:00:00', 10.00, 2.00, FALSE, 0);

-- Inserir Escalas e Turnos
INSERT INTO escalas_turnos (funcionario_id, data_inicio, data_fim, tipo_turno, ferias_vencidas, observacoes) VALUES
-- Escala normal Carlos
(1, '2026-01-01', '2026-01-31', 'Diurno', FALSE, 'Escala regular de janeiro'),
-- Fernanda - férias programadas
(2, '2026-02-01', '2026-02-15', 'Diurno', TRUE, 'Férias vencidas - programadas'),
-- Ricardo - escala de estágio
(3, '2026-01-01', '2026-06-30', 'Diurno', FALSE, 'Período de estágio - 6 horas diárias'),
-- Juliana - turno misto
(4, '2026-01-01', '2026-03-31', 'Misto', FALSE, 'Turnos alternados conforme demanda'),
-- Pedro - turno noturno
(5, '2026-01-01', '2026-01-31', 'Noturno', FALSE, 'Turno noturno temporário');
