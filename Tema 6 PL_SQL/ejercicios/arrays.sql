set serveroutput on;
declare
    type jobsarray is array(15) of  emp.job%type;--tipo de variable
    tipo_trabajo jobsarray:=jobsarray();--variable del tipo de variable del array
    --obligatorio inicalizar variable del tipo array llamando al constructor
    --hay que reservarle espacio si o si con .extend (abajo se usa)
    cursor c_trabajo is select distinct(job) from emp;
    i int:=1;
    longitud int:=0;
    v_trabajo emp.job%type;

begin
    open c_trabajo;
    loop
        tipo.trabajo.extend;
        --array_variable.extend es ir reservando la memoria necesaria para ir usando
        --nuestro array. De forma dinámica vamos guardando trozos 
        fetch c_trabajo into v_trabajo;
        exit when c_trabajo%notfound;
        tipo_trabajo(i):=v_trabajo;
        i:=i+1;

    end loop;
    close c_trabajo;
    
    longitud:=tipo_trabajo.count;
    --variable tipo array el .count es devolver el tamaño de dicha variable
    for i in 1..longitud loop
        dbms_output.put_line(tipo_trabajo(i));
    end loop;
    dbms_output.put_line('La longitud de la variable de tipo array tipo_trabajo es '||longitud-1);
    
end;
    

select * from departments;
    
    
    
    