select 
t.raza_tra,
t.codi_tra,
case t.tjur_tra
 when 'F' then 'PESSOA'
 when 'J' then 'CORPORACAO'
end as TIPO_ORGANIZACAO,
'BR' AS PAIS,
t.cgc_tra as cnpj_cpf,

-------------------------------------------------

t.codi_tra,
t.ende_tra,
t.nend_tra,
t.comp_tra,
t.bair_tra,
mun.desc_mun,
mun.esta_mun,
t.cep_tra,
t.ines_tra,
t.insm_tra,
REGEXP_REPLACE(t.tel1_tra, '[^0-9]', '') as telefone1,
REGEXP_REPLACE(t.tel2_tra, '[^0-9]', '') as telefone2,
REGEXP_REPLACE(t.fax_tra, '[^0-9]', '') as fax,
t.emcg_tra,
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

------------------------------------------------------------

t.raza_tra,
t.codi_tra,
'PlanteBem BU && AgroExpress BU' as Procurement,
'PRINCIPAL' as address_name,
'PRINCIPAL' as Supplier_site_name,
'Y' as Purcharsing_Site,
'Y' as Pay_Site,
'Y' as Primary_Pay_Site,
t.cgc_tra as Tax_Registration, 
case t.tjur_tra
 when 'J' then 'ORA_BR_CNPJ'
 when 'F' then 'ORA_BR_CPF'
end as Validation_type

from transac t

    join (select 
        t.codi_tra,
        (
    select 
        DMOV_CPG 
    FROM
        (select * from cabpagar order by 1 desc) CP 
    WHERE CP.codi_tra in (t.codi_tra) and rownum <= 1) as dmov_cpg
    from transac t) P ON (t.codi_tra = p.codi_tra)
    left join municipio mun on (t.codi_mun = mun.codi_mun)
    
where t.forn_tra = 'S' and p.dmov_cpg >= to_date('01/01/2016');