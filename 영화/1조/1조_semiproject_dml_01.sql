--------------------------------------------------------------------------------
--select문
--------------------------------------------------------------------------------
--dml_01.sql에 포함된 테이블
select * from gender;
select * from job_category;
select * from genre_category;
select * from critic;
select * from filmcompany_category;
select * from country;

--dml_02.sql에 포함된 테이블
select * from human;
select * from movie;
select * from company;
select * from staff;
select * from actor;

--dml_03.sql에 포함된 테이블
select * from synopsis;
select * from audience;
select * from genre;
select * from release_date;
select * from review;
select * from filmcompany;
select * from critic_review;
select * from award;
select * from news;
select * from video;
select * from actorrole;
select * from staffrole;

-- view
--영화 순위(월간), 월간관객이 많은 순으로 순위 정렬
select * from vwmovieranking order by 월간관객 desc;

--------------------------------------------------------------------------------
--insert문
--------------------------------------------------------------------------------
--gender 테이블
insert into gender values (seqgender.nextval, '남자');
insert into gender values (seqgender.nextval, '여자');


--job_category 테이블
insert into job_category values (seqjob_category.nextval,'감독');
insert into job_category values (seqjob_category.nextval,'제작');
insert into job_category values (seqjob_category.nextval,'각본');
insert into job_category values (seqjob_category.nextval,'특수효과');
insert into job_category values (seqjob_category.nextval,'촬영');
insert into job_category values (seqjob_category.nextval,'음악');
insert into job_category values (seqjob_category.nextval,'원작');
insert into job_category values (seqjob_category.nextval,'편집');
insert into job_category values (seqjob_category.nextval,'미술');
insert into job_category values (seqjob_category.nextval,'분장');
insert into job_category values (seqjob_category.nextval,'시각효과');
insert into job_category values (seqjob_category.nextval,'음향');
insert into job_category values (seqjob_category.nextval,'의상');
insert into job_category values (seqjob_category.nextval,'세트');
insert into job_category values (seqjob_category.nextval,'캐스팅');
insert into job_category values (seqjob_category.nextval,'애니메이션 감독');
insert into job_category values (seqjob_category.nextval,'사운드');
insert into job_category values (seqjob_category.nextval,'연출부');
insert into job_category values (seqjob_category.nextval,'조감독');
insert into job_category values (seqjob_category.nextval,'조명');
insert into job_category values (seqjob_category.nextval,'프로듀서');
insert into job_category values (seqjob_category.nextval,'안무');

--genre_category 테이블
insert into genre_category values (seqgenre_category.nextval, '어드벤처');
insert into genre_category values (seqgenre_category.nextval, '액션');
insert into genre_category values (seqgenre_category.nextval, '스릴러');
insert into genre_category values (seqgenre_category.nextval, '공포');
insert into genre_category values (seqgenre_category.nextval, '드라마');
insert into genre_category values (seqgenre_category.nextval, '애니메이션');
insert into genre_category values (seqgenre_category.nextval, '판타지');
insert into genre_category values (seqgenre_category.nextval, '코미디');
insert into genre_category values (seqgenre_category.nextval, '미스터리');
insert into genre_category values (seqgenre_category.nextval, '다큐멘터리');
insert into genre_category values (seqgenre_category.nextval, '전쟁');
insert into genre_category values (seqgenre_category.nextval, 'SF');
insert into genre_category values (seqgenre_category.nextval, '퀴어');
insert into genre_category values (seqgenre_category.nextval, '멜로·로맨스');
insert into genre_category values (seqgenre_category.nextval, '범죄');
insert into genre_category values (seqgenre_category.nextval, '뮤지컬');
insert into genre_category values (seqgenre_category.nextval, '가족');



--critic 테이블
insert into critic (seq, name)    values (seqcritic.nextval, '김소미');
insert into critic (seq, name)    values (seqcritic.nextval, '박평식');
insert into critic (seq, name)    values (seqcritic.nextval, '이용철');    
insert into critic (seq, name)    values (seqcritic.nextval, '유선아');
insert into critic (seq, name)    values (seqcritic.nextval, '오진우');
insert into critic (seq, name)    values (seqcritic.nextval, '이유채');    
insert into critic (seq, name)    values (seqcritic.nextval, '김철홍');    
insert into critic (seq, name)    values (seqcritic.nextval, '김신');    
insert into critic (seq, name)    values (seqcritic.nextval, '김경수');    
insert into critic (seq, name)    values (seqcritic.nextval, '이자연');    
insert into critic (seq, name)    values (seqcritic.nextval, '조현나');    
insert into critic (seq, name)    values (seqcritic.nextval, '정재현');    
insert into critic (seq, name)    values (seqcritic.nextval, '남선우');    
insert into critic (seq, name)    values (seqcritic.nextval, '김성훈');
insert into critic (seq, name)    values (seqcritic.nextval, '김현수');    
insert into critic (seq, name)    values (seqcritic.nextval, '남지우');    
insert into critic (seq, name)    values (seqcritic.nextval, '최현수');    
insert into critic (seq, name)    values (seqcritic.nextval, '강한섭');    
insert into critic (seq, name)    values (seqcritic.nextval, '이명인');    
insert into critic (seq, name)    values (seqcritic.nextval, '유지나');    
insert into critic (seq, name)    values (seqcritic.nextval, '이우빈');
insert into critic (seq, name)    values (seqcritic.nextval, '이병현');
insert into critic (seq, name)    values (seqcritic.nextval, '문주화');
insert into critic (seq, name)    values (seqcritic.nextval, '이동진');
insert into critic (seq, name)    values (seqcritic.nextval, '김봉석');
insert into critic (seq, name)    values (seqcritic.nextval, '김도훈');    
insert into critic (seq, name)    values (seqcritic.nextval, '김현승');    
insert into critic (seq, name)    values (seqcritic.nextval, '허남웅');    
insert into critic (seq, name)    values (seqcritic.nextval, '송경원');
insert into critic (seq, name)    values (seqcritic.nextval, '김영진');

--filmcompany_category 테이블
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '배급');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '수입');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '제작');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '제공');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '공동배급');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '공동제작');
insert into filmcompany_category (seq, name) values (seqfilmcompany_category.nextVal, '공동제공');


--country 테이블
insert into country (seq, name) values (seqcountry.nextVal, '한국');
insert into country (seq, name) values (seqcountry.nextVal, '미국');
insert into country (seq, name) values (seqcountry.nextVal, '영국');
insert into country (seq, name) values (seqcountry.nextVal, '일본');
insert into country (seq, name) values (seqcountry.nextVal, '프랑스');
insert into country (seq, name) values (seqcountry.nextVal, '이탈리아');
insert into country (seq, name) values (seqcountry.nextVal, '캐나다');
insert into country (seq, name) values (seqcountry.nextVal, '몽골');
insert into country (seq, name) values (seqcountry.nextVal, '대만');
insert into country (seq, name) values (seqcountry.nextVal, '인도네시아');
insert into country (seq, name) values (seqcountry.nextVal, '오스트레일리아');
insert into country (seq, name) values (-1, '국가없음');

commit;