# Additional Indexes for AirBnB Database

This document describes additional SQL indexes created to optimize query performance in the AirBnB database. These indexes are intended for columns frequently used in `WHERE` clauses, `ORDER BY` clauses, and `JOIN` operations, beyond the primary and foreign keys already defined in `schema.sql`.

## Indexes Included

- **Property.location**  
  For efficient geographical searches:
  ```sql
  CREATE INDEX idx_property_location ON Property (location);
  ```

- **Property.pricepernight**  
  For range queries and price filtering:
  ```sql
  CREATE INDEX idx_property_pricepernight ON Property (pricepernight);
  ```

- **Booking.start_date**  
  For availability checks and date range queries:
  ```sql
  CREATE INDEX idx_booking_start_date ON Booking (start_date);
  ```

- **Booking.end_date**  
  For availability checks and date range queries:
  ```sql
  CREATE INDEX idx_booking_end_date ON Booking (end_date);
  ```

- **Booking.status**  
  For filtering bookings by their current state:
  ```sql
  CREATE INDEX idx_booking_status ON Booking (status);
  ```

- **Booking(property_id, start_date, end_date)**  
  Composite index for efficient querying on booking dates and property:
  ```sql
  CREATE INDEX idx_booking_property_dates ON Booking (property_id, start_date, end_date);
  ```
  _Useful for queries like:_  
  `SELECT * FROM Booking WHERE property_id = ? AND start_date < ? AND end_date > ?`

## Usage

To apply these indexes, run the corresponding `CREATE INDEX` statements in your SQL client after creating your tables.

---

These indexes help improve the performance of common queries and should be reviewed and adjusted based on actual query patterns and database size.
