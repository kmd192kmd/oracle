-- practice08.sql

select * from tblVideo;
select * from tblRent;
select * from tblMember;
select * from tblStaff;
select * from tblProject;
select * from tblCustomer;
select * from tblSales;

--1번. 
select
    s.name,
    s.address,
    s.salary,
    p.project
from tblStaff s
    join tblProject p
        on s.seq = p.staff_seq;

--2번.
select
    distinct(m.name) --한명이 여러번 대여시 이름이 여러개 나오게 된다.
from tblMember m
    join tblRent r
        on r.member = m.seq
            join tblVideo v
                on v.seq = r.video
where v.name = '뽀뽀할까요';

--3번.
select
    s.salary
from tblStaff s
    join tblProject p
        on s.seq = p.staff_seq
where p.project = 'TV 광고';

--4번.
select
    distinct(m.name)
from tblMember m
    join tblRent r
        on r.member = m.seq
            join tblVideo v
                on v.seq =r.video
where v.name = '털미네이터' and r.rentdate is not null;

--5번.
select
    s.name,
    s.salary,
    p.project
from tblStaff s
    join tblProject p
        on s.seq = p.staff_seq
where address not like('서울%')
order by s.name asc;

--6번.
select
    c.tel,
    c.name,
    s.item,
    s.qty
from tblCustomer c
    join tblSales s
        on c.seq = s.cseq
where s.qty >= 2;

--7번.
select
    v.name,
    v.qty,
    g.price
from tblVideo v
        join tblGenre g
            on v.genre = g.seq;
                
--8번.
select
    m.name,
    v.name,
    r.rentdate,
    g.price
from tblMember m
    join tblRent r
        on m.seq = r.member
            join tblVideo v
                on v.seq = r.video
                    join tblGenre g
                        on g.seq = v.genre
where r.rentdate >= to_date('2007-02-01', 'yyyy-mm-dd')
order by m.name asc;

--9번.
select * from tblVideo;
select * from tblRent;
select * from tblGenre;

select
    m.name,
    v.name,
    r.rentdate
from tblMember m
    join tblRent r
        on m.seq = r.member
            join tblVideo v
                on v.seq = r.video
where r.retdate is null;

--10번.
select * from employees;
select * from departments;
select * from jobs;

select
    e.last_name || ' ' || e.first_name as 사원이름,
    e.department_id as 부서번호,
    d.department_name as 부서이름
from employees e
    join departments d
        on e.department_id = d.department_id;
        
--11번.
select
    e.*,
    j.job_title
from employees e
    join jobs j
        on e.job_id = j.job_id;

--12번.
select
    e.*
from employees e
    join jobs j
        on e.job_id = j.job_id
where e.salary = j.max_salary;

--13번.
select
    d.*,
    l.street_address
from departments d
    join locations l
        on d.location_id = l.location_id;
        
--14번.
select
    c.country_name
from countries c
    join locations l
        on c.country_id = l.country_id
where location_id = 2900;
        
--15번.
select
    e.last_name || ' ' || e.first_name as 사원이름,
    e.salary as 급여,
    e.department_id as 부서번호
from employees e
where e.department_id in (select department_id from employees where salary >= 12000)
order by e.salary desc;

--16번.
select
    e.last_name || ' ' || e.first_name as 사원이름,
    j.job_title,
    e.department_id,
    d.department_name
from employees e
    join departments d
        on e.department_id = d.department_id
            join locations l
                on l.location_id = d.location_id
                    join jobs j
                        on j.job_id = e.job_id
where l.city = 'Seattle';

--17번.
select
    e.*
from employees e
    join departments d
        on e.department_id = d.department_id
where e.department_id = (select department_id from employees where first_name = 'Jonathon');

--18번.
select
    e.last_name || ' ' || e.first_name as 사원이름,
    d.department_name,
    e.salary
from employees e
    join departments d
        on e.department_id = d.department_id
where e.salary >= 3000;

--19번.
select
    e.department_id,
    d.department_name,
    e.last_name || ' ' || e.first_name as 사원이름,
    e.salary
from employees e
    join departments d
        on e.department_id = d.department_id
where e.department_id = 10;

--20번.
select 
    h.start_date,
    h.end_date,
    d.department_name
from job_history h
    join departments d
        on h.department_id = d.department_id;
        
--21번.
select
    e.employee_id as 사원번호,
    e.last_name || ' ' || e.first_name as 사원이름,
    e.manager_id as 관리자번호,
    (select last_name || ' ' || first_name from employees where employee_id = e.manager_id) as 관리자이름
from employees e;

--22번.
select
    to_char(e.hire_date, 'yyyy')||'년도' as 입사년도,
    avg(e.salary) as 평균급여
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by to_char(e.hire_date, 'yyyy') --group by hire_date는 날짜만 달라도 다른 그룹으로 인식된다.
order by to_char(hire_date, 'yyyy') asc;

--23번.
select
    l.city,
    round(avg(salary)),
    count(*)
from employees e
    join departments d
        on e.department_id = d.department_id
            join locations l
                on l.location_id = d.location_id
group by l.city
having count(*) < 10
order by avg(salary) asc;

--24번.

select * from departments;
select * from locations;
select * from countries;
select * from employees;
select * from jobs;
select * from job_history;

select
    e.employee_id,
    e.last_name || ' ' || e.first_name as 사원이름
from employees e
    join jobs j
        on e.job_id = j.job_id
--            join job_history h --아래 where절의 서브쿼리와 중복된다.
--                on h.employee_id = e.employee_id
where j.job_title != 'Public Accountant' and e.employee_id in (select employee_id from job_history where job_id = (select job_id from jobs where job_title = 'Public Accountant'));

--25번.
select
    e.first_name,
    e.last_name,
    d.department_name,
    l.location_id,
    l.city
from employees e
    join departments d
        on e.department_id = d.department_id
            join locations l
                on l.location_id = d.location_id
where e.commission_pct is not null;

--26번.
--select
--    e.first_name,
--    e.last_name,
--    e.hire_date,
--    (select hire_date from employees where employee_id = e.manager_id) as 매니저고용일
--from employees e
--where hire_date < (select hire_date from employees where employee_id = e.manager_id);

select
    e.first_name,
    e.last_name,
    e.hire_date,
    e2.hire_date
from employees e
    join employees e2
        on e.manager_id = e2.employee_id
where e.hire_date < e2.hire_date;
    