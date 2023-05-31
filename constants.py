# -*- coding: utf-8 -*-

from datetime import datetime, timedelta

months_ptbr = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
}

months_ptbr_abbr = {
    1: 'JAN',
    2: 'FEV',
    3: 'MAR',
    4: 'ABR',
    5: 'MAI',
    6: 'JUN',
    7: 'JUL',
    8: 'AGO',
    9: 'SET',
    10: 'OUT',
    11: 'NOV',
    12: 'DEZ',
}

weekdays_ptbr = {
    0: 'Segunda',
    1: 'Terça',
    2: 'Quarta',
    3: 'Quinta',
    4: 'Sexta',
    5: 'Sábado',
    6: 'Domingo',
}

weekdays_ptbr_abbr = {
    0: 'SEG',
    1: 'TER',
    2: 'QUA',
    3: 'QUI',
    4: 'SEX',
    5: 'SAB',
    6: 'DOM',
}


starting_year = 2022

current_month = datetime.now().month
current_year = datetime.now().year
current_day = datetime.now().day


columns_names_head = [
    'cod_colaborador',
    'nome_colaborador',
    'cod_cliente',
    'nome_cliente',
    'razao_social',
    'ramo_atividade',
    'data_cadastro',
    'bairro',
    'cidade',
    'uf',
    'endereco',
    'numero',
    'cep',
    'dias_atraso',
    'valor_devido',
    'dt_primeira_compra',
    'dt_ultima_compra',
]
sale_nops = [
    '6.102',
    '6.404',
    'BLACKFRIDAY',
    'VENDA',
    'VENDA_S_ESTOQUE',
    'WORKSHOP',
]
subsidized_nops = [
    'BONIFICADO',
    'BONIFICADO_F',
    'BONI_COMPRA',
    'PROMOCAO',
    'PROMO_BLACK',
    'CAMPANHA',
]
trousseau_nops = ['ENXOVAL']
str_to_int_cols = [
    'numero',
    'empresa_nota_fiscal',
    'cod_colaborador',
    'cod_pedido',
    'nr_ped_compra_cli',
    'cod_situacao',
    'cod_forma_pagto',
    'cod_grupo_produto',
    'cod_grupo_pai',
    'cod_marca',
]
int_cols = ['dias_atraso', 'qtd']
float_cols = [
    'valor_devido',
    'custo_total',
    'custo_kami',
    'preco_unit_original',
    'preco_total_original',
    'margem_bruta',
    'preco_total',
    'preco_desconto_rateado',
    'vl_total_pedido',
    'desconto_pedido',
    'valor_nota',
    'total_bruto',
]
trans_cols = {
    'company': 'Empresa',
    'branch': 'Canal de Vendas',
    'uf': 'Estado',
    'salesperson': 'Vendedores',
}
companies = {
    1: 'KAMI CO',
    2: 'NEW HAUSS',
    3: 'MOVEMENT SP',
    4: 'ENERGY',
    5: 'HAIRPRO',
    6: 'SOUTH',
    9: 'MMS',
    10: '3MKO MATRIZ',
    11: '3MKO FILIAL SP',
    12: '3MKO FILIAL ES',
    13: 'MOVEMENT RJ',
    14: '3MKO FILIAL PR',
    15: 'MOVEMENT MT',
    16: 'MOVEMENT RS',
}
template_cols = [
    'ano',
    'mes',
    'cod_cliente',
    'nome_cliente',
    'ramo_atividade',
    'bairro',
    'cidade',
    'uf',
    'cod_colaborador',
    'nome_colaborador',
    'cod_situacao',
    'desc_situacao',
    'cod_grupo_produto',
    'desc_grupo_produto',
    'cod_grupo_pai',
    'desc_grupo_pai',
    'cod_marca',
    'desc_marca',
    'empresa_nota_fiscal',
]
filter_cols = [
    'Ano',
    'Mês',
    'Empresa',
    'Marca',
    'Vendedores',
    'Canal de Vendas',
    'Estado',
    'Situação',
]
