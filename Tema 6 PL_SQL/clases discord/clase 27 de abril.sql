

Select * from emp;
select * from dept;

update emp set sal=sal+sal*0.1;

insert into emp values( 7839, 'KING', 'PRESIDENT', null,  
 to_date('17-11-1981','dd-mm-yyyy'),   5000, null, 10  );
 
 delete from emp where empno=7839;
 delete from emp where mgr=7839;
 delete from emp where empno in ();
 
 select empno from emp where mgr=7839;

 delete from emp where mgr=7698;
  delete from emp where mgr=7782;
  delete from emp where mgr=7566;
  
  select * from emp;
  
  
  delete from emp where empno=2;
-- Realizar un trigger para que no se puediera realizar ningún cambio
-- sobre el presidente


-- Trigger de fila update
-- Dos tipos principales de TRIGGERS o disparadores
-- orden y de fila




CREATE OR REPLACE TRIGGER  no_president1
BEFORE DELETE OR INSERT OR UPDATE ON emp
FOR EACH ROW

BEGIN
  IF :new.job = 'PRESIDENT' OR :old.job = 'PRESIDENT'
    THEN raise_application_error( -123456,'NO SE PUEDE MODIFICAR,BORRAR O CREAR A UN PRESIDENTE');
  END IF;
END;

insert into emp  
values(  
 7839, 'KING', 'PRESIDENT', null,  
 to_date('17-11-1981','dd-mm-yyyy'),  
 5000, null, 10  
);

insert into emp  
values(  
 7698, 'BLAKE', 'MANAGER', 7839,  
 to_date('1-5-1981','dd-mm-yyyy'),  
 2850, null, 30  
);

insert into emp  
values(  
 7782, 'CLARK', 'MANAGER', 7839,  
 to_date('9-6-1981','dd-mm-yyyy'),  
 2450, null, 10  
);

insert into emp  
values(  
 7566, 'JONES', 'MANAGER', 7839,  
 to_date('2-4-1981','dd-mm-yyyy'),  
 2975, null, 20  
);

insert into emp  
values(  
 7788, 'SCOTT', 'ANALYST', 7566,  
 to_date('13-JUL-87','dd-mm-rr') - 85,  
 3000, null, 20  
);

insert into emp  
values(  
 7902, 'FORD', 'ANALYST', 7566,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 3000, null, 20  
);

insert into emp  
values(  
 7369, 'SMITH', 'CLERK', 7902,  
 to_date('17-12-1980','dd-mm-yyyy'),  
 800, null, 20  
);

insert into emp  
values(  
 7499, 'ALLEN', 'SALESMAN', 7698,  
 to_date('20-2-1981','dd-mm-yyyy'),  
 1600, 300, 30  
);

insert into emp  
values(  
 7521, 'WARD', 'SALESMAN', 7698,  
 to_date('22-2-1981','dd-mm-yyyy'),  
 1250, 500, 30  
);

insert into emp  
values(  
 7654, 'MARTIN', 'SALESMAN', 7698,  
 to_date('28-9-1981','dd-mm-yyyy'),  
 1250, 1400, 30  
);

insert into emp  
values(  
 7844, 'TURNER', 'SALESMAN', 7698,  
 to_date('8-9-1981','dd-mm-yyyy'),  
 1500, 0, 30  
);

insert into emp  
values(  
 7876, 'ADAMS', 'CLERK', 7788,  
 to_date('13-JUL-87', 'dd-mm-rr') - 51,  
 1100, null, 20  
);

insert into emp  
values(  
 7900, 'JAMES', 'CLERK', 7698,  
 to_date('3-12-1981','dd-mm-yyyy'),  
 950, null, 30  
);

insert into emp  
values(  
 7934, 'MILLER', 'CLERK', 7782,  
 to_date('23-1-1982','dd-mm-yyyy'),  
 1300, null, 10  
);

Select * from emp;


-- CONTROLAR QUE UN EMPLEADO NO PUEDA SER MANAGER DE MÁS DE OTROS CINCO EMPLEADOS

select mgr,count(*) from emp group by mgr;
-- TRIGGER INSERT O UN UPDATE 

update emp set mgr=7698 where empno=2;

insert into emp  
values(  
 2, 'Ana', 'CLERK', 7566,  
 to_date('23-1-1982','dd-mm-yyyy'),  
 1300, null, 10  
);



-- UNO DE LOS MAYORES PROBLEMAS QUE VAMOS A TENER A LA HORA DE TRABAJAR
-- CON TRIGGERS ES EL PROBLEMA DE LAS TABLAS MUTANTES.
-- EN ORACLE CUANDO HACES UN INSERT ESTAS UNA ÚNICA FILA
-- SIN EMBARGO CON EL UPDATE PODRÍA SER QUE ESTUVIÉRAMOS MODIFICANDO NINGUNA, UNA O TODAS.
-- hay que arreglar el tema de las tablas mutantes a la hora de actualizar
SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER  TR_SUPERVISA5
BEFORE INSERT  ON emp
FOR EACH ROW
DECLARE
    v_supervisa int:=0;
BEGIN
    select count(*) INTO v_supervisa from emp WHERE empno=:new.empno;
   
    IF v_supervisa>4 THEN
    raise_application_error(-20600,'El empleado '||:new.mgr||' no puede ser el manager porque ya supervisa a 5 empleados');
    END IF;

END;




END;
UPDATE EMP SET MGR=7839 WHERE MGR=7566;



7839	3
7782	1
7698	5
7902	1
7566	4
7788	1


7839	7
7782	1
7698	5
7902	1
7566	0
7788	1


-- SOBRE LA TABLA EMP realizar un trigger que impida que se se modique el salario
-- de los empleados en más de un 20%

CREATE OR REPLACE TRIGGER TR_SALARIO
BEFORE UPDATE ON emp


BEGIN
     IF :NEW.sal > :OLD.sal*1.2 OR :NEW.sal*1.2 < :OLD.sal
    THEN raise_application_error(-20600,'No se puede modificar el salario en más de un 20%');
    ELSE
    dbms_output.put_line('salario modificado');
    end if;
END;

select * from emp;
update emp set sal=sal+10 where empno=2;

update emp set sal=sal+150 where empno<>7839;

select * from emp;

-- TRIGGER QUE IMPIDA QUE ALGÚN EMPLEADO COBRE MÁS QUE EL PRESIDENTE
-- HAY QUE modificar el TRIGGER DEL SALARIO PARA QUE NO SE PUEDA MODIFICAR
-- EL SALARIO MÁS QUE UNA VEZ CADA 3 MESES
-- CREAR UNA TABLA QUE SE LLAME EMP_HISTÓRICO Y QUE ALMACENE
-- LOS CAMBIOS QUE SE REALICEN EN LA TABLA EMP Y CON LA FECHA 
-- DEL DÍA QUE SE HAN REALIZADO DICHOS CAMBIOS

DESCRIBE EMP;

LA TABLA HISTORICO_EMPLEADO TENDRÁS LOS MISMOS CAMPOS QUE EMP
+ UN CAMPO NUMÉRICO CLAVE PRINCIPAL + OTRO CAMPO CON LA FECHA Y HORA DE LOS CAMBIOS.


SELECT * FROM EMP;

2	Ana	CLERK	7698	23/01/82	3710		10
                7839
                                    3740
HISTORICO_EMPLEADO

PK EMPNO ENAME JOB MGR HIREDATE SAL COMM DEPTNO FECHA-HORAACTUALIZACION/BORRADO
1  2      NULL NULL 7698 NULL    NULL NULL NULL  SYSDATE
2  2      NULL NULL NULL NULL   3710 NULL NULL SYSDATE


https://educacionadistancia.juntadeandalucia.es/aulavirtual/login/index.php

TODOS LOS MATERIALES DE 