SELECT ESTOQUE AS SALDO 
FROM TABLE(SALDO_INICIAL(CODI_EMPRESA,CRTL_SALDO,CODI_PRODUTO,DATA, 1))


/// LEITURA DAS MOVIMENTACOES COM CUPONS

SELECT CUP.DEMI_CUP, CUP.CODI_EMP, CUP.CUPO_CUP,'CF' AS SERI_CUP, ICUP.CODI_PSV, ICUP.QTDE_ICU, ICUP.VLIQ_ICU, CUP.CODI_TRA, PROD.UNID_PSV
FROM CUPOM CUP
INNER JOIN ICUPOM ICUP ON (CUP.NVEN_CUP = ICUP.NVEN_CUP)
INNER JOIN PRODSERV PROD ON (ICUP.CODI_PSV = PROD.CODI_PSV)
WHERE (CUP.DEMI_CUP BETWEEN '01/01/2017' AND '31/01/2017' AND CUP.CODI_EMP=1 AND CUP.SITU_CUP='E')

/// LEITURA DAS MOVIMENTACOES COM NOTAS FISCAIS EMITIDAS
SELECT N.DEMI_NOT, N.CODI_EMP, N.NOTA_NOT, N.SERI_NOT, INF.CODI_PSV, INF.QTDE_INO, INF.VLIQ_INO, N.CODI_TRA,PROD.UNID_PSV
FROM NOTA N
INNER JOIN INOTA INF ON (N.NPRE_NOT = INF.NPRE_NOT)
INNER JOIN PRODSERV PROD ON (INF.CODI_PSV = PROD.CODI_PSV)
WHERE(N.DEMI_NOT BETWEEN '01/01/2017' AND '31/01/2017' AND N.CODI_EMP = 1 AND N.SITU_NFE=4)

//LEITURA DAS MOVIMENTACOES COM NOTAS FISCAIS DE ENTRADA
SELECT ENT.DEMI_NFE, ENT.CODI_EMP, ENT.NUME_NFE, ENT.SERI_NFE, IENT.CODI_PSV, IENT.QUAN_INF, IENT.VLIQ_INF, ENT.CODI_TRA, PROD.UNID_PSV
FROM NFENTRA ENT
INNER JOIN INFENTRA IENT ON (ENT.NUME_NFE = IENT.NUME_NFE)  
INNER JOIN PRODSERV PROD ON (IENT.CODI_PSV = PROD.CODI_PSV)
WHERE(ENT.DEMI_NFE BETWEEN '01/01/2017' AND '31/01/2017' AND ENT.CODI_EMP = 1)