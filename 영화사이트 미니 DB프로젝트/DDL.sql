-- 시퀀스 삭제문
DROP SEQUENCE MOVIE_SEQ;
DROP SEQUENCE SYNOPSIS_SEQ;
DROP SEQUENCE RATING_SEQ;
DROP SEQUENCE GENRE_SEQ;
DROP SEQUENCE MOVIE_GENRE_SEQ;
DROP SEQUENCE REPORTER_SEQ;
DROP SEQUENCE ARTICLE_SEQ;
DROP SEQUENCE COUNTRY_SEQ;
DROP SEQUENCE COMPANY_SEQ;
DROP SEQUENCE STUDIO_BOSS_SEQ;
DROP SEQUENCE BUSINESS_SEQ;
DROP SEQUENCE director_seq;
DROP SEQUENCE direction_seq;
DROP SEQUENCE related_movie_seq;
DROP SEQUENCE ACTOR_SEQ;
DROP SEQUENCE appear_seq;
DROP SEQUENCE movie_user_seq;
DROP SEQUENCE MOVIE_Expert_SEQ;
DROP SEQUENCE UserReview_seq;
DROP SEQUENCE ExpertReview_seq;

-- 시퀀스 생성문
CREATE SEQUENCE MOVIE_SEQ;
CREATE SEQUENCE SYNOPSIS_SEQ;
CREATE SEQUENCE RATING_SEQ;
CREATE SEQUENCE GENRE_SEQ;
CREATE SEQUENCE MOVIE_GENRE_SEQ;
CREATE SEQUENCE REPORTER_SEQ;
CREATE SEQUENCE ARTICLE_SEQ;
CREATE SEQUENCE COUNTRY_SEQ;
CREATE SEQUENCE COMPANY_SEQ;
CREATE SEQUENCE STUDIO_BOSS_SEQ;
CREATE SEQUENCE BUSINESS_SEQ;
CREATE SEQUENCE director_seq;
CREATE SEQUENCE direction_seq;
CREATE SEQUENCE related_movie_seq;
CREATE SEQUENCE ACTOR_SEQ;
CREATE SEQUENCE appear_seq;
CREATE SEQUENCE movie_user_seq;
CREATE SEQUENCE MOVIE_Expert_SEQ;
CREATE SEQUENCE UserReview_SEQ;
CREATE SEQUENCE ExpertReview_seq;

-- 국가 / COUNTRY
CREATE TABLE COUNTRY (
    COUNTRY_SEQ NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_country PRIMARY KEY (COUNTRY_SEQ)
);


-- 시놉시스 / SYNOPSIS
CREATE TABLE SYNOPSIS (
    SYNOPSIS_SEQ NUMBER primary key,
    CONTENT VARCHAR2(4000) not null
);

-- 심의등급 / MOVIE_RATING
CREATE TABLE MOVIE_RATING(
    RATING_SEQ NUMBER PRIMARY KEY,
    RATING_NAME VARCHAR2(30) NOT NULL
);

commit;
-- 영화

CREATE TABLE MOVIE (
    MOVIE_SEQ NUMBER,
    TITLE_KOR VARCHAR2(100) NOT NULL,
    TITLE_ENG VARCHAR2(100) NOT NULL,
    REGDATE DATE,
    TIME NUMBER ,
    AUDIENCE_COUNT NUMBER,
    COUNTRY_SEQ NUMBER,
    RATING_SEQ NUMBER,
    SYNOPSIS_SEQ NUMBER,
    CONSTRAINT pk_movie PRIMARY KEY (MOVIE_SEQ),
    CONSTRAINT fk_movie_country FOREIGN KEY (COUNTRY_SEQ) REFERENCES COUNTRY(COUNTRY_SEQ),
    CONSTRAINT fk_movie_rating FOREIGN KEY (RATING_SEQ) REFERENCES MOVIE_RATING(RATING_SEQ),
    CONSTRAINT fk_movie_synopsis FOREIGN KEY (SYNOPSIS_SEQ) REFERENCES SYNOPSIS(SYNOPSIS_SEQ)
);
commit;

-- 관련영화
create table related_movie
(
    seq number not null, -- 관련영화번호
    movie_seq1 number, -- 영화번호
    movie_seq2 number, -- 영화번호2
    
    constraint  pk_related_movie primary key (seq),
    
    constraint fk_director1 foreign key (movie_seq1) references movie (movie_seq),
    constraint fk_director2 foreign key (movie_seq2) references movie (movie_seq)

);
commit;






-- 영화회사 / MOVIE_COMPANY
CREATE TABLE MOVIE_COMPANY (
    COMPANY_SEQ NUMBER,
    NAME VARCHAR2(60) NOT NULL,
    DIVISION VARCHAR2(30),
    SITE VARCHAR2(60),
    ADDRESS VARCHAR2(100),
    TEL VARCHAR2(30),
    COUNTRY_SEQ NUMBER,
    CONSTRAINT pk_movie_company PRIMARY KEY (COMPANY_SEQ),
    CONSTRAINT fk_movie_company_country FOREIGN KEY (COUNTRY_SEQ) REFERENCES COUNTRY(COUNTRY_SEQ)
);

commit;

-- 대표자 / STUDIO BOSS
CREATE TABLE STUDIO_BOSS (
    STUDIO_BOSS_SEQ NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    COMPANY_SEQ NUMBER,
    CONSTRAINT pk_studio_boss PRIMARY KEY (STUDIO_BOSS_SEQ),
    CONSTRAINT fk_studio_boss_company FOREIGN KEY (COMPANY_SEQ) REFERENCES MOVIE_COMPANY(COMPANY_SEQ)
);
commit;



-- 서비스 제공 / BUSINESS
CREATE TABLE BUSINESS (
    BUSINESS_SEQ NUMBER,
    BUSINESS_TYPE VARCHAR2(20) NOT NULL,
    MOVIE_SEQ NUMBER NOT NULL,
    COMPANY_SEQ NUMBER NOT NULL,
    CONSTRAINT pk_business PRIMARY KEY (BUSINESS_SEQ),
    CONSTRAINT fk_business_movie FOREIGN KEY (MOVIE_SEQ) REFERENCES MOVIE(MOVIE_SEQ),
    CONSTRAINT fk_business_company FOREIGN KEY (COMPANY_SEQ) REFERENCES MOVIE_COMPANY(COMPANY_SEQ)
);
commit;
rollback;



-- 감독
create table director
(
    director_seq number not null, -- 감독번호(PK)
    name varchar2(30) NOT NULL, -- 이름
    birth date, -- 생년월일
    gender number, -- 성별
    
    constraint pk_director primary key (director_seq) 
);
commit;

-- 연출
create table direction
(
    seq number not null, -- 연출번호(PK)
    movie_seq number not null, -- 영화번호
    director_seq number not null, -- 감독번호
    
    -- 기본키 제약 조건
    constraint PK_DIRECTION PRIMARY KEY (SEQ),
    
    -- 외래키 제약 조건 (부모 테이블의 PK를 참조)
    constraint FK_DIRECTION_MOVIE_seq FOREIGN KEY (MOVIE_SEQ)
        references MOVIE (movie_seq),
        
    constraint fk_Direction_director_seq foreign key (director_seq)
        references director (director_seq)

);
commit;
rollback;

-- 배우
CREATE TABLE ACTOR (
    ACTOR_SEQ NUMBER        NOT NULL, -- 배우번호 (PK)
    JOB       VARCHAR2(30) DEFAULT '배우',   -- 직업
    NAME      VARCHAR2(30) NOT NULL,  -- 배우이름
    BIRTH     DATE,                   -- 생년월일
    GENDER    NUMBER,                 -- 배우성별
    
    CONSTRAINT PK_ACTOR PRIMARY KEY (ACTOR_SEQ)
);
commit;


-- 출연
create table appear
(
    appear_seq number not null,
    movie_seq number not null,
    actor_seq number,
    
    constraint pk_appear primary key (appear_seq),
    
    constraint fk_movie_seq foreign key (movie_seq) references movie(movie_seq),
    constraint fk_actor_Seq foreign key (actor_seq) references actor(actor_seq)

);

commit;



-- 전문가/ EXPERT
create table MOVIE_Expert(
    movie_expert_seq number,
    name varchar2(30) not null,
    constraint PK_MovieExpert primary key (movie_expert_seq)
);

-- 전문가 리뷰
create table ExpertReview(
    expertReview_seq number,
    content varchar2(4000),
    rating number not null,
    expert_seq number NOT NULL,
    movie_seq number not null,
    
    constraint PK_ExpertReview primary key (expertReview_seq),
    constraint FK_ExpertReview_Expert foreign key (expert_seq) references Movie_Expert(movie_expert_seq) ,
    constraint FK_ExpertReview_Movie foreign key (movie_seq) references Movie(MOVIE_SEQ)
);
commit;

-- 유저/USER
create table MOVIE_User (
    movie_user_seq number not null,
    name varchar2(30) NOT NULL,
    
    constraint PK_MovieUser primary key (movie_user_seq)
);

-- 유저 리뷰
create table UserReview(
    UserReview_seq number,
    content varchar2(4000),
    review_date date default sysdate,
    rating number,
    user_seq number NOT NULL,
    movie_seq number NOT NULL,
    
    constraint PK_UserReview primary key (UserReview_seq),
    constraint FK_UserReview_User foreign key (user_seq) references Movie_User(movie_user_seq),
    constraint FK_UserReview_Movie foreign key (movie_seq) references Movie(MOVIE_SEQ)    
);
commit;



-- 장르 / GENRE
CREATE TABLE GENRE (
    GENRE_SEQ NUMBER,
    GENRE_NAME VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_genre PRIMARY KEY (GENRE_SEQ)
);
commit;


-- 영화장르 / MOVIE_GENRE
CREATE TABLE MOVIE_GENRE (
    MOVIE_GENRE_SEQ NUMBER,
    MOVIE_SEQ NUMBER NOT NULL,
    GENRE_SEQ NUMBER NOT NULL,
    CONSTRAINT pk_movie_genre PRIMARY KEY (MOVIE_GENRE_SEQ),
    CONSTRAINT fk_movie_genre_movie FOREIGN KEY (MOVIE_SEQ) REFERENCES MOVIE(MOVIE_SEQ),
    CONSTRAINT fk_movie_genre_genre FOREIGN KEY (GENRE_SEQ) REFERENCES GENRE(GENRE_SEQ)
);
commit;

-- 기자 / REPORTER
CREATE TABLE REPORTER (
    REPORTER_SEQ NUMBER,
    NAME VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_reporter PRIMARY KEY (REPORTER_SEQ)
);


-- 기사 / ARTICLE
CREATE TABLE ARTICLE (
    ARTICLE_SEQ NUMBER,
    TITLE VARCHAR2(100) NOT NULL,
    CONTENT VARCHAR2(4000) NOT NULL,
    MOVIE_SEQ NUMBER NOT NULL,
    REPORTER_SEQ NUMBER NOT NULL,
    CONSTRAINT pk_article PRIMARY KEY (ARTICLE_SEQ),
    CONSTRAINT fk_article_movie FOREIGN KEY (MOVIE_SEQ) REFERENCES MOVIE(MOVIE_SEQ),
    CONSTRAINT fk_article_reporter FOREIGN KEY (REPORTER_SEQ) REFERENCES REPORTER(REPORTER_SEQ)
);

commit;
