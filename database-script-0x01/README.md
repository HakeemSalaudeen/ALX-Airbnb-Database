# AirBnB Database Schema Design

This project defines the database schema for an AirBnB-like application. The schema is designed for optimal performance, data integrity, and minimal redundancy, adhering to Third Normal Form (3NF).

## Table of Contents

- [Overview](#overview)
- [Entities and Attributes](#entities-and-attributes)
  - [User](#user)
  - [Property](#property)
  - [Booking](#booking)
  - [Payment](#payment)
  - [Review](#review)
  - [Message](#message)
- [Constraints](#constraints)
- [Indexing](#indexing)
- [Usage](#usage)

## Overview

The schema supports core AirBnB functionalities: user management, property listings, bookings, payments, reviews, and messaging. Each component is represented as a table, with relationships established via foreign keys.

## Entities and Attributes

### User

- `user_id`: UUID, Primary Key
- `first_name`: VARCHAR, NOT NULL
- `last_name`: VARCHAR, NOT NULL
- `email`: VARCHAR, UNIQUE, NOT NULL
- `password_hash`: VARCHAR, NOT NULL
- `phone_number`: VARCHAR, NULLABLE
- `role`: ENUM('guest', 'host', 'admin'), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Property

- `property_id`: UUID, Primary Key
- `host_id`: Foreign Key → User(user_id), NOT NULL, ON DELETE CASCADE
- `name`: VARCHAR, NOT NULL
- `description`: TEXT, NOT NULL
- `location`: VARCHAR, NOT NULL
- `pricepernight`: DECIMAL(10,2), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### Booking

- `booking_id`: UUID, Primary Key
- `property_id`: Foreign Key → Property(property_id), NOT NULL, ON DELETE CASCADE
- `user_id`: Foreign Key → User(user_id), NOT NULL, ON DELETE CASCADE
- `start_date`: DATE, NOT NULL
- `end_date`: DATE, NOT NULL
- `total_price`: DECIMAL(10,2), NOT NULL
- `status`: ENUM('pending', 'confirmed', 'canceled'), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Payment

- `payment_id`: UUID, Primary Key
- `booking_id`: Foreign Key → Booking(booking_id), NOT NULL, ON DELETE CASCADE
- `amount`: DECIMAL(10,2), NOT NULL
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `payment_method`: ENUM('credit_card', 'paypal', 'stripe'), NOT NULL

### Review

- `review_id`: UUID, Primary Key
- `property_id`: Foreign Key → Property(property_id), NOT NULL, ON DELETE CASCADE
- `user_id`: Foreign Key → User(user_id), NOT NULL, ON DELETE CASCADE
- `rating`: INTEGER, NOT NULL, CHECK (1 ≤ rating ≤ 5)
- `comment`: TEXT, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Message

- `message_id`: UUID, Primary Key
- `sender_id`: Foreign Key → User(user_id), NOT NULL, ON DELETE CASCADE
- `recipient_id`: Foreign Key → User(user_id), NOT NULL, ON DELETE CASCADE
- `message_body`: TEXT, NOT NULL
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Constraints

- **Primary Keys:** Ensure unique identification for each record.
- **Foreign Keys:** Enforce referential integrity between tables. Most use `ON DELETE CASCADE`.
- **Unique Constraints:** Enforce uniqueness (e.g., `User.email`).
- **NOT NULL Constraints:** Essential fields cannot be empty.
- **ENUM Constraints:** Restrict values to predefined options.
- **CHECK Constraints:** E.g., `Review.rating` must be between 1 and 5.

## Indexing

- Index on `User.email` for efficient lookup.
- Indexes on all foreign key columns to optimize joins and lookups.

