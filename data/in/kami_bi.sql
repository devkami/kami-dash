USE bkp_db_uc_kami;
SELECT
'ano',
'mes',
'empresa_pedido',
'empresa_nota_fiscal',
'cod_cliente',
'nome_cliente',
'razao_social',
'ramo_atividade',
'bairro',
'cidade',
'uf',
'endereco',
'numero',
'cep',
'data_cadastro',
'dias_atraso',
'valor_devido',
'dt_primeira_compra',
'dt_ultima_compra',
'cod_colaborador',
'nome_colaborador',
'cod_pedido',
'nr_ped_compra_cli',
'cod_situacao',
'desc_situacao',
'nop',
'cfop',
'cod_cond_pagto',
'cod_forma_pagto',
'forma_pgto',
'cod_produto',
'desc_produto',
'cod_grupo_produto',
'desc_grupo_produto',
'cod_grupo_pai',
'desc_grupo_pai',
'cod_marca',
'desc_marca',
'custo_total',
'custo_kami',
'tb_preco',
'qtd',
'preco_unit_original',
'preco_total_original',
'margem_bruta',
'preco_total',
'preco_desconto_rateado',
'vl_total_pedido',
'desconto_pedido',
'valor_nota',
'total_bruto',
'dt_implante_pedido',
'dt_entrega_comprometida',
'dt_faturamento'
UNION ALL
SELECT  
 CONVERT(YEAR(IFNULL(CASE WHEN nota_fiscal.dt_emissao > 0 THEN nota_fiscal.dt_emissao ELSE nota_fiscal_2.dt_emissao END, pedido.dt_implant)), UNSIGNED) AS ano
,CONVERT(MONTH(IFNULL(CASE WHEN nota_fiscal.dt_emissao > 0 THEN nota_fiscal.dt_emissao ELSE nota_fiscal_2.dt_emissao END, pedido.dt_implant)), UNSIGNED) AS mes
,CONVERT(pedido.cod_empresa, UNSIGNED) AS empresa_pedido
,CONVERT(nota_fiscal_2.cod_empresa, UNSIGNED) AS empresa_nota_fiscal
,CONVERT(pedido.cod_cliente, UNSIGNED) AS cod_cliente
,CONVERT(pedido.nome_cliente USING utf8) AS nome_cliente
,CONVERT(cliente.razao_social USING utf8) AS razao_social
,CONVERT(ramo_atividade.desc_abrev USING utf8) AS ramo_atividade
,CONVERT(cliente_endereco.bairro USING utf8) AS bairro
,CONVERT(cliente_endereco.cidade USING utf8) AS cidade
,CONVERT(cliente_endereco.sigla_uf USING utf8) AS uf
,CONVERT(cliente_endereco.endereco USING utf8) AS endereco
,CONVERT(cliente_endereco.numero, UNSIGNED) AS numero
,CONVERT(cliente_endereco.cep, UNSIGNED) AS cep
,DATE_FORMAT(cliente.dt_implant,'%d/%m/%Y') AS data_cadastro
,CONVERT((SELECT  CASE WHEN (sum(recebe.vl_total_titulo) - sum(recebe.vl_total_baixa)) > 0 THEN  ( TIMESTAMPDIFF(DAY,recebe.dt_vencimento, CURRENT_DATE())) ELSE  "0" END FROM fn_titulo_receber AS recebe WHERE recebe.cod_cliente = pedido.cod_cliente AND recebe.situacao < 30 AND recebe.dt_vencimento < SUBDATE(CURDATE(), INTERVAL 1 DAY) AND recebe.cod_empresa IN (1,2,3,4,5,6,9,10,11)  group by recebe.cod_cliente), UNSIGNED) AS dias_atraso
,ROUND((SELECT CASE WHEN (sum(recebe.vl_total_titulo) - sum(recebe.vl_total_baixa)) > 0 THEN  (sum(recebe.vl_total_titulo) - sum(recebe.vl_total_baixa)) ELSE  "0" END FROM fn_titulo_receber AS recebe WHERE recebe.cod_cliente = pedido.cod_cliente AND recebe.situacao < 30 AND recebe.dt_vencimento < SUBDATE(CURDATE(), INTERVAL 1 DAY)  AND recebe.cod_empresa IN (1,2,3,4,5,6,9,10,11) group by recebe.cod_cliente), 2) AS valor_devido
,(SELECT DATE_FORMAT(min(nf2.dt_emissao),'%d/%m/%Y') FROM vd_nota_fiscal AS nf2 WHERE pedido.cod_cliente = nf2.cod_cliente AND nf2.situacao < 81 AND nf2.cod_empresa IN (1,2,3,4,5,6,9,10,11) AND nf2.nop IN ("6.102","6.404","BLACKFRIDAY","VENDA","VENDA_S_ESTOQUE","WORKSHOP")) AS dt_primeira_compra
,(SELECT DATE_FORMAT(max(nf2.dt_emissao),'%d/%m/%Y') FROM vd_nota_fiscal AS nf2 WHERE pedido.cod_cliente = nf2.cod_cliente AND nf2.situacao < 81 AND nf2.cod_empresa IN (1,2,3,4,5,6,9,10,11) AND nf2.nop IN ("6.102","6.404","BLACKFRIDAY","VENDA","VENDA_S_ESTOQUE","WORKSHOP")) AS dt_ultima_compra
,CONVERT(pedido.cod_colaborador USING utf8) AS cod_colaborador
,CONVERT(colaborador.nome_colaborador USING utf8) AS nome_colaborador
,CONVERT(pedido.cod_pedido USING utf8) AS cod_pedido
,CONVERT(IFNULL(pedido.nr_ped_compra_cli, pedido.cod_pedido_pda) USING utf8) AS nr_ped_compra_cli
,CONVERT(pedido.situacao, UNSIGNED) AS cod_situacao
,CONVERT(ponto_controle.descricao USING utf8) AS desc_situacao
,CONVERT(pedido.nop USING utf8) AS nop
,CONVERT(nota_fiscal_2.desc_abrev_cfop USING utf8) AS cfop
,CONVERT(pedido.cod_cond_pagto USING utf8) AS cod_cond_pagto
,CONVERT(pedido_pgto.cod_forma_pagto USING utf8) AS cod_forma_pagto
,CONVERT(forma_pgto.desc_abrev USING utf8) AS forma_pgto
,CONVERT(pedido_item.cod_produto USING utf8) AS cod_produto
,CONVERT(pedido_item.desc_comercial USING utf8) AS desc_produto
,CONVERT(grupo_item.cod_grupo_produto USING utf8) AS cod_grupo_produto
,CONVERT(grupo_produto.desc_abrev USING utf8) AS desc_grupo_produto
,CONVERT(grupo_produto.cod_grupo_pai USING utf8) AS cod_grupo_pai
,CONVERT(grupo_produto_pai.desc_abrev USING utf8) AS desc_grupo_pai
,CONVERT(marca.cod_marca USING utf8) AS cod_marca
,CONVERT(marca.desc_abrev USING utf8) AS desc_marca
,ROUND(produto_empresa.vl_custo_total, 2) AS custo_total
,ROUND(IFNULL(produto_empresa.vl_custo_kami,(SELECT cpi.preco_unit FROM cd_preco_item AS cpi WHERE cpi.cod_produto = pedido_item.cod_produto AND cpi.tb_preco = 'TabTbCusto')), 2) AS custo_kami
,CONVERT(pedido_item.tb_preco USING utf8) AS tb_preco
,CONVERT(pedido_item.qtd, UNSIGNED) AS qtd
,ROUND(pedido_item.preco_venda, 2) AS preco_unit_original
,ROUND(pedido_item.qtd * pedido_item.preco_venda, 2) AS preco_total_original
,ROUND((((pedido_item.preco_venda / produto_empresa.vl_custo_total)*100)-100), 2) AS margem_bruta
,ROUND(pedido_item.preco_total, 2) AS preco_total
,ROUND((pedido_item.preco_total -( pedido_item.preco_total / pedido.vl_total_produtos) * COALESCE(pedido.vl_desconto,0)), 2) AS preco_desconto_rateado
,ROUND(pedido.vl_total_produtos, 2) AS vl_total_pedido
,ROUND((pedido.vl_desconto * -1), 2) AS desconto_pedido
,ROUND((CASE WHEN nota_fiscal.vl_total_nota_fiscal > 0 THEN nota_fiscal.vl_total_nota_fiscal ELSE nota_fiscal_2.vl_total_nota_fiscal END), 2) AS valor_nota
,ROUND(((CASE WHEN nota_fiscal.vl_total_nota_fiscal > 0 THEN nota_fiscal.vl_total_nota_fiscal ELSE nota_fiscal_2.vl_total_nota_fiscal END) + pedido.vl_desconto), 2) AS total_bruto
,DATE_FORMAT(pedido.dt_implant, "%d/%m/%Y") AS dt_implante_pedido
,DATE_FORMAT(pedido.dt_entrega_comprometida, "%d/%m/%Y") AS dt_entrega_comprometida
,DATE_FORMAT(CASE WHEN nota_fiscal.dt_emissao > 0 THEN nota_fiscal.dt_emissao ELSE nota_fiscal_2.dt_emissao END, "%d/%m/%Y") AS dt_faturamento

FROM vd_pedido AS pedido
LEFT JOIN sg_colaborador AS colaborador ON (colaborador.cod_colaborador = pedido.cod_colaborador)
LEFT JOIN cd_cond_pagto AS cond_pgto ON  (cond_pgto.cod_cond_pagto = pedido.cod_cond_pagto)
LEFT JOIN vd_ponto_controle AS ponto_controle ON (ponto_controle.cod_controle = pedido.situacao)
LEFT JOIN vd_pedido_pagto AS pedido_pgto ON (pedido_pgto.cod_pedido = pedido.cod_pedido )
LEFT JOIN cd_forma_pagto AS forma_pgto ON  (pedido_pgto.cod_forma_pagto = forma_pgto.cod_forma_pagto)
LEFT JOIN cd_cliente_atividade AS cliente_atividade  ON (cliente_atividade.cod_cliente = pedido.cod_cliente)
LEFT JOIN cd_ramo_atividade AS ramo_atividade  ON (cliente_atividade.cod_ramo_atividade = ramo_atividade.cod_ramo_atividade)
LEFT JOIN vd_nota_fiscal AS nota_fiscal ON (nota_fiscal.cod_pedido = pedido.cod_pedido AND nota_fiscal.situacao < 86 AND nota_fiscal.situacao > 79 AND pedido.cod_empresa = nota_fiscal.cod_empresa)
LEFT JOIN vd_nota_fiscal AS nota_fiscal_2 ON (nota_fiscal_2.cod_pedido = pedido.cod_pedido AND nota_fiscal_2.situacao < 86 AND nota_fiscal_2.situacao > 79 )
LEFT JOIN vd_pedido_item AS pedido_item ON (pedido.cod_pedido = pedido_item.cod_pedido AND pedido.cod_empresa = pedido_item.cod_empresa)
LEFT JOIN cd_produto_empresa AS produto_empresa ON (pedido_item.cod_produto = produto_empresa.cod_produto AND pedido.cod_empresa = produto_empresa.cod_empresa)
LEFT JOIN cd_produto AS produto ON (produto.cod_produto = pedido_item.cod_produto)
LEFT JOIN cd_marca AS marca ON (marca.cod_marca = produto.cod_marca)
LEFT JOIN cd_cliente_endereco AS cliente_endereco ON (cliente_endereco.cod_cliente = pedido.cod_cliente)
LEFT JOIN cd_grupo_item AS grupo_item ON (grupo_item.cod_produto = pedido_item.cod_produto)
LEFT JOIN cd_grupo_produto AS grupo_produto ON (grupo_produto.cod_grupo_produto = grupo_item.cod_grupo_produto)
LEFT JOIN cd_grupo_produto AS grupo_produto_pai ON (grupo_produto_pai.cod_grupo_produto = grupo_produto.cod_grupo_pai)
LEFT JOIN cd_cliente AS cliente ON (cliente.cod_cliente = pedido.cod_cliente)

WHERE pedido.dt_implant >= "2022-01-01"
AND pedido.situacao < 200
AND pedido.cod_empresa IN (1,2,3,4,5,6,9,10,11)

GROUP BY ano, mes, pedido.cod_pedido, pedido.cod_cliente, pedido_item.cod_produto

INTO OUTFILE 'csv/faturamento_diario_GERAL.csv'
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'