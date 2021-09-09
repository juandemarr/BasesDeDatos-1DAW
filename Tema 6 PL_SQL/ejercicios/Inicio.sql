set SERVEROUTPUT on;

DECLARE
A VARCHAR(10) :='';
BEGIN
SELECT TO_CHAR(SYSDATE) INTO A FROM DUAL;
DBMS_OUTPUT.PUT_LINE('LA FECHA ACTUAL ES : ' || A || 'las dos tuberias sirven para concatenar aqui');

EXCEPTION
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('HOLA');
END;

--Ej1 Declarar dos variables a y b que contengan 5 y 6.
-- Declarar una variable suma, sumarlas y que aparezcan en pantalla
declare
a int:=5;
b int:=6;
suma int:=0;

begin
    suma:=a+b;
    DBMS_OUTPUT.PUT_LINE('La suma es: '||suma);
end;



set serveroutput on;
declare
    interes number(5,3):=16.6;
    descripcion varchar2(50):='inicial';
    fecha_max date:='11/03/2020';
    contabilizado boolean:=true;
    PI constant real:=3.14159;
    codigoWarehouse boxes.warehouse%type;
begin
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE interes ES TIPO NUMBER Y CONTIENE: '||interes);
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE descripcion ES TIPO VARCHAR2(50) Y CONTIENE: '||descripcion);
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE fecha_max ES TIPO NUMBER Y CONTIENE: '||fecha_max);
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE contabilizado ES TIPO boolean Y CONTIENE: '|| case when contabilizado=true
                                                                                    then 'true' else 'false' end);
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE pi ES TIPO constante Y CONTIENE: '||PI);
    DBMS_OUTPUT.PUT_LINE('LA VARIABLE codigoWarehouse ES TIPO Y CONTIENE: '||codigoWarehouse);
end;
    

--if
-- para que pida introducir el valor por teclado, lo de al lado es el mensaje que se muestra
set serveroutput on;
declare
    a int:=&introduce_un_valor;
    b int:=&introduce_un_valor;
begin
    if (a>b) then
        dbms_output.put_line('La variale '||a||' es mayor que la variable '||b);
    elsif(a=b) then
        dbms_output.put_line('La variale '||a||' es igual que la variable '||b);
    else
        dbms_output.put_line('La variale '||a||' es menor que la variable '||b);
    end if;
end;

--------------------------------------------------------------------------------
-- realizar bloque de codigo que reciba el numero de identidad y devuelva la letra correspondiente

set serveroutput on;
declare
    DNI int:=&introduce_un_dni;
    resto int;
begin
    resto:=mod(DNI,23);
    
case resto
when 0 then dbms_output.put_line('Tu letras es la T');
when 1 then dbms_output.put_line('Tu letras es la R');
when 2 then dbms_output.put_line('Tu letras es la W');
when 3 then dbms_output.put_line('Tu letras es la A');
when 4 then dbms_output.put_line('Tu letras es la G');
when 5 then dbms_output.put_line('Tu letras es la M');
when 6 then dbms_output.put_line('Tu letras es la Y');
when 7 then dbms_output.put_line('Tu letras es la F');
when 8 then dbms_output.put_line('Tu letras es la P');
when 9 then dbms_output.put_line('Tu letras es la D');
when 10 then dbms_output.put_line('Tu letras es la X');
when 11 then dbms_output.put_line('Tu letras es la B');
when 12 then dbms_output.put_line('Tu letras es la N');
when 13 then dbms_output.put_line('Tu letras es la J');
when 14 then dbms_output.put_line('Tu letras es la Z');
when 15 then dbms_output.put_line('Tu letras es la S');
when 16 then dbms_output.put_line('Tu letras es la Q');
when 17 then dbms_output.put_line('Tu letras es la V');
when 18 then dbms_output.put_line('Tu letras es la H');
when 19 then dbms_output.put_line('Tu letras es la L');
when 20 then dbms_output.put_line('Tu letras es la C');
when 21 then dbms_output.put_line('Tu letras es la K');

else dbms_output.put_line('Tu letras es la E');
end case;
end;

-- otra forma, en el case no se pone nada y en el when se escribe la condicion
set serveroutput on;
declare
    DNI int:=&introduce_un_dni;
    resto int;
begin
    resto:=mod(DNI,23);
    
case 
when resto=0 then dbms_output.put_line('Tu letras es la T');
when resto=1 then dbms_output.put_line('Tu letras es la R');
when resto=2 then dbms_output.put_line('Tu letras es la W');
when resto=3 then dbms_output.put_line('Tu letras es la A');
when resto=4 then dbms_output.put_line('Tu letras es la G');
when resto=5 then dbms_output.put_line('Tu letras es la M');
when resto=6 then dbms_output.put_line('Tu letras es la Y');
when resto=7 then dbms_output.put_line('Tu letras es la F');
when resto=8 then dbms_output.put_line('Tu letras es la P');
when resto=9 then dbms_output.put_line('Tu letras es la D');
when resto=10 then dbms_output.put_line('Tu letras es la X');
when resto=11 then dbms_output.put_line('Tu letras es la B');
when resto=12 then dbms_output.put_line('Tu letras es la N');
when resto=13 then dbms_output.put_line('Tu letras es la J');
when resto=14 then dbms_output.put_line('Tu letras es la Z');
when resto=15 then dbms_output.put_line('Tu letras es la S');
when resto=16 then dbms_output.put_line('Tu letras es la Q');
when resto=17 then dbms_output.put_line('Tu letras es la V');
when resto=18 then dbms_output.put_line('Tu letras es la H');
when resto=19 then dbms_output.put_line('Tu letras es la L');
when resto=20 then dbms_output.put_line('Tu letras es la C');
when resto=21 then dbms_output.put_line('Tu letras es la K');

else dbms_output.put_line('Tu letras es la E');
end case;
end;


-- bucle que muestre los primeros 100 numeros impares
set serveroutput on;
declare
    cont int:=1;
begin
    loop
        if(mod(cont,2)!=0) then
            dbms_output.put_line(cont||' es impar');
        
        end if;
        cont:=cont+1;
    exit when cont>=100;
    end loop;
end;

----------------------------------------------
set serveroutput on;
declare 
    nombre varchar2(20):='hola';
begin
    dbms_output.put_line(nombre);
end;