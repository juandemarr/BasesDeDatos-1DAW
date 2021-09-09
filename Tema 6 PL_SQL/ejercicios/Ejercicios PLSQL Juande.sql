/*1.-Desarrolle un programa que lea dos números de tipo int de teclado y posteriormente
los escriba en pantalla. Ejecútelo introduciendo dos números de tipo int válidos (por
ejemplo 1234 y 5678). Posteriormente ejecútelo introduciendo por teclado un primer
número de tipo int (por ejemplo 1234) e introduciendo por teclado un segundo dato que
no pertenezca al tipo int (por ejemplo hola). Finalmente ejecútelo introduciendo por
teclado un primer dato que no pertenezca al tipo int (por ejemplo hola). Evalúe las
diferencias entre ambas ejecuciones del mismo programa.
*/
set serveroutput on;
declare
    primero int:=&introduzca_un_primer_valor;
    segundo int:=&introduzca_un_segundo_valor;
begin
    dbms_output.put_line(primero);
    dbms_output.put_line(segundo);
end;
-- al escribir hola, en ambas opciones da error e ignora lo introduycido, 
-- ya que es un string en una variable declarada como in


/*2.- Desarrolle un programa que sólo declare variables de tipo int. El programa deberá
leer dos números enteros desde el teclado, posteriormente los sumará, almacenando el
resultado en una variable, y finalmente escribirá por pantalla el resultado de la suma.
Ejecute dicho programa introduciendo como datos de entrada los siguientes números y
analice los resultados obtenidos.
a) -20 y 30.
b) 20 y -30.
c) 147483647 y 2000000000.
d) 200000000 y 2000000000.
e) 1 y 2147483647.
f ) 1 y 3000000000.
*/
set serveroutput on;
declare
    a int:=&Valor_primero;
    b int:=&Valor_segundo;
    suma int;
begin
    suma:=a+b;
    DBMS_OUTPUT.put_line(suma);
end;


/*3.-Desarrolle un programa que lea de teclado una determinada cantidad de euros, calcule y 
escriba su equivalente en pesetas, considerando que 1C son 166.386 pts.
*/
set serveroutput on;
declare
    euros float:=&Euros;
begin
    dbms_output.put_line(euros*166.386);
end;


/*4.-Desarrolle un programa que calcule y escriba la media aritmética de 3 números enteros
leídos de teclado. Compruebe que la media aritmética de los números 3, 5 y 8 es 5.33333.
*/
set serveroutput on;
declare
    a float:=&Valor_1;
    b float:=&Valor_2;
    c float:=&Valor_3;
    media decimal(20,5);
begin
    media:= (a+b+c)/3;
    dbms_output.put_line(media);
end;


/*5.- Desarrolle un programa que lea de teclado una cierta cantidad de segundos y muestre su equivalente 
en semanas, días, horas, minutos y segundos, según el formato de los siguientes ejemplos:
2178585 segundos equivalen a [ 3] semanas, 4 dias, 05:09:45
9127145 segundos equivalen a [ 15] semanas, 0 dias, 15:19:05
*/
set serveroutput on;
declare
    segundos int:=&Numero_de_segundos;
    segundos2 int;
    minutos int;
    minutos2 int;
    horas int;
    horas2 int;
    dias int;
    dias2 int;
    semanas int;

begin
    minutos:=segundos/60;
    segundos2:=mod(segundos,60);
    horas:=minutos/60;
    minutos2:=mod(minutos,60);
    dias:=horas/24;
    horas2:=mod(horas,24);
    semanas:=dias/7;
    dias2:=mod(dias,7);
    
    dbms_output.put_line(semanas||' semanas, '||dias2||' dias, '||horas2||':'||minutos2||':'||segundos2);
end;
--con otras cifras sale bien el resultado, pero con esas dos del ejemplo varia un poco de lo que pone


/*6.-Desarrolle un programa que lea de teclado dos números enteros y los almacene en dos variables de tipo int. 
Posteriormente deberá intercambiar los valores almacenados en dichas variables, y finalmente deberá escribir 
el valor almacenado en cada una de ellas.
*/
set serveroutput on;
declare
    a float:=&Valor_1;
    b float:=&Valor_2;
    c float;
begin
    c:=b;
    b:=a;
    a:=c;
    dbms_output.put_line('Primer valor: '||a);
    dbms_output.put_line('Segundo valor: '||b);
end;

