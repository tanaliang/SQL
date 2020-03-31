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

