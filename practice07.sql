-- practice 07.sql

select * from employees;
select * from locations;
select * from tblMen;
select * from tblWomen;
select * from tblAddressBook;
select distinct(job) from tblAddressBook;

--1번.
select
    *
from employees
where department_id = (select department_id from departments 
    where location_id = (select location_id from locations where city = 'Munich'));
    
--2번.
--select
--    *
--from tblMen
--where couple = (select name from tblWomen); where절로는 두테이블을 합치기가 어렵다.

SELECT 
    name as "[남자]",
    height as "[남자키]",
    weight as "[남자몸무게]", 
    couple as "[여자]",
    (SELECT height FROM tblwomen where tblmen.couple = name) as "[여자키]", 
    (SELECT weight FROM tblwomen where tblmen.couple = name) as "[여자몸무게]" 
FROM tblmen 
    where couple is not null;

--3번.
--select
--    job,
--    count(*),
--    --max(hometown) --가나다(사전순)으로 가장 뒤에 있는 이름을 가져온다...
--    --(select hometown from tblAddressBook group by job having max(count(*))) 중첩이 너무 깊고, having 뒤에는 비교조건이 와야한다.
--from tblAddressBook
--    group by job
--    order by count(*) desc;
    
SELECT
    hometown
FROM (
    SELECT 
        hometown,
        RANK() OVER (ORDER BY count(*) DESC) as rnk
    FROM tblAddressBook
    WHERE job = (
        -- [1단계] 인원수가 가장 많은 직업(1등 반) 찾기
        SELECT job 
        FROM tblAddressBook 
        GROUP BY job 
        HAVING count(*) = (SELECT max(count(*)) FROM tblAddressBook GROUP BY job) --집계합수 중첩은 서브쿼리에서 가능한데, 주로 오라클에서 사용가능하고, MySQL, SQL Server는 불가능하다.
    )
    GROUP BY hometown -- [2단계] 그 반 아이들의 고향별 인원수 세기
)
WHERE rnk = 1; -- [3단계] 그 중 가장 많이 사는 동네 1등만 추출

SELECT 
    * 
FROM (
    SELECT hometown
    FROM tblAddressBook
    WHERE job = (
        -- 1등 직업 찾기
        SELECT job FROM tblAddressBook GROUP BY job 
        HAVING count(*) = (SELECT max(count(*)) FROM tblAddressBook GROUP BY job)
    )
    GROUP BY hometown
    ORDER BY count(*) DESC -- 고향 인원수 많은 순으로 정렬
)
WHERE ROWNUM = 1; -- 가장 위(1등) 동네 딱 하나만!


--4번.
select 
    substr(email, instr(email,'@') + 1), 
    avg(length(substr(email, 1, instr(email,'@') - 1)))
from tbladdressbook
    group by substr(email,instr(email,'@')+1)
        having avg(length(substr(email,1,instr(email,'@')-1))) 
            = (select max(avg(length(substr(email,1,instr(email,'@')-1)))) from tbladdressbook group by substr(email,instr(email,'@')+1));
            
--5번. --순위를 비교하라면 group by having이 필요하다. where절만으로는 부족하다.
select 
    job
from tblAddressBook
    where hometown = (select hometown from tblAddressBook group by hometown 
        having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown))
    group by job
    having count(*) = (select max(count(*)) from tblAddressBook 
        where hometown = (select hometown from tblAddressBook group by hometown 
            having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown)) 
        group by job); 

--6번. --순위비교가 없다면 where절만으로도 해결가능하다.
select
    *
from tblAddressBook
where hometown in ('서울') and age >= (select avg(age) from tblAddressBook where gender = 'm') and job not in('학생', '취업준비생', '백수');

SELECT *
FROM tblAddressBook
WHERE hometown = '서울' 
  AND age >= (SELECT AVG(age) FROM tblAddressBook WHERE gender = 'm')
  AND job IN (
      SELECT job 
      FROM tblAddressBook 
      WHERE job NOT IN ('학생', '취업준비생', '백수')
      GROUP BY job
  );
  
--이 코드는 평균나이가 평균남성나이보다 많은 사람이 하나라도 있는 직업의 모든 사람들을 가져온다.
--select
--    *
--from tblAddressBook
--    where hometown in ('서울') and job in(
--        select job from (
--            select job from tblAddressBook
--            where job not in ('학생', '취업준비생')
--            and age >= (select avg(age) from tblAddressBook where gender = 'm')
--            group by job
--            )
--        )
        
--7번.
select
    count(case
        when age >= 10 and age < 20 then 1
    end) as "10대",
    count(case
        when age >= 20 and age < 30 then 1
    end) as "20대",
    count(case
        when age >= 30 and age < 40 then 1
    end) as "30대",
    count(case
        when age >= 40 and age < 50 then 1
    end) as "40대"
from tblAddressBook
    where email like ('%@gmail.com');
  
--8번.  
select
    *
from tblAddressBook
where job in (
    select
        job
    from tblAddressBook
    where age = (select max(age) from tblAddressBook)
        and weight = (select max(weight) from tblAddressBook where age = (select max(age) from tblAddressBook)) --이 한줄로 끝날거같이 보이지만 이 한줄은 몸무게 1개의 값만을 가져온다!!
    );
    
--9번.
select
    *
from tblAddressBook
where name = (
    select 
        name
    from(
        select
            name
        from tblAddressBook
        group by name
        order by count(*) desc
        )
    where rownum = 1
    );

select 
    *
from tblAddressBook
    where name = (select name from tblAddressBook group by name having count(*) = (select max(count(*)) from tblAddressBook group by name));

--10번.
select
    round(count(case
        when age >= 10 and age < 20 then 2
    end)/count(*)*100,1)||'%' as "[10대]",
    round(count(case
        when age >= 20 and age < 30 then 2
    end)/count(*)*100,1)||'%' as "[20대]",
    round(count(case
        when age >= 30 and age < 40 then 2
    end)/count(*)*100,1)||'%' as "[30대]",
    round(count(case
        when age >= 40 and age < 50 then 2
    end)/count(*)*100,1)||'%' as "[40대]"
from tblAddressBook
where job = (select job from tblAddressBook group by job 
    having count(*) = (select max(count(*)) from tblAddressBook group by job));
