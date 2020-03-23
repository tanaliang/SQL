-- Q1. For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.

select h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from highschooler as h1, highschooler as h2, highschooler as h3, likes as l1, likes as l2
where (h1.id = l1.id1 and h2.id = l1.id2) and (h2.id = l2.id1 and  h3.id = l2.id2) and (h1.id <>l2.id2)

-- Q2. Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.

select name, grade
from highschooler
where id not in 
(select h1.id
from highschooler as h1, highschooler as h2, friend as f
where (h1.id = f.id1 and h2.id = f.id2) and (h1.grade = h2.grade))

-- Q3. What is the average number of friends per student? (Your result should be just one number.)

select AVG(C)
FROM 
(select count(id2) as C
FROM friend as f
group by id1)

-- Q4. Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.

select count(*)
from friend 
where id2 in 
(
select id1
from friend 
where id2 in 
(select id 
from highschooler 
where name = 'Cassandra'))

-- Q5. Find the name and grade of the student(s) with the greatest number of friends.

SELECT H.NAME, H.GRADE
FROM HIGHSCHOOLER as h 
inner join friend as f 
on h.id = f.id1 
group by f.id1
having COUNT(*)=
(
select MAX(C)
FROM 
(select count(id2) as C
from friend 
group by id1))
