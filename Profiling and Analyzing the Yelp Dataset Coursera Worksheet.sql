Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would.
For this first part of the assignment, you will be assessed both on the correctness of your findings, as well as the code you used to arrive at your answer. 
You will be graded on how easy your code is to read, so remember to use proper formatting and comments where necessary.

In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer.
You will be required to prepare the dataset for the analysis you choose to do. As with the first part, you will be graded, in part, on how easy your code is to read, 
so use proper formatting and comments to illustrate and communicate your intent as required.

For both parts of this assignment, use this "worksheet." It provides all the questions you are being asked, and your job will be to transfer your answers 
and SQL coding where indicated into this worksheet so that your peers can review your work. You should be able to use any Text Editor (
Windows Notepad, Apple TextEdit, Notepad ++, Sublime Text, etc.) to copy and paste your answers. If you are going to use Word or some other page layout application, 
just be careful to make sure your answers and code are lined appropriately.
In this case, you may want to save as a PDF to ensure your formatting remains intact for you reviewer.



Part 1: Yelp Dataset Profiling and Understanding

1. Profile the data by finding the total number of records for each of the tables below:
	
          i. Attribute table = 10000
          ii. Business table = 10000
          iii. Category table = 10000
          iv. Checkin table = 10000
          v. elite_years table = 10000
          vi. friend table = 10000
          vii. hours table = 10000
          viii. photo table = 10000
          ix. review table = 10000
          x. tip table = 10000
          xi. user table = 10000
	


2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

          i. Business = 10000 by business_id
          ii. Hours = 1562 by business_id
          iii. Category = 2643 by business_id
          iv. Attribute = 1115 by business_id
          v. Review = 10000 by id
          vi. Checkin = 493 by business_id
          vii. Photo = 10000
          viii. Tip = 537
          ix. User = 10000
          x. Friend = 11
          xi. Elite_years = 2780

Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.	



3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: No
	
	
	SQL code used to arrive at answer:
	
        Select Count(*)
        FROM user
        WHERE 
        name IS NULL OR
        review_count IS NULL OR
        yelping_since IS NULL OR
        useful IS NULL OR
        funny IS NULL OR
        cool IS NULL OR
        fans IS NULL OR
        average_stars IS NULL OR
        compliment_hot IS NULL OR
        compliment_more IS NULL OR
        compliment_profile IS NULL OR
        compliment_cute IS NULL OR
        compliment_list IS NULL OR
        compliment_note IS NULL OR
        compliment_plain IS NULL OR
        compliment_cool IS NULL OR
        compliment_funny IS NULL OR
        compliment_writer IS NULL OR
        compliment_photos IS NULL

	
4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars
	
		min: 1		max: 5		avg: 3.7082
		
	
	ii. Table: Business, Column: Stars
	
		min: 1.0		max: 5.0		avg: 3.6549
		
	
	iii. Table: Tip, Column: Likes
	
		min: 0		max: 2		avg: 0.0144
		
	
	iv. Table: Checkin, Column: Count
	
		min: 1		max: 53		avg: 1.9414
		
	
	v. Table: User, Column: Review_count
	
		min: 0		max: 2000		avg: 24.2995
		


5. List the cities with the most reviews in descending order: Las Vegas

	SQL code used to arrive at answer:
	
          Select city, count(r.id) as numofreview 
          From business b inner join review r on b.id = r.business_id 
          group by city 
          order by numofreview desc
          limit 1
	
	Copy and Paste the Result Below:

          +-----------+-------------+
        | city      | numofreview |
        +-----------+-------------+
        | Las Vegas |         193 |
        +-----------+-------------+

	
6. Find the distribution of star ratings to the business in the following cities:

i. Avon

SQL code used to arrive at answer:

          Select stars, sum(review_count) as ratingcount
          From business 
          where city = "Avon"
          group by stars

Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):

          +-------+-------------+
          | stars | ratingcount |
          +-------+-------------+
          |   1.5 |          10 |
          |   2.5 |           6 |
          |   3.5 |          88 |
          |   4.0 |          21 |
          |   4.5 |          31 |
          |   5.0 |           3 |
          +-------+-------------+

ii. Beachwood

SQL code used to arrive at answer:

        Select stars, sum(review_count) as ratingcount
        From business 
        where city = "Beachwood"
        group by stars


Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):

        +-------+-------------+
        | stars | ratingcount |
        +-------+-------------+
        |   2.0 |           8 |
        |   2.5 |           3 |
        |   3.0 |          11 |
        |   3.5 |           6 |
        |   4.0 |          69 |
        |   4.5 |          17 |
        |   5.0 |          23 |
        +-------+-------------+

7. Find the top 3 users based on their total number of reviews:
		
	SQL code used to arrive at answer:
	
        Select id, review_count
        from user
        order by review_count desc
        limit 3
		
	Copy and Paste the Result Below:
		
        +------------------------+--------------+
        | id                     | review_count |
        +------------------------+--------------+
        | -G7Zkl1wIWBBmD0KRy_sCw |         2000 |
        | -3s52C4zL_DHRK0ULG6qtg |         1629 |
        | -8lbUNlXVSoXqaRRiHiSNg |         1339 |
        +------------------------+--------------+

8. Does posing more reviews correlate with more fans?

	Please explain your findings and interpretation of the results:
  
        When two variables are correlate, that means they are linear related. If we collect the result of the query for reveiw_count and fans, 
        and construct a scatter diagram to see whether there is a relationship between these two variables. My observation conclude there is no correlation 
        between review_count and fans as when the number of review_count decrease, the number of fans varies randomly.  
  
  
	
        Select review_count, fans
        from user
        order by review_count desc, fans 
        +--------------+------+
        | review_count | fans |
        +--------------+------+
        |         2000 |  253 |
        |         1629 |   50 |
        |         1339 |   76 |
        |         1246 |  101 |
        |         1215 |  126 |
        |         1153 |  311 |
        |         1116 |   16 |
        |         1039 |  104 |
        |          968 |  497 |
        |          930 |  173 |
        |          904 |   38 |
        |          864 |   43 |
        |          862 |  124 |
        |          861 |  115 |
        |          842 |   85 |
        |          836 |   37 |
        |          834 |  120 |
        |          813 |  159 |
        |          775 |   61 |
        |          754 |   78 |
        |          702 |   35 |
        |          696 |   10 |
        |          694 |  101 |
        |          676 |   25 |
        |          675 |   45 |
        +--------------+------+
	
9. Are there more reviews with the word "love" or with the word "hate" in them?

	Answer: There are more words with "love", which appear in 1780 different reviews whereas word "hate" appears 232 times in different reviews.  

	
	SQL code used to arrive at answer:

          Select count(id)
          from review
          where text like "%love%"  --- number of review for word "love"
          +-----------+
          | count(id) |
          +-----------+
          |      1780 |
          +-----------+

          Select count(id)
          from review
          where text like "%hate%" --- number of review for word "hate"
          +-----------+
          | count(id) |
          +-----------+
          |       232 |
          +-----------+
	
	
10. Find the top 10 users with the most fans:

	SQL code used to arrive at answer:
	
          Select id, name, fans
          from user
          order by fans desc
          limit 10
	
	Copy and Paste the Result Below:

            +------------------------+-----------+------+
          | id                     | name      | fans |
          +------------------------+-----------+------+
          | -9I98YbNQnLdAmcYfb324Q | Amy       |  503 |
          | -8EnCioUmDygAbsYZmTeRQ | Mimi      |  497 |
          | --2vR0DIsmQ6WfcSzKWigw | Harald    |  311 |
          | -G7Zkl1wIWBBmD0KRy_sCw | Gerald    |  253 |
          | -0IiMAZI2SsQ7VmyzJjokQ | Christine |  173 |
          | -g3XIcCb2b-BD0QBCcq2Sw | Lisa      |  159 |
          | -9bbDysuiWeo2VShFJJtcw | Cat       |  133 |
          | -FZBTkAZEXoP7CYvRV2ZwQ | William   |  126 |
          | -9da1xk7zgnnfO1uTVYGkA | Fran      |  124 |
          | -lh59ko3dxChBSZ9U7LfUw | Lissa     |  120 |
          +------------------------+-----------+------+
		

Part 2: Inferences and Analysis

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. 
Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.

        city is "Las Vegas"
	
i. Do the two groups you chose to analyze have a different distribution of hours?

        Yes, the hours between stores with rating of 2-3 stars and rating of 4-5 stars differ. Whenever the stores are open for 2-3 stars, stores of 4-5 stars 
        are not open. The same observations apply to the opposite scenario. 

        Select city, stars, hours,
        case when stars between 2.0 and 3.0 then hours end as lowstars,
        case when stars between 4.0 and 5.0 then hours end as highstars
        from business b inner join hours h on b.id = h.business_id
        where city = "Las Vegas"
        and (stars between 2.0 and 3.0 or stars between 4.0 and 5.0)
        group by stars,  hours
        order by stars 
        +-----------+-------+----------------------+----------------------+--------------------+
        | city      | stars | hours                | lowstars             |          highstars |
        +-----------+-------+----------------------+----------------------+--------------------+
        | Las Vegas |   2.5 | Friday|8:00-22:00    | Friday|8:00-22:00    |               None |
        | Las Vegas |   2.5 | Monday|8:00-22:00    | Monday|8:00-22:00    |               None |
        | Las Vegas |   2.5 | Saturday|8:00-22:00  | Saturday|8:00-22:00  |               None |
        | Las Vegas |   2.5 | Sunday|8:00-22:00    | Sunday|8:00-22:00    |               None |
        | Las Vegas |   2.5 | Thursday|8:00-22:00  | Thursday|8:00-22:00  |               None |
        | Las Vegas |   2.5 | Tuesday|8:00-22:00   | Tuesday|8:00-22:00   |               None |
        | Las Vegas |   2.5 | Wednesday|8:00-22:00 | Wednesday|8:00-22:00 |               None |
        | Las Vegas |   3.0 | Friday|11:00-0:00    | Friday|11:00-0:00    |               None |
        | Las Vegas |   3.0 | Monday|11:00-0:00    | Monday|11:00-0:00    |               None |
        | Las Vegas |   3.0 | Saturday|11:00-0:00  | Saturday|11:00-0:00  |               None |
        | Las Vegas |   3.0 | Sunday|11:00-0:00    | Sunday|11:00-0:00    |               None |
        | Las Vegas |   3.0 | Thursday|11:00-0:00  | Thursday|11:00-0:00  |               None |
        | Las Vegas |   3.0 | Tuesday|11:00-0:00   | Tuesday|11:00-0:00   |               None |
        | Las Vegas |   3.0 | Wednesday|11:00-0:00 | Wednesday|11:00-0:00 |               None |
        | Las Vegas |   4.0 | Friday|10:00-19:00   | None                 | Friday|10:00-19:00 |
        | Las Vegas |   4.0 | Friday|10:00-23:00   | None                 | Friday|10:00-23:00 |
        | Las Vegas |   4.0 | Friday|11:00-20:00   | None                 | Friday|11:00-20:00 |
        | Las Vegas |   4.0 | Friday|8:00-17:00    | None                 |  Friday|8:00-17:00 |
        | Las Vegas |   4.0 | Friday|9:00-17:00    | None                 |  Friday|9:00-17:00 |
        | Las Vegas |   4.0 | Monday|10:00-19:00   | None                 | Monday|10:00-19:00 |
        | Las Vegas |   4.0 | Monday|10:00-23:00   | None                 | Monday|10:00-23:00 |
        | Las Vegas |   4.0 | Monday|11:00-20:00   | None                 | Monday|11:00-20:00 |
        | Las Vegas |   4.0 | Monday|7:30-17:00    | None                 |  Monday|7:30-17:00 |
        | Las Vegas |   4.0 | Monday|8:00-17:00    | None                 |  Monday|8:00-17:00 |
        | Las Vegas |   4.0 | Monday|9:00-17:00    | None                 |  Monday|9:00-17:00 |
        +-----------+-------+----------------------+----------------------+--------------------+

ii. Do the two groups you chose to analyze have a different number of reviews?

        Yes, the two groups do have different number of reviews. 

        Select stars,
        case when stars between 2.0 and 3.0 then sum(review_count) end as lowstars_reviewcount,
        case when stars between 4.0 and 5.0 then sum(review_count) end as highstars_reviewcount
        from business 
        where city = "Las Vegas"
        group by stars 
        +-------+----------------------+-----------------------+
        | stars | lowstars_reviewcount | highstars_reviewcount |
        +-------+----------------------+-----------------------+
        |   1.0 |                 None |                  None |
        |   1.5 |                 None |                  None |
        |   2.0 |                 1855 |                  None |
        |   2.5 |                 4846 |                  None |
        |   3.0 |                 8564 |                  None |
        |   3.5 |                 None |                  None |
        |   4.0 |                 None |                 25128 |
        |   4.5 |                 None |                 17803 |
        |   5.0 |                 None |                  4021 |
        +-------+----------------------+-----------------------+

         
iii. Are you able to infer anything from the location data provided between these two groups? Explain.

        When look at city in Las Vegas with its neighborhood as location separators, I observed that most neighborhoods have more than double review_counts 
        for star rating between 4.0-5.0 than star rating of 2.0-3.0. Very few neighborhood, such as Sunrise, have more review_counts for star rating of 2.0-3.0 
        than 4.0-5.0.  

SQL code used for analysis:

        Select neighborhood, cat, sum(reviewcount) as rc
        from 
        (Select state, city, neighborhood, stars, 
        case when stars between 2.0 and 3.0 then "lowstars"
             when stars between 4.0 and 5.0 then "highstars" end as cat,
        sum(review_count) reviewcount
        from business 
        where 
        state = "NV"
        and
        city = "Las Vegas" 
        and 
        ((stars between 2.0 and 3.0)
        or (stars between 4.0 and 5.0))
        group by state, city, neighborhood, stars
        order by state) t
        group by neighborhood, cat

          +-----------------+-----------+------+
          | neighborhood    | cat       |   rc |
          +-----------------+-----------+------+
          |                 | highstars | 5290 |
          |                 | lowstars  | 1959 |
          | Anthem          | highstars |   28 |
          | Centennial      | highstars |  939 |
          | Centennial      | lowstars  |  678 |
          | Chinatown       | highstars | 3559 |
          | Chinatown       | lowstars  |  589 |
          | Downtown        | highstars | 6704 |
          | Downtown        | lowstars  |  247 |
          | Eastside        | highstars | 2342 |
          | Eastside        | lowstars  | 1190 |
          | Northwest       | highstars |  590 |
          | Northwest       | lowstars  |  148 |
          | South Summerlin | highstars | 1072 |
          | South Summerlin | lowstars  |  345 |
          | Southeast       | highstars | 2814 |
          | Southeast       | lowstars  | 1977 |
          | Southwest       | highstars | 1737 |
          | Southwest       | lowstars  |  391 |
          | Spring Valley   | highstars | 4150 |
          | Spring Valley   | lowstars  |  632 |
          | Summerlin       | highstars | 1204 |
          | Summerlin       | lowstars  |  209 |
          | Sunrise         | highstars |   65 |
          | Sunrise         | lowstars  |  222 |
          +-----------------+-----------+------+

2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones 
that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:

          Based on the number of store per category accounts for the total number of stores as percentage, we can see the top 3 categories that are closed 
          are "Restaurant, Nightlife, Bars", whereas the top 3 categories that are open are "Restaurant, Shopping, Food."

          Select category, 
          round((count(*)*1.0/(Select count(*) from business where is_open = 0))*100,2) as ClosePercentage
          from business b inner join category c on b.id = c.business_id
          where is_open = 0
          group by category
          order by count(*) desc
          limit 10

            +---------------------------+-----------------+
            | category                  | ClosePercentage |
            +---------------------------+-----------------+
            | Restaurants               |            1.18 |
            | Nightlife                 |            0.53 |
            | Bars                      |            0.39 |
            | Shopping                  |            0.33 |
            | American (New)            |             0.2 |
            | American (Traditional)    |             0.2 |
            | Event Planning & Services |             0.2 |
            | Food                      |             0.2 |
            | Desserts                  |            0.13 |
            | Gluten-Free               |            0.13 |
            +---------------------------+-----------------+

            Select category, 
            round((count(*)*1.0/(Select count(*) from business where is_open = 1))*100,2) as OpenPercentage
            from business b inner join category c on b.id = c.business_id
            where is_open = 1
            group by category
            order by count(*) desc
            limit 10
            +------------------+----------------+
            | category         | OpenPercentage |
            +------------------+----------------+
            | Restaurants      |           0.63 |
            | Shopping         |           0.29 |
            | Food             |           0.24 |
            | Health & Medical |           0.19 |
            | Home Services    |           0.18 |
            | Beauty & Spas    |           0.14 |
            | Nightlife        |           0.14 |
            | Bars             |           0.13 |
            | Active Life      |           0.12 |
            | Local Services   |           0.12 |
            +------------------+----------------+
         
ii. Difference 2:

            The obsevations here are the top 3 city that have the most numbers of stores closed are "Las Vegas, Toronto, Phoenix" in a descending order; 
            although these are the same cities that have most stores open for the top 3 but are in a different descending order, which are 
            "Las Vegas, Phoenix, Toronto."

SQL code used for analysis:

              Select is_open, city, count(*)
              from business 
              where is_open = 0
              group by is_open, city 
              order by count(*) desc
              limit 10
            +---------+------------+----------+
            | is_open | city       | count(*) |
            +---------+------------+----------+
            |       0 | Las Vegas  |      250 |
            |       0 | Toronto    |      197 |
            |       0 | Phoenix    |      152 |
            |       0 | Scottsdale |       80 |
            |       0 | Charlotte  |       70 |
            |       0 | Pittsburgh |       58 |
            |       0 | Montréal   |       54 |
            |       0 | Edinburgh  |       53 |
            |       0 | Tempe      |       48 |
            |       0 | Chandler   |       44 |
            +---------+------------+----------+        

            Select is_open, city, count(*)
            from business 
            where is_open = 1
            group by is_open, city 
            order by count(*) desc
            limit 10

            +---------+------------+----------+
            | is_open | city       | count(*) |
            +---------+------------+----------+
            |       1 | Las Vegas  |     1311 |
            |       1 | Phoenix    |      849 |
            |       1 | Toronto    |      788 |
            |       1 | Scottsdale |      417 |
            |       1 | Charlotte  |      398 |
            |       1 | Pittsburgh |      295 |
            |       1 | Montréal   |      283 |
            |       1 | Mesa       |      260 |
            |       1 | Henderson  |      239 |
            |       1 | Tempe      |      213 |
            +---------+------------+----------+


	
	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data 
for analysis. Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or 
anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples 
to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. Indicate the type of analysis you chose to do:

          The problem statement for my analysis is "What are the key business attributes differentiate the stores with star rating of 4-5 that are still in business 
          compared to the stores that are closed but with star rating of 1-2 when considering rating?

          Select stars, count(*)
          from business
          where is_open = 1
          group by stars
          +-------+----------+
          | stars | count(*) |
          +-------+----------+
          |   1.0 |      142 |
          |   1.5 |      182 |
          |   2.0 |      472 |
          |   2.5 |      722 |
          |   3.0 |     1124 |
          |   3.5 |     1483 |
          |   4.0 |     1679 |
          |   4.5 |     1249 |
          |   5.0 |     1427 |
          +-------+----------+
         
         
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

          I was trying to find some differentiators between the two groups based on some attributes, such as category and hours. However, due to data availability, 
          I chose the column "name" under table "attibute" for my further analysis as a business amenity differtiates two groups. 

                  
iii. Output of your finished dataset:
 
        From the first table, we can see the top 5 amenity the 4-5 stars stores have in common are :
        "BusinessAcceptsCreditCards"
        "BikeParking"
        "BusinessParking"
        "RestaurantsPriceRange2"
        "ByAppointmentOnly"

        When compared this data to the 1-2 stars, not much stores have these top 5 amenity in their business. We would recommend business owners to consider provide
        these 5 amenity to support the business in the long run. 
            +-------+----------------------------+----------+
            | stars |                       name | count(*) |
            +-------+----------------------------+----------+
            |   4.0 |                       None |     1664 |
            |   5.0 |                       None |     1416 |
            |   4.0 | BusinessAcceptsCreditCards |       14 |
            |   5.0 | BusinessAcceptsCreditCards |       11 |
            |   4.0 |                BikeParking |        8 |
            |   4.0 |            BusinessParking |        8 |
            |   4.0 |     RestaurantsPriceRange2 |        8 |
            |   5.0 |          ByAppointmentOnly |        7 |
            |   4.0 |          ByAppointmentOnly |        6 |
            |   4.0 |         RestaurantsTakeOut |        6 |
            |   4.0 |                     Caters |        5 |
            |   4.0 |             OutdoorSeating |        5 |
            |   4.0 |        RestaurantsDelivery |        5 |
            |   4.0 |                       WiFi |        5 |
            |   4.0 |                    Alcohol |        4 |
            |   4.0 |                   Ambience |        4 |
            |   4.0 |                GoodForKids |        4 |
            |   4.0 |                GoodForMeal |        4 |
            |   4.0 |                      HasTV |        4 |
            |   4.0 |                 NoiseLevel |        4 |
            |   4.0 |          RestaurantsAttire |        4 |
            |   4.0 |   RestaurantsGoodForGroups |        4 |
            |   4.0 |    RestaurantsReservations |        4 |
            |   4.0 |    RestaurantsTableService |        4 |
            |   4.0 |       WheelchairAccessible |        4 |
            +-------+----------------------------+----------+   
            +-------+----------------------------+----------+
            | stars |                       name | count(*) |
            +-------+----------------------------+----------+
            |   2.0 |                       None |       88 |
            |   1.0 |                       None |       14 |
            |   2.0 | BusinessAcceptsCreditCards |        4 |
            |   2.0 |   RestaurantsGoodForGroups |        4 |
            |   2.0 |     RestaurantsPriceRange2 |        4 |
            |   2.0 |             OutdoorSeating |        3 |
            |   2.0 |                    Alcohol |        2 |
            |   2.0 |            BusinessParking |        2 |
            |   2.0 |                GoodForKids |        2 |
            |   2.0 |                GoodForMeal |        2 |
            |   2.0 |                      HasTV |        2 |
            |   2.0 |                      Music |        2 |
            |   2.0 |          RestaurantsAttire |        2 |
            |   2.0 |        RestaurantsDelivery |        2 |
            |   2.0 |         RestaurantsTakeOut |        2 |
            |   2.0 |       WheelchairAccessible |        2 |
            |   2.0 |                AgesAllowed |        1 |
            |   2.0 |                BikeParking |        1 |
            |   2.0 |          ByAppointmentOnly |        1 |
            |   2.0 |                 NoiseLevel |        1 |
            |   2.0 |    RestaurantsReservations |        1 |
            |   2.0 |                    Smoking |        1 |
            |   2.0 |                       WiFi |        1 |
            +-------+----------------------------+----------+

         
iv. Provide the SQL code you used to create your final dataset:

          Select stars, a.name, count(*)
          from business b left join attribute a on b.id = a.business_id
          where is_open = 1 
          and (stars = 4 or stars = 5)
          group by stars, a.name
          order by count(*) desc

          Select stars, a.name, count(*)
          from business b left join attribute a on b.id = a.business_id
          where is_open = 0 
          and (stars = 1 or stars = 2)
          group by stars, a.name
          order by count(*) desc
