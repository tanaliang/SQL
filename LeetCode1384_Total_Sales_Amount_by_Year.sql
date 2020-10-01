With cte as
(select min(year(period_start)) as start_year, max(year(period_end)) as end_year from sales),

cte1 as
(select start_year as report_year from cte
 union all
 select report_year + 1 from cte1,cte where report_year < end_year)
 
Select sales.PRODUCT_ID, PRODUCT_NAME, CAST(REPORT_YEAR AS varchar) as REPORT_YEAR,
   (datediff(day, 
   case when report_year <> year(period_start) then cast(cast(report_year as varchar)+'-01'+'-01' as date) else period_start end,
   case when report_year <> year(period_end) then cast(cast(report_year as varchar)+'-12'+'-31' as date) else period_end end)+1)*average_daily_sales as TOTAL_AMOUNT
from sales 
left join cte1
on cte1.report_year >= year(period_start) and cte1.report_year <= year(period_end)
inner join product as p
on p.product_id = sales. product_id
ORDER BY sales.PRODUCT_ID, REPORT_YEAR
