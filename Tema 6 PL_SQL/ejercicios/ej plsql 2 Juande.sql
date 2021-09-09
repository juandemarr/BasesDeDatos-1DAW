-- 1.- Que pida un número y diga si es primo o no.
set serveroutput on;
declare
    a int:=&te_pido_numero;
    contador int:=0;
begin
    for i in 1 .. a loop
        if mod(a,i)=0 then
            contador:=contador+1;
        end if;
    end loop;
    if contador<=2 then
        dbms_output.put_line('el número '||a||' es primo');
    else
        dbms_output.put_line('el número '||a||' no es primo');
    end if;
end;

-- 2.- Que muestre los números del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 loop
        dbms_output.put_line(i);
    end loop;
end;

-- 3.- Que muestre los números del 100 al 1.
set serveroutput on;

begin
    for i in reverse 1 .. 100 loop
        dbms_output.put_line(i);
    end loop;
end;

-- 4.- Que muestre los números pares que haya del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 loop
    
        if mod(i,2)=0 then
            dbms_output.put_line(i||' es par');
        end if;
        
    end loop;
end;

-- 5.- Que muestre los números impares que haya del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 loop
    
        if mod(i,2)!=0 then
            dbms_output.put_line(i||' es impar');
        end if;
        
    end loop;
end;

-- 6.- Que imprima la suma de todos los números que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        
        total:=total+i;
        
    end loop;
    dbms_output.put_line(total);
end;

-- 7.- Que imprima la suma de todos los números pares que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)=0 then
            total:=total+i;
        end if;
    end loop;
    dbms_output.put_line(total);
end;

-- 8.- Que imprima la suma de todos los números impares que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)!=0 then
            total:=total+i;
        end if;
    end loop;
    dbms_output.put_line(total);
end;

-- 9.- Que imprima la suma de todos los números pares que van del 1 al 100 y diga cuántos hay.
set serveroutput on;
declare
    total int:=0;
    contador int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)=0 then
            total:=total+i;
            contador:=contador+1;
        end if;
    end loop;
    dbms_output.put_line(total);
    dbms_output.put_line('Hay '||contador||' pares');
end;

-- 10.- Que imprima la suma de todos los números impares que van del 1 al 100 y diga cuántos hay.
set serveroutput on;
declare
    total int:=0;
    contador int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)!=0 then
            total:=total+i;
            contador:=contador+1;
        end if;
    end loop;
    dbms_output.put_line(total);
    dbms_output.put_line('Hay '||contador||' impares');
end;

-- 11.- Que pida dos números y muestre todos los números que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
        for i in a .. b loop
            DBMS_OUTPUT.PUT_LINE (i);
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            DBMS_OUTPUT.PUT_LINE (i);
        end loop;
    end if;
    
end;

-- 12.- Que pida dos números y muestre todos los números pares que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
    
        for i in a .. b loop
            if mod(i,2)=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            if mod(i,2)=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    end if;
    
end;

-- 13.- Que pida dos números y muestre todos los números impares que van desde el primero
-- al segundo. Se debe controlar que los valores son correctos
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
    
        for i in a .. b loop
            if mod(i,2)!=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            if mod(i,2)!=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    end if;
    
end;

-- 14.- Que pida dos números y sume todos los números que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    total int:=0;
    
begin

    if a<=b then
        for i in a .. b loop
            total:=total+i;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            total:=total+i;
        end loop;
    end if;
    dbms_output.put_line('la suma es: '||total);
end;

-- 15.- Que pida un número y muestre en pantalla el mismo número de asteriscos
set serveroutput on;
declare
    a int:=&escriba_un_número;
begin

    if a>=0 then
        for i in 1 .. a loop
            dbms_output.put_line('*');
        end loop;
        
    else
        dbms_output.put_line('escriba un número positivo');
    end if;
end;

-- 16.- Que calcule la media de X números, se dejarán de solicitar números hasta que se
-- introduzca el cero.
set serveroutput on;
declare
    media number;
    valor int;
begin
    loop
        valor:=&introduce_un_numero;
    exit when valor=0;
    end loop;
end;--Ni idea de cómo hacerlo o plantearlo. NO SE PUEDE EN PL/SQL

-- 17.- Que calcule la suma de los cuadrados de los 100 primeros números.
set serveroutput on;
declare
    cuadrado int;
    total int:=0;
begin
    for i in 1 .. 100 loop
        
        cuadrado:=i**2;
        total:=total+cuadrado;
        cuadrado:=0;
    end loop;
    dbms_output.put_line(total);
end;

/* Ni caso, me equivoqué y ya lo dejé por si luego me servía
primos del 1 al 100
set serveroutput on;
declare
    contador int:=0;
begin
    for i in 1 .. 100 loop
        
        for j in 1 .. i loop
            
            if mod(i,j)=0 then
                contador:=contador+1;
            end if;
            
        end loop;
        
        if contador<=2 then 
            dbms_output.put_line(i||' es primo');
        else
            dbms_output.put_line(i||' no es primo');
            
        end if;
        contador:=0;
    end loop;
end;
*/

