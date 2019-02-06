-- EXERCICIO 1 --------------------------------
create or replace view emp_detail as
    select E.employee_id, CONCAT(E.first_name, CONCAT(' ' ,E.last_name)) as nome, E.email, E.phone_number, E.salary, (select E2.first_name from employees E2 where E2.employee_id = E.manager_id) as MANAGER, J.job_title, D.department_name, L.city, C.country_name from
    employees E 
    inner join jobs J on E.job_id = J.JOB_ID 
    inner join departments D on E.department_id = D.department_id 
    inner join locations L on D.location_id = L.location_id 
    inner join countries C on L.country_id = C.country_id;
    
select * from emp_detail;

-- EXERCICIO 2 --------------------------------
alter table EMPLOYEES
add 
   (
      EXTRA_SALARY  NUMBER(8) ,
      EXTRA_HOURS   NUMBER(4)
   );
   
update employees
set extra_salary=0,
    extra_hours=0;
    
select * from employees;

create or replace procedure act_extra(ident int, hours number) as
    begin
        update employees
        set extra_hours = hours
        where employee_id = ident;
    end;
    
call act_extra(100,777);


create or replace procedure salary_calc(ident int, per decimal) as
    begin
        update employees
        set extra_salary = salary*per*extra_hours
        where employee_id = ident;
    end;
    
call salary_calc(100,0.1);


update 
(select E.extra_hours from employees E
inner join departments D on E.department_id = D.department_id
inner join locations L on D.location_id = L.location_id
where L.city like 'Southlake') t
set t.extra_hours = 190 ;
   
select * from employees;

create or replace procedure act_extra2(per BINARY_FLOAT) as
    begin
        update 
        (select E.extra_hours from employees E
        inner join departments D on E.department_id = D.department_id
        inner join locations L on D.location_id = L.location_id
        where L.city like 'Southlake') t
        set t.extra_hours = t.extra_hours * per ;
    end;
    
call act_extra2(0.05);

-- EXERCICIO 3 --------------------------------
create or replace function getsalary(ident number) return number is new_salary number;
    begin
        new_salary := 0;
        select salary + extra_salary INTO new_salary from employees where employee_id = ident;
        return new_salary;
    end getsalary;
    
select getsalary(100) from dual;
    select * from employees;

create or replace view emp_southlake as
select CONCAT(first_name, CONCAT(' ' ,last_name)) as name, salary, sum(salary,extra_salary) as new_salary from employees E
        inner join departments D on E.department_id = D.department_id
        inner join locations L on D.location_id = L.location_id
        where L.city like 'Southlake';

    select * from emp_southlake;
    
    create or replace view emp_southlake as
select CONCAT(first_name, CONCAT(' ' ,last_name)) as name, salary, getsalary(employee_id) as new_salary from employees E
        inner join departments D on E.department_id = D.department_id
        inner join locations L on D.location_id = L.location_id
        where L.city like 'Southlake';

    select * from emp_southlake;


create or replace view ver_salario as
select employee_id, CONCAT(first_name, CONCAT(' ' ,last_name)) as name, salary, getsalary(employee_id) as new_salary from employees E
        inner join departments D on E.department_id = D.department_id
        inner join locations L on D.location_id = L.location_id
        where getsalary(employee_id) > 200;

select * from ver_salario;

-- EXERCICIO 4 --------------------------------

CREATE TABLE TOTAL_COST 
(
  HOUR_SPENT NUMBER(10, 0) NOT NULL 
, SALARY_SPENT NUMBER(10, 0) NOT NULL 
) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NO INMEMORY 
NOPARALLEL;


Select * from total_cost;

insert into total_cost (hour_spent, salary_spent) select sum(extra_hours), sum(salary) from employees;

select max(employee_id) from employees; -- verificar id do ultimo employee ( = 206)
create sequence employee_sq start with 207 ;

create or replace trigger salary_value after insert or delete or update 
    on employees
    begin
        update total_cost 
        set hour_spent = (select sum(extra_hours) from employees),
        salary_spent = (select sum(salary) from employees);
    end;
    
insert into employees(employee_id, first_name, last_name, email, phone_number,hire_date, job_id, salary, 
commission_pct, manager_id, department_id, extra_salary, extra_hours) 
values (employee_sq.NEXTVAL, 'gil', 'cunha', 'gilcunha@email.com', '123456789', '12-12-2012', 'AD_PRES',10000, NULL, NULL, NULL, NULL, 400);

select * from employees;

update employees
    set salary = 15000
    where employee_id = 40;

update employees
    set salary = 15000
    where employee_id = 140;


delete from employees where salary = (select max(salary) from employees);

