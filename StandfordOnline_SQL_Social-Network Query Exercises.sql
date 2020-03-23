-- Q1. Find the names of all students who are friends with someone named Gabriel.

SELECT H2.name
FROM FRIEND AS F
INNER JOIN HIGHSCHOOLER AS H1
ON F.ID1=H1.ID
INNER JOIN HIGHSCHOOLER AS H2
ON F.ID2=H2.ID
WHERE H1.NAME = 'Gabriel'

-- Q2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.

SELECT h.name, h.grade, h2.name, h2.grade
FROM HIGHSCHOOLER as h
inner join likes as l 
on h.id=l.id1
inner join highschooler as h2
on h2.id=l.id2
where h.grade > h2.grade and h.grade-h2.grade >=2

-- Q3. For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.

select h1.name, h1.grade, h2.name, h2.grade
from highschooler as h1, highschooler as h2, likes as l1, likes as l2
where (h1.id = l1.id1 and h2.id = l1.id2) and (h1.id = l2.id2 and h2.id = l2.id1) and (h1.name < h2.name)

-- Q4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.

SELECT NAME, GRADE 
FROM HIGHSCHOOLER 
WHERE ID NOT IN( 
SELECT ID1
FROM LIKES 
UNION 
SELECT ID2
FROM LIKES )
ORDER BY GRADE, NAME

-- Q5. For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.

SELECT h1.name, h1.grade, h2.name, h2.grade 
from highschooler as h1, highschooler as h2, likes as l
on h1.id = l.id1 and h2.id = l.id2
where l.id2 in 
(select id2
from likes
except
select id1
from likes)

-- Q6. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.

select name, grade 
from highschooler 
where id not in 
(select h1.id
from highschooler as h1, highschooler as h2, friend as f
where h1.id = f.id1 and h2.id = f.id2 and h1.grade <> h2.grade)
order by grade, name

-- Q7. For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.

select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Highschooler H2, Highschooler H3, Likes L, Friend F1, Friend F2
where (h1.id = l.id1) and (h2.id = l.id2) and (h2.id not in 
(select id2
from friend 
where id1 = h1.id)) and 
(h1.id = f1.id1 and h3.id = f1.id2) and (h2.id = f2.id1 and h3.id = f2.id2)

-- Q8. Find the difference between the number of students in the school and the number of different first names.

select count(name) - count (distinct name)
from highschooler 

-- Q9. Find the name and grade of all students who are liked by more than one other student.

select j.name, j.grade  
from likes as l
inner join highschooler as j
on l.id2 = j.id 
group by id2
having count(id2) >= 2 


