-- ex25_rank_function.sql

/*

    순위 함수
    - rownum을 기반으로 만들어진 함수
    
    1. rank() over(order by 컬럼명 [asc|desc])
        - 동일값 = 동일순위
        - 누적O
    
    2. dense_rank() over(order by 컬럼명 [asc|desc])
        - 동일값 = 동일순위
        - 누적X
    
    3. row_number() over(order by 컬럼명 [asc|desc])
        - 무조건 다른 순위
        - rownum을 직접 사용했을 때와 동일

*/


-- tblInsa. 급여순으로 가져오시오. + 순위 표시
select 
    a.*, rownum
from (select name, buseo, basicpay from tblInsa order by basicpay desc) a;

select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

select
    name, buseo, basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblInsa;


select
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;



--1위
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa
    where rank() over(order by basicpay desc) = 1; --불가능

select * from
    (select
        name, buseo, basicpay,
        rank() over(order by basicpay desc) as rnum
    from tblInsa)
        where rnum = 5;

-------------------------------------------------------------

-- 순위함수 + partition by == group by 역할
select
    name, buseo, jikwi, basicpay,
    rank() over(partition by buseo, jikwi order by basicpay desc) as rnum
from tblInsa;














