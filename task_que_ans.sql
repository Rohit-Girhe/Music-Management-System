## Q.1. Who is the senior most employee based on job title?

SELECT first_name, last_name, title, hire_date
FROM EMPLOYEE
ORDER BY hire_date ASC
LIMIT 1;

##-------------------------------------------------------------------------------------------------------##

## Q.2. Which countries have the most Invoices?

SELECT billing_country, COUNT(*) AS invoice_count
FROM invoice
GROUP BY billing_country
ORDER BY invoice_count DESC;

## 3. What are the top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

## Q.4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT billing_city, SUM(total) AS total_spending
FROM invoice
GROUP BY billing_city
ORDER BY total_spending DESC
limit 1;

## Q.5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

SELECT c.first_name, c.last_name, SUM(i.total) AS total_spending
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spending DESC
LIMIT 1;

## Q.6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email ASC; 

## Q.7. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT ar.name AS artist_name, COUNT(t.track_id) AS rock_track_count
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id
ORDER BY rock_track_count DESC
LIMIT 10;

## Q.8. Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first

SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

## Q.9. Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent 

SELECT c.first_name, c.last_name, ar.name AS artist_name, SUM( CAST(il.unit_price AS DECIMAL(10, 2)) * CAST(il.quantity AS SIGNED) ) AS total_spent_on_artist
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY c.customer_id, ar.artist_id, c.first_name, c.last_name, ar.name
ORDER BY total_spent_on_artist DESC;

## Q.10. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared, return all Genres

-- Step 1: Count purchases by genre for each country
WITH genre_purchases AS (
    SELECT c.country, g.name AS genre_name, COUNT(il.invoice_line_id) AS purchase_count
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),

-- Step 2: Find the maximum purchase count per country
max_genre_per_country AS (
    SELECT country, MAX(purchase_count) AS max_purchases 
    FROM genre_purchases
    GROUP BY country
)

-- Step 3: Join both CTEs to get all genres with max purchases
SELECT gp.country, gp.genre_name AS most_popular_genre, gp.purchase_count AS total_purchases
FROM genre_purchases gp
JOIN max_genre_per_country mgc 
ON gp.country = mgc.country 
AND gp.purchase_count = mgc.max_purchases
ORDER BY gp.country, gp.genre_name;

## Q.11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount
-- Step 1: Calculate total spending by customer for each country
WITH customer_spending AS (
    SELECT c.country, c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(CAST(il.unit_price AS DECIMAL(10, 2)) * CAST(il.quantity AS SIGNED)) AS total_spent
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    GROUP BY c.country, c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
),

-- Step 2: Find the maximum spending amount per country
max_spending_per_country AS (
    SELECT country, MAX(total_spent) AS max_spending
    FROM customer_spending
    GROUP BY country
)

-- Step 3: Join both CTEs to get all customers who spent the max amount in their country
SELECT cs.country, cs.customer_name, cs.customer_id, cs.total_spent AS amount_spent
FROM customer_spending cs
JOIN max_spending_per_country msc 
ON cs.country = msc.country 
AND cs.total_spent = msc.max_spending
ORDER BY cs.country, cs.customer_name;
