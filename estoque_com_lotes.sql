SELECT 
    PRODSERV.CODI_PSV, 
    PRODSERV.DESC_PSV, 
    PRODSERV.SITU_PSV, 
    GRUPO.DESC_GPR, 
    SUBGRUPO.DESC_SBG,
    coalesce (cast ((SELECT ESTOQUE FROM TABLE (SALDO_INICIAL(1, 1, PRODSERV.CODI_PSV, TO_DATE('08/06/19', 'DD/MM/YY'), 1))) as decimal(18,4)), 0) AS ESTOQUE_FISCAL,
    coalesce (cast ((SELECT SUM(SALD_CTR) FROM TABLE (SALDO_INICIAL_TIPOEST(1, 2, PRODSERV.CODI_PSV, TO_DATE('08/06/19', 'DD/MM/YY'), 'S' , null, null))) as decimal(18,4)), 0) AS ESTOQUE_PERTENCENTE,
    L.LOTE_LOT AS LOTE,
    L.DTFA_LOT AS FABRICACAO_LOTE,
    L.VALG_LOT AS VALIDADE_LOTE,
    (SELECT QTDE FROM TABLE(SALDO_LOTE(1,PRODSERV.CODI_PSV,L.LOTE_LOT,TO_DATE('08/06/19'),1,0))) AS QTDE_LOTE
FROM PRODUTO PRODUTO
      INNER JOIN PRODSERV PRODSERV ON (PRODSERV.CODI_PSV = PRODUTO.CODI_PSV)
      INNER JOIN TRANSAC TRANSAC ON (TRANSAC.CODI_TRA = PRODUTO.CODI_TRA)
      INNER JOIN GRUPO GRUPO ON (GRUPO.CODI_GPR = PRODSERV.CODI_GPR)
      INNER JOIN SUBGRUPO SUBGRUPO ON (SUBGRUPO.CODI_SBG = PRODSERV.CODI_SBG AND SUBGRUPO.CODI_GPR = PRODSERV.CODI_GPR)
      LEFT JOIN LOTE L ON (PRODSERV.CODI_PSV = L.CODI_PSV)
ORDER BY PRODSERV.CODI_PSV;