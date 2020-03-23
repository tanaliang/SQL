-- Q1. Find the names of all reviewers who rated Gone with the Wind.

select distinct name 
from reviewer as re
inner join rating as r
on re.rid = r.rid
inner join movie as m
on m.mid = r.mid
where title = 'Gone with the Wind' and stars is not null

-- Q2. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

select distinct name, title, stars 
from reviewer as re
inner join rating as r
on re.rid = r.rid
inner join movie as m
on m.mid = r.mid
where director = name

-- Q3. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)

select  name
from reviewer as re
left outer join rating as r
on re.rid = r.rid
union 
select title
from movie as m
left outer join rating as r
on m.mid = r.mid
order by name, title

-- Q4. Find the titles of all movies not reviewed by Chris Jackson.

Select distinct title 
from movie as m
left outer join rating as r
on m.mid = r.mid
left outer join reviewer as re
on re.rid = r.rid
where title not in (
select  title
from movie as m
left outer join rating as r
on m.mid = r.mid
left outer join reviewer as re
on re.rid = r.rid
where name is 'Chris Jackson')

/* Q5. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
       Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. 
       For each pair, return the names in the pair in alphabetical order.
*/
SELECT DISTINCT T2.NAME, T1.NAME
FROM
(Select title, max(name) as name 
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid
group by title
having count(*) > 1) AS T1,
(Select distinct title, name  
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid) as T2
WHERE T1.title = T2.title AND T1.name <> T2.name 
ORDER BY T2.NAME

-- Q6. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.

select name, title, stars
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid
where stars in 
(select min(stars)
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid)

-- Q7. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.

select title, avg(stars)
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid
group by title
order by avg(stars) desc, title

-- Q8. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)

select ROW_NUMBER () OVER (partition by name order by name) as R, name, stars
from movie as m
inner join rating as r
on m.mid = r.mid
inner join reviewer as re
on re.rid = r.rid

-- Q9. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)

SELECT TITLE,DIRECTOR
FROM MOVIE
WHERE DIRECTOR IN 
(select director
from movie
GROUP BY DIRECTOR
HAVING COUNT(*)>=2)
ORDER BY DIRECTOR, TITLE

-- Q10. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
(Hint: This query is more difficult to write in SQLite than other systems; 
you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)

select title, AVG(stars) 
from movie as m
inner join 
rating as r
on m.mid = r.mid
GROUP BY TITLE
HAVING AVG(stars) in
(select max(S) 
from (
select title, avg(stars) as S
from movie as m
inner join 
rating as r
on m.mid = r.mid
group by title))

-- Q11. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)

select title, AVG(stars) 
from movie as m
inner join 
rating as r
on m.mid = r.mid
GROUP BY TITLE
HAVING AVG(stars) in
(select min(S) 
from (
select title, avg(stars) as S
from movie as m
inner join 
rating as r
on m.mid = r.mid
group by title))

-- Q12. For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.

select director, title,max(stars) 
from movie as m
inner join 
rating as r
on m.mid = r.mid
GROUP BY director
having director is not null



