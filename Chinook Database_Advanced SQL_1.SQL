/*Question 1
We want to find out the most popular music Genre for each country. 
We determine the most popular genre as the genre with the highest amount of purchases. 
Write a query that returns each country along with the top Genre. 
For countries where the maximum number of purchases is shared return all Genres.*/

select distinct Country, Genre, max(purchase) AS Popular
FROM
(
select c.Country as Country, g.name as Genre, count(il.Quantity) as Purchase
from Invoice as i 
Inner join InvoiceLine as il 
on i.InvoiceId = il.InvoiceId 
INNER join Customer as c
on i.CustomerId = c.CustomerId
INNER join Track as t
on il.TrackId = t.TrackId 
INNER join genre as g
on t.GenreId = g.GenreId
group by Country, Genre
order by purchase desc)
group by Country
