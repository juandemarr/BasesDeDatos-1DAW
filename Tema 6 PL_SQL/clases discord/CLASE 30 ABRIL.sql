-- Creación de las tablas

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

-- Inserción de datos

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

-- TRIGGER R1 
-- Realizar un trigger sobre la tabla student de cada que se inserta un
-- nuevo estudiante si su nota de GPA está entre el 3.3 y el 3.6
-- entonces directamente se hace su preinscripción e Geología en Stanford
-- y en biología en Mit

/*El alcance de los disparadores puede ser la fila o de orden. 
 El modificador FOR EACH ROW 
indica que el trigger se disparará cada vez que se realizan operaciones 
sobre cada fila de la tabla. Si 
se acompaña del modificador WHEN, se establece una  restricción; 
el trigger solo actuará, sobre las 
filas que satisfagan la restricción. */

select * from apply;

CREATE OR REPLACE TRIGGER TR_R1
AFTER INSERT ON student
FOR EACH ROW
WHEN (NEW.GPA>=3.3 AND NEW.GPA<=3.6)
BEGIN
    INSERT INTO apply values(:new.sid,'Stanford','Geology',null);
    INSERT INTO apply values(:new.sid,'MIT','Biology',null);
END;

select * from student;
select * from apply;

insert into student values(111,'Ana',3.5,1000);
insert into student values(222,'Pepe',2.0,1000);

-- TRIGGER R2 que cuando borremos un estudiante 
-- se borrren las peticiones de dicho estudiante.

CREATE OR REPLACE TRIGGER TR_R2
AFTER DELETE ON STUDENT
FOR EACH ROW
BEGIN
    DELETE FROM APPLY WHERE sid=:old.sid;
end;
DELETE from STUDENT where sid=111;

-- TRIGGER R3 que cuando actulicemos el nombre de un universidad 
-- se actualice en la tabla apply.

select * from apply;
SELECT * FROM COLLEGE;


CREATE OR REPLACE TRIGGER TR_R3
AFTER UPDATE OF cName ON COLLEGE
FOR EACH ROW
BEGIN
    UPDATE apply set cName=:new.cname where cName=:OLD.cname;
end;

update college set cname='UGR' where cname='Stanford';