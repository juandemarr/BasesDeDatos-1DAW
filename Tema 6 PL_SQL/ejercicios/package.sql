--especificacion: crear el nombre del paquete y poner las cabeceras de los procedimientos y funciones que se van a incluir
create or replace miscelanea is
procedure dni_persona(v_dni in personas.dni%type);
function factorial (num int) return int;
end;

--crear cuerpo paquete:
create or replace package body miscelanea is
--se copia el procedimiento y funcion aqui dentro
procedure 
  ...
function
  ...

end;


--para usar el paquete:
declare
  num int:=&introduce;
  resultado int;
begin
  resultado:=miscelanea.factorial(num);
  dbms_output.put_line('El factorial del numero '||num||' es '||resultado);
end;