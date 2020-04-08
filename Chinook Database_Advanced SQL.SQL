/*Question 1
We want to find out the most popular music Genre for each country. 
We determine the most popular genre as the genre with the highest amount of purchases. 
Write a query that returns each country along with the top Genre. 
For countries where the maximum number of purchases is shared return all Genres.*/

WITH t1 as (
			select c.Country as Country, g.name as Genre, count(il.Quantity) as Purchase, g.GenreId
			From Invoice as i 
			Inner join InvoiceLine as il 
			on i.InvoiceId = il.InvoiceId 
			INNER join Customer as c
			on i.CustomerId = c.CustomerId
			INNER join Track as t
			on il.TrackId = t.TrackId 
			INNER join genre as g
			on t.GenreId = g.GenreId
			group by Country, Genre
		),
     t2 as (
			select Country, max(purchase) as P2
			from(	
				select c.Country as Country, g.name as Genre, count(il.Quantity) as Purchase
				From Invoice as i 
				Inner join InvoiceLine as il 
				on i.InvoiceId = il.InvoiceId 
				INNER join Customer as c
				on i.CustomerId = c.CustomerId
				INNER join Track as t
				on il.TrackId = t.TrackId 
				INNER join genre as g
				on t.GenreId = g.GenreId
				group by Country, Genre 
			)
			Group by Country
		)
		
select t1.purchase, t1.country, t1.Genre, t1.GenreId
from t1, t2
where t1.country = t2.country and t1.purchase = t2.P2

/* Question 2
Return all the track names that have a song length longer than the average song length. Though you could perform this with two queries. 
Imagine you wanted your query to update based on when new data is put in the database. 
Therefore, you do not want to hard code the average into your query. You only need the Track table to complete this query.

Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.*/

select name, Milliseconds
from track
where Milliseconds > 
	(
		SELECT avg(Milliseconds)
		FROM Track
	)
ORDER BY Milliseconds DESC

/*Question 3
Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.

You should only need to use the Customer and Invoice tables.*/

With t1 as (
		Select Country, FirstName, CustomerId, max(Spent) as TotalSpent
		from 
			(
				select C.Country, C.FirstName, C.LastName, C. CustomerId, SUM(I.total)as Spent
				from CUSTOMER AS C INNER JOIN Invoice AS I
				ON C.CustomerId = I.CustomerId
				group by C.Country, C. CustomerId
			)
		group by Country), 
     t2 as (
		select C.Country, C.FirstName, C.LastName, C. CustomerId, SUM(I.total)as Spent
		from CUSTOMER AS C INNER JOIN Invoice AS I
		ON C.CustomerId = I.CustomerId
		group by C.Country, C. CustomerId
	   )
select t1.Country, t1.TotalSpent, t2.FirstName as FirstName, t2.LastName as LastName, t2.CustomerId as CustomerId
from t1, t2
where t1.Country = t2.Country and t1.TotalSpent = t2.spent
ORDER BY TotalSpent DESC

=======================================================================================================================

Lesson 5 SQL Data Cleaning 

/* Q1. In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address 
they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website 
type exist in the accounts table.*/

SELECT RIGHT(website, 3) AS Extension, COUNT(*)as C
FROM accounts
GROUP BY RIGHT(website, 3)


/* Q2. There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table 
to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).*/

select left(upper(name),1) as name, count(*) as C 
from accounts
group by left(upper(name),1)
order by name


/* Q3. Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and 
a second group of those company names that start with a letter. What proportion of company names start with a letter?*/

Select sum(letter)as L, sum(num) as N
FROM 
(
	SELECT Left(UPPER(name), 1) AS N, 
	CASE WHEN Left(UPPER(name), 1) in ('0','1','2','3','4','5','6','7','8','9') then 1 else 0 end as NUM, 
	CASE WHEN Left(UPPER(name), 1) in 
	('0','1','2','3','4','5','6','7','8','9') then 0
	else 1 end as LETTER
	FROM accounts
) AS T1

/* Q4. Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?*/

Select sum(V) as Vowels , sum(O) as Others , count(V) as Total
from 
(
	Select name, Left(Upper(name),1) as L,
	CASE WHEN Left(Upper(name),1) IN ('A','E','I','O','U') then 1 
	else 0 end as V,
	CASE WHEN Left(Upper(name),1) IN 
	('A','E','I','O','U') then 0
	else 1 end as O
	from accounts
) as t1


/* Q5. Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.*/

select primary_poc, STRPOS(primary_poc,' '), Left(primary_poc, STRPOS(primary_poc,' ')-1) as FirstName, Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')) as LastName
from accounts

/* Q6. Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*/

select name, STRPOS(name,' '), Left(name, STRPOS(name,' ')-1) as FirstName, Right(name, length(name)-STRPOS(name,' ')) as LastName
from sales_reps


/* Q7. Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/

Select Left(primary_poc, STRPOS(primary_poc,' ')-1) as FirstName, Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')) as LastName, 
Concat(Left(primary_poc, STRPOS(primary_poc,' ')-1),'.', 
Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),'@',name,'.com' ) as Email
from accounts

/* Q8. You may have noticed that in the previous solution some of the company names include spaces, 
which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces 
in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.*/

Select name, Replace(name,' ','') as Trim, concat(Left(primary_poc, STRPOS(primary_poc,' ')-1),'.', 
Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),'@',Replace(name,' ',''),'.com' ) as Email
from accounts     
      
      
/* Q9. We would also like to create an initial password, which they will change after their first log in. 
The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name 
(lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters 
in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.*/

Select primary_poc, 
LOWER(Left(primary_poc,1)) as First1, 
LOWER(RIGHT(Left(primary_poc, STRPOS(primary_poc,' ')-1),1)) as First2,
LOWER(Left(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),1)) as Last1,
LOWER(Right(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),1)) as Last2, 
LENGTH(Left(primary_poc, STRPOS(primary_poc,' ')-1)) AS CF, 
LENGTH(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')))as CL, 
UPPER(Replace(name,' ','')) as CompanyName,
CONCAT(
LOWER(Left(primary_poc,1)), 
LOWER(RIGHT(Left(primary_poc, STRPOS(primary_poc,' ')-1),1)),
LOWER(Left(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),1)),
LOWER(Right(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' ')),1)), 
LENGTH(Left(primary_poc, STRPOS(primary_poc,' ')-1)), 
LENGTH(Right(primary_poc, length(primary_poc)-STRPOS(primary_poc,' '))), 
UPPER(Replace(name,' ','')) 
 ) AS PASSWORD
from accounts
