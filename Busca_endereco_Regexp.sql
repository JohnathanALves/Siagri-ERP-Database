SELECT 
    CNPJ,
    NOME,
    ENDE
--COUNT(*)
FROM 
(   select
        C.cnpj_cli AS CNPJ,
        C.nome_cli AS NOME,
        UPPER(C.ENCO_CLI || ' # ' || C.NUME_CLI || ' # ' || C.BAIR_CLI || ' # ' || C.COMP_CLI) AS ENDE
    FROM BASF_CLIENT C
)
WHERE 
REGEXP_LIKE(ENDE, '+(N)+(8)', 'i')  OR
REGEXP_LIKE(ENDE, '+(N)+(9)', 'i')  OR
REGEXP_LIKE(ENDE, '+(N)+(10)', 'i') OR
REGEXP_LIKE(ENDE, '+(N)+(11)', 'i') OR
REGEXP_LIKE(ENDE, '+(BEBEDOURO)', 'i') OR
REGEXP_LIKE(ENDE, '+(NOVA)+(DESCOBERTA)', 'i');