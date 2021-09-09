Packages. 

Además de brindarnos múltiples elementos que nos permiten desarrollar 
una aplicación robusta, Oracle nos ofrece la posibilidad de programar 
en forma modular, clara y eficiente.

Esta estructura se denomina Package (Paquete) y su uso nos permite no 
sólo mejorar la calidad de diseño  de nuestras aplicaciones sino también
optimizar el desempeño de las mismas. 

Los Paquetes están divididos en 2 partes: especificación (obligatoria) 
y cuerpo (no obligatoria). La especificación o encabezado es la interfaz
entre el Paquete y las aplicaciones que loutilizan y es allí donde se  
declaran  los tipos, variables, constantes, excepciones, cursores, 
procedimientos y funciones que podrán ser invocadosdesde fuera del paquete. 

Ventajas del uso de Paquetes. 
1.- Permite modularizar el diseño de nuestra aplicación
2.- Otorga flexibilidad al momento de diseñar la aplicación.
3.- Permite ocultar los detalles de implementación 
4.- Agrega mayor funcionalidad a nuestro desarrollo 
5.- Introduce mejoras al rendimiento.
6.- Permite la “Sobrecarga de funciones” (Overloading). 




DECLARE
    num int:=&introduce;
    resultado int;
BEGIN
    resultado:=miscelanea.factorial(num);
    dbms_output.put_line('El factorial del número '||num||' es '||resultado);
END;


ESPECIFICACIÓN DEL PACKAGE

CREATE OR REPLACE PACKAGE  miscelanea2 IS
procedure dni_persona(v_dni in personas.dni%type);
function factorial(num int) RETURN INT;
--function existe_emp(v_codigo emp.empno%type) RETURN BOOLEAN;
END;

describe emp;



CUERPO DEL PACKAGE

CREATE OR REPLACE PACKAGE BODY miscelanea2 IS


PROCEDURE dni_persona(v_dni  personas.dni%type)
is
v_persona personas%rowtype;
cursor c_persona is select * from personas where dni=v_dni;
begin
    OPEN c_persona;
    loop
        fetch c_persona into v_persona;
        exit when c_persona%notfound;
        dbms_output.put_line(v_persona.nombre||' tiene '||v_persona.edad|| ' años');
      
    END LOOP;
      
    CLOSE c_persona;
end;

function factorial(num int) return int is
    
   
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
END;























select * from emp;

select sysdate from dual

select  CURRENT_TIMESTAMP from dual;





select TO_CHAR(SYSDATE, 'DY') from dual;
select TO_CHAR(SYSDATE, 'HH24') from dual;



UPDATE emp set sal=sal+sal*0.01;
delete from emp;



-- DELETE
--INSERT


-- Comprobar que no se realicen cambios en la tabla emp
-- fuera del horario laboral
-- TRIGGER DE ORDEN

CREATE OR REPLACE TRIGGER emp_permit_changes 
BEFORE DELETE OR INSERT OR UPDATE ON emp 
DECLARE 
BEGIN 
/* If today is a Saturday or Sunday, then return an error.*/ 

IF (TO_CHAR(SYSDATE, 'DY') = 'SAB' OR  TO_CHAR(SYSDATE, 'DY') = 'DOM') 
THEN raise_application_error( -20501, 'May not change employee table during the weekend'); 
END IF; 

/*If the current time is before 8:00AM or after 6:00PM, then return an error. */ 

IF (TO_CHAR(SYSDATE, 'HH24') < 8 OR TO_CHAR(SYSDATE, 'HH24') >= 18) 
THEN raise_application_error( -20502,'May only change employee table during working hours'); 
END IF; 
END;



DISPARADORES HAY DOS TIPOS PRINCIPALES
1.- DE ORDEN
    update,delete,insert se produce una acción independientemente
    si dicha setencia DML afecta a 1 o 1000 filas.

2.- DE FILA.
    update,delete,insert se produce una acción pero se comprueba que la fila
    en la que estamos cumple unas determinadas condiciones.
    

-- Actualizar el sueldo de los trabajadors y subirles un 10% el salario
-- pero al presidente de la compañía no se le sube el salario.

UPDATE emp set sal=sal+sal*0.01;

- TRIGGER emp_permit_changes y comprueba que estamos en un día laboral y horario laboral
- TRIGGER emp_no_president y comprueba que no podemos realizar cuando sea el presidente el implicado.




-- Creación de la tabla
CREATE table customers (
id NUMBER NOT NULL,
name VARCHAR2(20),
age NUMBER,
address VARCHAR2(20),
salary DECIMAL(6,2),
PRIMARY KEY (id)
);

-- Inserción de valores
INSERT INTO customers VALUES (1,'Ramesh',32,'Ahmedabad',2000.00);
INSERT INTO customers VALUES (2,'Khilan',25,'Delhi',1500.00);
INSERT INTO customers VALUES (3,'Kaushik',23,'Kota',2000.00);
INSERT INTO customers VALUES (4,'Chaitali',25,'Mumbai',6500.00);
INSERT INTO customers VALUES (5,'Hardik',27,'Bhopal',8500.00);
INSERT INTO customers VALUES (6,'Komal',22,'MP',4500.00);

SELECT * FROM customers;

-- Creación del trigger de FILA

CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE DELETE OR INSERT OR UPDATE ON customers
FOR EACH ROW
-- WHEN (NEW.id > 0)
DECLARE
  sal_diff NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('El empleado '||:NEW.name);
  IF UPDATING THEN
  sal_diff := :NEW.salary - :OLD.salary;
  DBMS_OUTPUT.PUT_LINE('El empleado '||:NEW.name);
  DBMS_OUTPUT.PUT_LINE('Old Salary: ' || :OLD.salary);
  DBMS_OUTPUT.PUT_LINE('New Salary: ' || :NEW.salary);
  DBMS_OUTPUT.PUT_LINE('Salary difference: ' || sal_diff);
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Old Salary: ' || :OLD.salary);
  END IF;
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('New Salary: ' || :NEW.salary);
END IF;
END;

-- Lanzar el trigger

set SERVEROUTPUT ON;
update customers set salary=salary+salary*0.01;

set serveroutput on;
INSERT INTO customers (id,name,age,address,salary) VALUES (8,'Kritti',22,'HP',7500.00);

UPDATE customers SET salary=salary+500 WHERE id=2;
DELETE FROM CUSTOMERS WHERE id=6;

:OLD Y :NEW cuando realicemos un UPDATE
:OLD cuando hagamos un DELETE
:NEW cuando hagamos un INSERT