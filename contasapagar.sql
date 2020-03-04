SELECT
    CAB.CODI_EMP AS COD_EMPRESA,
    
    CAB.CODI_TRA AS COD_FORNECEDOR,
    TRANSAC.RAZA_TRA AS RAZAO_FORNECEDOR,
    
    CAB.CODI_TDO,
    TIPDOC.DESC_TDO AS TIPO_DOCUMENTO,
    
    
    CAB.DOCU_CPG AS DOCUMENTO,
    CAB.DMOV_CPG AS DATA_DOCUMENTO,
    
    CAB.COND_CON AS COD_CONDICAO,
    CONDICAO.DESC_CON AS CONDICAO,
    CONDICAO.PRAZ_CON AS CONDICAO_DIAS_INTERVALO,
    
    cast (CAB.TOTA_CPG as decimal(18,4)) AS TOTAL_DOCUMENTO,
    CAB.TDRL_CPG,
    
    PAG.CODI_TCO AS COD_TIPO_COBRANCA,
    TIPCOB.DESC_TCO AS TIPO_COBRANCA,
    
    PAG.CODI_POR AS COD_PORTADOR,
    PORTADOR.DESC_POR AS PORTADOR,
    
    PAG.DVEN_PAG AS VENCIMENTO_PARCELA,
    PAG.NPAR_PAG AS NUMERO_PARCELA,
    cast (PAG.VLOR_PAG as decimal(18,4)) AS VALOR_PARCELA,
    cast ((SELECT VALOR FROM TABLE (VALOR_ABERTO_PAGAR(CPG.CTRL_PAG))) as decimal(18,4)) AS VALOR_ABERTO_PARCELA,
    
    CPG.DPAG_CPB AS DATA_PAGAMENTO_PARCELA,
    cast (CPG.VLOR_CPB as decimal(18,4)) AS VALOR_PAGO,
    cast (CPG.MULT_CPB as decimal(18,4)) AS MULTA,
    cast (CPG.JURO_CPB as decimal(18,4)) AS JUROS,
    cast (CPG.DESC_CPB as decimal(18,4)) AS DESCONTOS,
    cast (CPG.ACRE_CPB as decimal(18,4)) AS ACRESCIMOS,
    CPG.HIST_CPB AS HISTORICO_BAIXA,
    
    CPG.CODI_TPG AS COD_TIPO_PAGAMENTO,
    TIPOPAG.DESC_TPG AS TIPO_PAGAMENTO,
    
    CPG.CTRL_LAN AS COD_LANCAMENTO
    
FROM CABPAGAR CAB
    INNER JOIN PAGAR PAG ON(PAG.CTRL_CPG = CAB.CTRL_CPG)
    JOIN CPGBAIXA CPG ON (PAG.CTRL_PAG = CPG.CTRL_PAG)
    
    JOIN TIPCOB ON (TIPCOB.CODI_TCO = PAG.CODI_TCO)
    JOIN PORTADOR ON (PORTADOR.CODI_POR = PAG.CODI_POR)
    JOIN TIPOPAG ON (TIPOPAG.CODI_TPG = CPG.CODI_TPG)
    JOIN CONDICAO ON (CONDICAO.COND_CON = CAB.COND_CON)
    JOIN TIPDOC ON (TIPDOC.CODI_TDO = CAB.CODI_TDO)
    JOIN TRANSAC ON (TRANSAC.CODI_TRA = CAB.CODI_TRA)

WHERE 
    CAB.DMOV_CPG BETWEEN TO_DATE('01/10/2018') AND TO_DATE('31/10/2018') AND
    PAG.DVEN_PAG BETWEEN TO_DATE('01/01/1900') AND TO_DATE('31/12/2999') AND
    CPG.DPAG_CPB BETWEEN TO_DATE('01/01/1900') AND TO_DATE('31/12/2999');