-- database_index.sql
-- Additional Indexes for AirBnB Database

-- This script contains CREATE INDEX statements for columns
-- frequently used in WHERE clauses, ORDER BY clauses, and JOIN operations,
-- beyond the primary keys and foreign keys already explicitly indexed in schema.sql.
-- These indexes aim to further optimize query performance.

-- Index on Property.location for efficient geographical searches
CREATE INDEX idx_property_location ON Property (location);

-- Index on Property.pricepernight for range queries (e.g., price filtering)
CREATE INDEX idx_property_pricepernight ON Property (pricepernight);

-- Index on Booking.start_date for availability checks and date range queries
CREATE INDEX idx_booking_start_date ON Booking (start_date);

-- Index on Booking.end_date for availability checks and date range queries
CREATE INDEX idx_booking_end_date ON Booking (end_date);

-- Index on Booking.status for filtering bookings by their current state
CREATE INDEX idx_booking_status ON Booking (status);

-- Composite index for efficient querying on Booking dates and property_id
-- This can be particularly useful for availability checks:
-- SELECT * FROM Booking WHERE property_id = ? AND start_date < ? AND end_date > ?
CREATE INDEX idx_booking_property_dates ON Booking (property_id, start_date, end_date);
