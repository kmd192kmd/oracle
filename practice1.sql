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

select * from employees;
 
select -- 문제01.sql의 5번까지 함.
    first_name || last_name as "[이름]",
    email as "[이메일]",
    phone_number as "[연락처]",
    salary as "[급여]"
from employees;
 
 
    