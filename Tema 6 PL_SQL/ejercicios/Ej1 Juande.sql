--1.- Un bloque anónimo PL/SQL que reciba un número por teclado y diga si es par o impar.
set serveroutput on;

declare
numero real:=&introduce_un_valor;

begin
    if(numero mod(2)=0) then
        dbms_output.put_line('El numero '||numero||' es par.');
    else
        dbms_output.put_line('El numero '||numero||' es impar.');
    end if;
end;


--2.- Un bloque anónimo PL/SQL que dibuje en pantalla los primeros 200 números impares.
set serveroutput on;

declare
    cont int:=0;
    
begin
    loop
        if(mod(cont,2)!=0) then
            dbms_output.put_line(cont||' es impar');
        end if;
        cont:=cont+1;
    exit when cont>=200;
    end loop;
end;


--3.- Un bloque anónimo PL/SQL que dado los 8 dígitos del DNI devuelva los 8 dígitos+letra.
set serveroutput on;

declare
    DNI int:=&Introduce_DNI;
    letra char;
    
begin
    case DNI mod(23)
    when 0 then letra:='T';
    when 1 then letra:='R';
    when 2 then letra:='W';
    when 3 then letra:='A';
    when 4 then letra:='G';
    when 5 then letra:='M';
    when 6 then letra:='Y';
    when 7 then letra:='F';
    when 8 then letra:='P';
    when 9 then letra:='D';
    when 10 then letra:='X';
    when 11 then letra:='B';
    when 12 then letra:='N';
    when 13 then letra:='J';
    when 14 then letra:='Z';
    when 15 then letra:='S';
    when 16 then letra:='Q';
    when 17 then letra:='V';
    when 18 then letra:='H';
    when 19 then letra:='L';
    when 20 then letra:='C';
    when 21 then letra:='K';
    end case;
dbms_output.put_line(DNI||' '||letra);
end;
