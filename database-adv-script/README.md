# SQL Join Queries for AirBnB Database

This document provides SQL queries demonstrating different types of joins (INNER JOIN, LEFT JOIN, FULL OUTER JOIN simulation) for the AirBnB database schema. These queries are fundamental for combining data from multiple related tables.

## Table of Contents

- [Overview](#overview)
- [Query Examples](#query-examples)
  - [1. INNER JOIN: Bookings with Users](#1-inner-join-bookings-with-users)
  - [2. LEFT JOIN: Properties with Reviews (Including No Reviews)](#2-left-join-properties-with-reviews-including-no-reviews)
  - [3. FULL OUTER JOIN Simulation: Users with Bookings (All Users and All Bookings)](#3-full-outer-join-simulation-users-with-bookings-all-users-and-all-bookings)
- [Usage](#usage)

## Overview

SQL JOIN clauses are used to combine rows from two or more tables, based on a related column between them. Different types of joins retrieve different sets of data, making them versatile tools for complex data retrieval.

These queries assume you have already set up the AirBnB database schema using `schema.sql` and populated it with sample data using `seed.sql`.

## Query Examples

### 1. INNER JOIN: Bookings with Users

**Objective:** Retrieve all bookings and the details of the users who made those bookings. Only bookings that are successfully linked to a user will be returned.

```sql
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
```

**Explanation:**  
An INNER JOIN returns only the rows that have matching values in both tables (Booking and User) based on the join condition (`B.user_id = U.user_id`). Bookings without a corresponding user or users without bookings will not appear in the result set.

---

### 2. LEFT JOIN: Properties with Reviews (Including No Reviews)

**Objective:** Retrieve all properties and any associated reviews. Properties that do not have any reviews will still be included in the result, with NULL values for the review-related columns.

```sql
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
```

**Explanation:**  
A LEFT JOIN returns all rows from the left table (Property) and the matching rows from the right table (Review). If there is no match, the review columns will be NULL, ensuring every property is included.

---

### 3. FULL OUTER JOIN Simulation: Users with Bookings (All Users and All Bookings)

**Objective:** Retrieve all users and all bookings, including users with no bookings and bookings with no user (though the latter should not occur with proper constraints).

```sql
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

-- Part B: Get all bookings that might not have a matching user
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
    U.user_id IS NULL;
```

**Explanation:**  
MySQL does not natively support FULL OUTER JOIN. This query simulates it using a combination of LEFT JOIN and UNION ALL with a RIGHT JOIN. The first SELECT gets all users and their bookings; the second SELECT gets bookings without a matching user.

---

## Usage

To execute these queries:

1. Ensure you have a MySQL-compatible database set up with the AirBnB schema (`schema.sql`) and sample data (`seed.sql`).
2. Copy and paste individual queries into your SQL client (e.g., MySQL Workbench, DBeaver, command-line client), or run the entire `joins_queries.sql` file:

   ```sh
   mysql -u your_username -p your_database_name < joins_queries.sql
   ```

   Replace `your_username` and `your_database_name` with your actual database credentials.