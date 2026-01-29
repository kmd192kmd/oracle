--배우 테이블
create table tblActor(
    actornum number primary key, --배우 번호
    actorname varchar2(100) not null ,    --배우 이름
    actorbirth varchar2(50) not null,    --배우 생년월일
    actorgender varchar2(10) not null    --배우 성별
);


--출연 테이블
create table tblAppear ( --출연 테이블
    appernum NUMBER PRIMARY KEY, -- 출연번호 (기본키)
    apperrole VARCHAR2(100) NOT NULL, -- 배역
    actornum NUMBER NOT NULL,        -- 배우번호 (외래키)
    movieNum NUMBER NOT NULL,
    CONSTRAINT fk_tblappear_actor FOREIGN KEY(actornum) REFERENCES tblActor(actornum),
    CONSTRAINT fk_tblappear_movie FOREIGN KEY(movieNum) REFERENCES tblMovie(movieNum)
);


--감독 테이블
create table tblDirector(  --감독 테이블
    directorNum number primary key,
    directorName varchar2(100) not null

);


--회사 종류 테이블
create table tblCompanyType(   --회사 종류 테이블
    companyTypeNum number primary key,   --회사 종류 번호
    companyTypeName varchar2(100) not null   --회사 종류 이름
);

--회사 이름 테이블
create table tblCompanyname(           --회사이름 테이블
    companyNameNum number primary key, --회사이름 번호(기본키)
    companyName varchar2(300) not null --회사 이름
);

--회사 테이블
CREATE TABLE tblCompany (               --회사 예정
    companyNum NUMBER primary key,      --회사 번호(기본키)
    movieNum NUMBER NOT NULL,           --영화 번호(외래키)
    companyNameNum NUMBER NOT NULL,     --회사이름 번호(외래키)
    companyTypeNum NUMBER  NOT NULL,    --회사 종류(외래키)
    
    CONSTRAINT fk_tblproduce_company FOREIGN KEY(companyNum) REFERENCES tblCompany(companyNum),
    CONSTRAINT fk_tblcompany_movie FOREIGN KEY(movieNum) REFERENCES tblMovie(movieNum),
    CONSTRAINT fk_tblcompany_name FOREIGN KEY(companyNameNum) REFERENCES tblCompanyName(companyNameNum),
    CONSTRAINT fk_tblcompany_type FOREIGN KEY(companyTypeNum) REFERENCES tblCompanyType(companyTypeNum)
);
	

--전문가 테이블
CREATE TABLE tblExpert (                  --전문가 테이블
    expertNum NUMBER primary key,         --전문가 번호
    expertName VARCHAR2(100) NOT NULL      --전문가 이름
);


--전문가 리뷰 테이블
CREATE TABLE tblExpertReview (             	 --전문가 리뷰 테이블
    expertReviewNum NUMBER primary key,      --전문가 리뷰 번호
    expertReview VARCHAR2(1000) NOT NULL,  --리뷰 내용
    expertStar VARCHAR2(30) NOT NULL,       	 --별점
    expertNum NUMBER NOT NULL,              	 --전문가 번호
    movieNum NUMBER NOT NULL,               	 --영화번호
    
    CONSTRAINT fk_tblexpertreview_expert FOREIGN KEY(expertNum) REFERENCES tblExpert(expertNum),
    CONSTRAINT fk_tblexpertreview_movie FOREIGN KEY(movieNum) REFERENCES tblMovie(movieNum)
);
desc tblmio


-- 영화 테이블
CREATE TABLE tblMovie (
    movieNum NUMBER PRIMARY KEY,                          -- 영화번호
    movieTitle VARCHAR2(150) NOT NULL,                    -- 제목
    movieEngTitle VARCHAR2(100) NOT NULL,                 -- 영어제목
    movieAudience NUMBER NOT NULL,                        -- 관객수
    runningTime NUMBER NOT NULL,                        -- 러닝타임
    releaseDate DATE NOT NULL,                            -- 개봉일
    synopsis VARCHAR2(4000) NOT NULL,                     -- 시놉시스
    movieRatingNum NUMBER NOT NULL,                       -- 등급번호
    directorNum NUMBER NOT NULL,                          -- 감독번호
    stateNum NUMBER NOT NULL,                             -- 국가번호
    CONSTRAINT FK_tblMovie_movieRatingNum FOREIGN KEY (movieRatingNum) 
        REFERENCES tblRating(ratingNum),
    CONSTRAINT FK_tblMovie_directorNum FOREIGN KEY (directorNum) 
        REFERENCES tblDirector(directorNum),
    CONSTRAINT FK_tblMovie_stateNum FOREIGN KEY (stateNum) 
        REFERENCES tblMovieCountry(countryNum)             
);

-- 영화 장르 매핑 테이블
CREATE TABLE tblMovieGenre (
    movieGenreNum NUMBER PRIMARY KEY,                     -- 영화장르번호
    movieNum NUMBER NOT NULL,                             -- 영화번호
    genreNum NUMBER NOT NULL,                             -- 장르번호

    CONSTRAINT FK_tblMovieGenre_movieNum FOREIGN KEY (movieNum) 
        REFERENCES tblMovie(movieNum),
    CONSTRAINT FK_tblMovieGenre_genreNum FOREIGN KEY (genreNum) 
        REFERENCES tblmGenre(genreNum)
);

-- 장르 테이블
CREATE TABLE tblMGenre (
    genreNum NUMBER PRIMARY KEY,                          -- 장르번호
    genreName VARCHAR2(100)                               -- 장르명
);

-- 등급 테이블
CREATE TABLE tblRating (
    ratingNum NUMBER PRIMARY KEY,                         -- 등급번호
    rating VARCHAR2(50) NOT NULL                          -- 등급
);

-- 영화 서비스 매핑 테이블
CREATE TABLE tblMovieService (
    movieService NUMBER PRIMARY KEY,                      -- 영화서비스번호
    serviceNum NUMBER NOT NULL,                           -- 서비스번호
    movieNum NUMBER NOT NULL,                             -- 영화번호

    CONSTRAINT FK_tblMovieService_serviceNum FOREIGN KEY (serviceNum) 
        REFERENCES tblService(serviceNum),
    CONSTRAINT FK_tblMovieService_movieNum FOREIGN KEY (movieNum) 
        REFERENCES tblMovie(movieNum)
);

-- 서비스 테이블
CREATE TABLE tblService (
    serviceNum NUMBER PRIMARY KEY,                        -- 서비스번호
    serviceName VARCHAR2(50) NOT NULL                     -- 서비스명
);

-- 국가 테이블
CREATE TABLE tblMovieCountry (
    countryNum NUMBER PRIMARY KEY,                        -- 국가번호
    country VARCHAR2(100) NOT NULL                        -- 국가명
);

-- 관객 리뷰 테이블
CREATE TABLE tblAudienceReview (
    audienceReviewNum NUMBER PRIMARY KEY,                 -- 관객리뷰번호
    audienceID VARCHAR2(50) NOT NULL,                     -- 아이디
    audienceReview VARCHAR2(4000) NOT NULL,               -- 리뷰
    audiencetReviewTime DATE NOT NULL,                    -- 작성시간
    audienceStar VARCHAR2(30) NOT NULL,                   -- 별점
    movieNum NUMBER NOT NULL,                             -- 영화번호

    CONSTRAINT FK_tblAudienceReview_movieNum FOREIGN KEY (movieNum) 
        REFERENCES tblMovie(movieNum)
);

-- 스탭 이름 테이블
CREATE TABLE tblStaffName (
    staffNameNum NUMBER PRIMARY KEY,                      -- 스탭이름번호
    staffName VARCHAR2(100) NOT NULL                      -- 스탭명
);

-- 스탭 역할 테이블
CREATE TABLE tblStaffRoles (
    staffRolesNum NUMBER PRIMARY KEY,                     -- 스탭역할번호
    staffRoles VARCHAR2(100) NOT NULL                     -- 스탭역할명
);

-- 스탭 매핑 테이블
CREATE TABLE tblMovieStaff (
    staffNum NUMBER PRIMARY KEY,                          -- 스탭번호
    movieNum NUMBER NOT NULL,                             -- 영화번호
    staffNameNum NUMBER NOT NULL,                         -- 스탭이름번호
    staffRolesNum NUMBER NOT NULL,                        -- 스탭역할번호

    CONSTRAINT FK_tblStaff_movieNum FOREIGN KEY (movieNum) 
        REFERENCES tblMovie(movieNum),
    CONSTRAINT FK_tblStaff_staffNameNum FOREIGN KEY (staffNameNum) 
        REFERENCES tblStaffName(staffNameNum),
    CONSTRAINT FK_tblStaff_staffRolesNum FOREIGN KEY (staffRolesNum) 
        REFERENCES tblStaffRoles(staffRolesNum)
);


-- 테이블 수정 명령어 modify 사용
--ALTER TABLE tblMGenre
--MODIFY (genreName VARCHAR2(100) NULL);
-- 테이블명 수정 명령어
--Alter table tblmovie
--rename column runinningTime to runningTime;

