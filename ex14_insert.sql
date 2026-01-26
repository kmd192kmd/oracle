-- ex14_insert.sql

/*

    DML > select, insert, update, delete
    
    insert문
    - 테이블에 데이터를 추가하는 명령어
    
    insert into 테이블명 (컬럼 리스트) values (값 리스트);    
    
*/
drop table tblMemo;

--메모 테이블
create table tblMemo (
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null
);

create sequence seqMemo;

--1. 표준
--: 원본 테이블에 정의된 컬럼순서대로 컬럼리스트와 값리스트를 작성
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--2. 컬럼리스트의 순서는 원본 테이블과 무관하다.
--: 컬럼리스트의 순서와 값리스트의 순서는 일치해야 한다.(***)
insert into tblMemo (regdate, seq, name, memo)
    values (sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');

--3. ORA-00913: 값의 수가 너무 많습니다
insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--4. ORA-00947: 값의 수가 충분하지 않습니다
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate);

--5. null 컬럼 조작(name) > null을 넣는 방법
--5.a null 상수 사용
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', null, sysdate);
    
--5.b 컬럼 생략
insert into tblMemo (seq, name, regdate)
    values (seqMemo.nextVal, '홍길동', sysdate);

--6. default 조작 > 기본값을 넣는 방법
--6.a 컬럼 생략 > null 대입(암시적) > default 호출(***)
insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate);

--6.b null 상수 > default 동작 안함
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, null, '메모입니다.', sysdate);

--6.c default 상수(***)
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, default, '메모입니다.', sysdate);

---------------------------------------------------------------

--7. 단축 > 컬럼리스트는 원본 테이블의 순서대로 적혀있다.
--7.a 컬럼 리스트를 생략할 수 있다.
insert into tblMemo values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--7.b 컬럼리스트 순서를 바꿀 수 없다.
insert into tblMemo values (sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');

--7.c null 컬럼 생략 불가능
insert into tblMemo values (seqMemo.nextVal, '메모입니다.', sysdate);
insert into tblMemo values (seqMemo.nextVal, null, '메모입니다.', sysdate);

--7.d default 컬럼 생략 불가능
insert into tblMemo values (seqMemo.nextVal, '메모입니다.', sysdate);
insert into tblMemo values (seqMemo.nextVal, default, '메모입니다.', sysdate);


--8.
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)


create table tblMemoCopy (
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null
);

insert into tblMemoCopy select * from tblMemo; --Sub Query

insert into tblMemoCopy select * from tblMemo where name = '홍길동';


--9.
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)
--데이터 복사(O), 컬럼 복사(O)
--제약사항은 복사가 안된다.(*****)
--더미 데이터용 > 임시용 or 테스트용
create table tblMemoCopy
as
select * from tblMemo;

select * from tblMemo;
select * from tblMemoCopy;
drop table tblMemoCopy;

insert into tblMemoCopy values (3, '하하하', '메모', default);












