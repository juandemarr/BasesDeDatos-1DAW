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

-- Creaci�n del trigger de fila (usa for each)
CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE DELETE OR INSERT OR UPDATE ON customers
FOR EACH ROW
WHEN (NEW.id > 0)--opcional
DECLARE
  sal_diff NUMBER;
BEGIN
  if updating then --para que haga solo esto en caso de actualziar
    sal_diff := :NEW.salary - :OLD.salary;
    DBMS_OUTPUT.PUT_LINE('El empleado '||:OLD.name);--tbn puede ser :new al no cambiarse
    DBMS_OUTPUT.PUT_LINE('Old Salary: ' || :OLD.salary);
    DBMS_OUTPUT.PUT_LINE('New Salary: ' || :NEW.salary);
    DBMS_OUTPUT.PUT_LINE('Salary difference: ' || sal_diff);
  end if;
  
  if deleting then--mejor con else if
    DBMS_OUTPUT.PUT_LINE('Old Salary: ' || :OLD.salary);
  end if;
  
  if inserting then
    DBMS_OUTPUT.PUT_LINE('New Salary: ' || :NEW.salary);
  end if;
  
END;

-- Lanzar el trigger
set serveroutput on;

update customers set salary=salary+salary*0.01;



set serveroutput on;
INSERT INTO customers (id,name,age,address,salary) VALUES (7,'Kritti',22,'HP',7500.00);

UPDATE customers SET salary=salary+500 WHERE id=2;

delete from customers where id=2;

--------------------------------------------
:OLD y :NEW solo se accede a ellos cuando realizamos un update
:OLD cuando hagamos un delete
:NEW cuando hagamos un insert



