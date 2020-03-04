select 
     NF.CODI_EMP, 
     NF.CODI_TRA, 
     TR.RAZA_TRA, 
     TR.CGC_TRA, 
     case 
        when ( nf.PROP_PRO is null ) then mu.ESTA_MUN 
     else 
        mu1.ESTA_MUN 
     end as ESTA_MUN, 
     case 
        when ( nf.PROP_PRO is null ) then mu.DESC_MUN 
     else 
        mu1.DESC_MUN 
     end as DESC_MUN , 
     NF.CCFO_CFO, 
     CFO.DIMP_CFO as DESC_CFO, 
     NF.NOTA_NOT, 
     NF.SERI_NOT, 
     NF.DEMI_NOT, 
     NF.COND_CON, 
     NF.OBSE_NOT, 
     NF.COD1_PES,
     PES.NOME_PES,
     NF.DATA_VLR, 
     INF.CODI_PSV, 
     PD.DESC_PSV, 
     PD.UNID_PSV, 
     GP.DESC_GPR,
     SBG.DESC_SBG,
     FT.FUNC_TOP, 
     PR.CEST_PRO,  
     case 
        when ( FT.FUNC_TOP = 'A' ) then INF.QTDE_INO 
     else 
        INF.QTDE_INO * (-1) 
     end as QTDE_INO , 
     INF.QDEV_INO,
     INF.VLIQ_INO, 
     (SELECT CUST_MED FROM TABLE (CUSTO_MEDIO(1, INF.CODI_PSV,NF.DEMI_NOT))) AS CUSTO,
     CO.DESC_CON, 
     NF.NPRE_NOT, 
     INF.ITEM_INO, 
    T.TIPO_TOP,  
    CFO.COMP_CFO, 
    PR.PLIQ_PRO, PR.PBRU_PRO, NF.PEDI_PED, NF.SERI_PED, NF.CODI_TOP, T.PNFO_TOP, PE.DEMI_PED, 
    INF.DSOF_INO, INF.VDOF_INO, PE.VCTO_PED, 
    CASE 
    WHEN coalesce(NF.TOTA_NOT,0) > 0 THEN 
    ( NF.fret_not  * ((INF.VLIQ_INO * INF.QTDE_INO)  
        / NF.TOTA_NOT 
     )) 
   ELSE 0 
   END as  FRETPORPROD, 
   
   CASE 
   WHEN coalesce(NF.TOTA_NOT,0) > 0 THEN 
     (INF.VLIQ_INO * (INF.QTDE_INO - INF.QDEV_INO))  
       - (coalesce(NF.FRET_NOT,0)     
          * (  (INF.VLIQ_INO * INF.QTDE_INO) 
               / NF.TOTA_NOT 
     ))  
   ELSE 0 
   END as VALOR_TOTAL 
 
from INOTA INF  
inner join NOTA NF on (NF.NPRE_NOT = INF.NPRE_NOT) 
inner join TRANSAC TR on (TR.CODI_TRA = NF.CODI_TRA)  
inner join PRODSERV PD on (PD.CODI_PSV = INF.CODI_PSV) 
inner join FUNCAOTOPER FT on (FT.CODI_TOP = NF.CODI_TOP and FT.CODI_PTO = 102)
left outer join TIPOOPER T on  (NF.CODI_TOP = T.CODI_TOP) 
left join PEDIDO PE on (PE.CODI_EMP = INF.EMPR_PED) and (PE.PEDI_PED = INF.PEDI_PED) and (PE.SERI_PED = INF.SERI_PED) 
left join CONDICAO CO on (CO.COND_CON = NF.COND_CON) 
left join CLIENTE CL on (CL.CODI_TRA = TR.CODI_TRA) 
left join PRODUTO PR on (PR.CODI_PSV = PD.CODI_PSV) 
left join EMBALA EM on (EM.CODI_EMB = PR.CODI_EMB) 
left join FORNEC FAB on (PR.CODI_TRA = FAB.CODI_TRA) 
left join CFO on ( cfo.CCFO_CFO = nf.CCFO_CFO ) 
left join PROPRIED pro on ( nf.PROP_PRO = pro.PROP_PRO ) 
left join MUNICIPIO MU on (MU.CODI_MUN = TR.CODI_MUN) 
left join MUNICIPIO MU1 on (MU1.CODI_MUN = pro.CODI_MUN) 
left join GRUPO GP on (GP.CODI_GPR = PD.CODI_GPR)
left join SUBGRUPO SBG on (SBG.CODI_SBG = PD.CODI_SBG)
left join PESSOAL PES on (PES.CODI_PES = NF.COD1_PES)
left outer join VENDEDORCLI VD on (NF.CODI_TRA = VD.CODI_TRA and NF.CODI_EMP = VD.CODI_EMP)  
left join VENDEDOR VDD on (VDD.CODI_PES = NF.COD1_PES)  
where (NF.SITU_NOT = '5')   
and (NF.DEMI_NOT between to_date('01/01/2018') and to_date('08/10/2018')) and (NF.CODI_EMP in ('1')) and (INF.QDEV_INO <> INF.QTDE_INO);
