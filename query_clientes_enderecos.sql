select 
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
left join municipio mun on (p.codi_mun = mun.codi_mun);