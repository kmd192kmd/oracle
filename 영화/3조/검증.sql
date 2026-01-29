--[씨네 21]			
			
-- 1. 누적 관객수 순서대로 가져오시오.			
	select 
        m.*, 
        rank() over(order by movieAudience desc)
    from tblMovie m;

-- 2. '유해진' 배우가 출연한 영화를 가져오시오.			
    select 
        distinct m.*
    from tblMovie m
        join tblAppear a on m.movieNum = a.movieNum
            join tblActor ac on a.actorNum = ac.actorNum
                where ac.actorname = '유해진';
                
-- 3. '김병우' 감독이 제작한 영화를 가져오시오.			

select
   *
from tblMovie
    where directorNum = (select directorNum from tblDirector where directorName = '봉준호');

-- 4. 씨네 21 평점 6.0 이상 + 네티즌 평점 6.0 이상  받은 영화를 가져오시오.

 select
    m.movieTitle,
    round(e.avgExpertStar,2) as "씨네21 평점",
    round(a.avgAudienceStar,2) as "네티즌 평점"
   
from tblMovie m
    inner join (
        select movieNum, avg(expertStar) as avgExpertStar
            from tblExpertReview
                group by movieNum ) e on m.movieNum = e.movieNum
                    inner join (
                        select movieNum, avg(audienceStar) as avgAudienceStar
                            from tblAudienceReview
                                group by movieNum) a on m.movieNum = a.movieNum
                                    where e.avgExpertStar >= 6 and a.avgAudienceStar >= 6;
                        

-- 5. 등록된 영화 중 가장 많은 영화에 참여한 배우와 영화를 가져오시오.			
select 
    distinct m.movietitle,
    ac.actorname
from tblMovie m
    join tblAppear a on m.movieNum = a.movieNum
    join tblActor ac on a.actorNum = ac.actorNum
        where ac.actorNum = (
            select actorNum 
            from (select 
                    actornum, 
                    count(*) as cnt,
                    row_number() over(order by count(*) desc) as rnum
                from tblAppear
                    group by actorNum)
            where rnum= 1);
		
-- 6. 장르 중 '드라마'와 '액션'을 동시에 속한 영화를 가져오시오.			
select
    movietitle as 영화제목,
    listagg(g.genreName, ', ') within group (order by g.genreName) as 장르
from tblMovie m
    join tblMovieGenre mg on m.movieNum = mg.movieNum
    join tblMGenre g on mg.genreNum = g.genreNum
        where m.movieNum in (
            select 
                movieNum
            from tblMovieGenre mg
               join tblMGenre g on mg.genreNum = g.genreNum
                    where g.genreName in ('드라마', '액션')
                        group by movieNum
                            having count(distinct g.genreName) = 2)
    group by m.movietitle;
    
-- 7. 상영시간이 120분 미만인 영화를 가져오시오.	
select
    *
from tblMovie
    where runningTime <=120;

-- 8. 15세 이상 관람가 영화를 가져오시오.	
select 
    *
from tblMovie
    where movieRatingNum = (select movieRatingNum from tblRating
                                where rating = '15세이상관람가');
			
-- 9. 네티즌 리뷰가 가장 많이 달린 순으로 가져오시오.			
--리뷰많이 단 사람순
select 
    audienceID, 
    count(audienceReviewNum) as 리뷰많은사람순
from tblAudienceReview
    group by audienceID
        order by 리뷰많은사람순 DESC;

--리뷰많은 영화
select 
    m.movienum, 
    m.movietitle,
    count(a.audienceReview) as 리뷰수 
from tblmovie m
    join tblaudienceReview a on m.movienum = a.movienum
        group by m.movienum, m.movietitle
            order by 리뷰수 desc;

-- 10. 네티블 리뷰를 가장 많이 작성한 네티즌의 아이디를 가져오시오.			
select 
    audienceID, 
    리뷰많은사람
from (select audienceID, count(*) as 리뷰많은사람
        from tblAudienceReview
            group by audienceID
                order by 리뷰많은사람 desc)  
                    where rownum = 1;			
-- 11. 전문가 별점에 가장 많이 참여한 전문가의 이름을 가져오시오.		
select
    e.* ,
    count(*)
from tblexpert e
    join tblexpertreview b on e.expertnum = b.expertnum
        group by e.expertnum, e.expertname
            having count(*) = ( select max(review_count)
                from (select count(*) as review_count
                    from tblexpertreview
                        group by expertnum));