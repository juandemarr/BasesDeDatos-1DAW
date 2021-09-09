EXCEPCIONES

Edmodo
Carpetas
Unidad 6 Unidad
En la página 11 del pdf
Es cuando en error durante la ejecución de un programa

las excepciones en ORACLE HAY DE DOS TIPOS PRINCIPALES:

1.- LAS PREDEFINIDAS POR EL PROPIO SISTEMA
    NO_DATA_FOUND
    TOO_MANY_ROWS
    INVALID_CURSOR
    ZERO_DIVIDE
    ...
2.- LAS EXCEPCIONES DEFINIDAS POR EL PROPIO USUARIO.

DECLARE

miexcepcion EXCEPTION;

BEGIN



EXCEPTION

    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No hemos encontrado el cliente');
    WHEN miexcepcion THEN
        dbms_output.put_line('No se ha cumplido alguna de las condiciones');
        
        
-- curso implícito
-- a partir del código del departamento nos  va a devolver el nombre de ese departamento;

declare
    v_codigo departments.code%type:=&introducecodigo;
    v_name departments.name%type;
    e_nonegativos EXCEPTION;
begin
    if v_codigo<0 then
        raise e_nonegativos;
    end if;
    select name into v_name from departments where code=v_codigo;
    dbms_output.put_line('El nombre del departamento '||v_codigo||' es '||v_name);
EXCEPTION
    WHEN no_data_found then
        dbms_output.put_line('El codigo del departamento no existe');
    WHEN e_nonegativos THEN
        dbms_output.put_line('Los códigos del departamento no pueden ser negativos');
end;






END;

select * from employees;
-- 123234877
-- 326587417

select * from departments;

-- 14
-- 37

describe departments;
-- Cursor que dado un código de departamento nos diga el nombre

CREATE OR REPLACE procedure empleadosdeundepartamento(codigo in departments.code%type)
IS
cursor c_empleado is SELECT NAME,LASTNAME FROM EMPLOYEES WHERE department=codigo;
v_nombre employees.name%type;
v_apellidos employees.lastname%type;
e_noempleados EXCEPTION;
e_nodepartamento EXCEPTION;
v_existe int;

BEGIN
    select count(*) into v_existe from departments where code=codigo;
    if v_existe=0 then 
        raise e_nodepartamento;
    end if;
    OPEN c_empleado;
    LOOP
        FETCH c_empleado INTO v_nombre,v_apellidos;
        exit when c_empleado%notfound;
        dbms_output.put_line(v_nombre||' '||v_apellidos);
    
    END LOOP;
    if c_empleado%rowcount=0 then 
        raise e_noempleados;
    end if;   
    CLOSE c_empleado;
EXCEPTION
    WHEN e_noempleados then 
        dbms_output.put_line('El departamento no tiene empleados asignados');
    WHEN e_nodepartamento then 
        dbms_output.put_line('El departamento no existe ');
end;

set serveroutput on;
declare
    v_codigo departments.code%type:=&introducecodigo;
begin
    
    empleadosdeundepartamento(v_codigo);
end;


select * from departments;

--Realizar una función llamada factorial que dado un número devuelva
-- el factorial del dicho número.
--Hay que hacerlo de dos maneras una recursiva
-- (es que se llama así misma hasta que calcule 
--el factorial de 1 que devuelve 1) y otra con loop.
--CON BUCLE loop

5!=5*4*3*2*1=120

-- loop 
-- recursiva es aquella que se llama así misma

factorial(5)=5*factorial(4)

factorial(4)=4*factorial(3)

factorial(3)=3*factorial(2)

factorial(2)=2*factorial(1)

factorial(1)=1;


create or replace function factorial(num int) return int is
    
   
    v_factorial int:=1;
    i int:=0;
    e_nonegativo exception;
    begin
     if num<0 then
        raise e_nonegativo;
    end if;
       loop
            i:=i+1;
            v_factorial:=v_factorial*i;  
        exit when i = num;
        end loop;

        return v_factorial;
    EXCEPTION
        WHEN e_nonegativo then
            return -1;
    end;
    
--CON BUCLE for
create or replace function factorial_recursivo(num int) return int is
    
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
    dbms_output.put_line(factorial(numero));
end;
---------------------------------------------------------------
---------------------------------------------------------------


--CON RECURSIVIDAD
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


-- UNA FUNCIÓN QUE DEVUELVA EL NÚMERO DE APELLIDOS REPETIDOS QUE 
-- TIENEN LOS EMPLEADOS DADO UN SSN.

select * from employees;


CREATE OR REPLACE FUNCTION apellidosrepetidos(v_ssn employees.ssn%type)
RETURN STRING
IS
v_apellido employees.lastname%type;
BEGIN
    SELECT lastname INTO v_apellido from employees WHERE ssn=v_ssn;
    return v_apellido;
end;

CREATE OR REPLACE FUNCTION numeroapellidos(v_apellidos employees.lastname%type)
RETURN INT
IS
v_numero int;
BEGIN
    Select count(*) INTO v_numero FROM employees WHERE lastname=v_apellidos;
    return v_numero;
end;

declare
    v_ssn employees.ssn%type:=&introducessn;
    v_numero int;
BEGIN
    v_numero:=numeroapellidos(apellidosrepetidos(v_ssn));
    DBMS_OUTPUT.PUT_LINE('El número de apellidos repetidos es '||v_numero);
END;

SELECT * FROM EMPLOYEES;

222364883
845657245


select * from clientes;
-- 1.- Realizar un bloque anónimo que dado el código de un cliente 
--  Nos muestre su nombre.
Set Serveroutput On;
Declare
  codigo clientes.codigocliente%type := &Introduce_codigo;
  nombre clientes.nombrecliente%type;
Begin
  select nombrecliente into nombre from clientes where codigocliente=codigo;
   Dbms_Output.Put_Line('El nombre es  ' || nombre);
    exception when no_data_found then
    Dbms_Output.Put_Line('El codigo no existe');
end;

-- 2.- Mostrar el precio de venta y la gama de un producto una vez dado su identificador
Set Serveroutput On;
Declare
  identificador productos.codigoproducto%type := '&Introduce_identificador';
  gama productos.gama%type;
  precioVenta productos.precioventa%type;
Begin
    select productos.gama,productos.precioventa into gama,precioVenta from productos where codigoproducto=identificador;
    Dbms_Output.Put_Line('Precio Venta: ' || precioVenta || ' Gama: ' || gama);
    exception when no_data_found then
    Dbms_Output.Put_Line('El codigo no existe');
end;

select * from productos;