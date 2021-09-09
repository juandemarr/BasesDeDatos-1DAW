--Realizar un trigger compuesto que evite que un mgr lleve a más de 5 empleados
create or replace trigger tr_maximo5pormgr
for update or insert on emp
compound trigger

    maximo int;
    newManager emp.mgr%type:= :new.mgr;
    
   after each row is
    begin
       dbms_output.put_line('EXITO');
    end after each row;
    
    after statement is
    begin
        select count(ename) into maximo from emp where mgr=newManager;
        if maximo > 5 then
            raise_application_error(-20600, 'El manager '||newManager||' no puede tener a más de 5 empleados');
        end if;
    end after statement;
end;




select * from emp;
select count(ename) from emp where mgr=7698;
insert into emp(empno,ename,mgr) values (1111,'HOLA',7698);


