select 
 dp.codi_emp,
 p.codi_psv as codigo_siagri,
 p.situ_psv as situacao,
 p.desc_psv as descricao,
 p.unid_psv as unidade_primaria,
 prod.cfis_pro as NCM,
 grupo.DESC_GPR as grupo,
 subgrupo.DESC_SBG as subgrupo,
 coalesce (cast ((SELECT SUM(SALD_CTR) FROM TABLE (SALDO_INICIAL_TIPOEST(1, 2, PRODSERV.CODI_PSV, TO_DATE('15/07/19', 'DD/MM/YY'), 'S' , null, null))) as decimal(18,4)), 0) AS ESTOQUE_PERTENCENTE,
 dp.codi_com as codigo_reducao,
 comppro.desc_com as reducao_base,
 case icomppro.codi_tpc
    when 1 then 'N�O CONTRIBUINTE'
    when 2 then 'CONTRIBUINTE'
    when 10 then 'SYNGENTA'
 end as tipo_contribuinte,
 case icomppro.tipo_com
    when 'SI' then 'SAIDA DENTRO DO ESTADO'
    when 'SF' then 'SAIDA FORA DO ESTADO'
    when 'SE' then 'SAIDA P/ EXTERIOR'
    when 'EI' then 'ENTRADA DENTRO DO ESTADO'
    when 'EF' then 'ENTRADA FORA DO ESTADO'
    when 'EE' then 'ENTRADA DO EXTERIOR'
 end as tipo_tributacao,
 icomppro.mens_com as mensagem_complementar,
 icomppro.rbca_com as aliquota_reducao_base,
 icomppro.cstp_com as situcao_tributaria,
 estapro.desc_est as aliquota_estadual,
 apc.desc_apc as aliquota_PIS_COFINS,
 case iapc.tipo_IPC
    when 'IE' then 'MERCADO INTERNO - ENTRADA'
    when 'IS' then 'MERCADO INTERNO - SAIDA'
    when 'EE' then 'MERCADO EXTERNO - ENTRADA'
    when 'ES' then 'MERCADO EXTERNO - SAIDA'
 end as regime_tributacao_pis_cofins,
 iapc.apis_ipc as aliquota_pis,
 iapc.ACOF_IPC as aliquota_cofins,
 iapc.cstp_ipc as cst_pis,
 iapc.cstc_ipc as cst_cofins

from prodserv p
 left join grupo on (p.codi_gpr = grupo.codi_gpr)
 left join subgrupo on (p.codi_sbg = subgrupo.codi_sbg)
 left join produto prod on (p.codi_psv = prod.codi_psv)
 left join dadospro dp on (p.codi_psv = dp.codi_psv)
 left join comppro on (dp.codi_com = comppro.codi_com)
 left join icomppro on (comppro.codi_com = icomppro.codi_com)
 left join estapro on (dp.codi_est = estapro.codi_est)
 left join aliqpiscofins apc on (dp.codi_apc = apc.codi_apc)
 left join ialiqpiscofins iapc on (apc.codi_apc = iapc.codi_apc and icomppro.codi_tpc = iapc.CODI_TPC)

where 
dp.codi_emp in (1,3,4,5) and
icomppro.codi_tpc in (1,2);