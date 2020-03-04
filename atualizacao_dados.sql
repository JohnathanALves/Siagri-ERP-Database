SET SERVEROUTPUT ON
declare

cursor c_table is
select *
from dadoscfo
where codi_emp = 5;

v_data dadoscfo%rowtype;

begin
    open c_table;
    loop
    fetch c_table
    into v_data;
if c_table%NOTFOUND THEN
    EXIT;
END
IF;
--    DBMS_OUTPUT.PUT_LINE('atualizando linhas: ' || v_cliente.codi_tra);
    v_data.codi_emp := 10;
insert into dadoscfo values
v_data;
end loop;
close c_table;
end;