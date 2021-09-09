-- 1. Buscar en la documentación en línea y en bd el contenido de las vistas:
-- dba_profiles // muestra todos los perfiles del servidor, el nombre del recurso al que hace referencia, si el recurso del perfil es un parametro de tipo kernel o contraseña y el limite del perfil
select * from dba_profiles;

-- files dba_roles // muestra todos los roles existentes en el servidor, si requieren de contraseña y qué tipo de contraseña
select * from dba_roles;

-- dba_users // muestra todos los usuarios creados en el servidor, su id, la contraseña encriptada, el estado de la cuenta, fecha de la cuenta desde su bloqueo (si lo está), fecha de expiración de la cuenta, espacio por defecto de memoria en la que se encuentra, espacio en memoria temporal, fecha de creación, nombre del perfil que ofrece los recursos, grupo inicial que aporta los recursos,       
select * from dba_users;

-- dba_role_privs // muestra los usuarios o grupos que recibe los permisos, el nombre del rol concedido, si tiene la opcion del administrador y y si el rol está por defecto 
select * from dba_role_privs;

-- dba_tab_privs // muestra el nombre del usuario que tiene el acceso garantizado, el propietario del objeto, nombre del objeto, nombre del usuario que otorga el permiso, nombre del privilegio, si fue concecido con GRANT y si el privilegio fue concedido de forma jerárquica
select * from dba_tab_privs;

-- dba_sys_privs // muestra el nombre del usuario o rol que recibe el permiso, el nombre del privilegio y si el permiso fue concedido con la opción de ADMIN
select * from dba_sys_privs;

-- para que diga qué usuario está actualmente activo
select user from dual;
show user;

-- CREATE TABLESPACE
CREATE TABLESPACE tab_factura
DATAFILE 'C:\oraclexe\taplespace\tablespace_facturas.dat' SIZE 100M
DEFAULT STORAGE( INITIAL 100K NEXT 100K )
ONLINE
PERMANENT;

-- 2. Conectarse como usuario SYSTEM a la base y crear un usuario llamado “administrador” autentificado por la base de datos.
-- Indicar como "tablespace" por defecto USERS y como "tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace" USERS.
create user administrador3 identified by hola 
    DEFAULT TABLESPACE users 
    TEMPORARY TABLESPACE temp
    quota 500K on users;
-- drop user administrador3;

-- 3. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene concedidos el usuario “administrador”.
select * from dba_sys_privs where grantee ='ADMINISTRADOR3'; -- el usuario va escrito en mayuscula

-- 4. Otorgar el privilegio “CREATE SESSION” al usuario “administrador” e intentar de nuevo la conexión.
grant create session to administrador3;

-- 5. Conectarse como usuario “administrador” y crear un usuario llamado “prueba00” que tenga como "tablespace" por defecto USERS
-- y como "tablespace" temporal TEMP; asignar una cuota de 0K en el "tablespace" USERS. ¿Es posible hacerlo?.
connect administrador3; -- conecta y desconecta
create user prueba00 identified by prueba00 default tablespace users temporary tablespace temp quota 0k on users; -- error privilegios insuficientes

-- 6. Conectado como usuario SYSTEM, otorgar el privilegio “create user” al usuario “administrador” y repetir el ejercicio anterior.
grant create user to administrador3;

-- 7. Averiguar que usuarios de la base de datos tienen asignado el privilegio “create user” de forma directa, ¿qué vista debe ser
-- consultada?.
select grantee from dba_sys_privs where privilege = 'CREATE USER';

-- 8. Hacer lo mismo para el privilegio “create session”.


-- 9.Crear dos "tablespace" llamados NOMINA y ACADEMO, que contendrán datos relativos a las aplicaciones de nomina y datos académicos de
-- los empleados de una empresa, según las siguientes características:
-- Consulte la ayuda en línea si no recuerda la sintaxis exacta de la sentencia.


-- 10.Crear dos "tablespace" temporales, manejados de forma local, llamados TEMP_NOMINA y TEMP_ACADEMO con las siguientes características:

-- 11.Estando conectado como usuario “administrador” probar a crear un rol llamado “administrador”, ¿qué ocurre?.
-- 12.Idem estando conectado como usuario SYSTEM, ¿qué sucede?, ¿por qué?.
-- 13.Comprobar en el diccionario de datos los usuarios o roles que poseen el privilegio “CREATE ROLE”.
-- 14.Crear un rol llamado “ADMIN”, asignarle los privilegios “create session”, “create user” y “CREATE ROLE”. Asignarlo al usuario
-- administrador.


--15.Consultar los privilegios de sistema que tiene asignados de forma directa el usuario “administrador”, revocarlos y asignarle el rol
-- “admin.”.


-- 16.Crear, conectado como SYSTEM, un usuario llamado “prueba01” autenticado por base de datos al que no se le asigne
-- "tablespace" por defecto ni temporal.


-- 17.Consultar en las vistas correspondientes los "tablespaces" y la quota en cada uno de ellos que tiene los usuarios SYS, SYSTEM,
-- “administrador”, “prueba00” y “prueba01”. ¿Qué ha ocurrido con el usuario “prueba01”?.


-- 18.Crear un usuario llamado “prueba02” autenticado por base de datos, asignando como "tablespace" por defecto NOMINA y como "tablespace"
-- temporal TEMP_NOMINA (no se le asignara cuota en NOMINA).


-- 19.Asignar al usuario “prueba01” los "tablespace" ACADEMO y TEMP_ACADEMO como "tablespace" de trabajo y temporal
-- respectivamente (sin especificar cuota).


-- 20.Consultar en las vistas correspondientes los "tablespace" y la cuota en cada uno de ellos que tiene los usuarios “prueba01” y
-- “prueba02”.


-- 21.Crear un rol llamado “CONEXIÓN” y asignarle el permiso “CREATE SESSION”.


--22.Asignar el rol “CONEXIÓN” a los usuarios “prueba00”, “prueba01” y “prueba02”.


-- 23.Comprobar en la vista correspondiente cuales son los roles asignados a los usuarios “prueba00”, “prueba01” y “prueba02”.


-- 24.Conectarse como usuario “prueba01” y crear la tabla siguiente en el "tablespace" ACADEMO:
CREATE TABLE CODIGOS
(CODIGO
varchar2(3),
DESCRIPCION
varchar2(20))
TABLESPACE
ACADEMO
STORAGE
(INITIAL 64K
NEXT
64K
MINEXT
ENTS 5
MAXEXTENTS 10);
-- ¿Es posible hacerlo?, ¿falta algún permiso?.


