-- -----------------------------------------------------
-- DUMP 4
-- -------------------------------------------------------

CREATE DATABASE IF NOT EXISTS db_sistema_vendas
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE db_sistema_vendas;

-- 2. Tabela de Clientes
-- Note o uso do motor InnoDB, padrão no MySQL 8 para suporte a transações
CREATE TABLE tbl_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Restrição estrutural obrigatória
    email VARCHAR(100) UNIQUE,  -- Garante exclusividade do registro
    cidade VARCHAR(50) DEFAULT 'São Paulo' -- Valor automático para novos registros
) ENGINE=InnoDB;

-- 3. Tabela de Vendedores
CREATE TABLE tbl_vendedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    percentual_comissao DECIMAL(5,2)
) ENGINE=InnoDB;

-- 4. Tabela de Produtos com a "Regra de Ouro"
-- No MySQL 8, a restrição CHECK é finalmente VALIDADA pelo banco
CREATE TABLE tbl_produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2),
    categoria VARCHAR(50),
    CONSTRAINT chk_preco_positivo CHECK (preco > 0) -- Integridade Estrutural
) ENGINE=InnoDB;

CREATE TABLE tbl_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Em Processamento', -- Conforme evolução estrutural [1]
    FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id) ON DELETE RESTRICT,
    FOREIGN KEY (id_vendedor) REFERENCES tbl_vendedores(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

SET SQL_SAFE_UPDATES = 0;

-- adicionando quantidade
ALTER TABLE tbl_produtos
ADD COLUMN quantidade INT DEFAULT 0;

-- fazendo migração
CREATE TABLE tbl_categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ====================================================================
-- ETEC - Centro Paula Souza
-- Disciplina: Banco de Dados II / Linguagem de Consulta SQL
-- Laboratório Prático: População do Esquema db_sistema_vendas (DML)
-- ====================================================================

-- populando o banco
USE db_sistema_vendas;

-- --------------------------------------------------------------------
-- 1. POPULANDO A TABELA DE CLIENTES (30 Registros)
-- --------------------------------------------------------------------
INSERT INTO tbl_clientes (nome, email, cidade) VALUES
('Ana Silva', 'ana.silva@email.com', 'São Paulo'),
('Bruno Oliveira', 'bruno.oliveira@email.com', 'Campinas'),
('Carlos Eduardo', 'carlos.eduardo@email.com', 'São Paulo'),
('Daniela Rocha', 'daniela.rocha@email.com', 'Santos'),
('Eduardo Santos', 'eduardo.santos@email.com', 'São Paulo'),
('Fernanda Lima', 'fernanda.lima@email.com', 'Sorocaba'),
('Gabriel Costa', 'gabriel.costa@email.com', 'São Paulo'),
('Helena Martins', 'helena.martins@email.com', 'Ribeirão Preto'),
('Igor Ferreira', 'igor.ferreira@email.com', 'São Paulo'),
('Juliana Alves', 'juliana.alves@email.com', 'São José dos Campos'),
('Lucas Pereira', 'lucas.pereira@email.com', 'São Paulo'),
('Mariana Souza', 'mariana.souza@email.com', 'Osasco'),
('Nicolas Rodrigues', 'nicolas.rodrigues@email.com', 'São Paulo'),
('Olivia Barbosa', 'olivia.barbosa@email.com', 'Santo André'),
('Paulo Henrique', 'paulo.henrique@email.com', 'São Paulo'),
('Quintino Bocaiuva', 'quintino.bocaiuva@email.com', 'Campinas'),
('Rafaela Castro', 'rafaela.castro@email.com', 'São Paulo'),
('Sergio Ramos', 'sergio.ramos@email.com', 'Guarulhos'),
('Tatiane Freitas', 'tatiane.freitas@email.com', 'São Paulo'),
('Ubiratan Silva', 'ubiratan.silva@email.com', 'Piracicaba'),
('Vanessa Camargo', 'vanessa.camargo@email.com', 'São Paulo'),
('Wagner Montes', 'wagner.montes@email.com', 'Bauru'),
('Xavier Prado', 'xavier.prado@email.com', 'São Paulo'),
('Yara Mendes', 'yara.mendes@email.com', 'Jundiaí'),
('Zuleica Gomes', 'zuleica.gomes@email.com', 'São Paulo'),
('Arthur Pendelton', 'arthur.p@email.com', 'Taubaté'),
('Beatriz Souza', 'beatriz.s@email.com', 'São Paulo'),
('Caio Ribeiro', 'caio.r@email.com', 'Francas'),
('Diana Prince', 'diana.p@email.com', 'São Paulo'),
('Erick Jacquin', 'erick.j@email.com', 'São José do Rio Preto');

-- --------------------------------------------------------------------
-- 2. POPULANDO A TABELA DE VENDEDORES (10 Registros)
-- --------------------------------------------------------------------
INSERT INTO tbl_vendedores (nome, percentual_comissao) VALUES
('Roberto Carlos', 5.00),
('Patricia Abravanel', 7.50),
('Marcos Mion', 6.00),
('Galvão Bueno', 8.00),
('Ana Maria Braga', 5.50),
('Luciano Huck', 6.50),
('Sabrina Sato', 7.00),
('Celso Portiolli', 4.50),
('Eliana Michaelichen', 8.50),
('Fausto Silva', 10.00);

-- --------------------------------------------------------------------
-- 3. POPULANDO A TABELA DE PRODUTOS (150 Registros)
-- --------------------------------------------------------------------
INSERT INTO tbl_produtos (nome, preco, categoria) VALUES
-- Informática (30 produtos)
('Notebook Dell Inspiron', 3500.00, 'Informática'),
('Notebook Lenovo IdeaPad', 2800.00, 'Informática'),
('MacBook Air M2', 8999.00, 'Informática'),
('Monitor LG 29 UltraWide', 1200.00, 'Informática'),
('Monitor Samsung 24 FHD', 750.00, 'Informática'),
('Teclado Mecânico Redragon', 250.00, 'Informática'),
('Teclado Sem Fio Logitech', 180.00, 'Informática'),
('Mouse Gamer Razer', 320.00, 'Informática'),
('Mouse Optico USB', 35.00, 'Informática'),
('SSD Kingston 480GB', 220.00, 'Informática'),
('SSD NVMe M.2 1TB', 450.00, 'Informática'),
('HD Externo 2TB Seagate', 380.00, 'Informática'),
('Memória RAM 8GB DDR4', 160.00, 'Informática'),
('Memória RAM 16GB DDR5', 390.00, 'Informática'),
('Placa de Vídeo RTX 3060', 1890.00, 'Informática'),
('Placa de Vídeo RTX 4070', 4200.00, 'Informática'),
('Processador Intel i5 12400', 980.00, 'Informática'),
('Processador AMD Ryzen 5 5600X', 920.00, 'Informática'),
('Placa Mãe Asus B550', 780.00, 'Informática'),
('Fonte Corsair 650W', 420.00, 'Informática'),
('Gabinete Gamer ATX', 290.00, 'Informática'),
('Water Cooler 240mm', 360.00, 'Informática'),
('Cabo HDMI 2.1 2m', 45.00, 'Informática'),
('Webcam Logitech C920', 380.00, 'Informática'),
('Roteador Wi-Fi 6 TP-Link', 310.00, 'Informática'),
('Switch 8 Portas Gigabit', 120.00, 'Informática'),
('Filtro de Linha 6 Tomadas', 55.00, 'Informática'),
('Nobreak 1200VA SMS', 790.00, 'Informática'),
('Headset Gamer HyperX', 340.00, 'Informática'),
('Pendrive SanDisk 64GB', 40.00, 'Informática');

INSERT INTO tbl_produtos (nome, preco, categoria) VALUES
-- Eletrônicos & Telefonia (30 produtos)
('Smartphone Samsung S23', 3999.00, 'Eletrônicos'),
('Smartphone iPhone 14', 4999.00, 'Eletrônicos'),
('Smartphone Xiaomi Redmi Note 12', 1300.00, 'Eletrônicos'),
('Smartphone Motorola Edge 40', 2100.00, 'Eletrônicos'),
('Tablet Samsung Galaxy Tab A8', 1100.00, 'Eletrônicos'),
('iPad 10ª Geração 64GB', 3499.00, 'Eletrônicos'),
('Smartwatch Apple Watch SE', 2200.00, 'Eletrônicos'),
('Smartband Xiaomi Band 8', 230.00, 'Eletrônicos'),
('Carregador Rápido USB-C', 85.00, 'Eletrônicos'),
('Power Bank 20000mAh', 150.00, 'Eletrônicos'),
('Smart TV 55 4K LG', 2600.00, 'Eletrônicos'),
('Smart TV 50 4K Samsung', 2200.00, 'Eletrônicos'),
('Smart TV 32 HD TCL', 1050.00, 'Eletrônicos'),
('Soundbar JBL 110W', 890.00, 'Eletrônicos'),
('Caixa de Som JBL Flip 6', 650.00, 'Eletrônicos'),
('Fone Bluetooth Airpods 3', 1399.00, 'Eletrônicos'),
('Fone Bluetooth JBL Wave 100', 220.00, 'Eletrônicos'),
('Headphone Sony WH-1000XM4', 1890.00, 'Eletrônicos'),
('Vitrola Retrô USB', 450.00, 'Eletrônicos'),
('Projetor Portátil FHD', 820.00, 'Eletrônicos'),
('Amazon Fire TV Stick', 280.00, 'Eletrônicos'),
('Chromecast Google TV 4K', 340.00, 'Eletrônicos'),
('Assistente Virtual Alexa Echo Dot 5', 380.00, 'Eletrônicos'),
('Câmera de Segurança Wi-Fi', 190.00, 'Eletrônicos'),
('Lâmpada Inteligente RGB', 60.00, 'Eletrônicos'),
('Fechadura Eletrônica Digital', 590.00, 'Eletrônicos'),
('Carregador por Indução', 110.00, 'Eletrônicos'),
('Antena Digital Interna', 35.00, 'Eletrônicos'),
('Cabo USB-C para Lightning', 70.00, 'Eletrônicos'),
('Suporte para Celular Veicular', 30.00, 'Eletrônicos');

INSERT INTO tbl_produtos (nome, preco, categoria) VALUES
-- Games & Consoles (30 produtos)
('Console PlayStation 5', 3800.00, 'Games'),
('Console Xbox Series X', 4200.00, 'Games'),
('Console Xbox Series S', 2400.00, 'Games'),
('Console Nintendo Switch OLED', 2100.00, 'Games'),
('Controle DualSense PS5', 400.00, 'Games'),
('Controle Sem Fio Xbox', 380.00, 'Games'),
('Controle Pro Nintendo Switch', 350.00, 'Games'),
('Volante Logitech G29', 1750.00, 'Games'),
('Jogo EA Sports FC 24 PS5', 280.00, 'Games'),
('Jogo God of War Ragnarok PS5', 250.00, 'Games'),
('Jogo Zelda Tears of the Kingdom', 320.00, 'Games'),
('Jogo GTA V PS4', 90.00, 'Games'),
('Jogo Spider-Man 2 PS5', 290.00, 'Games'),
('Jogo Halo Infinite Xbox', 180.00, 'Games'),
('Jogo Mario Kart 8 Deluxe', 290.00, 'Games'),
('Cadeira Gamer ThunderX3', 950.00, 'Games'),
('Mesa Gamer em L', 480.00, 'Games'),
('Suporte para Headset RGB', 85.00, 'Games'),
('Mousepad Extra Grande 90x40', 70.00, 'Games'),
('Cartão Presente PSN R$100', 100.00, 'Games'),
('Cartão Presente Xbox R$100', 100.00, 'Games'),
('Óculos de Realidade Virtual Meta Quest 2', 2600.00, 'Games'),
('Dock Station para Controles PS5', 130.00, 'Games'),
('Cabo Carregador Controle 3m', 40.00, 'Games'),
('Skin Protetora PS5', 60.00, 'Games'),
('Volante com Pedais Thrustmaster', 2900.00, 'Games'),
('Manete de Avião Joystick Hotas', 580.00, 'Games'),
('Grip para Controle Switch', 45.00, 'Games'),
('Case de Transporte Nintendo Switch', 80.00, 'Games'),
('Kinect Sensor Xbox 360', 150.00, 'Games');

INSERT INTO tbl_produtos (nome, preco, categoria) VALUES
-- Eletrodomésticos & Casa (30 produtos)
('Geladeira Brastemp Frost Free 375L', 3100.00, 'Eletrodomésticos'),
('Fogão 4 Bocas Consul', 850.00, 'Eletrodomésticos'),
('Micro-ondas Electrolux 20L', 520.00, 'Eletrodomésticos'),
('Lava-Louças Brastemp 8 Serviços', 1980.00, 'Eletrodomésticos'),
('Máquina de Lavar Electrolux 11kg', 1750.00, 'Eletrodomésticos'),
('Aspirador de Pó Robô Mondial', 450.00, 'Eletrodomésticos'),
('Aspirador Vertical 2 em 1', 180.00, 'Eletrodomésticos'),
('Fritadeira Air Fryer Philips Walita', 490.00, 'Eletrodomésticos'),
('Liquidificador Arno Powerix', 140.00, 'Eletrodomésticos'),
('Batedeira Planetária Oster', 320.00, 'Eletrodomésticos'),
('Cafeteira Nespresso Essenza', 380.00, 'Eletrodomésticos'),
('Cafeteira Elétrica Três Corações', 290.00, 'Eletrodomésticos'),
('Sanduicheira Grill Cadence', 85.00, 'Eletrodomésticos'),
('Panela de Pressão Elétrica Rita Lobo', 340.00, 'Eletrodomésticos'),
('Ferro de Passar a Vapor Arno', 120.00, 'Eletrodomésticos'),
('Ventilador de Coluna Arno 40cm', 220.00, 'Eletrodomésticos'),
('Ar Condicionado Split 12000 BTU Inverter', 2100.00, 'Eletrodomésticos'),
('Purificador de Água Consul', 410.00, 'Eletrodomésticos'),
('Chaleira Elétrica Inox 1.8L', 95.00, 'Eletrodomésticos'),
('Torradeira Inox Oster', 130.00, 'Eletrodomésticos'),
('Multiprocessador de Alimentos', 260.00, 'Eletrodomésticos'),
('Adega Climatizada 12 Garrafas', 890.00, 'Eletrodomésticos'),
('Freezer Horizontal 200L', 1650.00, 'Eletrodomésticos'),
('Coifa de Parede Inox 60cm', 750.00, 'Eletrodomésticos'),
('Cooktop 5 Bocas Indução', 1290.00, 'Eletrodomésticos'),
('Forno Elétrico de Embutir 44L', 620.00, 'Eletrodomésticos'),
('Umidificador de Ar Ultrassônico', 110.00, 'Eletrodomésticos'),
('Aquecedor Elétrico Aak', 130.00, 'Eletrodomésticos'),
('Moedor de Café Elétrico', 160.00, 'Eletrodomésticos'),
('Mixer Multiuso com Acessórios', 170.00, 'Eletrodomésticos');

INSERT INTO tbl_produtos (nome, preco, categoria) VALUES
-- Escritório & Papelaria (30 produtos)
('Cadeira de Escritório Presidente', 680.00, 'Escritório'),
('Mesa para Escritório em L', 420.00, 'Escritório'),
('Gaveteiro Volante 3 Gavetas', 280.00, 'Escritório'),
('Luminária de Mesa LED Articulada', 75.00, 'Escritório'),
('Impressora Multifuncional Epson EcoTank', 1150.00, 'Escritório'),
('Impressora Laser HP', 890.00, 'Escritório'),
('Fragmentadora de Papel 8 Folhas', 310.00, 'Escritório'),
('Calculadora Científica Casio', 95.00, 'Escritório'),
('Organizador de Mesa em Acrílico', 45.00, 'Escritório'),
('Rotulador Eletrônico Brother', 230.00, 'Escritório'),
('Quadro Branco Magnético 120x90', 140.00, 'Escritório'),
('Projetor de Slide Epson', 2400.00, 'Escritório'),
('Plastificadora A4', 180.00, 'Escritório'),
('Encadernadora de Espiral', 220.00, 'Escritório'),
('Suporte para Monitor com Regulagem', 85.00, 'Escritório'),
('Apoio Ergonomico para os Pés', 65.00, 'Escritório'),
('Almofada Ergonômica Coccix', 90.00, 'Escritório'),
('Kit 500 Folhas Sulfite A4', 28.00, 'Escritório'),
('Caixa de Caneta Esferográfica 50 un', 40.00, 'Escritório'),
('Grampeador de Mesa Média Capacidade', 35.00, 'Escritório'),
('Furador de Papel 2 Furos', 30.00, 'Escritório'),
('Quadro de Cortiça 90x60', 60.00, 'Escritório'),
('Mochila Executiva para Notebook', 180.00, 'Escritório'),
('Pasta Sanfonada 12 Divisórias', 40.00, 'Escritório'),
('Tinta para Impressora Preta 100ml', 50.00, 'Escritório'),
('Mousepad com Apoio em Gel', 35.00, 'Escritório'),
('Fita Adesiva Larga Rolo 45m', 12.00, 'Escritório'),
('Tesoura Profissional Aço Inox', 25.00, 'Escritório'),
('Estilete Largo Profissional', 18.00, 'Escritório'),
('Porta Crachá com Cordão Retrátil', 15.00, 'Escritório');

-- --------------------------------------------------------------------
-- 4. POPULANDO A TABELA DE PEDIDOS (50 Registros)
-- --------------------------------------------------------------------
INSERT INTO tbl_pedidos (id_cliente, id_vendedor, Status) VALUES
(1, 1, 'Entregue'),
(2, 3, 'Em Processamento'),
(3, 2, 'Enviado'),
(4, 5, 'Entregue'),
(5, 4, 'Cancelado'),
(6, 6, 'Entregue'),
(7, 2, 'Em Processamento'),
(8, 7, 'Entregue'),
(9, 8, 'Enviado'),
(10, 10, 'Entregue'),
(11, 1, 'Entregue'),
(12, 3, 'Cancelado'),
(13, 9, 'Em Processamento'),
(14, 4, 'Entregue'),
(15, 5, 'Enviado'),
(16, 2, 'Entregue'),
(17, 6, 'Entregue'),
(18, 7, 'Em Processamento'),
(19, 8, 'Entregue'),
(20, 1, 'Enviado'),
(21, 10, 'Entregue'),
(22, 3, 'Entregue'),
(23, 5, 'Cancelado'),
(24, 4, 'Em Processamento'),
(25, 9, 'Entregue'),
(26, 2, 'Enviado'),
(27, 6, 'Entregue'),
(28, 7, 'Entregue'),
(29, 8, 'Em Processamento'),
(30, 1, 'Entregue'),
(1, 2, 'Enviado'),
(3, 4, 'Entregue'),
(5, 6, 'Entregue'),
(7, 8, 'Em Processamento'),
(9, 10, 'Cancelado'),
(2, 1, 'Entregue'),
(4, 3, 'Entregue'),
(6, 5, 'Enviado'),
(8, 7, 'Entregue'),
(10, 9, 'Entregue'),
(11, 2, 'Em Processamento'),
(13, 4, 'Entregue'),
(15, 6, 'Enviado'),
(17, 8, 'Entregue'),
(19, 10, 'Entregue'),
(21, 1, 'Em Processamento'),
(23, 3, 'Entregue'),
(25, 5, 'Enviado'),
(27, 7, 'Entregue'),
(29, 9, 'Cancelado');

INSERT INTO tbl_categorias (nome)
SELECT DISTINCT categoria
FROM tbl_produtos;

ALTER TABLE tbl_produtos
ADD COLUMN id_categoria INT;

UPDATE tbl_produtos p
JOIN tbl_categorias c
    ON p.categoria = c.nome
SET p.id_categoria = c.id;

ALTER TABLE tbl_produtos
ADD CONSTRAINT fk_produtos_categorias
FOREIGN KEY (id_categoria)
REFERENCES tbl_categorias(id);

SELECT
    p.id,
    p.nome AS produto,
    p.categoria,
    c.id AS id_categoria,
    c.nome AS categoria_nova
FROM tbl_produtos p
JOIN tbl_categorias c
    ON p.id_categoria = c.id
ORDER BY p.id;

SELECT DISTINCT categoria
FROM tbl_produtos;

ALTER TABLE tbl_produtos
DROP COLUMN categoria;

SELECT COUNT(*) AS total_clientes FROM db_sistema_vendas.tbl_clientes;  -- Retorna 30
SELECT COUNT(*) AS total_vendedores FROM db_sistema_vendas.tbl_vendedores; -- Retorna 10
SELECT COUNT(*) AS total_produtos FROM db_sistema_vendas.tbl_produtos;  -- Retorna 150
SELECT COUNT(*) AS total_pedidos FROM db_sistema_vendas.tbl_pedidos;   -- Retorna 50

-- Consultas 1

-- Nível 1.1: Projeção de todas as colunas
SELECT * FROM tbl_produtos;

-- Nível 1.2: Projeção de colunas específicas com Alias (Apelido)
SELECT nome AS produto, preco AS valor_unitario FROM tbl_produtos;

-- Nível 1.3: Filtro condicional de comparação com ordenação
SELECT
    p.nome,
    p.preco,
    c.nome AS categoria
FROM tbl_produtos AS p
INNER JOIN tbl_categorias AS c
    ON p.id_categoria = c.id
WHERE p.preco > 1000.00
ORDER BY p.preco DESC;

-- Nível 1.4: Filtro com operadores lógicos (AND/OR) e faixa de valores (BETWEEN)
SELECT
    p.nome,
    p.preco,
    c.nome AS categoria
FROM tbl_produtos AS p
INNER JOIN tbl_categorias AS c
    ON p.id_categoria = c.id
WHERE c.nome = 'Informática'
AND p.preco BETWEEN 200.00 AND 1500.00;

-- Nível 1.5: Busca por padrões de texto (LIKE) e conjunto de valores (IN)
SELECT nome, email, cidade FROM tbl_clientes
WHERE cidade IN ('Campinas', 'Santos', 'Sorocaba') AND nome LIKE 'A%';
