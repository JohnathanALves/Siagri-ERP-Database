select 
case t.situ_tra 
    when 'A' then 'ATIVO'
    when 'I' then 'INATIVO'
end as situacao,
t.codi_tra as codig_erp_legado,
t.raza_tra as razao_social, 
t.fant_tra as nome_fantasia, 
t.sexo_tra as sexo,
t.ines_tra as inscricao_estadual_RG,
t.insm_tra as emissor,
t.dcad_tra as data_inicial,
t.cgc_tra as cnpj_cpf,
REGEXP_REPLACE(t.tel1_tra, '[^0-9]', '') as telefone1,
REGEXP_REPLACE(t.tel2_tra, '[^0-9]', '') as telefone2,
REGEXP_REPLACE(t.fax_tra, '[^0-9]', '') as fax,
t.emcg_tra as email,
t.obse_tra as observacoes_cliente,
case t.codi_tpc
    when 1 then 'NAO CONTRIBUINTE'
    when 2 then 'CONTRIBUINTE'
end as tipo_contribuinte_icms,
case t.tcpc_tra
    when 1 then 'NAO CONTRIBUINTE'
    when 2 then 'CONTRIBUINTE'
end as contribuinte_pis_cofins,
case t.tcip_tra
    when 2 then 'NAO CONTRIBUINTE'
    when 1 then 'CONTRIBUINTE'
end as contribuinte_ipi,
t.lati_tra as latitude,
t.long_tra as longitude,
c.npai_cli as nome_pai,
c.nmae_cli as nome_mae,
c.naci_cli as nacionalidade,
c.natu_cli as naturalidade,
case c.estc_cli 
 when 'C' then 'CASADO'
 when 'S' then 'SOLTEIRO'
 when 'O' then 'OUTROS'
 when 'N' then 'CONVIVENTE'
 when 'D' then 'DIVORCIADO'
 when 'V' then 'VIUVO'
 else 'OUTROS'
end as estado_civil,
c.dnas_cli as data_nascimento,
c.prof_cli as profissao,
coalesce(lc.limi_lim, 0) as limite_credito,
compra.demi_not as ultima_compra,
case cat.desc_ctc
    when 'FAZENDA' then 'Fazenda - Bronze'
    when 'CONSUMIDOR' then 'Consumidor - Bronze'
    when 'REVENDA' then 'Distribuição - Bronze'
    when 'FOCALIZADO' then 'Focalizado - Bronze'
    else 'Consumidor - Bronze'
end as Perfil_cliente,
enderecos.tipo_endereco,
enderecos.codigo_endereco,
enderecos.logradouro,
enderecos.numero,
enderecos.bairro,
enderecos.cep,
enderecos.complemento,
enderecos.cidade,
enderecos.estado,
enderecos.IE_propriedade
from transac t
    left join cliente c on (t.codi_tra = c.codi_tra)
    left join limitecr lc on (t.codi_tra = lc.codi_tra)
    left join categcli cat on (c.codi_ctc = cat.codi_ctc)
    join (select 
        t.codi_tra,
        'PRINCIPAL' as tipo_endereco,
        null as codigo_endereco,
        t.ende_tra as logradouro,
        t.nend_tra as numero, 
        t.bair_tra as bairro, 
        t.cep_tra as cep,
        t.comp_tra as complemento,
        mun.desc_mun as cidade,
        mun.esta_mun as estado,
        null as IE_propriedade
        from transac t
        left join municipio mun on (t.codi_mun = mun.codi_mun)
        
        union 
        
        select 
        t.codi_tra, 
        'COBRANCA',
        null,
        t.cend_tra,
        t.cnum_tra,
        t.cbai_tra,
        t.ccep_tra,
        t.comc_tra,
        mun.desc_mun,
        mun.esta_mun,
        null
        from transac t
        left join municipio mun on (t.codi_mun = mun.codi_mun)
        
        union 
        
        select
        p.codi_tra,
        'ENTREGA',
        p.prop_pro,
        p.ende_pro,
        p.nump_pro,
        p.bair_pro,
        p.cep_pro,
        p.desc_pro,
        mun.desc_mun,
        mun.esta_mun,
        p.isne_pro
        from propried p
        left join municipio mun on (p.codi_mun = mun.codi_mun)
    ) enderecos on (t.codi_tra = enderecos.codi_tra)
    join (select codi_tra,
        (select DEMI_NOT
        from
        (select * from  NOTA N  order by 1 DESC) N inner join FUNCAOTOPER F ON (F.CODI_TOP 
          = N.CODI_TOP) where N.SITU_NOT = '5' and N.CODI_TRA in (t.codi_tra) and F.CODI_PTO =
           '101'  and rownum <= 1) as demi_not
        from transac t) compra on (t.codi_tra = compra.codi_tra)
where clie_tra = 'S' and compra.demi_not >= to_date('01/01/2015');