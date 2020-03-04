select 
l.sequ_lct,
l.sequ_clc,
l.codi_plc,
l.codi_cpc,
l.hist_his,
l.tipo_lct,
l.codi_emp,
cabl.data_clc,
l.tlan_lct,
case l.tipo_lct
    when 'D' then l.vlor_lct end as VALOR_DEBITO,
case l.tipo_lct
    when 'C' then l.vlor_lct end as VALOR_CREDITO,

case cabl.orig_clc
    when 'NE' then 'NOTA EMPRESA'
    when 'NT' then 'NOTA TERCEIROS'
    when 'FC' then 'CAIXA E BANCOS'
    when 'CT' then 'CONHECIMENTO DE TRANSPORTE'
END AS ORIGEM,
hist.desc_his,
cc.desc_cpc,
l.comp_lct,
ccusto.DESC_CCU,
cabl.codi_tra,
tra1.raza_tra,
cclan.vlor_lct as RATEIO_CENTRO_CUSTO_VALOR,
tra.raza_tra as RATEIO_CORRENTISTA,
pd.desc_psv AS RATEIO_PRODUTO,
conta.desc_con as RATEIO_CONTA
from lancontab l
   inner join cablanctb cabl on (l.sequ_clc = cabl.sequ_clc)
   inner join contaspl cc on (cc.codi_cpc = l.codi_cpc)
   inner join historico hist on (hist.hist_his = l.hist_his)
   left join ccustolan cclan on (cclan.sequ_lct = l.SEQU_LCT)
   left join ccusto on (cclan.CODI_CCU = ccusto.CODI_CCU)
   left join corlancon on (cclan.sequ_lct = corlancon.sequ_lct)
   left join corlantra on (cclan.sequ_lct = corlantra.sequ_lct)
   left join corlanpro on (cclan.sequ_lct = corlanpro.sequ_lct)
   left join conta on (corlancon.codi_con = conta.CODI_CON)
   left join transac tra on (corlantra.codi_tra = tra.codi_tra)
   left join transac tra1 on (cabl.codi_tra = tra1.codi_tra)
   left join prodserv pd on (corlanpro.codi_psv = pd.codi_psv)
where cabl.data_clc between to_date('01/01/2019', 'DD/MM/YYYY') and to_date('01/06/2019', 'DD/MM/YYYY') and l.codi_emp in (1,3,4,5)