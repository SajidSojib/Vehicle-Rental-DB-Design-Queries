# Vehicle Rental System - Database Design & SQL Queries

## 📋 Project Overview
A comprehensive Vehicle Rental System database designed to manage users, vehicles, and bookings with efficient SQL queries for common rental operations.

## 🗺️ Entity Relationship Diagram (ERD)
*visit: https://drawsql.app/teams/sajid-3/diagrams/first*


## 📊 Sample Data

### Users Data
| user_id | name    | email                | phone       | role     |
|---------|---------|----------------------|-------------|----------|
| 1       | Alice   | alice@example.com    | 1234567890  | Customer |
| 2       | Bob     | bob@example.com      | 0987654321  | Admin    |
| 3       | Charlie | charlie@example.com  | 1122334455  | Customer |

### Vehicles Data
| vehicle_id | name           | type  | model | registration_number | rental_price | status       |
|------------|----------------|-------|-------|---------------------|--------------|--------------|
| 1          | Toyota Corolla | car   | 2022  | ABC-123            | 50.00        | available    |
| 2          | Honda Civic    | car   | 2021  | DEF-456            | 60.00        | rented       |
| 3          | Yamaha R15     | bike  | 2023  | GHI-789            | 30.00        | available    |
| 4          | Ford F-150     | truck | 2020  | JKL-012            | 100.00       | maintenance  |

### Bookings Data
| booking_id | user_id | vehicle_id | start_date  | end_date    | status     | total_cost |
|------------|---------|------------|-------------|-------------|------------|------------|
| 1          | 1       | 2          | 2023-10-01  | 2023-10-05  | completed  | 240.00     |
| 2          | 1       | 2          | 2023-11-01  | 2023-11-03  | completed  | 120.00     |
| 3          | 3       | 2          | 2023-12-01  | 2023-12-02  | confirmed  | 60.00      |
| 4          | 1       | 1          | 2023-12-10  | 2023-12-12  | pending    | 100.00     |

## 🔍 Queries Analysis & Solutions

### **Query 1: Retrieve booking information along with Customer name and Vehicle name.**
```sql
SELECT 
  b.booking_id, 
  c.name as customer_name, 
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM bookings as b
INNER JOIN users as c USING (user_id)
INNER JOIN vehicles as v USING (vehicle_id);
```

**📈 Result:**
| booking_id | customer_name | vehicle_name  | start_date  | end_date    | status     |
|------------|---------------|---------------|-------------|-------------|------------|
| 1          | Alice         | Honda Civic   | 2023-10-01  | 2023-10-05  | completed  |
| 2          | Alice         | Honda Civic   | 2023-11-01  | 2023-11-03  | completed  |
| 3          | Charlie       | Honda Civic   | 2023-12-01  | 2023-12-02  | confirmed  |
| 4          | Alice         | Toyota Corolla| 2023-12-10  | 2023-12-12  | pending    |

### 📌 Purpose

This query retrieves complete booking information along with the **customer name** and **vehicle name** for each booking.

### 🧠 Explanation

* `bookings (b)` is the main table containing booking details.
* `users (c)` is joined using `user_id` to get the customer name.
* `vehicles (v)` is joined using `vehicle_id` to get the vehicle name.
* `INNER JOIN` is used, so only bookings that have both a valid customer and a valid vehicle are shown.

---

### **Query 2: Find Vehicles That Have Never Been Booked**
```sql
SELECT * FROM vehicles as v
WHERE NOT EXISTS(
  SELECT * FROM bookings as b 
  WHERE v.vehicle_id = b.vehicle_id
);
```

**📈 Result:**
| vehicle_id | name       | type | model | registration_number | rental_price | status    |
|------------|------------|------|-------|---------------------|--------------|-----------|
| 3          | Yamaha R15 | bike | 2023  | GHI-789            | 30.00        | available |
| 4          | Ford F-150 | truck| 2020  | JKL-012            | 100.00       | maintenance |

### 📌 Purpose

This query finds vehicles that do **not appear** in the bookings table, meaning they have never been booked.

### 🧠 Explanation

* The outer query selects all vehicles from the `vehicles` table.
* The `NOT EXISTS` subquery checks whether a matching `vehicle_id` exists in the `bookings` table.
* If no matching booking is found, the vehicle is returned.

---

### **Query 3: Retrieve Available Vehicles by Type**
```sql
SELECT * FROM vehicles
WHERE status = 'available' AND type = 'car';
```

**📈 Result:**
| vehicle_id | name           | type | model | registration_number | rental_price | status    |
|------------|----------------|------|-------|---------------------|--------------|-----------|
| 1          | Toyota Corolla | car  | 2022  | ABC-123            | 50.00        | available |

### 📌 Purpose

This query retrieves all vehicles that are currently **available** and of type **car**.

### 🧠 Explanation

* Filters vehicles where:

  * `status = 'available'`
  * `type = 'car'`
* Only vehicles matching **both conditions** are shown.

---

### **Query 4: Find Popular Vehicles That Have More Than 2 Bookings**
```sql
SELECT
  v.name as vehicle_name,
  COUNT(*) as total_bookings
FROM bookings as b
INNER JOIN vehicles as v USING (vehicle_id)
GROUP BY v.vehicle_id
HAVING COUNT(b.booking_id) > 2;
```

**📈 Result:**
| vehicle_name | total_bookings |
|--------------|----------------|
| Honda Civic  | 3              |

### 📌 Purpose

This query counts how many times each vehicle has been booked and displays only those vehicles that have **more than 2 bookings**.

### 🧠 Explanation

* `bookings` is joined with `vehicles` using `vehicle_id`.
* `COUNT(*)` counts total bookings per vehicle.
* `GROUP BY v.vehicle_id` groups bookings by vehicle.
* `HAVING COUNT(b.booking_id) > 2` filters vehicles with more than two bookings.


## 📝 License & Acknowledgments

This project is developed for educational purposes. Feel free to modify and extend based on your requirements.

**Author**: Sajid Ahmed Sojib
**Tools Used**: PostgreSQL, DrawSQL for ERD  
**Date**: 23 December 2023

---