-- Create DEPT table which will be the parent table of the EMP table. 
create table dept(
  deptno     number(2,0),
  dname      varchar2(14),
  loc        varchar2(13),
  constraint pk_dept primary key (deptno)
);
?
-- Create the EMP table which has a foreign key reference to the DEPT table.  The foreign key will require that the DEPTNO in the EMP table exist in the DEPTNO column in the DEPT table.
create table emp(
  empno    number(4,0),
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number(2,0),
  constraint pk_emp primary key (empno),
  constraint fk_deptno foreign key (deptno) references dept (deptno)
);
?
-- Insert row into DEPT table using named columns.
insert into DEPT (DEPTNO, DNAME, LOC)
values(10, 'ACCOUNTING', 'NEW YORK');
?
-- Insert a row into DEPT table by column position.
insert into dept
values(20, 'RESEARCH', 'DALLAS');
?
insert into dept
values(30, 'SALES', 'CHICAGO');
?
insert into dept
values(40, 'OPERATIONS', 'BOSTON');
?
-- Insert EMP row, using TO_DATE function to cast string literal into an oracle DATE format.
insert into emp
values(
 7839, 'KING', 'PRESIDENT', null,
 to_date('17-11-1981','dd-mm-yyyy'),
 5000, null, 10
);
?
insert into emp
values(
 7698, 'BLAKE', 'MANAGER', 7839,
 to_date('1-5-1981','dd-mm-yyyy'),
 2850, null, 30
);
?
insert into emp
values(
 7782, 'CLARK', 'MANAGER', 7839,
 to_date('9-6-1981','dd-mm-yyyy'),
 2450, null, 10
);
?
insert into emp
values(
 7566, 'JONES', 'MANAGER', 7839,
 to_date('2-4-1981','dd-mm-yyyy'),
 2975, null, 20
);
?
insert into emp
values(
 7788, 'SCOTT', 'ANALYST', 7566,
 to_date('13-JUL-87','dd-mm-rr') - 85,
 3000, null, 20
);
?
insert into emp
values(
 7902, 'FORD', 'ANALYST', 7566,
 to_date('3-12-1981','dd-mm-yyyy'),
 3000, null, 20
);
?
insert into emp
values(
 7369, 'SMITH', 'CLERK', 7902,
 to_date('17-12-1980','dd-mm-yyyy'),
 800, null, 20
);
?
insert into emp
values(
 7499, 'ALLEN', 'SALESMAN', 7698,
 to_date('20-2-1981','dd-mm-yyyy'),
 1600, 300, 30
);
?
insert into emp
values(
 7521, 'WARD', 'SALESMAN', 7698,
 to_date('22-2-1981','dd-mm-yyyy'),
 1250, 500, 30
);
?
insert into emp
values(
 7654, 'MARTIN', 'SALESMAN', 7698,
 to_date('28-9-1981','dd-mm-yyyy'),
 1250, 1400, 30
);
?
insert into emp
values(
 7844, 'TURNER', 'SALESMAN', 7698,
 to_date('8-9-1981','dd-mm-yyyy'),
 1500, 0, 30
);
?
insert into emp
values(
 7876, 'ADAMS', 'CLERK', 7788,
 to_date('13-JUL-87', 'dd-mm-rr') - 51,
 1100, null, 20
);
?
insert into emp
values(
 7900, 'JAMES', 'CLERK', 7698,
 to_date('3-12-1981','dd-mm-yyyy'),
 950, null, 30
);
?
insert into emp
values(
 7934, 'MILLER', 'CLERK', 7782,
 to_date('23-1-1982','dd-mm-yyyy'),
 1300, null, 10
);



--Realizar un trigguer para que no se pudiera realizar 
--ningun cambio sobre el presidente

create or replace trigger no_presidente
before delete or insert or update on emp
for each row

begin

  if :new.job='PRESIDENT' or :old.job='PRESIDENT'
    then raise_aplication_error(-20501,'No se puede modificar ningun presidente');
  end if;
  --da igual el numero que poner de error 
end;




set serveroutput on;
update set sal=sal+sal*0.1;

insert into emp values(7899,'KING','PRESIDENT',null,to_date('17-11-1981','dd-mm-yyyy'),5000,null,10);

--borrar a todos para despues intentar borrar al presidente
delete from emp where empno=7839;
--delete from emp where empno in (select * from emp where mgr=7839);
delete from emp where mgr=7839;

delete from emp where empno=7698;

delete from emp where empno=7839;

select * from emp where mgr=7782;

delete from emp where empno=7566;


delete from emp where mgr=7369;

delete from emp where mgr=7902;

delete from emp where mgr=7788;

delete from emp where mgr=7566;

delete from emp where empno=1;
delete from emp where empno=2;
delete from emp where mgr=7566;
delete from emp where mgr=7566;



--controlar que un empleado no pueda ser manager de mas de otro cinco empleados
--trigguer insert o update
select mgr,count(*) from emp group by mgr;

create or replace trigger tr_supervisa5
before insert or update on emp
for each row
declare
  v_supervisa int:=0;
  
begin --variables de entorno de los triggers :old y :new
  select count(*) into v_supervisas from emp where mgr=:new.mgr;--:new.mgr equivale al nuevo que se introduzca en el insert into
  
  if v_supervisa>4 then
    raise_aplication_error(-20600 ,'El empleado '||:new.mgr||' no puede ser el manager porque el empleado ya tiene 5');
  end if;
end;
    
    
    
    
insert into emp values (2,'Ana','CLERK',7566,to_date('23-1-1982','dd-mm-yyyy'),
1300,null,10);

update emp set mgr=7698 where empno=2;

update emp set mgr=7839 where mgr=7566;


--uno de los mayores problemas que vamos a tener a la hora de trabajar con triggers es el problema de las tablas mutantes.
--en oracle con insert se toca 1 fila
--sin embargo con el update podria ser que estuvieramos modificando ninguna, una o todas.

--no se puede hacer el update porque tenemos un select count(*), y al cambiar la tabla no se puede ir calculando sobre 
--la marxa el count de la tabla modificada, en este caso por eso sale ese error 
--hay que arreglar el tema de las tablas mutantes a la hora de actualizar
--al acceder a la misma tabla que se esta modificando


--sobre la tabla emp realizar un trigger que impida que se modifique el salario 
--de los empleados en mas de un 20%

create or replace trigger tr_salario
before update on emp
for each row--si no se pone esto no se puede usar :old y :new

begin
  if :new.sal > :old.sal*1.2 or :new.sal*1.2 <:old.sal
    then raise_application_error(-20600,'No se puede modificar el salario en mas de un 20%');--se pyuede usar con if updating y demas, no es excluyente
    --el numero de error da igual
  else
    dbms_output.put_line('Salario modificado');
  end if;
end;

update emp set sal=5100 where ename='KING';
update emp set sal=sal+10 where empno=2;
update emp set sal=sal+100 where empno<>7839;


update emp set sal=sal+150 where empno<>7839;
--trigger que impida que algun empleado cobre mas que el presidente modificando trigger para que pokito a pokito no deje subirlo mas que el presidente.
--se cambie como max en tres meses. Esto ni caso
--crear una tabla que se llame emp_historico y que almacene 
--los cambios que se realicen en la tabla emp y con la fecha
--del dia que se han realizado dichos cambios

--la tabla historico empleado tendra los mismos campos que empleado mas 
--un campo numerico clave principal mas otro campo con la fecha y hora de los cambios que se han realizado

--historico_empleado
--pk(autoincrementado)  empno  ename  job  mgr  hiredate  sal  comm  deptno  fecha-horaactualziacion/borrado
2 ana clerk 7698 23/01/82 3710 10
                  7839
                  
1  2  null  null  7839  null null null null sysdate





