select * from (select 
cb.desc_cta,
t.codi_psv,
t.basi_tab,
t.pdes_tab
from tabela t
left join cabtab cb on (cb.tabe_cta = t.tabe_cta)
where t.tabe_cta in (1,2,3,4,7,10000007))
