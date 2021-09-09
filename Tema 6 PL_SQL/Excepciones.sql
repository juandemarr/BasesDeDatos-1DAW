set serveroutput on;
declare
    v_codigo departments.code%type:=&introduce_codigo_dep;
    v_name departments.name%type;
    e_codigosdepnegativos exception;
begin
    if v_codigo<0 then
        raise e_codigosdepnegativos;
    end if;
    
    select name into v_name from departments where code=v_codigo;
    dbms_output.put_line('El nombre del departamento '||v_codigo||' es '||v_name);

exception

    when no_data_found then
        dbms_output.put_line('El codigo del departamento no existe');
    when e_codigosdepnegativos then
        dbms_output.put_line('Los codigos no pueden ser negativos');
    
end;


--AGREGAR EXCEPCION
-- crear un procedimiento que dado un codigo de departamento dibuje en pantalla los
--empleados de dicho departamento

create or replace procedure empleadosdeundepartamento (codigo in departments.code%type)
is
    cursor c_empleado is select name,lastname from employees where department=codigo;
    v_nombre employees.name%type;
    v_apellidos employees.lastname%type;
    e_noempleados exception;
    e_nodepartamento exception;
    v_existe int;
    
begin
    select count(*) into v_existe from departments where code=codigo; 
    
    if v_existe=0 then
        raise e_nodepartamento;
    end if;
    
    open c_empleado;
    
    loop
        fetch c_empleado into v_nombre,v_apellidos;
        exit when c_empleado%notfound;
        dbms_output.put_line(v_nombre||'  '||v_apellidos);
    end loop;
    
    if(c_empleado%rowcount=0) then     
        raise e_noempleados;
    end if;
    
    close c_empleado;
    
exception
    when e_noempleados then
        dbms_output.put_line('El dep no tiene empleados');
    when e_nodepartamento then
        dbms_output.put_line('El departamento no existe');
end;


--------
set serveroutput on;
declare
    v_codigo departments.code%type:=&codigo_dep;
    
begin
    empleadosdeundepartamento(v_codigo);

end;


select * from departments;
    
    
    
    