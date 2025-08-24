create database airlinereservationdb;
use airlinereservationdb;
-- Flights Table
create table flights (
    flight_id int auto_increment primary key,
    flight_number varchar(10) not null unique,
    origin varchar(50),
    destination varchar(50),
    departure_time datetime,
    arrival_time datetime,
    total_seats int check (total_seats > 0)
);

-- Customers Table
create table customers (
    customer_id int auto_increment primary key,
    full_name varchar(100),
    email varchar(100) unique,
    phone varchar(15)
);

-- Bookings Table
create table bookings (
    booking_id int auto_increment primary key,
    customer_id int,
    flight_id int,
    booking_date datetime default current_timestamp,
    seat_number varchar(5),
    status enum('confirmed', 'cancelled') default 'confirmed',
    foreign key (customer_id) references customers(customer_id),
    foreign key (flight_id) references flights(flight_id)
);

-- Seats Table
create table seats (
    seat_id int auto_increment primary key,
    flight_id int,
    seat_number varchar(5),
    is_booked boolean default false,
    foreign key (flight_id) references flights(flight_id)
);

insert into flights (flight_number, origin, destination, departure_time, arrival_time, total_seats) values
('AI101', 'mumbai', 'delhi', '2024-07-20 08:00:00', '2024-07-20 10:30:00', 180),
('AI102', 'delhi', 'mumbai', '2024-07-21 15:00:00', '2024-07-21 17:30:00', 180),
('AI103', 'mumbai', 'bangalore', '2024-07-22 09:00:00', '2024-07-22 11:30:00', 150);

insert into customers (full_name, email, phone) values
('john doe', 'john@example.com', '9876543210'),
('emma stone', 'emma@example.com', '8765432109'),
('liam smith', 'liam@example.com', '7654321098');


insert into seats (flight_id, seat_number) values
(1, '1A'), (1, '1B'), (1, '1C'), (1, '2A'), (1, '2B');

insert into bookings (customer_id, flight_id, seat_number) values
(1, 1, '1A'),
(2, 1, '1B'),
(3, 2, '1A');

-- Find available seats for a flight
select seat_number from seats
where flight_id = 1 and is_booked = false;

-- Search flights from Mumbai to Delhi
select * from flights
where origin = 'mumbai' and destination = 'delhi';

-- joins
-- Customers with their Bookings
select c.full_name, b.seat_number, f.flight_number
from customers c
inner join bookings b on c.customer_id = b.customer_id
inner join flights f on b.flight_id = f.flight_id;

-- All Flights and Bookings (even if no booking)
select f.flight_number, b.booking_id, b.status
from flights f
left join bookings b on f.flight_id = b.flight_id;

select b.booking_id, c.full_name
from bookings b
right join customers c on b.customer_id = c.customer_id;

-- Total seats booked per flight
select f.flight_number, count(b.booking_id) as total_bookings
from flights f
join bookings b on f.flight_id = b.flight_id
group by f.flight_number;

-- Average seats booked per flight
select avg(seat_count) as average_bookings
from (
    select count(*) as seat_count
    from bookings
    group by flight_id
) as booking_summary;

-- Stored Procedure: Cancel a booking
delimiter //
create procedure cancel_booking(in b_id int)
begin
    update bookings set status = 'cancelled' where booking_id = b_id;
    update seats set is_booked = false
    where seat_number = (select seat_number from bookings where booking_id = b_id)
    and flight_id = (select flight_id from bookings where booking_id = b_id);
end //
delimiter ;

-- Call Procedure
call cancel_booking(1);

-- Stored Function: Count bookings for a customer
delimiter //
create function count_customer_bookings(c_id int)
returns int
deterministic
begin
    declare total int;
    select count(*) into total from bookings where customer_id = c_id;
    return total;
end //
delimiter ;

-- Use Function
select full_name, count_customer_bookings(customer_id) as total_bookings from customers;

-- Trigger: Update seat status on booking
delimiter //
create trigger after_booking_insert
after insert on bookings
for each row
begin
    update seats set is_booked = true
    where seat_number = new.seat_number and flight_id = new.flight_id;
end //
delimiter ;

-- View for Flight Availability
create view flight_availability as
select f.flight_number, count(s.seat_id) - sum(s.is_booked) as seats_available
from flights f
join seats s on f.flight_id = s.flight_id
group by f.flight_number;

-- update flight details
update flights
set departure_time = '2024-07-21 09:00:00'
where flight_number = 'AI101';

-- mark a seat as available again
update seats
set is_booked = false
where seat_number = '1B' and flight_id = 1;


