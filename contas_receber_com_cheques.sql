SELECT DISTINCT C.DATA_CBR, R.VENC_REC, R.VEN2_REC, R.VLOR_REC, 
          (select VALOR from  table( VALOR_ABERTO_RECEBER(R.CTRL_REC))) as VLAB_REC, 
          R.CTRL_CBR, C.NUME_CBR, R.CTRL_REC, TO_CHAR(R.NPAR_REC), T.RAZA_TRA, R.CODI_TCO,   R.CODI_POR,  
          R.SITU_REC,
          C.CODI_EMP, T.CGC_TRA, R.COD1_PES, P.NOME_PES, 
          C.SERI_CBR,    C.CODI_TRA,    R.DATA_VLR, 
          R.CODI_IND,  TD.DESC_TDO, 
          TD.TIPO_TDO, TD.CODI_TDO,  
          I.ABRE_IND, 
          R.TJUR_REC,   R.DINI_REC,  R.JATV_REC, R.JAPV_REC, 
          R.DANT_REC,  R.DPON_REC, BL.NUME_BOL, R.ACDU_REC, TC.DESC_TCO, R.VDOF_REC,
          N.NOTA_NOT,C.TDRL_CBR, N.COND_CON, CON.DESC_CON, CON.PRAZ_CON
FROM CABREC C 
        left join  RECEBER R  on (C.CTRL_CBR = R.CTRL_CBR) 
        left outer join CRCBAIXA CRC on (R.CTRL_REC = CRC.CTRL_REC)
        left outer join TRANSAC T    on (T.CODI_TRA = C.CODI_TRA) 
        left outer join TIPDOC TD     on (TD.CODI_TDO = C.CODI_TDO) 
        left outer join CLIENTE CL    on (CL.CODI_TRA = T.CODI_TRA) 
        left outer join INDEXADOR I on (I.CODI_IND = R.CODI_IND) 
        left outer join PESSOAL P on (P.CODI_PES = R.COD1_PES) 
        left outer join BOLETO BL on (R.CTRL_BOL = BL.CTRL_BOL) 
        left outer join PORTADOR POR on (POR.CODI_POR = R.CODI_POR) 
        left outer join TIPCOB TC on (TC.CODI_TCO = R.CODI_TCO) 
        left outer join NOTACRC NCR on (R.CTRL_CBR = NCR.CTRL_CBR)
        left outer join NOTA N on (C.NUME_CBR = N.NOTA_NOT)
        inner join CONDICAO CON on (N.COND_CON = CON.COND_CON)
WHERE (C.DATA_CBR between '01/01/1900' and '30/12/2999') and (R.VENC_REC between '01/01/2011' and '31/01/2018') and C.CODI_TDO in ('15','101','102','104','105','107','108','110','10000045') and (C.CODI_EMP in ('1','3','5','4')) and (R.SITU_REC <> 'C')

UNION ALL

SELECT CHREC.DATA_CHR, CHREC.VENC_CHR, NULL, NULL, CHREC.VLOR_CHR AS VLAB_REC, NULL, CHREC.NUME_CHR, NULL, CHREC.SERI_CHR, T.RAZA_TRA, CHREC.CODI_TCO, CHREC.CODI_POR, 
    CHREC.SITU_CHR, CHREC.CODI_EMP, T.CGC_TRA, NULL, NULL,NULL, CHREC.CODI_TRA, NULL, NULL, TD.DESC_TDO, NULL, CHREC.CODI_TDO, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TC.DESC_TCO, NULL, NULL, NULL, NULL, NULL, NULL
FROM CHEQUEREC CHREC
    left outer join TRANSAC T on (CHREC.CODI_TRA = T.CODI_TRA )
    left outer join TIPDOC TD     on (CHREC.CODI_TDO = TD.CODI_TDO)
    left outer join PORTADOR POR on (CHREC.CODI_POR = POR.CODI_POR)
    left outer join TIPCOB TC on (CHREC.CODI_TCO = TC.CODI_TCO)
WHERE (CHREC.DATA_CHR between to_date('01/01/1990') and to_date('30/12/2999')) AND (CHREC.VENC_CHR between to_date('01/01/2011') and to_date('31/01/2018')) AND CHREC.SITU_CHR = 'D' and TD.CODI_TDO in ('15','101','102','104','105','107','108','110','10000045') and (CHREC.CODI_EMP in ('1','3','5','4'));