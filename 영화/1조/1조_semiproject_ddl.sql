--테이블 총 23개
--------------------------------------------------------------------------------
--SEQUENCE 삭제문
--------------------------------------------------------------------------------
DROP SEQUENCE seqcountry;
DROP SEQUENCE seqgender;
DROP SEQUENCE seqjob_category;
DROP SEQUENCE seqgenre_category;
DROP SEQUENCE seqfilmcompany_category;
DROP SEQUENCE seqcritic;

DROP SEQUENCE seqhuman;
DROP SEQUENCE seqmovie;
DROP SEQUENCE seqcompany;

DROP SEQUENCE seqaward;
DROP SEQUENCE seqactor;
DROP SEQUENCE seqstaff;

DROP SEQUENCE seqactorrole;
DROP SEQUENCE seqaudience;
DROP SEQUENCE seqsynopsis;
DROP SEQUENCE seqfilmcompany;
DROP SEQUENCE seqstaffrole;
DROP SEQUENCE seqnews;
DROP SEQUENCE seqgenre;
DROP SEQUENCE seqrelease_date;
DROP SEQUENCE seqvideo;
DROP SEQUENCE seqreview;
DROP SEQUENCE seqcritic_review;

--------------------------------------------------------------------------------
--DROP TABLE문
--------------------------------------------------------------------------------
DROP TABLE country;
DROP TABLE gender;
DROP TABLE job_category;
DROP TABLE genre_category;
DROP TABLE filmcompany_category;
DROP TABLE critic;
DROP TABLE human;
DROP TABLE movie;
DROP TABLE company;
DROP TABLE award;
DROP TABLE actor;
DROP TABLE staff;
DROP TABLE actorrole;
DROP TABLE audience;
DROP TABLE synopsis;
DROP TABLE filmcompany;
DROP TABLE staffrole;
DROP TABLE news;
DROP TABLE genre;
DROP TABLE release_date;
DROP TABLE video;
DROP TABLE review;
DROP TABLE critic_review;

--------------------------------------------------------------------------------
--SEQUENCE 생성문
--------------------------------------------------------------------------------
CREATE SEQUENCE seqcountry;
CREATE SEQUENCE seqgender;
CREATE SEQUENCE seqjob_category;
CREATE SEQUENCE seqgenre_category;
CREATE SEQUENCE seqfilmcompany_category;
CREATE SEQUENCE seqcritic;

CREATE SEQUENCE seqhuman;
CREATE SEQUENCE seqmovie;
CREATE SEQUENCE seqcompany;

CREATE SEQUENCE seqaward;
CREATE SEQUENCE seqactor;
CREATE SEQUENCE seqstaff;

CREATE SEQUENCE seqactorrole;
CREATE SEQUENCE seqaudience;
CREATE SEQUENCE seqsynopsis;
CREATE SEQUENCE seqfilmcompany;
CREATE SEQUENCE seqstaffrole;
CREATE SEQUENCE seqnews;
CREATE SEQUENCE seqgenre;
CREATE SEQUENCE seqrelease_date;
CREATE SEQUENCE seqvideo;
CREATE SEQUENCE seqreview;
CREATE SEQUENCE seqcritic_review;

commit;

--------------------------------------------------------------------------------
--CREATE TABLE문
--------------------------------------------------------------------------------
--1. 국가 테이블
create table country(
    seq number,     --일련번호(PK)
    name varchar2(30) not null, --국가명
    constraint country_seq_pk primary key(seq),
    constraint country_name_uq unique(name)
);
--desc country;

--2. 성별
create table gender(
    seq number, --일련번호(PK)
    gender varchar2(30) not null, --성별
    constraint gender_seq_pk primary key(seq),
    constraint gender_gender_uq unique(gender)
);
--desc gender;

--3. 직업분류
create table job_category(
    seq number, --일련번호(PK)
    jobname varchar2(30) not null, --직업명
    constraint job_category_seq_pk primary key(seq),
    constraint job_category_jobname_uq unique(jobname)
);


--4. 장르분류
create table genre_category(
    seq number, --일련번호(PK)
    genre varchar2(30) not null, --장르명
    constraint genre_category_seq_pk primary key(seq),
    constraint genre_category_genre_uq unique(genre)
);


--5. 영화사분류
create table filmcompany_category(
    seq number, --일련번호(PK)
    name varchar2(30) not null, --영화사종류(배급, 수입, 등등)
    constraint filmcompany_category_seq_pk primary key(seq),
    constraint filmcompany_category_name_uq unique(name)
);


--6. 전문가정보
create table critic(
    seq number, --일련번호(PK)
    name varchar2(30) not null, --전문가이름
    constraint critic_seq_pk primary key(seq),
    constraint critic_name_uq unique(name)
);

--------------------------------------------------------------------------------

--7. 인물
create table human (
    seq number ,                    --일련번호
    name varchar2(50) not null,     --이름
    engname varchar2(50) not null,  --영문이름
    birthday date,                  --생일
    gender_seq number not null,     --성별(FK)
     --제약사항만
    constraint human_seq_pk primary key(seq),
    CONSTRAINT human_gender_fk FOREIGN KEY (gender_seq)
        REFERENCES Gender(seq)
);

--8. 영화
create table movie (
    seq number ,                --일련번호(PK)
    title varchar2(1000) not null,       --제목
    engTitle varchar2(1000) default '없음',    --영문제목
    rating varchar2(50) default '없음',        --영화등급
    runningTime number default 0,         --상영시간
    country_seq number default -1,         --국가(FK)
    --제약사항
    constraint movie_seq_pk primary key(seq), 
    CONSTRAINT movie_country_fk FOREIGN KEY (country_seq)
        REFERENCES country(seq)
    
);



--9. 기업
create table company (
    seq number ,                --일련번호(PK)
    name varchar2(60) not null,         --기업명
    engName varchar2(60) default '없음',      --영문기업명
    phoneNum varchar2(30) default '없음', --전화번호
    chief varchar2(30) default '없음',                --대표자명
    website varchar2(1000) default '없음',             --사이트주소
    address varchar2(1000) default '없음',             --도로명주소
    bio varchar2(1000) default '없음',                 --소개내용
    country_seq number default -1,        --국가(FK)
    --제약사항
    constraint company_seq_pk primary key(seq), 
    CONSTRAINT company_country_fk FOREIGN KEY (country_seq)
        REFERENCES country(seq)
);

--------------------------------------------------------------------------------
--10. 수상기록
create table award (
    seq number ,                    --일련번호(PK)
    detail varchar2(1000),          --수상기록내역
    human_seq number not null,      --인물(FK)
    --제약사항
    constraint award_seq_pk primary key(seq), 
    CONSTRAINT award_human_fk FOREIGN KEY (human_seq)
        REFERENCES human(seq)
);


--11. 배우
create table actor (
    seq number ,                --일련번호(PK)
    human_seq number not null,          --인물(FK)
    --제약사항
    constraint actor_seq_pk primary key(seq),
    CONSTRAINT actor_human_fk FOREIGN KEY (human_seq)
        REFERENCES human(seq)
);


--12. 스태프
create table staff (
    seq number ,                --일련번호(PK)
    human_seq number not null,          --인물(FK)
    category_seq number not null,       --직업(FK)
    --제약사항
    constraint staff_seq_pk primary key(seq),
    CONSTRAINT staff_human_fk FOREIGN KEY (human_seq)
        REFERENCES human(seq),
    CONSTRAINT staff_job_category_fk FOREIGN KEY (category_seq)
        REFERENCES job_category(seq)    
    
);

--------------------------------------------------------------------------------

--13. 배역
create table ActorRole (
    --컬럼 선언
    seq number , --배역 기본키
    rolename varchar2(30), --배역이름
    movie_seq number not null, --영화키 참조 외래키
    actor_seq number, -- 배우키 참조 외래키
    --제약사항
    constraint actorrole_pk primary key(seq),
    constraint actorrole_movie_fk
        foreign key(movie_seq) references movie(seq),
    constraint actorrole_actor_fk
        foreign key(actor_seq) references actor(seq)
);

--14. 관객수
create table audience (
    seq number, --관객수 기본키
    movie_seq number not null, --영화키 참조 외래키
    monthly_audience number, --월 관객수
    all_audience number not null, --누적 관객수

    CONSTRAINT audience_pk primary key(seq),
    constraint audience_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--15. 시놉시스
create table synopsis(
    seq number, --시놉시스 기본키
    detail varchar2(3000) not NULL, --시놉시스내용
    movie_seq number not null, -- 무비키 참조 외래키

    CONSTRAINT synopsis_pk primary key(seq),
    constraint synopsis_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--16. 영화사
create table FILMCOMPANY(
    seq number,--영화사 기본키
    category_seq number not null, --카테고리키 참조 외래키
    company_seq number not null,  --회사키 참조 외래키
    movie_seq number not null,    -- 영화키 참조 외래키

    CONSTRAINT FILMCOMPANY_pk primary key(seq),
    constraint filmcompany_filmcompany_category_fk
        foreign key(category_seq) references filmcompany_category(seq),
    constraint filmcompany_company_fk
        foreign key(company_seq) references company(seq),
    constraint filmcompany_movie_fk
        foreign key(movie_seq) references movie(seq)
);


--17. 참여내역
create table STAFFROLE(
    seq number,--영화 기본키
    staff_seq number not null, --스텝키 참조 외래키 
    movie_seq number not null, --영화키 참조 외래키
    CONSTRAINT pk_STAFFROLE primary key(seq),
    constraint STAFFROLE_movie_fk
        foreign key(movie_seq) references movie(seq),
    constraint STAFFROLE_staff_fk
        foreign key(staff_seq) references staff(seq)
);

--18. 관련기사
create table news (
    seq number,                     --관련기사번호(PK)
    title varchar2(1000) not null,  --기사제목
    regdate date not null,          --기사작성날짜
    editor varchar2(30) not null,   --기자이름
    movie_seq number not null,      --영화 번호(FK)
    
    constraint news_seq_pk PRIMARY KEY(seq),
    constraint news_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--19. 장르
create table genre (
    seq number,                     --장르목록번호(PK)
    category_seq number not null,   --장르분류번호(FK)
    movie_seq number not null,      --영화 번호(FK)
    
    constraint genre_seq_pk PRIMARY KEY(seq),
    constraint genre_genre_category_fk
        foreign key(category_seq) references genre_Category(seq),
    constraint genre_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--20. 개봉
create table release_date (
    seq number,                     --배급번호(PK)
    rel_date date null,             --개봉날짜
    movie_seq number not null,      --영화 번호(FK)
    
    constraint release_date_seq_pk PRIMARY KEY(seq),
    constraint release_date_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--21. 비디오
create table video (
    seq number,                     --비디오번호(PK)
    title varchar2(1000) not null,  --비디오 제목
    movie_seq number not null,      --영화 번호(FK)
    
    constraint video_seq_pk PRIMARY KEY(seq),
    constraint video_movie_fk
        foreign key(movie_seq) references movie(seq)
    
);

--22. 일반리뷰
create table review (
    seq number,                         --일반리뷰번호(PK)
    id varchar2(30) not null,           --작성자ID
    rating number not null,             --별점
    detail varchar2(1000),         --리뷰내용
    regdate date not null,              --작성시각
    movie_seq number not null,          --영화 번호(FK)
    
    constraint review_seq_pk PRIMARY KEY(seq),
    constraint review_movie_fk
        foreign key(movie_seq) references movie(seq)
);

--23. 전문가리뷰
create table critic_review (
    seq number,                     --전문가리뷰번호(PK)
    critic_seq number not null,     --전문가번호(FK)
    rating number not null,         --별점
    detail varchar2(1000) not null, --리뷰내용
    movie_seq number not null,      --영화 번호(FK)
    
    constraint critic_review_seq_pk PRIMARY KEY(seq),
    constraint critic_review_critic_fk
        foreign key(critic_seq) references critic(seq),
    constraint critic_review_movie_fk
        foreign key(movie_seq) references movie(seq)
);

commit;


--------------------------------------------------------------------------------
--CREATE VIEW문
--------------------------------------------------------------------------------
create or replace view vwMovieRanking as
select
    m.title as 영화제목,
    round(avg(cr.rating), 2) as 씨네21평점,
    a.monthly_audience as 월간관객,
    a.all_audience 누적관객,
    rd.rel_date as 개봉일
from
    movie m
    left join critic_review cr on m.seq = cr.movie_seq
    left join audience a on m.seq = a.movie_seq
    left join release_date rd on m.seq = rd.movie_seq
group by
    m.seq,
    m.title,
    a.monthly_audience,
    a.all_audience,
    rd.rel_date;

