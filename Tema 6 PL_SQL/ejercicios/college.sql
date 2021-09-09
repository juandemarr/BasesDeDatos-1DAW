-- CreaciÃ³n de las tablas

CREATE TABLE college (
  cname VARCHAR2(15),
  state NVARCHAR2(2),
  enrollment NUMBER,
  PRIMARY KEY (cname)
);

CREATE TABLE student (
  sid NUMBER,
  sname NVARCHAR2(15),
  gpa NUMBER(2,1),
  sizehs NUMBER,
  PRIMARY KEY (sid)
);

CREATE TABLE apply (
  sid NUMBER,
  cname NVARCHAR2(15),
  major NVARCHAR2(20),
  decision CHAR(1),
  PRIMARY KEY (sid,cname,major)
);

-- InserciÃ³n de datos

INSERT INTO college VALUES ('Stanford','CA',15000);
INSERT INTO college VALUES ('Berkeley','CA',36000);
INSERT INTO college VALUES ('MIT','MA',10000);
INSERT INTO college VALUES ('Cornell','NY',21000);

INSERT INTO student VALUES (123,'Amy',3.9,1000);
INSERT INTO student VALUES (234,'Bob',3.6,1500);
INSERT INTO student VALUES (345,'Craig',3.5,500);
INSERT INTO student VALUES (456,'Doris',3.9,1000);
INSERT INTO student VALUES (567,'Edward',2.6,2000);
INSERT INTO student VALUES (678,'Fay',3.8,200);
INSERT INTO student VALUES (789,'Gary',3.4,800);
INSERT INTO student VALUES (987,'Helen',3.6,800);
INSERT INTO student VALUES (876,'Irene',3.9,400);
INSERT INTO student VALUES (765,'Jay',2.9,1500);
INSERT INTO student VALUES (654,'Amy',3.9,1000);
INSERT INTO student VALUES (543,'Craig',3.4,2000);

INSERT INTO apply VALUES (123,'Stanford','CS','Y');
INSERT INTO apply VALUES (123,'Stanford','EE','N');
INSERT INTO apply VALUES (123,'Berkeley','CS','Y');
INSERT INTO apply VALUES (123,'Cornell','EE','Y');
INSERT INTO apply VALUES (234,'Berkeley','biology','N');
INSERT INTO apply VALUES (345,'MIT','bioengineering','Y');
INSERT INTO apply VALUES (345,'Cornell','bioengineering','N');
INSERT INTO apply VALUES (345,'Cornell','CS','Y');
INSERT INTO apply VALUES (345,'Cornell','EE','N');
INSERT INTO apply VALUES (678,'Stanford','history','Y');
INSERT INTO apply VALUES (987,'Stanford','CS','Y');
INSERT INTO apply VALUES (987,'Berkeley','CS','Y');
INSERT INTO apply VALUES (876,'Stanford','CS','Y');
INSERT INTO apply VALUES (876,'MIT','biology','Y');
INSERT INTO apply VALUES (876,'MIT','marine biology','N');
INSERT INTO apply VALUES (765,'Stanford','history','Y');
INSERT INTO apply VALUES (765,'Cornell','history','N');
INSERT INTO apply VALUES (765,'Cornell','psychology','Y');
INSERT INTO apply VALUES (543,'MIT','CS','N');

SELECT * FROM college;
SELECT * FROM student;
SELECT * FROM apply;


--TRIGGERS

--TRIGGER R1
--realizar un trigger sobre la tabla student y cada vez que se inserta 
--un nuevo estudiante, si su nota de gpa(selectividad) esta entre el 3,3 y el 3,6
--entonces directamente se hace su prescripción en geologia en Standford
--y en biología en Mit

select * from apply;

create or replace trigger tr_r1
after insert on student
for each row
when (new.gpa>=3.3 and new.gpa<=3.6)--este new no lleva dos puntos porque es antes de entrar en el trigger, entonces se hace sin los dos puntos
begin
    insert into apply values (:new.sid,'Standford','Geology',null);
    insert into apply values(:new.sid,'MIT','Biology',null);
end;


select * from student;
select * from apply;

insert into student values (111,'Ana',3.5,1000);
insert into student values (222,'Pepe',2.0,1000);


--TRIGGER R2 (al no tener on delete cascade ni fk)
--Cuando borremos un estudiante se borren las peticiones de dicho estudiante

create or replace trigger tr_r2
after delete on student 
for each row 
begin 
    delete from apply where sid=:old.sid --aqui es old porque cogemos el valor antiguo sid de la tabla student, que es en donde haremos el delete. Esto lo cogera y lo comparar con el sid de apply, si coincide lo borrara en la tabla apply
end;


delete from student where sid=111;


--TRIGGER R3 que cuando actualicemos el nombre de una 
--universidad se actualice tambien en la tabla apply

create or replace trigger tr_r3
after update of cname on college --el of es para que se actualice un determinado campo. Solo se puede con update
for each row
begin
    update apply set cname = :new.cname where cname = :old.cname;
end;

update college set cname='UGR' where cname = 'Standford';