-------------------------------------------------------------장르

INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '멜로');                 
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '로맨스');             
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '드라마');             
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '액션');                 
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '모험');              
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, 'SF');                  
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '범죄');               
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '애니메이션');           
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '코미디');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '판타지');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '스릴러');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '미스터리');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '시대극');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '역사');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '서사');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '공포');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '어드벤처');
INSERT INTO GENRE VALUES (GENRE_SEQ.nextVal, '다큐멘터리');

select * from genre;
commit;



-----------------------------------------------------영화장르
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 1,1); 
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 1,2);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 2,3);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 3,4);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 3,5);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 3,6);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 4,3);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 4,7);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 5,8);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 6,8);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 7,9);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 8,8);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 8,10);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 9,3);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 10,11);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 11,1);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 11,2);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 12,11);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 13,11);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 13,12);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 14,3);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 14,13);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 15,3);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 15,14);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 15,15);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 16,11);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 16,16);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 17,8);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 18,1);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 18,2);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 19,1);
insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 19,2);

insert into MOVIE_GENRE values (MOVIE_GENRE_SEQ.nextval, 20,3);

commit;