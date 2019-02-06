create tablespace aebd_project
datafile '\u01\app\oracle\oradata\orcl12\orcl\aebd_project_01.dbf'
size 100M;

create temporary tablespace aebd_project_temp
tempfile '\u01\app\oracle\oradata\orcl12\orcl\aebd_project_temp.dbf'
size 50M
autoextend on;

select * from dba_tablespaces;

alter session set "_ORACLE_SCRIPT"=true;

create user USER
identified by 1234
default tablespace aebd_project
temporary tablespace aebd_project_temp
quota 10M on aebd_project
account unlock;

grant connect to USER;

grant create table, create view, create trigger to USER;

grant drop any table to USER;

grant create sequence to USER;

grant create trigger to USER;