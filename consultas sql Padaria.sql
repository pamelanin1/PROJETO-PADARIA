USE Padaria;

-- 1. Quantos funcionários trabalham em cada cargo da padaria?
SELECT cargo, COUNT(*) AS quantidadeFuncionarios FROM funcionarios
GROUP BY cargo;

-- 2. Quantos produtos estão cadastrados em cada categoria?
SELECT FK_categoriaID, COUNT(*) AS quantidadeProdutos
FROM produtos GROUP BY FK_categoriaID;

-- 3. Qual é a quantidade de vendas e o valor total registrado para cada status?
SELECT status, COUNT(*) AS quantidadeVendas, SUM(valorTotal) AS totalVendas
FROM vendas GROUP BY status;

-- 4. Quais formas de pagamento possuem um valor total pago superior a R$ 100,00?
SELECT formaPagamento, SUM(valorPago) AS totalRecebido FROM pagamentos
GROUP BY formaPagamento HAVING SUM(valorPago) > 100;

-- 5. Quais cargos da padaria possuem uma média salarial superior a R$ 2.000,00?
SELECT cargo, COUNT(*) AS quantidadeFuncionarios, AVG(salario) AS mediaSalarial
FROM funcionarios GROUP BY cargo HAVING AVG(salario) > 2000;

-- 6. Quais produtos possuem preço de venda superior à média de preços dos produtos cadastrados?
SELECT nome, precoVenda FROM produtos WHERE precoVenda > (
    SELECT AVG(precoVenda)
    FROM produtos
);

-- 7. Quais funcionários recebem o maior salário da padaria?
SELECT nome, cargo, salario FROM funcionarios WHERE salario = (
    SELECT MAX(salario)
    FROM funcionarios
);

-- 8. Quais clientes possuem vendas registradas na padaria, mostrando o número da venda, a data e o valor total?
SELECT c.nome,v.vendasID,v.dataVenda,v.valorTotal FROM vendas AS v 
INNER JOIN clientes AS c ON v.FK_clientesID = c.clientesID
WHERE c.clientesID IN (SELECT FK_clientesID FROM vendas WHERE FK_clientesID IS NOT NULL)
ORDER BY c.nome, v.dataVenda;


-- 9. Quais vendas possuem valor total superior à média de todas as vendas realizadas na padaria? E ordene pelo maior valor total.
SELECT vendasID, dataVenda, valorTotal, status FROM vendas
WHERE valorTotal > (SELECT AVG(valorTotal) FROM vendas)
ORDER BY valorTotal DESC;


-- 10. Quais fornecedores estão relacionados a pelo menos uma compra cujo valor total foi superior à média de todas as compras?
SELECT nomeFantasia, cnpj FROM fornecedores WHERE fornecedoresID IN (
    SELECT FK_fornecedoresID FROM compras
    WHERE valorTotal > ( SELECT AVG(valorTotal) FROM compras)
);

-- 11. Quais são os produtos cadastrados, seus preços e suas respectivas categorias?
SELECT p.nome AS produto, c.nome AS categoria, p.precoVenda FROM produtos AS p
INNER JOIN categoria AS c ON p.FK_categoriaID = c.categoriaID;

-- 12. Quais vendas foram realizadas e quais clientes estão relacionados a elas?
SELECT v.vendasID, c.nome, v.dataVenda, v.valorTotal FROM vendas AS v 
LEFT JOIN clientes AS c ON v.FK_clientesID = c.clientesID;

-- 13. Quais funcionários foram responsáveis pelas vendas realizadas na padaria?
SELECT v.vendasID, f.nome, v.dataVenda, v.valorTotal FROM vendas AS v
INNER JOIN funcionarios AS f ON v.FK_funcionariosID = f.funcionariosID;

-- 14. Quais compras foram registradas e quais fornecedores estão relacionados a elas?
SELECT c.comprasID, f.nomeFantasia, c.dataCompra, c.valorTotal, c.status
FROM compras AS c INNER JOIN fornecedores AS f ON c.FK_fornecedoresID = f.fornecedoresID;

-- 15. Quais produtos foram vendidos, em quais vendas, e quais suas quantidades e subtotais?
SELECT v.vendasID, p.nome, iv.quantidade, iv.precoUnit, iv.subtotal
FROM itensVenda AS iv INNER JOIN vendas AS v ON iv.FK_vendasID = v.vendasID
INNER JOIN produtos AS p ON iv.FK_produtosID = p.produtosID;

-- 16. Qual é a quantidade total vendida de cada produto da padaria? E ordene para maior quantidade de vendas.
SELECT p.nome AS produto, SUM(iv.quantidade) AS quantidadeVendida FROM produtos AS p
INNER JOIN itensVenda AS iv ON p.produtosID = iv.FK_produtosID GROUP BY p.produtosID, p.nome
ORDER BY quantidadeVendida DESC;

-- 17. Qual é a quantidade de vendas e o valor total vendido por cada funcionário da padaria? E ordene para maior total de vendas.
SELECT f.nome, COUNT(v.vendasID) AS quantidadeVendas, SUM(v.valorTotal) AS totalVendido
FROM funcionarios AS f INNER JOIN vendas AS v ON f.funcionariosID = v.FK_funcionariosID
GROUP BY f.funcionariosID, f.nome ORDER BY totalVendido DESC;






