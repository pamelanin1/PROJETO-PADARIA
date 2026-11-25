CREATE DATABASE IF NOT EXISTS Padaria;
USE Padaria;
-- DROP DATABASE Padaria;


CREATE TABLE IF NOT EXISTS categoria (
    categoriaID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS clientes (
    clientesID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS fornecedores (
    fornecedoresID INT PRIMARY KEY AUTO_INCREMENT,
    nomeFantasia VARCHAR(120) NOT NULL,
    cnpj CHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(120),
    endereco VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS funcionarios (
    funcionariosID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE,
    cargo VARCHAR(80) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    dataAdmissao DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS produtos (
    produtosID INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    descricao VARCHAR(255),
    unidadeMedida VARCHAR(10) NOT NULL,
    precoVenda DECIMAL(10,2) NOT NULL,
    estoqueAtual DECIMAL(10,3) NOT NULL DEFAULT 0,
    estoqueMin DECIMAL(10,3) NOT NULL DEFAULT 0,
    ativo BOOLEAN DEFAULT TRUE,
    FK_categoriaID INT NOT NULL,
    FOREIGN KEY (FK_categoriaID) REFERENCES categoria(categoriaID)
);

CREATE TABLE IF NOT EXISTS compras (
    comprasID INT PRIMARY KEY AUTO_INCREMENT,
    dataCompra DATE NOT NULL,
    valorTotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    status VARCHAR(30) NOT NULL,
    FK_fornecedoresID INT NOT NULL,
    FK_funcionariosID INT NOT NULL,
    FOREIGN KEY (FK_fornecedoresID) REFERENCES fornecedores(fornecedoresID),
    FOREIGN KEY (FK_funcionariosID) REFERENCES funcionarios(funcionariosID)
);

CREATE TABLE IF NOT EXISTS itensCompras (
    itensComprasID INT PRIMARY KEY AUTO_INCREMENT,
    quantidade DECIMAL(10,3) NOT NULL,
    custoUnitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FK_comprasID INT NOT NULL,
    FK_produtosID INT NOT NULL,
    FOREIGN KEY (FK_comprasID) REFERENCES compras(comprasID),
    FOREIGN KEY (FK_produtosID) REFERENCES produtos(produtosID)
);

CREATE TABLE IF NOT EXISTS vendas (
    vendasID INT PRIMARY KEY AUTO_INCREMENT,
    dataVenda DATE NOT NULL,
    desconto DECIMAL(10,2) NOT NULL DEFAULT 0,
    valorTotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    status VARCHAR(30) NOT NULL,
    FK_clientesID INT,
    FK_funcionariosID INT NOT NULL,
    FOREIGN KEY (FK_clientesID) REFERENCES clientes(clientesID),
    FOREIGN KEY (FK_funcionariosID) REFERENCES funcionarios(funcionariosID)
);

CREATE TABLE IF NOT EXISTS itensVenda (
    itensVendaID INT PRIMARY KEY AUTO_INCREMENT,
    quantidade DECIMAL(10,3) NOT NULL,
    precoUnit DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FK_vendasID INT NOT NULL,
    FK_produtosID INT NOT NULL,
    FOREIGN KEY (FK_vendasID) REFERENCES vendas(vendasID),
    FOREIGN KEY (FK_produtosID) REFERENCES produtos(produtosID)
);

CREATE TABLE IF NOT EXISTS pagamentos (
    pagamentoID INT PRIMARY KEY AUTO_INCREMENT,
    formaPagamento VARCHAR(40) NOT NULL,
    valorPago DECIMAL(12,2) NOT NULL,
    data DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    FK_vendasID INT NOT NULL,
    FOREIGN KEY (FK_vendasID) REFERENCES vendas(vendasID)
);
