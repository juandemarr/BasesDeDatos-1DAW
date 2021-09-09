-- SALARIO QUE NO PUEDA SER MAYOR QUE 25 VECES EL MÃ?NIMO


CREATE OR REPLACE TRIGGER tr_salario_equitativo 
   AFTER INSERT OR UPDATE 
   ON EMP 
   FOR EACH ROW 
DECLARE 
   l_max_allowed   emp.sal%TYPE; 
BEGIN 
   SELECT MIN (sal) * 25 
     INTO l_max_allowed 
     FROM emp; 
 
   IF l_max_allowed < :NEW.sal 
   THEN 
      UPDATE emp 
         SET sal = l_max_allowed 
       WHERE empno = :NEW.empno; 
   END IF; 
END tr_salario_equitativo; 

SELECT * FROM EMP;



-- USANDO PACKAGES
-- 
CREATE TABLE emp AS SELECT * FROM scott.emp;

CREATE OR REPLACE PACKAGE pkg_emp_cache AS
max_sal emp.sal%TYPE;
END;
/

CREATE OR REPLACE TRIGGER trg_bef_ins_upd_emp
BEFORE INSERT OR UPDATE ON emp
BEGIN
SELECT 25*MIN(sal) INTO pkg_emp_cache.max_sal
FROM emp;
END;
/

CREATE OR REPLACE TRIGGER trg_bef_ins_upd_row_emp
BEFORE INSERT OR UPDATE ON emp
FOR EACH ROW
BEGIN
:NEW.sal:=LEAST(pkg_emp_cache.max_sal, :NEW.sal);
DBMS_OUTPUT.PUT_LINE('New Salary of ' || :NEW.ename || ' is set to ' || :NEW.sal);
END;

UPDATE EMP SET SAL=SAL*2 WHERE DEPTNO=30;




--TRIGGER COMPUESTO PARA SALARIO EQUITATIVO

create or replace TRIGGER TR_compuesto_equitativo
FOR UPDATE OR INSERT ON emp    
COMPOUND TRIGGER     
   TYPE id_salary_rt IS RECORD (    
      employee_id   emp.empno%TYPE    
    , salary        emp.sal%TYPE    
   );    

   TYPE row_level_info_t IS TABLE OF id_salary_rt  INDEX BY PLS_INTEGER;    

   g_row_level_info   row_level_info_t;
   v_mgr emp.mgr%type:=:new.mgr;

   AFTER EACH ROW IS    
   BEGIN  
      
      g_row_level_info (g_row_level_info.COUNT + 1).employee_id := :NEW.empno;    
      g_row_level_info (g_row_level_info.COUNT).salary := :NEW.sal;
   END AFTER EACH ROW;    

   AFTER STATEMENT IS    
      l_max_allowed   emp.sal%TYPE;    
   BEGIN      
      SELECT MIN (sal) * 25    
        INTO l_max_allowed    
        FROM emp;     

      FOR indx IN 1 .. g_row_level_info.COUNT    
      LOOP                                      
         IF l_max_allowed < g_row_level_info (indx).salary    
         THEN    
            UPDATE emp   
               SET sal = l_max_allowed    
             WHERE empno = g_row_level_info (indx).employee_id;    
         END IF;    
      END LOOP;    
   END AFTER STATEMENT;    
END TR_compuesto_equitativo; 


SELECT * FROM EMP;
UPDATE EMP SET SAL=SAL*2 WHERE DEPTNO=10;




--RESTAR FECHAS
select to_date( '02-01-2016', 'DD-MM-YYYY' )
         - to_date( '01-01-2016', 'DD-MM-YYYY' )
         as difference
from   dual