WITH PRODUTOIND AS 
    (SELECT CODI_TRA
    FROM transac
    WHERE LOWER(raza_tra) LIKE '%fmc%'
            OR lower(fant_tra) LIKE '%fmc%'
    UNION
    SELECT CODI_TRA
    FROM transac
    WHERE LOWER(raza_tra) LIKE '%FMC%'
            OR lower(fant_tra) LIKE '%FMC%'
    UNION
    SELECT CODI_TRA
    FROM transac
    WHERE LOWER(raza_tra) LIKE '%dupont%'
            OR lower(fant_tra) LIKE '%dupont%'
    UNION
    SELECT CODI_TRA
    FROM transac
    WHERE LOWER(raza_tra) LIKE '%du pont%'
            OR lower(fant_tra) LIKE '%du pont%' )
SELECT to_char(n.demi_not,
         'MM-YYYY') AS periodo, inf.codi_psv AS codigo_sistema, p.desc_psv AS descricao, -- p.unid_psv, sum( pd.qte1_pro * inf.qtde_ino ) AS volume_total, sum( inf.vlor_ino * inf.qtde_ino) AS valor_total
FROM nota n
LEFT JOIN inota inf
    ON (n.npre_not = inf.npre_not)
LEFT JOIN prodserv p
    ON (inf.codi_psv = p.codi_psv)
LEFT JOIN produto pd
    ON (inf.codi_psv = pd.codi_psv)
LEFT JOIN funcaotoper ft
    ON (n.codi_top = ft.codi_top)
WHERE ft.codi_pto = 102
        AND pd.codi_tra IN 
    (SELECT CODI_TRA
    FROM PRODUTOIND)
        AND n.demi_not
    BETWEEN to_date('01/01/2019')
        AND to_date('07/10/2019')
GROUP BY  to_char(n.demi_not, 'MM-YYYY'), inf.codi_psv, p.desc_psv; 