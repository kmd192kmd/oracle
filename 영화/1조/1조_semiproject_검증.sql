--[씨네 21] 

-- 1. 누적 관객수 순서대로 가져오시오.
select m.title as 영화제목, aud.all_audience as 누적관객수 
from movie m
    inner join audience aud on m.seq = aud.seq
order by aud.all_audience desc;

-- 2. '유해진' 배우가 출연한 영화를 가져오시오.
--유해진 배우가 출연한 영화가 주간 영화 50위 이내에 없어서
--쥬라기월드에 유해진 배우가 출연했다고 가정하고 데이터를 넣었습니다
select 
    h.name as 배우명,
    m.title as 영화제목,
    ar.rolename
from 
    actorrole ar
    inner join actor a on ar.actor_seq  = a.seq
    inner join human h on a.human_seq   = h.seq
    inner join movie m on ar.movie_seq  = m.seq
where 
    h.name = '유해진';

-- 3. '김병우' 감독이 제작한 영화를 가져오시오.
select 
    h.name as 이름,
    m.title as 영화제목
from 
    human h
    inner join staff s on h.seq = s.human_seq
    inner join staffrole sr on s.seq = sr.staff_seq
    inner join movie m on sr.movie_seq = m.seq
    inner join job_category jc on s.category_seq = jc.seq
where 
    jc.jobname = '감독'
    and h.name = '김병우';

-- 4. 씨네 21 평점 6.0 이상 + 네티즌 평점 6.0 이상  받은 영화를 가져오시오.
select 
    m.title as 영화제목,
    round(avg(cr.rating), 2) as 씨네21평점,
    round(avg(r.rating), 2) as 네티즌평점
from 
    movie m
    inner join review r on m.seq = r.movie_seq
    inner join critic_review cr on m.seq = cr.movie_seq
group by 
    m.seq, m.title
having 
    avg(r.rating) >= 6.0
    and avg(cr.rating) >= 6.0
order by 
    씨네21평점 desc, 네티즌평점 desc;


-- 5. 등록된 영화 중 가장 많은 영화에 참여한 배우와 영화를 가져오시오. -> 중복되는 값이 많은 듯..

SELECT h.name AS actor_name, m.title AS movie_title
FROM actorrole ar
JOIN actor a ON ar.actor_seq = a.seq
JOIN human h ON a.human_seq = h.seq
JOIN movie m ON ar.movie_seq = m.seq
WHERE ar.actor_seq IN (
    SELECT actor_seq
    FROM (
        SELECT actor_seq, COUNT(*) AS cnt
        FROM actorrole
        GROUP BY actor_seq
    )
    WHERE cnt = (
        SELECT MAX(cnt)
        FROM (
            SELECT actor_seq, COUNT(*) AS cnt
            FROM actorrole
            GROUP BY actor_seq
        )
    )
)
ORDER BY actor_name, movie_title;


-- 6. 장르 중 '드라마'와 '액션'을 동시에 속한 영화를 가져오시오.
select 
    m.title as 영화제목
from 
    genre g
    inner join genre_category gc on g.category_seq = gc.seq
    inner join movie m on g.movie_seq = m.seq
where 
    gc.genre in ('드라마', '액션')
group by 
    m.seq, m.title
having 
    count(distinct gc.genre) = 2;

-- 7. 상영시간이 120분 미만인 영화를 가져오시오.

SELECT 
    m.title AS 영화제목,
    m.runningTime AS 상영시간
FROM 
    movie m
WHERE 
    m.runningTime < 120 and m.runningtime > 0
ORDER BY 
    m.runningTime ASC;

-- 8. 15세 이상 관람가 영화를 가져오시오.
SELECT 
    title as 제목,
    rating as 관람등급
FROM 
    movie
WHERE 
    rating LIKE '%15%';


-- 9. 네티즌 리뷰가 가장 많이 달린 순으로 가져오시오.
SELECT 
    m.title AS 제목,
    COUNT(r.seq) AS 리뷰개수
FROM 
    movie m
    LEFT JOIN review r ON m.seq = r.movie_seq
GROUP BY 
    m.seq, m.title, m.engTitle
ORDER BY 
    리뷰개수 DESC;


-- 10. 네티즌 리뷰를 가장 많이 작성한 네티즌의 아이디를 가져오시오.
SELECT * FROM (
    SELECT id, COUNT(*) AS 리뷰개수
    FROM review
    GROUP BY id
    ORDER BY 리뷰개수 DESC
) WHERE ROWNUM = 1;



-- 11. 전문가 별점에 가장 많이 참여한 전문가의 이름을 가져오시오.
SELECT * FROM (
    SELECT c.name, COUNT(cr.seq) AS 리뷰개수
    FROM critic_review cr
    JOIN critic c ON cr.critic_seq = c.seq
    GROUP BY c.name
    ORDER BY 리뷰개수 DESC
) WHERE ROWNUM = 1;
