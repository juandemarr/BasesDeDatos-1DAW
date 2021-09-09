select * from department;
select * from academic;
select * from paper;
select * from author;
select * from field;
select * from interest;
-- Department(#DeptNum, Descrip, Instname, DeptName, State, Postcode)
-- Academic(#AcNum, *DeptNum, FamName, GiveName, Initials, Title)
-- Paper(#PaNum, Title)4997
-- Author(#*PaNum, #*AcNum) 5000
-- Field(#FieldNum, ID, Title)
-- Interest(#*FieldNum, #*AcNum, Descrip)

-- RESEARCH

-- HAY QUE REALIZAR UN CURSOR QUE RECORRA LA TABLA AUTHOR DE 1 EN 1
-- Y QUE VAYA COMPROBANDO CON LA TABLA PAPER SI EXISTE EL NÚMERO DEL PAPER
-- SINO EXISTE EN UNA VARIABLE DE TIPO ARRAY V_PAPERARRAY INTRODUZCAMOS
-- LOS NÚMEROS DE LOS PAPERS que faltan.

/*PAPER(paNum#, Title); 4997 nos faltas tres papers 1 5000

Author(paNum#*,acNum#*);5000 papers*/

set serveroutput on;
declare
    cursor c_autor is select author.panum from author left join paper 
         on author.panum=paper.panum where paper.panum is null;
    v_panumAutor author.panum%type;

    type arrayPaper is varray(4) of paper.panum%type;
    v_arrayPaper arrayPaper:=arrayPaper();
    
    i int:=1;
    longitud int:=0;
    
begin

    open c_autor;
    loop
        v_arrayPaper.extend;
        
        fetch c_autor into v_panumAutor;
        exit when c_autor%notfound;
        
        v_arrayPaper(i):=v_panumAutor;
        i:=i+1;
        
    end loop;
    close c_autor;
    
    longitud:=v_arrayPaper.count;
    
    for i in 1..longitud-1 loop
        dbms_output.put_line(v_arrayPaper(i));--sale un elemento de más, que al recorrerlo es vacío, 
                                                                    --pero tengo que declarar el array con uno de más porque 
                                                                    --si no da error. Entonces no lo muestro en el for
        --titulos(v_arrayPaper(i),'titulo '||i);
    end loop; 
end;



/*create or replace procedure titulos(valorArray paper.panum%type) is
    titulo paper.title%type:='&introduce_titulo';
    
begin
    insert into paper values(valorArray,titulo);
    
end; */--Esta función la probamos sergio y yo, para poder insertarle un titulo distinto en cada iteración,
          --pero solo pide una vez el mensaje en el bucle for, entonces ya...

--insert manuales que nunca fallan
insert into paper values(3112,'titulo1');
insert into paper values(3839,'titulo2');
insert into paper values(2269,'titulo3');


--comprobación
--select * from paper where panum=3112;
--select * from paper where panum=3839;
--select * from paper where panum=2269;

--borrado 
--delete from paper where panum=3112;
--delete from paper where panum=3839;
--delete from paper where panum=2269;
