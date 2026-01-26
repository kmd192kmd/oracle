-- ex13_sequence.sql

/*

    시퀀스, Sequence
    - DB Object(테이블, 제약사항, 시퀀스 등..)
    - DB Object > 생성/수정/삭제 > DDL(create, drop, alter)
    - 일련 번호를 생성하는 객체(***)
    - 오라클 전용
    - 주로 식별자를 만드는데 사용
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;
    
    시퀀스 객체 사용하기
    - 시퀀스명.nextVal
    - 시퀀스명.currVal

*/

create sequence seqNum start with 21;
drop sequence seqNum;

select seqNum.nextVal from dual; --10

create sequence seqNo;

select seqNo.nextVal from dual; --5

select name, seqNum.nextVal from tblInsa;


insert into tblMemo (seq, name, memo, regdate) 
    values (seqNum.nextVal, '강아지', '멍멍멍.', sysdate);

select * from tblMemo;

select seqNum.currVal from dual;

select seqNum.nextVal from dual;


-- 쇼핑몰 > 상품번호 > ABC001, BDF5534
select 'ABC' || seqNum.nextVal from dual; --ABC21

select 'ABC' || lpad(seqNum.nextVal, 3, '0') from dual; --ABC024

/*

    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    - create sequence 시퀀스명 
                        increment by n  --증감치
                        start with n    --시작값
                        maxvalue n      --최댓값(증감치가 양수일때)
                        minvalue n      --최솟값(증감치가 음수일때)
                        cycle           --순환구조
                        cache n;        --임시저장(성능 관련)

*/
drop sequence seqTest;

create sequence seqTest
                --increment by 100
                --start with 100
                --maxvalue 10
                --cycle
                --cache 20
                ;

select seqTest.nextVal from dual; --15 > ??? > 26

drop sequence seqTest;
create sequence seqTest start with 16;


-- 접지 > 정전
-- services.msc > OracleServiceXE > 중지






