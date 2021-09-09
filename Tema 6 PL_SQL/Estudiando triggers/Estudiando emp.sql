-- Create DEPT table which will be the parent table of the EMP table. 
drop table dept;
drop table emp;


create table dept(
  deptno     number(2,0),
  dname      varchar2(14),
  loc        varchar2(13),
  constraint pk_dept primary key (deptno)
);
--? este signo de interrogacion muestra como obtener ayuda debajo de la salida

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



-- Insert row into DEPT table using named columns.
insert into DEPT (DEPTNO, DNAME, LOC)
values(10, 'ACCOUNTING', 'NEW YORK');

-- Insert a row into DEPT table by column position.
insert into dept
values(20, 'RESEARCH', 'DALLAS');

insert into dept
values(30, 'SALES', 'CHICAGO');

insert into dept
values(40, 'OPERATIONS', 'BOSTON');

-- Insert EMP row, using TO_DATE function to cast string literal into an oracle DATE format.
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


select * from dept;
select * from emp;

--1. Realizar un trigguer para que no se pudiera realizar 
--ningun cambio sobre el presidente
create or replace trigger no_president
before update or delete on emp
for each row
declare
begin
if updating then
    if (:old.empno<>:new.empno or :old.ename<>:new.ename or :old.job <> :new.job or :old.mgr<>:new.mgr or :old.hiredate<>:new.hiredate or 
        :old.sal<>:new.sal or :old.comm<>:new.comm or :old.deptno<>:new.deptno) and :old.job='PRESIDENT' then
        raise_application_error(-20500,'No se pueden realizar cambios sobre el presidente');
    end if;
end if;
if deleting then
    if :old.job='PRESIDENT' then
        raise_application_error(-20501,'No se puede borrar al presidente');
    end if;
end if;
end;

set serveroutput on;
update emp set job='camionero' where ename='KING';
delete from emp where ename='KING';
select * from emp;

-------------------------------------------------------------
--OTRA FORMA
update emp set ename='HELLO' where ename='KING';
update emp set ename='KING' where ename='HELLO';

select * from emp;

create or replace trigger no_president_mejorado 
before insert or update or delete on emp
for each row
declare
begin
    
    if :old.job='PRESIDENT' or :new.job='PRESIDENT' then
        raise_application_error(-20600,'No se puede modificar, añadir o borrar al presidente');
    end if;
    
end;


--2. Controlar que un empleado no pueda ser manager de mas de otro cinco empleados
--trigguer insert o update
select * from emp;

select mgr, count(ename) from emp where mgr=7698 group by mgr ;


create or replace trigger no_mas_de_cinco 
before insert or update on emp
for each row
declare
    maximo int;
begin

    select count(ename) into maximo from emp where mgr=:new.mgr;
    if maximo>=5 then
        raise_application_error(-20500,'No puede ser manager de mas de cinco empleados');
    end if;

end;

insert into emp(ename,mgr) values (1111,7698);
--prueba con menor de 5
insert into emp values (1113,'Hola','camionero',7839,null,900,null,10);
select mgr, count(ename) from emp group by mgr;
select * from emp;
delete from emp where empno=1111;

--3. Sobre la tabla emp realizar un trigger que impida que se modifique el salario 
--de los empleados en mas de un 20%
select * from emp;
select sal*1.2 ,sal from emp;

create or replace trigger max_20
before update on emp
for each row
declare
    maximo int;
begin

    select sal*1.2 into maximo from emp;
    if :new.sal >= maximo then
        raise_application_error(-20500,'No se puede subir el salario mas de un 20%');
    end if;

end;
--no puedo hacer un select de la tabla de trigger dentro del trgger(debajo de su begin), por lo que el calculo lo hago sobre la marxa con 
--:old y :new en el if. Tampoco así porque da error de tabla mutando
create or replace trigger max_20
before update on emp
for each row
declare
begin


    if :new.sal > :old.sal*1.2 then
        raise_application_error(-20500,'No se puede subir el salario mas de un 20%');
    end if;

end;


update emp set sal=5200 where ename='KING';--tenia 5000 y el 20% es 6000
