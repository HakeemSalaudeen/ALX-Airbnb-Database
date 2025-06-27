-- Database Schema Definition for AirBnB Application

-- Drop tables in reverse order of dependency to avoid foreign key constraints issues
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS User;

-- Create User Table
CREATE TABLE User (
    user_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- Unique constraint on email
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20), -- NULLable
    role ENUM('guest', 'host', 'admin') NOT NULL, -- Enum for user roles
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Property Table
CREATE TABLE Property (
    property_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    host_id VARCHAR(36) NOT NULL, -- Foreign Key to User
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically updates on row modification
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Create Booking Table
CREATE TABLE Booking (
    booking_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    property_id VARCHAR(36) NOT NULL, -- Foreign Key to Property
    user_id VARCHAR(36) NOT NULL, -- Foreign Key to User (the guest making the booking)
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL, -- Enum for booking status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Create Payment Table
CREATE TABLE Payment (
    payment_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    booking_id VARCHAR(36) NOT NULL, -- Foreign Key to Booking
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL, -- Enum for payment method
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- Create Review Table
CREATE TABLE Review (
    review_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    property_id VARCHAR(36) NOT NULL, -- Foreign Key to Property
    user_id VARCHAR(36) NOT NULL, -- Foreign Key to User (the reviewer)
    rating INTEGER NOT NULL, -- Rating from 1 to 5
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_rating CHECK (rating >= 1 AND rating <= 5), -- Check constraint for rating value
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Create Message Table
CREATE TABLE Message (
    message_id VARCHAR(36) PRIMARY KEY NOT NULL, -- Primary Key, UUID
    sender_id VARCHAR(36) NOT NULL, -- Foreign Key to User (sender)
    recipient_id VARCHAR(36) NOT NULL, -- Foreign Key to User (recipient)
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Create Indexes for Optimal Performance
-- Indexes are crucial for speeding up data retrieval operations, especially on columns used in WHERE clauses or JOIN conditions.

-- Index on email for quick user lookup
CREATE INDEX idx_user_email ON User (email);

-- Indexes for foreign keys (often automatically indexed by some DBs, but good practice to explicitly define)
CREATE INDEX idx_property_host_id ON Property (host_id);
CREATE INDEX idx_booking_property_id ON Booking (property_id);
CREATE INDEX idx_booking_user_id ON Booking (user_id);
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);
CREATE INDEX idx_review_property_id ON Review (property_id);
CREATE INDEX idx_review_user_id ON Review (user_id);
CREATE INDEX idx_message_sender_id ON Message (sender_id);
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);
