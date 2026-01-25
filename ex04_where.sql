-- ex04_where.sql

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
    
    각 절의 순서(********************************************************)
    3. SELECT
    1. FROM
    2. WHERE

*/

select *                        --3.
    from tblCountry             --1. 
        where continent = 'AS'; --2. 행 > 레코드(Record) = 튜플(Tuple)

select *                        
    from tblCountry             
        where continent <> 'AS';


select *                        
    from tblCountry             
        where area >= 100;
        
select *                        
    from tblCountry             
        where continent = 'AS' or continent = 'EU';

-- tblComedian
-- 1. 몸무게(weight)가 60kg 이상이고, 키(height)가 170cm 미만인 사람

-- 2. 몸무게가 70kg 이하인 여자만

-- tblInsa
-- 3. 부서가 '개발부'이고, 급여가 150만원 이상 받은 직원

-- 4. 급여 + 수당을 합한 금액이 200만원이 넘는 직원



/*

    Optimizer > SQL 실행하기 전에 결과를 얻기 위해 최적의 SQL로 수정


    between
    - where절에서 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 범위 비교
    - 가독성 향상
    - 최솟값, 최댓값 모두 포함

*/
select * from tblInsa where basicpay >= 1000000 and basicpay <= 1200000;
select * from tblInsa where 1000000 <= basicpay and basicpay <= 1200000;
select * from tblInsa where basicpay <= 1200000 and 1000000 <= basicpay;

select * from tblInsa where basicpay between 1100000 and 1320000;

/*
    SQL에서 비교 연산
    1. 숫자형
    2. 문자형
    3. 날짜시간형
*/
select * from tblInsa where basicpay between 1100000 and 1320000;

select * from employees where first_name <= 'F'; --first_name.compareTo("F")
select * from employees where first_name >= 'J' and first_name <= 'L';
select * from employees where first_name between 'J' and 'L';

desc tblInsa;
select * from tblInsa where ibsadate < '2010-01-01';
select * from tblInsa 
    where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';
select * from tblInsa where ibsadate between '2010-01-01' and '2010-12-31';

/*
    in
    - where절에서 사용 > 조건으로 사용
    - 열거형 비교
    - 컬럼명 in (값, 값, 값..)
    - 가독성 향상
*/

-- tblInsa. 개발부 + 홍보부 + 총무부
select * from tblInsa where buseo = '개발부' or buseo = '홍보부' or buseo = '총무부';
select * from tblInsa where buseo in ('개발부', '홍보부', '총무부');

-- city > 서울 + 인천
-- jikwi > 과장 + 부장
-- basicpay > 250~300만원
select * from tblInsa
    where city in ('서울', '인천')
        and jikwi in ('과장', '부장')
            and basicpay between 2500000 and 3000000;

/*
    like
    - where절에서 사용 > 조건으로 사용
    - 패턴 비교(정규 표현식 유사 기능)
    - 컬럼명 like '패턴 문자열'
    
    패턴 문자열 구성 요소
    1. _: 임의의 문자 1개(.)
    2. %: 임의의 문자 N개. 0~무한대(.*)
    
*/
-- 직원명: 김OO
select * from tblInsa;
select * from tblInsa where name like '김__';
select * from tblInsa where name like '_길_';
select * from tblInsa where name like '__수';
select * from tblInsa where name like '김___';

select * from employees where first_name like 'S_____';

select * from tblInsa where name like '김%';
select * from tblInsa where name like '%길%';
select * from tblInsa where name like '%수';

select * from employees where first_name like 'S%';

select * from tblInsa where ssn like '______-1______';
select * from tblInsa where ssn like '%-2%';


/*

    RDBMS에서의 null
    - 컬럼값이 비어있는 상태
    - null 상수 제공
    - 대부분의 언어는 null은 연산의 대상이 될 수 없다.
    
    is null
    - where절에서 사용
    - 컬럼명 is null
    
*/
select * from tblCountry;

-- 인구수가 미기재된 나라?
select * from tblCountry where population = null;
select * from tblCountry where population is null;

-- 인구수가 기재된 나라?
select * from tblCountry where population <> null;
select * from tblCountry where not population is null;
select * from tblCountry where population is not null;

-- tblInsa. 연락처(tel)가 직원?
select * from tblInsa where tel is null;
select * from tblInsa where tel is not null;

-- tblTodo
select * from tblTodo;

-- 할일을 완료한 일들이?
select * from tblTodo where completedate is not null;

select * from tblTodo where completedate is null;

-- 도서관 > 대여 테이블(컬럼: 대여날짜, 반납날짜)
-- 아직 반납을 안한 사람?
select * from 대여 where 반납날짜 is null;

-- 반납 완료 사람?
select * from 대여 where 반납날짜 is not null;


