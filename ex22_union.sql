-- ex22_union.sql

/*

    DB 이론
    - 관계 대수 > 연산(자)
    - 테이블을 피연산자로 하는 연산
    - 테이블 + 테이블 = union
    - 테이블 - 테이블 = minus
    - 테이블 x 테이블 = join
    
    
    테이블
    - 합집합(union)
    - 차집합(minus)
    - 교집합(intersect)

*/
select * from tblMen;
select * from tblWomen;

select * from tblMen m inner join tblWomen w on m.name = w.couple; --커플

select * from tblMen 
union 
select * from tblWomen;


-- ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
select * from tblInsa
union
select * from tblTodo;


select name, ibsadate from tblInsa
union
select title, adddate from tblTodo;


-- 쇼핑몰 > 구매 이력
-- 전체 기간(X) > 전체 기간(O)
-- 3개월, 6개월
-- 2026년, 2025년, 2024년
select * from 구매2026; --10만
select * from 구매2025; --1백만
select * from 구매2024; --1백만

select * from 구매2026
union
select * from 구매2025
union
select * from 구매2024;


-- 회사 > 게시판 > 부서별 전용 게시판
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

-- 사장님 > 모든 게시판 한번에 볼 수?
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;

--야구 선수 > 공격수, 수비수
select * from 공격수;
select * from 수비수;

select 공통된컬럼 from 공격수
union
select 공통된컬럼 from 수비수;

--동물 > 애완 동물
create table tblAAA (
    name varchar2(30) not null,
    color varchar2(30) not null
);

--동물 > 야생 동물
create table tblBBB (
    name varchar2(30) not null,
    color varchar2(30) not null
);


insert into tblAAA values ('강아지', '검정');
insert into tblAAA values ('고양이', '노랑');
insert into tblAAA values ('토끼', '갈색');
insert into tblAAA values ('거북이', '녹색');
insert into tblAAA values ('강아지', '회색');

insert into tblBBB values ('강아지', '검정');
insert into tblBBB values ('고양이', '노랑');
insert into tblBBB values ('호랑이', '주황');
insert into tblBBB values ('사자', '회색');
insert into tblBBB values ('고양이', '삼색');

select * from tblAAA;
select * from tblBBB;

-- union > 수학의 집합 > 중복 제거
select * from tblAAA  --5개
union
select * from tblBBB; --5개


-- union all > 중복 허용
select * from tblAAA  --5개
union all
select * from tblBBB; --5개


-- 차집합(minus)
select * from tblAAA
minus
select * from tblBBB;

select * from tblBBB
minus
select * from tblAAA;


--교집합
select * from tblAAA
intersect
select * from tblBBB;








