-- joins_queries.sql
-- SQL Queries Demonstrating JOIN Types, Subqueries, and Aggregate Functions/Window Functions for AirBnB Database

-- Query 1: Retrieve all bookings and the respective users who made those bookings.
-- This uses an INNER JOIN, which returns rows when there is a match in both tables.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    B.status,
    U.user_id,
    U.first_name,
    U.last_name,
    U.email
FROM
    Booking AS B
INNER JOIN
    User AS U ON B.user_id = U.user_id;

-- Query 2: Retrieve all properties and their reviews, including properties that have no reviews.
-- This uses a LEFT JOIN (or LEFT OUTER JOIN), which returns all rows from the left table (Property)
-- and the matching rows from the right table (Review). If there's no match, NULLs are returned for Review columns.
SELECT
    P.property_id,
    P.name AS property_name,
    P.location,
    P.pricepernight,
    R.review_id,
    R.rating,
    R.comment AS review_comment,
    R.created_at AS review_date
FROM
    Property AS P
LEFT JOIN
    Review AS R ON P.property_id = R.property_id;

-- Query 3: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
-- MySQL does not directly support FULL OUTER JOIN. This query simulates it using a UNION of LEFT JOIN and RIGHT JOIN (or LEFT JOIN and anti-LEFT JOIN)
-- to cover all records from both tables.

-- Part A: Get all users and their bookings (matching or not)
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    B.booking_id,
    B.start_date,
    B.end_date,
    B.status
FROM
    User AS U
LEFT JOIN
    Booking AS B ON U.user_id = B.user_id

UNION ALL

-- Part B: Get all bookings that might not have a matching user (and their associated user data if any, but focus on non-matched bookings)
-- This part specifically targets bookings that might *not* have a user, ensuring they are included.
-- In a well-normalized schema with FK constraints, this part *should* ideally yield no results (unless data integrity is compromised),
-- but it's crucial for a technically correct FULL OUTER JOIN simulation.
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    B.booking_id,
    B.start_date,
    B.end_date,
    B.status
FROM
    User AS U
RIGHT JOIN
    Booking AS B ON U.user_id = B.user_id
WHERE
    U.user_id IS NULL; -- This condition ensures we only get rows from Booking that had no match in User

-- Query 4: Find all properties where the average rating is greater than 4.0 using a subquery.
-- This query uses a subquery to first calculate the average rating for each property
-- and then filters properties based on that average.
SELECT
    P.property_id,
    P.name AS property_name,
    P.location,
    AVG_R.average_rating
FROM
    Property AS P
INNER JOIN (
    SELECT
        property_id,
        AVG(rating) AS average_rating
    FROM
        Review
    GROUP BY
        property_id
    HAVING
        AVG(rating) > 4.0
) AS AVG_R ON P.property_id = AVG_R.property_id;

-- Query 5: Find users who have made more than 3 bookings using a correlated subquery.
-- This query uses a correlated subquery to count bookings for each user.
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    U.email
FROM
    User AS U
WHERE (
    SELECT
        COUNT(B.booking_id)
    FROM
        Booking AS B
    WHERE
        B.user_id = U.user_id
) > 3;

-- Query 6: Find the total number of bookings made by each user, using COUNT and GROUP BY.
-- This query aggregates bookings by user and counts them.
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    COUNT(B.booking_id) AS total_bookings
FROM
    User AS U
LEFT JOIN -- Use LEFT JOIN to include users who have made no bookings
    Booking AS B ON U.user_id = B.user_id
GROUP BY
    U.user_id, U.first_name, U.last_name
ORDER BY
    total_bookings DESC;

-- Query 7: Rank properties based on the total number of bookings they have received using a window function.
-- This query uses a Common Table Expression (CTE) to first count bookings per property,
-- and then applies the RANK() window function to assign a rank based on that count.
WITH PropertyBookingCounts AS (
    SELECT
        P.property_id,
        P.name AS property_name,
        COUNT(B.booking_id) AS num_bookings
    FROM
        Property AS P
    LEFT JOIN
        Booking AS B ON P.property_id = B.property_id
    GROUP BY
        P.property_id, P.name
)
SELECT
    property_id,
    property_name,
    num_bookings,
    RANK() OVER (ORDER BY num_bookings DESC) AS booking_rank
FROM
    PropertyBookingCounts
ORDER BY
    booking_rank ASC, property_name ASC;

