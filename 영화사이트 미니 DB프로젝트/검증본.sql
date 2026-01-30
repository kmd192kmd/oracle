--1번
select
    movie.title_kor,
    movie.audience_count
from movie
    order by  AUDIENCE_COUNT desc;
    
--2번
select
    movie.title_kor,
    actor.name
from movie
    inner join actor
        on actor.name = '권상우';
        
--3번
select
    movie.title_kor,
    director.name
from movie
    inner join director
        on director.name = '진성문';
        
--4번
select
    m.title_kor,
    erv.rating as expert_rating,
    urv.rating as user_rating
from movie m
    inner join expertreview erv
        on erv.rating >= 6
            inner join userReview urv
                on urv.rating >= 6;
                
--5번
select
    a.name,
    m.title_kor
from appear ap
inner join actor a on ap.actor_seq = a.actor_seq
inner join movie m on m.movie_seq = ap.movie_seq
    where a.actor_seq in (
        select actor_seq
        from( 
            select actor_seq, row_number() over (order by count(*) desc) as rnk
            from appear
            group by actor_seq)
                 where rnk = 1
            );
            
select * from appear;

--6번
select
    *
from movie_genre mg
    inner join genre g
        on mg.genre_seq = g.genre_seq
            inner join movie m
                on mg.movie_seq = m.movie_seq
                    where g.genre_name = '드라마' and g.genre_name = '액션'; 
                    
--7번
select
    *
from movie 
    where time < 120;
    
--8번
select
    *
from movie 
    where rating_seq = 2;
    
--9번
select
    *
from UserReview ur
inner join movie m on m.movie_seq = ur.movie_seqs
where m.movie_seq in (
    select * from(
     select rank() over (order by count(*) desc) as rnk
        from UserReview
        group by movie_seq
     ));
     