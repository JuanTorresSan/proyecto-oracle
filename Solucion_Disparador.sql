--de la tabla X hacer un backup de ta tbla Y, Exactamente cada que se guarden 3 nregistros , el 4to debe ocacoinar que los 3 se borren de la tabla X y se inserten en la tabla Y 
create table papa(id integer primary key,nombre varchar2(40),edad integer);
create table hijomayor(id integer primary key, nombre varchar2(40), edad integer);
create table hijomenor(id integer primary key, nombre varchar2(40),edad integer);


create or replace trigger disp_papa after insert on papa for each row 
begin
if : new.edad > 18 then
insert into hijomayor values(:new.id, :new.nombre, :new.edad);
else
insert into hijomenor values(:new.id, :new.nombre, :new.edad);
end if;
end;
/


--hacemos un select en papa
select * from papa;
select * from hijomayor;
select * from hijomenor;


create table trabajador(id integer primary key, nombre varchar2(20), sueldo_base float);
create table respaldo(id integer primary key, nombre varchar2(20), sueldo_base float);

insert into trabajador values(1,'izzra',24);
insert into trabajador values(2,'Dani',17);
insert into trabajador values(3,'Mary',21);

insert into trabajador values(4,'Riven',16);
insert into trabajador values(5,'Sivir',19);
insert into trabajador values(6,'Vanessa',22);

CREATE OR REPLACE PROCEDURE CONTAR(NUMERO OUT INTEGER)
AS
BEGIN
SELECT COUNT(*) INTO NUMERO FROM trabajador;

DBMS_OUTPUT.PUT_LINE('ENCONTRADOS  '||NUMERO);
END;
/

DECLARE 
VALOR INTEGER;
BEGIN
CONTAR(VALOR);
END;
/

-- EL QUE COPIA
CREATE OR REPLACE PROCEDURE COPIAR 
AS
CURSOR CUR_trabajador IS SELECT * FROM trabajador;
BEGIN
FOR REC IN CUR_trabajador LOOP
INSERT INTO respaldo VALUES(REC.id, REC.NOMBRE, REC.sueldo_base);
END LOOP;
END;
/

CREATE OR REPLACE TRIGGER DISP_trabajador BEFORE INSERT ON trabajador FOR EACH ROW
DECLARE
VALOR INTEGER;
BEGIN
CONTAR(VALOR);
IF  VALOR = 3 THEN
COPIAR();
DELETE FROM trabajador;
END IF;
END;
/


SELECT * FROM trabajador;
SELECT * FROM respaldo;
