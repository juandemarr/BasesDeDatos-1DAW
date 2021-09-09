--Realizar un trigguer para que no se pudiera realizar 
--ningun cambio sobre el presidente
select * from emp;


create or replace trigger no_presidente
before delete or insert or update on emp
for each row

begin

  if :new.job='PRESIDENT' or :old.job='PRESIDENT'
    then raise_application_error(-20500,'No se puede modificar ningun presidente');
  end if;
  --da igual el numero que poner de error 
end;

set serveroutput on;
update emp set sal=sal+sal*0.1;

