WITH produtoind AS (
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%corteva%'
            OR
                lower(fant_tra) LIKE '%corteva%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%dow%'
            OR
                lower(fant_tra) LIKE '%dow%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%dupont%'
            OR
                lower(fant_tra) LIKE '%dupont%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%du pont%'
            OR
                lower(fant_tra) LIKE '%du pont%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%pioneer%'
            OR
                lower(fant_tra) LIKE '%pioneer%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%brevant%'
            OR
                lower(fant_tra) LIKE '%brevant%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%biogene%'
            OR
                lower(fant_tra) LIKE '%biogene%'
        UNION
        SELECT
            codi_tra
        FROM
            transac
        WHERE
                lower(raza_tra) LIKE '%coodetec%'
            OR
                lower(fant_tra) LIKE '%coodetec%'
    ) 
select 

cademp.cnpj_emp as CNPJ_EMISSOR,
empresa.raza_tra as RAZAO_SOCIAL_EMISSOR,
n.nota_not as NUMERO_NOTA_FISCAL,
n.seri_not AS SERIE_NOTA_FISCAL,
n.demi_not AS DATA_EMISSAO,
cliente.cgc_tra AS CPF_CNPJ_CLIENTE_RECEBEDOR,
cliente.raza_tra AS RAZAO_SOCIAL_CLIENTE_RECEBEDOR,
cliente.cep_tra AS CEP_CLIENTE_RECEBEDOR,
municipio.desc_mun AS CIDADE_CLIENTE_RECEBEDOR,
municipio.esta_mun AS ESTADO_CLIENTE_RECEBEDOR,
cliente.ende_tra || ', ' || cliente.nend_tra || ', ' ||cliente.comp_tra as ENDERECO_CLIENTE_RECEBEDOR,
cliente.bair_tra as BAIRRO_CLIENTE_RECEBEDOR,
cliente.tel1_tra as telefone_CLIENTE_RECEBEDOR,
cliente.tel2_tra as telefone2_CLIENTE_RECEBEDOR,
cfo.dimp_cfo as Natureza_Operacao,
SUBSTR(inf.ccfo_cfo, 1, 4) as Natureza_Operacao_codigo,
case top.tipo_top
    when 'S' then 'Saída'
    when 'E' then 'Entrada'
end as Tipo_Operacao,
inf.codi_psv as codigo_produto,
psv.desc_psv as Nome_produto,
codbarra.codi_bar as codigo_barras,
p.cori_pro as codigo_original,
inf.qtde_ino as quantidade,
psv.unid_psv as unidade,
inf.vlor_ino as preco_unitario,
inf.vlor_ino * inf.qtde_ino as valor_bruto,
inf.vliq_ino * inf.qtde_ino as valor_liq,
cond.desc_con as condicao,
n.cod1_pes as codigo_vendedor,
pes1.NOME_PES AS VENDEDOR,
pes1.CPF_PES AS CPF_VENDEDOR
from nota n
    left join inota inf on (n.npre_not = inf.npre_not)
    join cademp on (n.codi_emp = cademp.codi_emp)
    join transac empresa on (cademp.cod1_tra = empresa.codi_tra)
    join transac cliente on (n.codi_tra = cliente.codi_tra)
    join municipio on (cliente.codi_mun = municipio.codi_mun)
    join cfo on (inf.ccfo_cfo = cfo.ccfo_cfo)
    join tipooper top on (inf.codi_top = top.codi_top)
    join prodserv psv on (inf.codi_psv = psv.codi_psv)
    left join codbarra on (inf.codi_psv = codbarra.codi_psv)
    join produto p on (psv.codi_psv = p.codi_psv)
    left join condicao cond on (n.cond_con = cond.cond_con)
    left join pessoal pes1 on (n.cod1_pes = pes1.CODI_PES)
    left join funcaotoper on (top.codi_top = funcaotoper.codi_top)
where
    n.codi_emp in (1,3,4,5) and
    n.demi_not between to_date('01/04/2018') and to_date('31/03/2019') and
    funcaotoper.codi_pto = 102 and
    top.tipo_top = 'S' and
    p.codi_tra IN (
    SELECT
        codi_tra
    FROM
        produtoind
    )
