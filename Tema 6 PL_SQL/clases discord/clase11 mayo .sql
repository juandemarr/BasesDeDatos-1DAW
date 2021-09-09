--TRIGGER COMPUESTO PARA SALARIO EQUITATIVO
--PARA EVITAR EL ERROR DE LAS TABLAS MUTANTES
--uN TRIGGER DE FILA (FOR EACH ROW) Y REALIZABAMOS UNA CONSULTA SQL
-- SELECT MAX(SAL) FROM EMP;
-- MANERAS PARA SOLUCIONAR EL PROBLEMAS DE LAS TABLAS MUTANTES
--1.- UTILIZAR UN TRIGGER DE SENTENCIA (quitar el for each row)
--  Problema: no podemos usar ni :new ni :old
-- 2.- Utilizar paquetes. Es importante que los trigger no tengan demasiado código
-- ya que haría que nuestra BD fuera ineficiente. Hace llamadas a funciones o procedimientos
-- que tengamos almacenados y compilados en paquetes. Nuestra BD sea más eficiente.
-- 3.- TRIGGERS COMPUESTOS.
-- 3.1. Primera parte del trigger va a ser de fila.
-- es ir almacenando en una tabla los valores que se están modificando
-- el nuevo sueldo sea 25 veces mayor que el sueldo mínimo del empleado.
-- 3.2. Sentencia 
create or replace TRIGGER TR_compuesto_equitativo
FOR UPDATE OR INSERT ON emp    
COMPOUND TRIGGER     
   TYPE id_salary_rt IS RECORD (    
      employee_id   emp.empno%TYPE    
    , salary        emp.sal%TYPE    
   );    

   TYPE row_level_info_t IS TABLE OF id_salary_rt  INDEX BY PLS_INTEGER;    

   g_row_level_info   row_level_info_t;
   
   AFTER EACH ROW IS    
   BEGIN  
      g_row_level_info (g_row_level_info.COUNT + 1).employee_id := :NEW.empno;    
      dbms_output.put_line('El empleado '||:new.empno||' tiene nuevo sueldo '||:new.sal);
      g_row_level_info (g_row_level_info.COUNT).salary := :NEW.sal;
     
   END AFTER EACH ROW;    

   AFTER STATEMENT IS    
      l_max_allowed   emp.sal%TYPE;    
   BEGIN      
      SELECT MIN (sal) * 25    
        INTO l_max_allowed    
        FROM emp;     
    dbms_output.put_line('Salario máximo '||l_max_allowed);
      FOR indx IN 1 .. g_row_level_info.COUNT    
      LOOP                                      
         IF l_max_allowed < g_row_level_info (indx).salary    
         THEN    
            UPDATE emp   
               SET sal = l_max_allowed    
             WHERE empno = g_row_level_info (indx).employee_id;
             dbms_output.put_line('El empleado le hemos tenido que cambiar el sueldo '||g_row_level_info (indx).salary||' '||g_row_level_info (indx).employee_id);
         ELSE
            dbms_output.put_line('El empleado '||g_row_level_info (indx).employee_id||' tiene sueldo correcto');
         END IF;    
      END LOOP;    
   END AFTER STATEMENT;    
END TR_compuesto_equitativo; 

-- que un manager no lo podía ser más que de 5 empleados
-- REALIZAR un trigger compuesto que solucione este problema.
--


select min(sal)*25 from emp;
select * from emp;
set serveroutput on;


update emp set sal=35000 where empno=7369;



-- BEFORE OR AFTER EN UN TRIGGER
-- AL FINAL PUEDE DAR COMO RESULTADO QUE LA SETENCIA NO SE EJECUTE Y SE VUELVA 
-- A UN ESTADO ANTERIOR.
-- ¿Cuándo utilizar un trigger AFTER OR BEFORE?
-- dEPENDE de la lógica que de estemos haciendo
-- por ejemplo:SI ESTAMOS CONTROLANDO ALGÚN PERO TENEMOS SOLUCIÓN AFTER.
-- SI ESTAMOS CONTROLANDO QUE NO HAYAMODIFICACIONES POR RAZÓN DE USUARIO
-- O POR RAZÓN DE HORARIO O DE FECHA BEFORE
-- TRIGGER DE SENTENCIA Y BEFORE 

-- SOBRE UNA MISMA TABLA VAMOS A TENER VARIOS TRIGGERS
-- ORDEN EN LOS QUE SE VAN A EJECUTAR LOS TRIGGERS.
-- 3*2*2=12 DIFERENTES TIPOS DE TRIGGERS
-- ORDEN DE EJECUCIÓN DE LOS TRIGGERS
-- 1.- BEFORE SETENCIA. 
-- 2.- BEFORE FILA.
-- 3.- AFTER FILA.
-- 4.- AFTER SENTENCIA.

--3 
CREATE OR REPLACE TRIGGER TR_AFTER_FILA
AFTER UPDATE OR INSERT OR DELETE ON DEPT
FOR EACH ROW
BEGIN
    dbms_output.put_line('Este es un trigger After fila en la tabla dept');
END;

--4

CREATE OR REPLACE TRIGGER TR_AFTER_SENTENCIA
AFTER INSERT OR UPDATE OR DELETE ON DEPT
BEGIN 
    dbms_output.put_line('Este es un trigger After sentencia en la tabla dept');

end;

--2
CREATE OR REPLACE TRIGGER TR_BEFOREFILA
BEFORE UPDATE OR INSERT OR DELETE ON DEPT
FOR EACH ROW
BEGIN
        dbms_output.put_line('Este es un trigger BEFORE fila en la tabla dept');
END;

--1
CREATE OR REPLACE TRIGGER TR_BEFORESENTENCIA
BEFORE UPDATE OR INSERT OR DELETE ON DEPT
BEGIN
        dbms_output.put_line('Este es un trigger BEFORE SETENCIA en la tabla dept');
END;

SELECT * FROM DEPT;
set serveroutput on;
INSERT INTO DEPT VALUES(50,'Resources','L.A.');
INSERT INTO DEPT VALUES(61,'Human Reso','Miami');

update dept set deptno=deptno+1 where deptno>=50;


delete dept where deptno>50;

select count(*)from dept;


CREATE OR REPLACE TRIGGER TR_5MAX
AFTER INSERT ON DEPT
declare
v_numdept int:=0;
BEGIN
    select count(*) into v_numdept from dept;
    dbms_output.put_line('El número de departamentos es '||v_numdept);
    if v_numdept >= 5 then
        raise_application_error(-20001,'No puede haber más de 5 departamentos');
    end if;
end;
        




































CREATE OR REPLACE TRIGGER TR1 
BEFORE UPDATE OR INSERT OR DELETE on DEPT
BEGIN
    dbms_output.put_line('Este es un trigger en la tabla dept before de setencia ');
END;

CREATE OR REPLACE TRIGGER TR2 
BEFORE UPDATE OR INSERT OR DELETE on DEPT
FOR EACH ROW
BEGIN
    dbms_output.put_line('Este es un trigger en la tabla dept before de FILA ');
END;

CREATE OR REPLACE TRIGGER TR3 
AFTER UPDATE OR INSERT OR DELETE on DEPT
FOR EACH ROW
BEGIN
    dbms_output.put_line('Este es un trigger en la tabla dept AFTER de FILA ');
END;

CREATE OR REPLACE TRIGGER TR4 
AFTER UPDATE OR INSERT OR DELETE on DEPT

BEGIN
    dbms_output.put_line('Este es un trigger en la tabla dept AFTER de SENTENCIA ');
END;

select * from dept;

set serveroutput on;
insert into dept values (50,'Resources','L.A.');
insert into dept values (60,'Rec','Detroit');
update dept set deptno=deptno+10 where deptno >=50 ;
DELETE DEPT WHERE deptno >=50 ;