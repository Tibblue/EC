--TABLESPACE TP_AEBD
CREATE TABLESPACE TP_AEBD 
    DATAFILE 
        '\u01\app\oracle\oradata\orcl12\orcl\TP_AEBD_01.DBF' SIZE 104857600;

--TABLESPACE TP_TEMP   
CREATE TEMPORARY TABLESPACE TP_TEMP 
    TEMPFILE 
        '\u01\app\oracle\oradata\orcl12\orcl\TP_TEMPORARY_01.DBF' SIZE 52428800 AUTOEXTEND ON NEXT 104857600 MAXSIZE 34359721984 
    EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1048576;

--USER grupo2
CREATE USER grupo2 IDENTIFIED BY pass  
DEFAULT TABLESPACE TP_AEBD
TEMPORARY TABLESPACE TP_TEMP
PASSWORD EXPIRE ;

ALTER USER grupo2 QUOTA UNLIMITED ON TP_AEBD;

-- GRANTS to grupo2
GRANT "DBA" TO grupo2 ;

GRANT CREATE SESSION TO grupo2 ;
GRANT CREATE TABLE TO grupo2 ;

-- TEST CONNECTION
connect grupo2/pass;

show user;

-- TABLE DROPS
--DROP TABLE Memory PURGE;
--DROP TABLE CPU PURGE;
--DROP TABLE Datafile PURGE;
--DROP table UsersDB cascade constraints;
--DROP TABLE Role cascade constraints;
--DROP TABLE role_user cascade constraints;
--DROP TABLE Tablespace PURGE;
--DROP TABLE DB PURGE; 


-- MODELO FISICO
CREATE TABLE db(
    id_db number(30) NOT NULL,
    id_db_root number(30) NOT NULL,
    name varchar(200) NOT NULL,
    platform varchar(20) NOT NULL,
    data_storage number(20) NOT NULL,
    number_sessions number(20) NOT NULL,
    db_timestamp varchar(50) NOT NULL,
    CONSTRAINT id_db PRIMARY KEY (id_db)
    );
    
CREATE TABLE memory(
    id_mem          NUMBER(30) NOT NULL,
    total_size_mb   NUMBER(30),
    free_size_mb    NUMBER(30),
    used_size_mb    NUMBER(30),
    mem_timestamp   varchar(50),
    id_db_FK        NUMBER(30) NOT NULL,
    CONSTRAINT id_mem PRIMARY KEY (id_mem),
    CONSTRAINT id_db_memory
        FOREIGN KEY (id_db_FK)
        REFERENCES db(id_db)
    );
    
CREATE TABLE cpu(
    id_cpu number(30) NOT NULL,
    cpu_count number(20) NOT NULL,
    db_version varchar(70) NOT NULL,
    cpu_core_count number(20) NOT NULL,
    cpu_socket_count number(20) NOT NULL,
    cpu_timestamp varchar(50) NOT NULL,
    id_db_FK number(30) NOT NULL,
    CONSTRAINT id_cpu PRIMARY KEY (id_cpu),
    CONSTRAINT id_db_cpu
        FOREIGN KEY (id_db_FK)
        REFERENCES db(id_db)
    );

CREATE TABLE usersDB(
    id_user number(30) NOT NULL,
    username varchar(70) NOT NULL,
    account_status varchar(70) NOT NULL,
    default_ts varchar(70) NOT NULL,
    temp_ts varchar(70) NOT NULL,
    last_login varchar(200) NOT NULL, 
    user_timestamp varchar(50) NOT NULL,
    id_db_FK number(30) NOT NULL,
    CONSTRAINT id_user PRIMARY KEY (id_user),
    CONSTRAINT id_db_users
        FOREIGN KEY (id_db_FK)
        REFERENCES db(id_db)
    );


CREATE TABLE role(
    id_role number(30) NOT NULL,
    name varchar(70) NOT NULL,
    CONSTRAINT id_role PRIMARY KEY (id_role)
    );


CREATE TABLE role_user(
    user_id_user   NUMBER(30) NOT NULL,
    role_id_role   NUMBER(30) NOT NULL,
    timestamp      VARCHAR2(50),
    CONSTRAINT role_user_user_fk 
        FOREIGN KEY ( user_id_user )
        REFERENCES usersdb ( id_user ),
    CONSTRAINT role_user_role_fk 
        FOREIGN KEY ( role_id_role )
        REFERENCES role ( id_role )
    );



CREATE TABLE tablespace(
    id_tablespace number(30) NOT NULL,
    name varchar(100) NOT NULL,
    block_size number(20) NOT NULL,
    max_size number(20) NOT NULL,
    status varchar(20) NOT NULL,
    contents varchar(30) NOT NULL,
    initial_extent number(20) NOT NULL,
    ts_timestamp varchar(50) NOT NULL,
    id_db_FK number(30) NOT NULL,
    CONSTRAINT id_tablespace PRIMARY KEY (id_tablespace),
    CONSTRAINT id_db_tablespace
        FOREIGN KEY (id_db_FK)
        REFERENCES db(id_db)
    );


CREATE TABLE datafile(
    id_datafile number(30) NOT NULL,
    name varchar(150) NOT NULL,
    bytes number(20) NOT NULL,
    id_tablespace_FK numeric(20) NOT NULL,
    df_timestamp varchar(50) NOT NULL,
    CONSTRAINT id_datafile PRIMARY KEY (id_datafile),
    CONSTRAINT id_tablespace_datafile
        FOREIGN KEY (id_tablespace_FK)
        REFERENCES tablespace(id_tablespace)
    );


--SEQUENCE DROPS
--DROP sequence db_seq;
--DROP sequence memory_seq;
--DROP sequence cpu_seq;
--DROP sequence usersdb_seq;
--DROP sequence role_seq;
--DROP sequence tablespace_seq;
--DROP sequence datafile_seq;

--SEQUENCES
CREATE sequence db_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence memory_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence cpu_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence usersdb_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence role_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence tablespace_seq start with 1 increment by 1 nomaxvalue;
CREATE sequence datafile_seq start with 1 increment by 1 nomaxvalue;


-- TRIGGERS
CREATE OR REPLACE TRIGGER db_trigger
BEFORE INSERT ON db
FOR EACH ROW
 WHEN (new.id_db IS NULL) 
BEGIN
  SELECT  db_seq.nextval
  INTO :new.id_db
  FROM dual;
END;
/

CREATE OR REPLACE TRIGGER memory_trigger
BEFORE INSERT ON memory
FOR EACH ROW
 WHEN (new.id_mem IS NULL) 
BEGIN
  SELECT  memory_seq.nextval
  INTO :new.id_mem
  FROM dual;
END;
/


CREATE OR REPLACE TRIGGER cpu_trigger
BEFORE INSERT ON cpu
FOR EACH ROW
 WHEN (new.id_cpu IS NULL) 
BEGIN
  SELECT  cpu_seq.nextval
  INTO :new.id_cpu
  FROM dual;
END;
/
        

CREATE OR REPLACE TRIGGER usersDB_trigger
BEFORE INSERT ON usersDB
FOR EACH ROW
 WHEN (new.id_user IS NULL) 
BEGIN
  SELECT  usersDB_seq.nextval
  INTO :new.id_user
  FROM dual;
END;
/


CREATE OR REPLACE TRIGGER role_trigger
BEFORE INSERT ON role
FOR EACH ROW
 WHEN (new.id_role IS NULL) 
BEGIN
  SELECT  role_seq.nextval
  INTO :new.id_role
  FROM dual;
END;
/  
        

CREATE OR REPLACE TRIGGER tablespace_trigger
BEFORE INSERT ON tablespace
FOR EACH ROW
 WHEN (new.id_tablespace IS NULL) 
BEGIN
  SELECT  tablespace_seq.nextval
  INTO :new.id_tablespace
  FROM dual;
END;
/  
        

CREATE OR REPLACE TRIGGER datafile_trigger
BEFORE INSERT ON datafile
FOR EACH ROW
 WHEN (new.id_datafile IS NULL) 
BEGIN
  SELECT  datafile_seq.nextval
  INTO :new.id_datafile
  FROM dual;
END;
/         