-- ex30.sql
/*

    ** 지금 예제 테이블은 근태 관리의 적합한 구조가 아니다.
    
    
    근태(출결) 관리
    - 근태 상태 관리(정상, 지각, 조퇴)
    - 2026년 1월 > 한달분 데이터(1일~31일)
    - 달력 > 출력
    
*/
--근태 테이블
create table tblDate (
    seq number primary key,         --PK
    state varchar2(30) not null,    --정상,지각,조퇴
    regdate date not null           --날짜
);

delete from tblDate;

--01-01: 신정
insert into tblDate (seq, state, regdate) values (1, '정상', '2026-01-02 09:01:30');
--01-03: 토요일
--01-04: 일요일
insert into tblDate (seq, state, regdate) values (2, '정상', '2026-01-05');
insert into tblDate (seq, state, regdate) values (3, '지각', '2026-01-06');
insert into tblDate (seq, state, regdate) values (4, '지각', '2026-01-07');
insert into tblDate (seq, state, regdate) values (5, '정상', '2026-01-08');
insert into tblDate (seq, state, regdate) values (6, '정상', '2026-01-09');
--01-10: 토요일
--01-11: 일요일
insert into tblDate (seq, state, regdate) values (7, '정상', '2026-01-12');
--insert into tblDate (seq, state, regdate) values (8, '정상', '2026-01-13');
insert into tblDate (seq, state, regdate) values (9, '정상', '2026-01-14');
insert into tblDate (seq, state, regdate) values (10, '조퇴', '2026-01-15');
insert into tblDate (seq, state, regdate) values (11, '정상', '2026-01-16');
--01-17: 토요일
--01-18: 일요일
insert into tblDate (seq, state, regdate) values (12, '지각', '2026-01-19');
insert into tblDate (seq, state, regdate) values (13, '정상', '2026-01-20');
insert into tblDate (seq, state, regdate) values (14, '정상', '2026-01-21');
--insert into tblDate (seq, state, regdate) values (15, '정상', '2026-01-22');
insert into tblDate (seq, state, regdate) values (16, '정상', '2026-01-23');
--01-24: 토요일
--01-25: 일요일
insert into tblDate (seq, state, regdate) values (17, '정상', '2026-01-26');
insert into tblDate (seq, state, regdate) values (18, '정상', '2026-01-27');
insert into tblDate (seq, state, regdate) values (19, '정상', '2026-01-28');
insert into tblDate (seq, state, regdate) values (20, '정상', '2026-01-29');

commit;

select * from tblDate;

-- 근태 조회 or 출력 > select
-- 1월 1일부터 1월 29일까지 근태 내역 > 29건의 내역 + 실제 기록 8건
-- 기록이 없는 날도 같이 보고 싶다. > 공휴일, 주말, 결석
-- 1. ANSI-SQL
-- 2. PL/SQL
-- 3. Java


-- 1. 1월 1일 ~ 1월 29일 > 날짜 데이터 생성하기
-- ANSI-SQL > 반복문(X) > 계층형 쿼리

-- 일련번호 생성용 > 계층형 쿼리
select
    sysdate + level
from dual
    connect by level <= 10;

create or replace view vwDate
as
select
    to_date('2026-01-01') + level - 1 as regdate
from dual
    connect by level <= 29;


select * from vwDate;   --1월 한달 날짜
select * from tblDate;  --1월 한달 근태


select
    *
from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            order by v.regdate asc;




select
    v.regdate,
    --t.state,
    --to_char(v.regdate, 'dy')
    case
        when to_char(v.regdate, 'dy') = '토' then '토요일'
        when to_char(v.regdate, 'dy') = '일' then '일요일'
        else t.state
    end as state
from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            order by v.regdate asc;


-- 공휴일 처리 > 공식 없음
create table tblHoliday (
    seq number primary key,
    regdate date not null,
    name varchar2(50) not null
);

insert into tblHoliday values (1, '2026-01-01', '신정');



select
    v.regdate,
    case
        when to_char(v.regdate, 'dy') = '토' then '토요일'
        when to_char(v.regdate, 'dy') = '일' then '일요일'
        when h.seq is not null then h.name
        when h.seq is null and t.seq is null then '결석'
        else t.state
    end as state
from vwDate v
    left outer join tblDate t
        on to_char(v.regdate, 'yyyy-mm-dd') = to_char(t.regdate, 'yyyy-mm-dd')
            left outer join tblHoliday h
                on to_char(h.regdate, 'yyyy-mm-dd') = to_char(v.regdate, 'yyyy-mm-dd')
                    order by v.regdate asc;


/*

    1. ANSI-SQL
    2. 모델링 + 정규화
    3. DB 프로젝트 > 1일 
    4. PL/SQL
    5. DB 프로젝트
    
    
    영화
    1. 사이트 분석 > 어떤 데이터 추출
    2. 논리 모델링 > [산출물]
    3. 물리 모델링 > [산출물]
    4. DDL > [산출물]
    5. 데이터 추가 > DML > [산출물]
    6. 검증
    
*/






