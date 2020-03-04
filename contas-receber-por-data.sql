select 
crec.ctrl_cbr, crec.codi_emp as loja, crec.codi_tdo as tipo_doc, crec.seri_cbr as serie_doc, crec.data_cbr as "DATA", crec.tota_cbr as total, crec.situ_cbr as situacao, LPAD(crec.codi_tra, 10, '0') as cod_parceiro,
t.raza_tra as razao_social,
rec.codi_tco, tipcob.DESC_TCO ,rec.codi_por, portador.DESC_POR, rec.codi_con as Cod_CONTA, conta.desc_con as CONTA, rec.cod1_pes, p1.nome_pes as vendedor_1, rec.cod2_pes, p2.nome_pes as vendedor_2, rec.npar_rec, rec.venc_rec, rec.vlor_rec, rec.dant_rec, rec.dpon_rec, rec.tjur_rec, rec.jatv_rec, rec.japv_rec, rec.situ_rec, rec.hist_rec,
crec.CTRL_LAN as cod_lancamento, lan.COMP_LAN as complemento_lancamento,

notacrc.tdoc_noc as TP_DOC, notacrc.ndoc_noc as N_nota, notacrc.vlor_noc as valor_nota,
nota.ccfo_cfo as cfop, nota.COND_CON as cod_condicao, condicao.desc_con as condicao, 

p1.nome_pes as vendedor1, p2.nome_pes as vendedor2

from cabrec crec
left join transac t on (crec.codi_tra = t.codi_tra)
left join receber rec on (rec.ctrl_cbr = crec.ctrl_cbr)
left join tipcob on (rec.codi_tco = tipcob.CODI_TCO)
left join portador on (rec.codi_por = portador.codi_por)
left join conta on (rec.codi_con = conta.codi_con)
left join pessoal p1 on (rec.cod1_pes = p1.codi_pes)
left join pessoal p2 on (rec.cod2_pes = p2.codi_pes)
left join lancamen lan on (lan.CTRL_LAN = crec.CTRL_LAN)
left join notacrc on (crec.ctrl_cbr = notacrc.CTRL_CBR)
left join nota on (notacrc.NDOC_NOC = nota.nota_not and notacrc.SDOC_NOC = nota.seri_not and notacrc.CODI_EMP = nota.CODI_EMP)
left join condicao on (nota.cond_con = condicao.cond_con)

where crec.data_cbr between '01/01/2018' and '08/08/2018';