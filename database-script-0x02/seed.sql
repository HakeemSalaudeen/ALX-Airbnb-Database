-- seed.sql
-- Sample Data for AirBnB Database

-- User Sample Data
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('user-101', 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_alice_123', '111-222-3333', 'guest'),
('user-102', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_bob_456', '444-555-6666', 'host'),
('user-103', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_charlie_789', '777-888-9999', 'guest'),
('user-104', 'Diana', 'Prince', 'diana.prince@example.com', 'hashed_password_diana_012', '123-456-7890', 'host'),
('user-105', 'Eve', 'Adams', 'eve.adams@example.com', 'hashed_password_eve_345', NULL, 'admin');

-- Property Sample Data
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
('prop-201', 'user-102', 'Cozy Downtown Apartment', 'A comfortable apartment in the heart of the city.', 'New York, USA', 150.00),
('prop-202', 'user-102', 'Lakeside Cabin Retreat', 'Secluded cabin with beautiful lake views.', 'Lake Tahoe, USA', 250.00),
('prop-203', 'user-104', 'Beachfront Villa', 'Luxurious villa right on the beach.', 'Miami, USA', 500.00),
('prop-204', 'user-104', 'Mountain View Chalet', 'Rustic chalet with stunning mountain vistas.', 'Aspen, USA', 300.00);

-- Booking Sample Data
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('book-301', 'prop-201', 'user-101', '2025-07-10', '2025-07-15', 750.00, 'confirmed'), -- 5 nights * 150
('book-302', 'prop-202', 'user-103', '2025-08-01', '2025-08-07', 1500.00, 'pending'), -- 6 nights * 250
('book-303', 'prop-203', 'user-101', '2025-09-01', '2025-09-03', 1000.00, 'confirmed'), -- 2 nights * 500
('book-304', 'prop-204', 'user-103', '2025-10-10', '2025-10-12', 600.00, 'canceled'); -- 2 nights * 300

-- Payment Sample Data
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('pay-401', 'book-301', 750.00, 'credit_card'),
('pay-402', 'book-303', 1000.00, 'paypal');

-- Review Sample Data
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('rev-501', 'prop-201', 'user-101', 5, 'Absolutely loved the downtown apartment! Perfect location and very clean.'),
('rev-502', 'prop-203', 'user-101', 4, 'Beautiful villa, but a bit noisy at night. Still recommend.'),
('rev-503', 'prop-201', 'user-103', 4, 'Great place, responsive host. Would stay again.');

-- Message Sample Data
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
('msg-601', 'user-101', 'user-102', 'Hi Bob, is the downtown apartment available for July 10-15?'),
('msg-602', 'user-102', 'user-101', 'Yes, Alice! It is currently available.'),
('msg-603', 'user-103', 'user-104', 'Hi Diana, interested in the Mountain View Chalet for October. Any special deals?'),
('msg-604', 'user-104', 'user-103', 'Hello Charlie, let me check and get back to you soon!');

-- Notification Sample Data
INSERT INTO Notification (notification_id, user_id, message) VALUES
('notif-701', 'user-101', 'Your booking for Cozy Downtown Apartment has been confirmed!'),
('notif-702', 'user-102', 'New booking request from Alice for July 10-15.'),
('notif-703', 'user-103', 'Your booking for Lakeside Cabin Retreat is pending approval.'),
('notif-704', 'user-104', 'New message from Charlie regarding Mountain View Chalet.');