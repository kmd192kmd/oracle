-- ex32_transaction.sql

/*

    트랜잭션, Transaction
    - 데이터를 조작하는 업무들의 시간적 단위
    - 1개 이상의 DML을 묶어 놓은 단위
    ex) 은행 > 계좌
    
    
    트랜잭션 명령어(DCL > TCL)
    1. commit
    2. rollback
    3. savepoint
    
*/
create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

-- 우리가 하는 행동(SQL - insert,update,delete) > 반드시 시간순으로 기억(*****)

-- A
-- 트랜잭션 시작 > 종료 > 또 다른 트랜잭션 시작 > 종료 > 또 다른 트랜잭션 시작..

select * from tblTrans;

delete from tblTrans where name = '김말숙';

select * from tblTrans;

--김말숙 되살리기
rollback; -- 현재 트랜잭션에서 발생한 모두 SQL를 없었던 일로..

select * from tblTrans;


delete from tblTrans where name = '김말숙';

select * from tblTrans;

commit; --이전까지 작업을 책임지고 승인 > 이전 작업은 되돌리지 않겠다.(***)

select * from tblTrans;


rollback;
delete from tblUser; --1만건(운영)

--1주일


------------------------------------------------

-- 트랜잭션은 딱 1개 존재

-- 트랜잭션 시작
select * from tblTrans; --19명, select 미포함

insert into tblTrans values ('강아지', '개발부', '사원');

update tblTrans set jikwi = '이사' where name = '홍길동';

delete from tblTrans where name = '한석봉';

--트랜잭션 단위로 처리(일부 SQL만 따로 처리 불가능!!)
select * from tblTrans; --현재 세션에만 반영

rollback;

select * from tblTrans;

--commit;

/*

    ***** 트랜잭션이 언제 시작해서 ~ 언제 끝나는지?
    
    새로운 트랜잭션이 시작하는 경우
    1. 클라이언트가 접속한 직 후
    2. commit 실행 직 후
    3. rollback 실행 직 후
    4. DDL 실행 직 후 > 자동 commit
        - create, alter, drop
    
    현재 트랜잭션이 끝나는 경우
    1. 클라이언트 접속 종료
        a. 정상 종료
            - 현재 트랜잭션이 모두 완료 > 아무일도 안 일어남
            - 현재 트랜잭션이 반영이 안된 상태 > 질문?
        b. 비정상 종료
            - rollback
    2. commit 실행 직 후
    3. rollback 실행 직 후
    4. DDL(구조) 실행 직 전 > 자동 commit
        - create, alter, drop > 프로젝트 초반에 하는 행동
        - DML(insert,update,delete) > DDL 작업 이후에 주로 하는 행동
    
*/

commit;

insert into tblTrans values ('강아지', '개발부', '사원');

---------------------------------------------------------

select * from tblTrans;


insert into tblTrans values ('강아지', '개발부', '사원');

update tblTrans set jikwi = '이사' where name = '홍길동';

-- 옆사람 > 시퀀스 객체 생성 요청

create sequence seqAAA; --자동 commit 실행

rollback;

select * from tblTrans;

delete from tblTrans where name = '한석봉';


------------------------------------------------------

-- savepoint
commit;

insert into tblTrans values ('고양이', '개발부', '사원');

savepoint a;

update tblTrans set jikwi = '사장' where name = '홍길동';

savepoint b;

delete from tblTrans where name = '한석봉';

select * from tblTrans;

rollback to b;

select * from tblTrans;

rollback to a;

select * from tblTrans;

rollback;

select * from tblTrans;


-------------------------------------------------------------

/*

    오라클 서버
    - 팀원A: SQL Developer + HR > 접속
    - 팀원B: DBeaver + HR > 접속
    - 팀원C: DataGrip + HR > 접속
    
    팀 작업 시 > 트랜잭션(***) & 툴 특성(Auto Commit 기능 On/Off)
    
    팀 작업
    1. 각자 DB 사용 > 합치는 방법
    2. 하나 DB 사용 > 실시간 방법 > 추천
    
    5명 > 그중 1명 PC > 오라클 서버 선정
    1. 프로젝트 계정 생성
    2. 방화벽 오픈(오라클 사용하는 포트) > 오라클 서버 컴퓨터에서만 설정
    
    집
    1. *.sql > 관리
    2. 외부 오라클 사용
        a. 클라우드 서비스 > AWS(X), OracleCloud(O - 팀작업 살짝 버벅임)
        b. 집 > PC(24H) + 공유기(포트 포워딩) > 검색
       
    
*/
commit;

insert into tblTrans values ('병아리', '개발부', '사원');

select * from tblTrans;

commit;





-- 프로젝트 계정 생성하기(12c 이후 > 계정명 앞에 'C##')
create user 계정명 identified by 암호;

-- 관리자만 가능


show user;

alter session set "_ORACLE_SCRIPT"=true;
create user team identified by java1234;
grant connect, resource, dba to team; --DCL
alter user team default tablespace users;








