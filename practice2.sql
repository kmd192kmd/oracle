practice2

select * from tblInsa;

select distinct job_id from employees;

select distinct department_id from employees where hire_date between '2002-01-01' and '2004-12-31';

select distinct manager_id from employees where salary >= 5000;

select distinct jikwi from tblInsa where ssn like '8%';

select distinct city from tblInsa where sudang >= 200000;

select distinct buseo from tblInsa where tel is null;

practice3

select
    first_name || last_name as fullname,
    length(first_name) + length(last_name) as length
from employees
    order by 2 desc;

select
    max(length(first_name) + length(last_name)),
    min(length(first_name) + length(last_name)),
    round(avg(length(first_name) + length(last_name)))
from employees;

select
    first_name
from employees
    where length(last_name) = 4
        order by 1;
        
practice4
select * from employees;
select * from tblCountry;
select * from tblInsa;
select count(*) from tblCountry where continent in ('AS', 'EU');

select count(*) from tblCountry where population between 7000 and 20000;

select count(*) from employees where job_id = 'IT_PROG' and salary >= 5000;

select count(*) from tblInsa where tel not like '010%';

select count(*) from tblInsa where city in ('서울', '경기', '인천');

select count(*) from tblInsa where ssn like '%-2%' and (ssn like '__07%' or ssn like '__08%' or ssn like '__09%');

select
    count(case
        when jikwi = '부장' then 1
    end) as 부장,
    count(case
        when jikwi = '과장' then 1
    end) as 과장,
    count(case
        when jikwi = '대리' then 1
    end) as 대리,
    count(case
        when jikwi = '사원' then 1
    end) as 사원
from tblInsa
    where buseo = '개발부';
    
select sum(population) from tblCountry;

select sum(salary) from employees where manager_id is not null;

select sum(salary) from employees where job_id in ('ST_CLERK', 'SH_CLERK');

select sum(basicpay + sudang) from tblInsa where city = '서울';
    
select sum(basicpay) from tblInsa where jikwi in ('부장', '과장');

select avg(population) from tblCountry where continent = 'AS';

select avg(salary) from employees where first_name like '%AN%' or first_name like '%an%' or first_name like '%An%' or first_name like '%aN%';

select avg(basicpay) from tblInsa where jikwi in ('부장', '과장');

select avg(basicpay) from tblInsa where jikwi in ('대리', '사원');

select max(area) from tblCountry;

select min(basicpay+sudang) from tblInsa;

practice5

select
    count(decode(jikwi, '부장', 1)) + count(decode(jikwi, '과장', 1)) as 간부,
    count(decode(jikwi, '대리', 1)) + count(decode(jikwi, '사원', 1)) as 사원
from tblInsa;

select
    count(decode(jikwi, '부장', 1, '과장', 1)),
    count(decode(jikwi, '사원', 1, '대리', 1))
from tblInsa;



select
    round(avg(decode(buseo, '기획부', basicpay))) as 기획부,
    round(avg(decode(buseo, '영업부', basicpay))) as 영업부,
    round(avg(decode(buseo, '총무부', basicpay))) as 총무부,
    round(avg(decode(buseo, '개발부', basicpay))) as 개발부
from tblInsa;

select
    '19' || min(decode(substr(ssn,8,1),'1',substr(ssn,1,2))),
    '19' || max(decode(substr(ssn,8,1),'2',substr(ssn,1,2)))
from tblInsa;

select * from tblInsa;


