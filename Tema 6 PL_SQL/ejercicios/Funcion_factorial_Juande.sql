--Realizar una función llamada factorial que dado un número devuelva el factorial del dicho número.
--Hay que hacerlo de dos maneras una recursiva(es que se llama así misma hasta que calcule 
--el factorial de 1 que devuelve 1) y otra con loop.

--CON BUCLE loop
create or replace function factorial(num int) return int is
    
    v_factorial int:=1;
    i int:=0;
    e_nonegativo exception;
    
    begin
    
        if(num<0) then
            raise e_nonegativo;
        end if;
    
       loop
            i:=i+1;
            v_factorial:=v_factorial*i;  
        exit when i = num;
        end loop;

        return v_factorial;
        
        exception
            when e_nonegativo then
                return -1;
    end;
    
--CON BUCLE for
create or replace function factorial(num int) return int is
    
    v_factorial int:=1;
    
    begin
    
        for i in 1 .. num loop
            v_factorial:=v_factorial*i;
        end loop;
        return v_factorial;
        
    end;

---------------------------------------------------------------
set serveroutput on;
declare
    numero int:=&introduce_numero;
    
begin
    if factorial(num)=-1 then
        dbms_output.put_line('No existe el factorial de un valor negativo');
    end if;
    
    dbms_output.put_line(factorial(numero));
end;
---------------------------------------------------------------
---------------------------------------------------------------


--CON RECURSIVIDAD
/*factorial(5)=5*factorial(4)
factorial(4)=4*factorial(3)
factorial(3)=3*factorial(2)
factorial(2)=2*factorial(1)
factorial(1)=1;
se va apsando con valor hacia abajo hasta que encuentra el uno*/
create or replace function factorialRecursivo(num int) return int is
    
begin
    if(num=0) then
        return 1;
    else
        return num*factorial(num-1);
    end if;        
end;

-----------------------------------------------------------------
set serveroutput on;
declare
    numero int:=&introduce_numero;
    
begin
    dbms_output.put_line(factorialRecursivo(numero));
end;

