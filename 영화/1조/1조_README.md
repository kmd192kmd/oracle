# SQL 파일 실행 순서 및 파일 상세 내용 설명



#### 파일 실행 순서

외래키 제약 때문에 순서대로 실행이 필요함

1\. semiproject\_ddl.sql → create문 전부

2\. semiproject\_dml\_01.sql

3\. semiproject\_dml\_02.sql

4\. semiproject\_dml\_03.sql



#### 파일 상세 내용 설명

* **semiproject\_ddl.sql**

    - 모든 테이블에 대한 SEQUENCE 객체 생성, 삭제 (CREATE, DROP)

    - 모든 테이블 생성, 삭제 (CREATE, DROP)

    - 영화 월간 순위를 확인하는 view에 대한 CREATE문

* **semiproject\_dml\_01.sql**

    - 모든 테이블에 대한 select문(주석처리하였음)

    - 아래 테이블들에 대한 insert문

        - gender 테이블(2개 레코드)

        - job\_category 테이블(22개 레코드)

        - genre\_category 테이블(17개 레코드)

        - critic 테이블(30개 레코드)

        - filmcompany\_category 테이블(7개 레코드)

        - country 테이블(12개 레코드)

    - commit

* **semiproject\_dml\_02.sql**

    - 아래 테이블들에 대한 insert문

        - human 테이블(284개 레코드)

        - movie 테이블(50개 레코드)

        - company 테이블(80개 레코드)

        - staff 테이블(85개 레코드)

        - actor 테이블(209개 레코드)

    - commit

* **semiproject\_dml\_03.sql**

    - 아래 테이블들에 대한 insert문

        - synopsis 테이블(42개 레코드)

        - audience 테이블(50개 레코드)

        - genre 테이블(78개 레코드)

        - release\_date 테이블(44개 레코드)

        - review 테이블(240개 레코드)

        - filmcompany 테이블(136개 레코드)

        - critic\_review 테이블 (136개 레코드)

        - award 테이블(238개 레코드)

        - news 테이블(314개 레코드)

        - video 테이블(173개 레코드)

        - actorrole 테이블(209개 레코드)

        - staffrole 테이블(85개 레코드)

    - commit

