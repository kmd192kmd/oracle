-- ex17_groupby.sql

/*

    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    
    SELECT column_list  -- 원하는 컬럼을 지정 > 해당 컬럼만 가져와라
    FROM table_name     -- 데이터소스. 어떤 테이블로부터 데이터를 가져와라
    WHERE search_condition -- 행 조건 지정 > 원하는 행만 가져와라
    GROUP BY group_by_expression -- 그룹을 나눈다.
    ORDER BY order_expression [ASC|DESC] -- 레코드 정렬 > 정렬 기준(컬럼)
    
    각 절의 순서(********************************************************)
    4. SELECT
    1. FROM
    2. WHERE
    3. GROUP BY
    5. ORDER BY
    
    group by 절
    - 특정 기준(컬럼값)으로 레코드들을 그룹을 나눈다.(수단)
        > 각각의 그룹을 대상으로 집계 함수를 실행한다.(목적)
    
*/
select * from tblInsa;

--tblInsa. 직위별 평균 급여?
select round(avg(basicpay)) from tblInsa;

select distinct jikwi from tblInsa;

select round(avg(basicpay)) from tblInsa where jikwi = '부장';
select round(avg(basicpay)) from tblInsa where jikwi = '과장';
select round(avg(basicpay)) from tblInsa where jikwi = '대리';
select round(avg(basicpay)) from tblInsa where jikwi = '사원';

select
    jikwi,
    round(avg(basicpay)) as "직위별 평균 급여",
    count(*) as "직위별 인원수",
    sum(basicpay) as "직위별 총지급액",
    max(basicpay) as "직위별 최고 급여",
    min(basicpay) as "직위별 최저 급여"
from tblInsa
    group by jikwi;

select * from tblComedian;

-- 남자수? 여자수?(최종)
select count(*) from tblComedian where gender = 'm';
select count(*) from tblComedian where gender = 'f';

select
    count(case
        when gender = 'm' then 1
    end) as m,
    count(case
        when gender = 'f' then 1
    end) as f
from tblComedian;

select
    count(decode(gender, 'm', 1)) as m,
    count(decode(gender, 'f', 1)) as f
from tblComedian;

select
    gender,
    count(*)
from tblComedian
    group by gender;

select
    buseo,
    count(*) as "부서별 인원수"
from tblInsa
    group by buseo
    --order by 2 desc;
    --order by "부서별 인원수" asc;
    order by count(*) desc;

select
    buseo,
    count(*) as "부서별 인원수"
from tblInsa
    group by buseo;
    
-- 1차 그룹  > 2차 그룹 > 3차 그룹
select
    jikwi,
    buseo,
    count(*)
from tblInsa
    group by jikwi, buseo
        order by jikwi;
        
-- tblInsa
-- 급여별 그룹
-- 100만원 미만
-- 100만원 이상 ~ 200만원 미만
-- 200만원 이상
select
    basicpay,
    count(*)
from tblInsa
    group by basicpay;
    
select
    (floor(basicpay / 1000000) + 1) * 100 || '만원 이하' as money,
    count(*)
from tblInsa
    group by floor(basicpay / 1000000);

-- tblInsa. 남자수? 여자수?
select
    substr(ssn, 8, 1),
    count(*)
from tblInsa
    group by substr(ssn, 8, 1);

-- tbl Todo
select
     completedate,
     count(*)
from tblTodo
    group by completedate;

select
    case
        when completedate is not null then 1
    else 2
    end,
    count(*)
from tblTodo
    group by case
                 when completedate is not null then 1
                 else 2
             end;
             
-- tblInsa. 과장+부장 몇명? 사원+대리 몇명?
select
    case
        when jikwi in ('과장', '부장') then 1
        else 2
    end,
    count(*)
from tblInsa
    group by case
                 when jikwi in ('과장', '부장') then 1
                 else 2
             end;


