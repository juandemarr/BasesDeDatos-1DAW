--CREAR UNA TABLA QUE SE LLAME EMP_HISTÓRICO Y QUE ALMACENE
-- LOS CAMBIOS QUE SE REALICEN EN LA TABLA EMP Y CON LA FECHA
-- DEL DÍA QUE SE HAN REALIZADO DICHOS CAMBIOS


--LA TABLA HISTORICO_EMPLEADO TENDRÁS LOS MISMOS CAMPOS QUE EMP     --DESCRIBE EMP;
--UN CAMPO NUMÉRICO CLAVE PRINCIPAL + OTRO CAMPO CON LA FECHA Y HORA DE LOS CAMBIOS.

--SELECT * FROM EMP;

--2 Ana CLERK 7698 23/01/82 3710 10
                    --7839
                    --3740
--HISTORICO_EMPLEADO

--PK EMPNO ENAME JOB MGR HIREDATE SAL COMM DEPTNO FECHA-HORAACTUALIZACION/BORRADO
--1 2 NULL NULL 7698 NULL NULL NULL NULL SYSDATE
--2 2 NULL NULL NULL NULL 3710 NULL NULL SYSDATE


drop table emp_historico;

create sequence incremento start with 1;

create table emp_historico(
    num int primary key,
    empno number(4) not null,
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm  number(7,2),
    deptno number(2),
    fechaHora varchar2(50)
);

select * from emp;

--AUTOINCREMENTO

create or replace trigger tr_incremento before insert on emp_historico
for each row
begin
    select incremento.nextval into :new.num from dual;
    --:new.num:=incremento.nextval;
    
end;

--prueba
--insert into emp_historico(empno,ename) values ('1','Ana Clerk');
--insert into emp_historico(empno,ename) values ('2','Ana Clerk');
select * from emp_historico;
delete from emp_historico; --hay que borrar tambien el incremento y volver a crearlo para que al insertar empiece en uno
drop sequence incremento;



--TRIGGER INSERTAR EN EMP_HISTORICO

create or replace trigger tr_historico before update on emp
for each row
declare
    c_fechaHora varchar2(50);
    v_emphistorico emp%rowtype;

begin
    
    select to_char(sysdate,'dd-mon-yyyy hh:mm:ss') into c_fechaHora from dual;
    
if updating then
    v_emphistorico.empno:= :old.empno;--para guardarlo siempre

    
    if :new.ename <>:old.ename then 
        v_emphistorico.ename:= :old.ename;
    else v_emphistorico.ename:=null;
    end if;
    
    if :new.job <>:old.job then 
        v_emphistorico.job:= :old.job;
    else v_emphistorico.job:=null;
    end if;
    
    if :new.mgr <>:old.mgr then 
        v_emphistorico.mgr:= :old.mgr;
    else v_emphistorico.mgr:=null;
    end if;
    
    if :new.hiredate <>:old.hiredate then 
        v_emphistorico.hiredate:= :old.hiredate;
    else v_emphistorico.hiredate:=null;
    end if;
    
    if :new.sal <>:old.sal then 
        v_emphistorico.sal:= :old.sal;
    else v_emphistorico.sal:=null;
    end if;
    
    if :new.comm <>:old.comm then 
        v_emphistorico.comm:= :old.comm;
    else v_emphistorico.comm:=null;
    end if;
    
    if :new.deptno <>:old.deptno then 
        v_emphistorico.deptno:= :old.deptno;
    else v_emphistorico.deptno:=null;
    end if;
    
else
    v_emphistorico.empno:= :old.empno;
    v_emphistorico.ename:= :old.ename;
    v_emphistorico.job:= :old.job;
    v_emphistorico.mgr:= :old.mgr;
    v_emphistorico.hiredate:= :old.hiredate;
    v_emphistorico.sal:= :old.sal;
    v_emphistorico.comm:= :old.comm;
    v_emphistorico.deptno:= :old.deptno;
end if;
    
    insert into emp_historico(empno,ename,job,mgr,hiredate,sal,comm,deptno,fechahora) values(v_emphistorico.empno,v_emphistorico.ename,v_emphistorico.job,v_emphistorico.mgr,
                                                v_emphistorico.hiredate,v_emphistorico.sal,v_emphistorico.comm,v_emphistorico.deptno,c_fechaHora);

end;



set serveroutput on;
declare

begin
    update emp set empno=111 where empno=7782;--comprobar que esté este valor antes
    
end;

select * from emp;
select * from emp_historico;

update emp set sal=sal*1.5;
delete from emp where deptno=30;



--RESOLVER el tema de las tablas mutantes
--ocurririan cuando se ejecutaba un trigger de fila
--for each row y estabamos realizando una consulta a la tabla
--que era objeto del trigger

--emp un trigger que no permita insertar o actualizar
--el salario de un empleado que no pueda ser 25 veces mayor
--que el salario minimo que cobre otro empleado
--y si nos pasamos que ponga el salario maximo --> min(sal)*25

    select min(sal)*25 from emp;


create or replace trigger tr_salario_max
after insert or update
on emp
for each row
declare
    v_salario_maximo emp.sal%type;
begin
    select min(sal)*25 into v_salario_maximo from emp;

    if v_salario_maximo < :new.sal then
        update emp set sal=v_salario_maximo where empno=:new.empno
    end if;
end tr_salario_max;


update emp set sal=sal*1.5 where 

:new.empno=7698  :new.ename='BLAKE'  ...  :new.sal=4275 --aunque no se mencione en la sentencia update
:old.empno=7698  :new ename='BLAKE'  ...  :old.sal=2850



--resolucion de tablas mutantes
--package
--trigger compuesto
        --trigger fila
        --trigger sentencia
        
--PACKAGE
--creamos varaible del select de la tabla k se sustituye en un package
create or replace package pk_salario_maximo as
max_sal emp.sal%type;
end;

--creamos un trigger k llame a la variable de ese package para que pueda hacer el calculo sobre la tabla a cambiar y no de fallo de no poder calcular algo sobre la tabla original por ser tabla mutante
--trigger de sentencia
create or replace trigger tr_maxsalario
before insert or update on emp
begin
        select min(sal)*25 into pk_salario_maximo.max_sal from emp;
end;


--trigger de fila
create or replace trigger tr_salario
before insert or update on emp
for each row
begin
    if :new.sal > pk_salario_maximo.max_sal then
        :new.sal:=pk_salario_maximo.max_sal;
    end if;
    dbms_output.put_line('El nuevo salario de '||:new.ename||' es '||:new.sal);
end;
        
        
        
set serveroutput on;
update emp set sal=sal*1.5 where deptno=30;



--trigger compuesto
--un trigger de fila (for each row) --> aqui no se hacen select
--un trigger de sentencia (no tiene for each row, solo se ejcecuta una vez independientemente del numero de filas) --> aqui si podemos hacer select
select * from emp where deptno=10;
--en el trigger de fila lo que vamos hacer es ir almacenando
--en un array los valores de que se vayan a ir actualizando
--update emp set sal=sal*1.5 where deptno=10;
--el array --> [(7839,5000*1.5),(7782,2450*1.5),(7934,1300*1.5)]

--trigger de sentencia 
--bucle donde vamos a recorrer el array de arriba y comprobamos que los datos son correctos
--salario > max que ocurre
--realizamos un nuevo update con el valor max
/*7839  7500 (sal)
7782  3675
7934  1950  => esto el array

dsp se comprueban que estos sueldo no se hayan ido x encima del maximo(7200) dentro del if se hace update emp set sal=salario_maximo where...
*/




