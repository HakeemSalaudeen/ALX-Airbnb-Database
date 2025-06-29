-- joins_queries.sql
-- SQL Queries Demonstrating JOIN Types for AirBnB Database

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
