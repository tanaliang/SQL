/*<<SQL Movie-Rating Modification Exercises>>*/

-- Q1. Add the reviewer Roger Ebert to your database, with an rID of 209.

insert into reviewer
(rid,name)
values (209, 'Roger Ebert')

-- Q2. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.

insert into rating 
 ( rID, mID, stars, ratingDate )
SELECT RID, MID, '5',NULL
FROM REVIEWER, MOVIE
where name = 'James Cameron'

-- Q3. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)

UPDATE MOVIE
SET YEAR = YEAR + 25
WHERE MID IN 
(SELECT MID
FROM RATING
GROUP BY MID
HAVING AVG (STARS) >= 4 )

-- Q4. Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.

DELETE FROM RATING
WHERE MID IN 
(SELECT MID 
FROM MOVIE 
WHERE YEAR <1970 OR YEAR > 2000) AND STARS < 4

/*<<SQL Social-Network Modification Exercises>>*/

-- Q1. It's time for the seniors to graduate. Remove all 12th graders from Highschooler.

DELETE FROM HIGHSCHOOLER 
WHERE GRADE  >=12

-- Q2. If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.

delete from likes
where id2 in 
(select id2 
from friend as f
where f.id1 = likes.id1
AND id2 not in 
(select id1
from likes as l2
where l2.id2 = likes.id1))

/* Q3. For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
(This one is a bit challenging; congratulations if you get it right.)*/

insert into friend 
select f1.id1, f2.id2
from friend as f1, friend as f2
where f1.id2 = f2.id1 and f1.id1 <> f2.id2 
except
select * from friend 

