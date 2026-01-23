-- ex08_numeric_function.sql

/*

    자바
    - Math.random()
    - Math.XXX()

    숫자(수학) 함수
    
    round()
    - 반올림 함수
    - number round(컬럼명): 정수 반환
    - number round(컬럼명, 소수이하자릿수): 정수/실수 반환

*/

select name, 3.14 from tblInsa;

desc dual;
select * from dual; --시스템 테이블 > 1행 1열짜리 테이블(***)

select 3.14 from tblInsa;
select 3.14 from dual;
select 3.14;

-- 특정 테이블 데이터와 무관 + 어떤 계산된 값을 만들거나 테스트용으로 테이블 필요
-- dual 테이블(오라클에만)


select round(3.14) from tblInsa;
select round(3.14) from dual;

select 
    round(3.14),
    round(3.54),
    round(3.4567, 1), --3.5
    round(3.4567, 2), --3.46
    round(3.4567, 3), --3.457
    round(3.4567, 4), --3.4567
    round(3.4567, 5), --3.4567
    round(3.4567, 0)  --3
from dual;

select
    avg(basicpay), --1556526.66666666666666666666666666666667
    round(avg(basicpay)) --1556527
from tblInsa;


/*
    floor()
    - 절삭 함수 > 소수 이하를 무조건 버린다.
    - 무조건 내림 함수
    - 자신과 인접한 가장 가까운 최저 정수를 반환
    - number floor(컬럼명): 정수 반환
*/

select
    floor(3.45), --3
    floor(3.55)  --3
from dual;

/*
    ceil()
    - 무조건 올림 함수
    - 자신과 인접한 가장 가까운 최대 정수를 반환
    - number ceil(컬럼명): 정수 반환
*/
select
    ceil(3.45), --4
    ceil(3.55)  --4
from dual;

select
    floor(3.9999999999999999999), --3
    ceil(3.00000000000000000001)  --4
from dual;


/*
    mod()
    - 나머지 함수
    - number mod(피제수, 제수)
    ex) 10 % 3
    ex) mod(10, 3)
*/

select
    10 / 3,
    floor(10 / 3) as 몫,
    mod(10, 3) as 나머지
from dual;

select
    abs(10), abs(-10),
    power(2,2), power(2,3), power(2,4), --제곱
    sqrt(4), sqrt(9), sqrt(16) --제곱근
from dual;











