-- Retrieve booking information along with Customer name and Vehicle name.
select 
  b.booking_id, 
  c.name as customer_name, 
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from bookings as b
inner join users as c using (user_id)
inner join vehicles as v using (vehicle_id);


-- Find all vehicles that have never been booked.
select * from vehicles as v
where not exists(
  select * from bookings as b 
  where v.vehicle_id = b.vehicle_id
);


-- Retrieve all available vehicles of a specific type (e.g. cars).
select * from vehicles
where status = 'available' and type = 'car';


-- Find the total number of bookings for each vehicle and 
-- display only those vehicles that have more than 2 bookings.
select
  v.name as vehicle_name,
  count(*) as total_bookings
from bookings as b
inner join vehicles as v using (vehicle_id)
group by v.vehicle_id
having count(b.booking_id)>2;