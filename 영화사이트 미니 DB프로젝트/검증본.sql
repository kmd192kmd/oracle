--1번
select
    movie.title_kor,
    movie.audience_count
from movie
    order by AUDIENCE_COUNT desc;
    
--2번
select
    m.title_kor,
    a.name
from actor a
inner join appear ap
    on a.actor_seq = ap.actor_seq
        inner join movie m
            on ap.movie_seq = m.movie_seq
                where a.name = '권상우';
        
--3번
select
    m.title_kor,
    d.name
from movie m
    inner join direction drt
        on m.movie_seq = drt.movie_seq
            inner join director d
                on drt.director_seq = d.director_seq
                    where d.name = '진성문';
        
--4번
select
    m.title_kor,
    round(e.avg_rating) as expert_avg_rating,
    round(u.avg_rating) as user_avg_rating
from movie m
inner join (
    select
        movie_seq,
        avg(rating) as avg_rating
    from expertReview er
    --where er.rating >= 6 이 방법은 6점 이상을 먼저 취합 후 평균점수를 만들게 된다.
    having avg(rating) >= 6
    group by movie_seq
    ) e on e.movie_seq = m.movie_seq
    inner join (
        select
            movie_seq,
            avg(rating) as avg_rating
        from userReview ur
        --where ur.rating >= 6
        having avg(rating) >= 6
        group by movie_seq
        ) u on u.movie_seq = m.movie_seq;
                
--5번
--select --모든 배우가 1번씩만 출연해서 전부 동률이라 20명이 전부 나오는 문제가 있음.
--    a.name,
--    m.title_kor
--from appear ap
--inner join actor a on ap.actor_seq = a.actor_seq
--inner join movie m on m.movie_seq = ap.movie_seq
--    where a.actor_seq in (
--        select actor_seq
--        from appear
--        group by actor_seq
--        having count(*) = (
--            select max(cnt)
--            from(
--                select count(*) as cnt
--                from appear
--                group by actor_seq
--            )
--        )
--    );

SELECT
    a.name,
    m.title_kor
FROM appear ap
JOIN actor a ON ap.actor_seq = a.actor_seq
JOIN movie m ON m.movie_seq = ap.movie_seq
WHERE ap.actor_seq = (
    SELECT actor_seq
    FROM (
        SELECT actor_seq
        FROM appear
        GROUP BY actor_seq
        ORDER BY COUNT(*) DESC, actor_seq
    )
    WHERE ROWNUM = 1
);
--위 아래 코드는 동률일 경우 위의 코드는 actor_seq가 작은 값을 선택, 아래 코드는 DBMS가 결정.
SELECT 
    a.name,
    m.title_kor
FROM appear ap
JOIN actor a ON ap.actor_seq = a.actor_seq
JOIN movie m ON m.movie_seq = ap.movie_seq
WHERE ap.actor_seq IN (
    SELECT actor_seq
    FROM (
        SELECT
            actor_seq,
            ROW_NUMBER() OVER (ORDER BY cnt DESC) AS rnk
        FROM (
            SELECT actor_seq, COUNT(*) AS cnt
            FROM appear
            GROUP BY actor_seq
        ) t
    ) r
    WHERE rnk = 1
);
            
--select 윈도우 함수를 쓰는 경우 위 코드처럼 집계함수와 윈도우 함수를 분리하는게 좋다고 한다.
--    a.name,
--    m.title_kor
--from appear ap
--inner join actor a on ap.actor_seq = a.actor_seq
--inner join movie m on m.movie_seq = ap.movie_seq
--    where a.actor_seq in (
--        select actor_seq
--        from( 
--            select actor_seq, 
--            row_number() over (order by count(*) desc) as rnk
--            from appear
--            group by actor_seq)
--            where rnk = 1
--            );
            

--6번
select
    m.title_kor
from movie m
inner join movie_genre mg on mg.movie_seq = m.movie_seq
inner join genre g on g.genre_seq = mg.genre_seq
where g.genre_name IN('드라마', '액션')
group by m.movie_seq, m.title_kor
having count(distinct g.genre_name) = 2;

--select
--    m.title_kor
--from movie_genre mg
--    inner join genre g
--        on mg.genre_seq = g.genre_seq
--            inner join movie m
--                on mg.movie_seq = m.movie_seq
--                    where g.genre_name = '드라마' and g.genre_name = '액션'; --이 코드는 하나의 레코드에 장르 드라마,액션이 두개가 들어가있어야 한다는 의미이다.
                    
--7번
select
    m.title_kor,
    time
from movie m
    where time < 120;
    
--8번
select
    m.title_kor,
    mr.rating_name
from movie m
inner join movie_rating mr on mr.rating_seq = m.rating_seq
    where m.rating_seq = 3;
    
--9번
select
    m.title_kor,
    review_counts.cnt as review_content_count
from movie m
inner join (
    select
        movie_seq,
        count(*) as cnt,
        rank() over (order by count(*) desc) as rnk
    from UserReview
    group by movie_seq
    )
    review_counts on m.movie_seq = review_counts.movie_seq
    order by review_counts.cnt desc;
    
--select
--    distinct(m.title_kor) --distinct는 성능이 떨어짐
--from UserReview ur
--inner join movie m on m.movie_seq = ur.movie_seq
--where m.movie_seq in ( --in은 단일 컬럼이 필요한데, 서브쿼리에서 두 컬럼이 반환되고 있음.
--    select * from(
--     select
--        movie_seq,
--        rank() over (order by count(*) desc) as rnk --서브쿼리 안에서 분석함수 성능 떨어짐
--        from UserReview
--        group by movie_seq
--     )
--);

--10번
select
    u.name,
    review_counts.cnt,
    rnum
from Movie_User u
    inner join (
        select
            count(*) as cnt,
            user_seq,
            row_number() over(order by count(*) desc) as rnum
        from UserReview
        group by user_seq
        ) review_counts on review_counts.user_seq = u.movie_user_seq
            where rnum = 1;
-- 위 코드는 동률이 있더라도 강제로 1명을 선택하고, 아래 코드는 동률을 모두 보여준다.
SELECT
    u.name,
    COUNT(*) AS cnt
FROM Movie_User u
JOIN UserReview ur ON ur.user_seq = u.movie_user_seq
GROUP BY u.Movie_User_seq, u.name
HAVING COUNT(*) = (
    SELECT MAX(user_review_count)
    FROM (
        SELECT COUNT(*) AS user_review_count
        FROM UserReview
        GROUP BY user_seq
    )
);

            
--11번
select
    e.name,
    rating_counts.cnt,
    rnum
from Movie_Expert e
inner join (
    select
        count(*) as cnt,
        expert_seq,
        row_number() over(order by count(*) desc) as rnum
    from ExpertReview
    group by expert_seq
    ) rating_counts on rating_counts.expert_seq = e.Movie_expert_seq
        where rnum = 1;
-- 위 코드는 동률이 있더라도 강제로 1명을 선택하고, 아래 코드는 동률을 모두 보여준다.
SELECT
    e.name,
    COUNT(*) AS cnt
FROM Movie_Expert e
JOIN ExpertReview er ON er.expert_seq = e.Movie_expert_seq
GROUP BY e.movie_expert_seq, e.name
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM ExpertReview
        GROUP BY expert_seq
    )
);
     