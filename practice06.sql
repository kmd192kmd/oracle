-- practice 06.sql

select * from tblZoo;
select * from traffic_accident;
select * from tblAddressBook;

--1번.
select
    round(avg(leg)),
    family
from tblZoo
    group by family;
    
--2번.
select
    trans_type,
    sum(total_acct_num),
    sum(death_person_num),
    round(sum(death_person_num) / sum(total_acct_num),3)
from traffic_accident
    where total_acct_num > 0 --한 타입의 trans_type의 total_acct)_num이 전부 0일 수 있으니...
    group by trans_type;
    
--3번.
select
    count(case
        when breath in ('gill') then 1
    end) as "변온, 아가미 호흡",
    count(case
        when breath in ('lung') then 1
    end) as "변온, 폐 호흡"
from tblZoo
    group by thermo
    having thermo = 'variable';
    
SELECT 
    count(case when breath = 'lung' then 1 end) as "변온,폐 호흡",
    count(case when breath = 'gill' then 1 end) as "변온,아가미 호흡"
FROM tblzoo
WHERE thermo = 'variable'; -- HAVING 대신 WHERE를 쓰면 그룹화 전 미리 필터링되어 더 빠릅니다.

--4번.
select
    family,
    sizeof,
    count(*)
from tblZoo
    group by family, sizeof;
    
--5번.
SELECT 
    email, count(email)
FROM tbladdressbook 
    group by email 
    having count(email) > 1;   

--6번.
SELECT 
    substr(name,1,1) 
FROM tbladdressbook 
    group by substr(name,1,1) 
    having count(substr(name,1,1)) >= 100;
    
--7번.
select
    job,
    round(count(case
        when substr(address, 1, 2) like ('%서울%') then 1
    end)/count(job)*100, 2) as "서울 거주자",
    round(count(case
        when substr(address, 1, 2) not like ('%서울%') then 1
    end)/count(job)*100, 2) as "(비)서울 거주자"
from tblAddressBook
    group by job
    having job in('건물주', '건물주자제분');

    
