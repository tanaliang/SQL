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
