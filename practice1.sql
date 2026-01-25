-- practice1.sql

select * from tblCountry;

select name, capital from tblCountry;

select
    name as "[국가명]",
    capital as "[수도명]",
    population as "[인구수]",
    area as "[면적]",
    continent as "[대륙]"
from tblCountry;

select
    ('국가명: ' || name || ', 수도명: ' || capital || ', 인구수: ' || population) as "[국가정보]"
from tblCountry;

select * from tblCountry;
 
select -- 문제01.sql의 5번까지 함.
    first_name || ' ' || last_name as "[이름]",
    email || '@gmail.com' as "[이메일]",
    phone_number as "[연락처]",
    '$' || salary as "[급여]"
from employees;

select
    name, area
from tblCountry
    where area <= 100;

select
    *
from tblCountry
    where continent in ('AS', 'EU');
    
select * from employees;    

select
    last_name || first_name, phone_number
from employees
    where job_id = 'IT_PROG';
    
select
    first_name, phone_number, hire_date
from employees
    where last_name = 'Grant';
    
select
    first_name, salary, phone_number
from employees
    where manager_id = 120;

select
    first_name, phone_number, email, department_id
from employees
    where department_id in ('60', '80', '100');

select * from tblInsa;

select
    *
from tblInsa
    where buseo = '기획부';

select
    name, jikwi, tel
from tblInsa
    where jikwi = '부장';

select
    *
from tblInsa
    where basicpay + sudang >= 1500000 and city = '서울';

select
    *
from tblInsa
    where sudang <= 150000 and jikwi in('사원', '대리');
    
select
    *
from tblInsa
    where basicpay*12 > 20000000 and jikwi in('과장', '부장') and city = '서울';

select * from tblCountry;

select
    *
from tblCountry
    where name like '_국';

select
    *
from employees
    where phone_number like '515%';

select
    *
from employees
    where job_id like 'SA%';
    
select
    *
from employees
    where first_name like '%de%';
    
select * from tblInsa;  
    
select
    *
from tblInsa
    where ssn like '%-1%';
    
select
    *
from tblInsa
    where ssn like '%-2%';
    
select
    *
from tblInsa
    where ssn like '__07%' or ssn like '__08%' or ssn like '__09%';
    
select
    *
from tblInsa
    where city in ('서울', '인천') and name like '김__';
    
select
    *
from tblInsa
    where jikwi in ('사원', '대리') and tel like '010%';
    
select
    *
from tblInsa
    where city in ('서울', '인천', '경기') and ibsadate between '2008-01-01' and '2010-12-31';
    
select
    *
from employees
    where department_id is null;
    