-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team 72
-- Aishwarya Mahale(amahale6@gatech.edu)
-- Upasanna Krishnan (ukrishnan3@gatech.edu)
-- Rohan Bukhar (rbukhar3@gatech.edu)
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.

-- ----------------------------------------------------
-- VIEWS AND STORED PROCEDURES BELOW
-- ----------------------------------------------------

-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin

if exists (select Email from Customer where Email = i_email)
then leave sp_main; end if;
if exists (select a.email from accounts as a 
	inner join clients as c on a.email = c.email
    where a.Email = i_email and c.Phone_Number = i_phone_number)
    then insert into Customer(Email, CcNumber, Cvv, Exp_Date, Location) values (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
	leave sp_main;
    end if;
if exists (select Phone_Number from clients where Phone_Number = i_phone_number) 
then leave sp_main; end if;
if exists (select Phone_Number, Email from clients where Phone_Number = i_phone_number and Email = i_email) 
then leave sp_main; end if;
if exists (select CcNumber from customer where CcNumber = i_cc_number) 
then leave sp_main; end if;
if exists (select a.email from accounts as a 
	inner join clients as c on a.email = c.email
    where (a.Email = i_email and c.Phone_Number <> i_phone_number) or (a.Email <> i_email and c.Phone_Number = i_phone_number)) 
    then leave sp_main; end if;
insert into Accounts(Email, First_Name, Last_Name, Pass) values (i_email, i_first_name, i_last_name, i_password);
insert into Clients(Email, Phone_Number) values (i_email, i_phone_number);
insert into Customer(Email, CcNumber, Cvv, Exp_Date, Location) values (i_email, i_cc_number, i_cvv, i_exp_date, i_location);
end //
delimiter ;


-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin

if exists (select Email from owners where Email = i_email)
	then leave sp_main; end if;
if exists (select a.email from accounts as a 
	inner join clients as c on a.email = c.email
    where a.Email = i_email)
    then insert into Owners(Email) values (i_email);
    leave sp_main; end if;
if exists (select Email, Phone_Number from clients where Email = i_Email and Phone_Number = i_phone_number)
	then leave sp_main;  end if;
if exists (select Phone_Number from clients where Phone_Number = i_phone_number) 
	then leave sp_main; end if;

insert into Accounts(Email, First_Name, Last_Name,Pass) values (i_email, i_first_name,i_last_name, i_password);
insert into Clients(Email, Phone_Number) values (i_email, i_phone_number);
insert into Owners(Email) values (i_email);
end //
delimiter ;

-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
if (exists (select Owner_email from Property where owner_email = i_owner_email)) then leave sp_main; end if;
if (not exists (select email from customer where email = i_owner_email)) then 
    delete from owners_rate_customers where owner_Email = i_owner_email;
	delete from review where owner_Email = i_owner_email;
	delete from owners where email = i_owner_email;
    delete from clients where Email = i_owner_email;
    delete from accounts where Email = i_owner_email;
else
	delete from owners_rate_customers where owner_Email = i_owner_email;
	delete from review where owner_Email = i_owner_email;
	delete from owners where email = i_owner_email;
end if;
end //
delimiter ;

-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin

if(i_flight_date < i_current_date ) then leave sp_main; end if;
if(i_from_airport = i_to_airport ) then leave sp_main; end if;
if(exists (select Flight_Num, Airline_Name from Flight 
where Flight_Num = i_flight_num and Airline_Name = i_airline_name)) then leave sp_main; end if;
if not exists (select Airport_Id from airport where Airport_Id = i_from_airport) or not exists
(select Airport_Id from airport where Airport_Id = i_to_airport) then leave sp_main; end if;

insert into Flight(Flight_Num, Airline_Name, From_Airport, To_Airport, Departure_Time, Arrival_Time, Flight_Date, Cost, Capacity) 
values (i_flight_num, i_airline_name, i_from_airport, i_to_airport, i_departure_time, i_arrival_Time, i_flight_date, i_cost, i_capacity);

end //
delimiter ;

-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin

if(i_current_date > (select Flight_Date from Flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num)) then leave sp_main; end if;
delete from Book where Flight_Num=i_flight_num and Airline_Name=i_airline_name;
delete from Flight where Flight_Num=i_flight_num and Airline_Name=i_airline_name;
end //
delimiter ;

-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin

if(i_num_seats > (select Capacity from Flight where Flight_Num = i_flight_num and Airline_name = i_airline_name) - 
(select sum(Num_Seats) from Book where Flight_Num = i_flight_num and Airline_Name = i_airline_name and Was_Cancelled = 0
group by Flight_Num,Airline_Name)) then leave sp_main; end if;
if(i_current_date > (select Flight_Date from Flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num)) then leave sp_main; end if;

if(exists (select Customer, Flight_Num, Airline_Name from book 
where Flight_Num = i_flight_num and Airline_Name = i_airline_name and Customer = i_customer_email and Was_Cancelled =1)) then leave sp_main; end if;

if(exists (select Customer, Flight_Num, Airline_Name from book 
where Flight_Num = i_flight_num and Airline_Name = i_airline_name and Customer = i_customer_email and Was_Cancelled =0)) then
update book set Num_Seats = Num_Seats + i_num_seats where Flight_Num = i_flight_num and 
Airline_Name = i_airline_name and Customer = i_customer_email; 
leave sp_main; end if;

if (exists (select Customer from book,flight where book.Flight_Num = flight.Flight_Num and book.Airline_Name = flight.Airline_Name
and Customer = i_customer_email and Flight_Date in (select Flight_Date from flight where Flight_Num = i_flight_num) and book.Was_Cancelled = 0))
then leave sp_main; end if;

insert into Book (Customer, Flight_Num, Airline_Name, Num_Seats, Was_Cancelled) values
(i_customer_email, i_flight_num, i_airline_name, i_num_seats, 0);
end //
delimiter ;

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin
if (not exists (select Customer, Flight_Num, Airline_Name from book 
where Airline_Name = i_airline_name and Flight_Num = i_flight_num and Customer = i_customer_email)) then leave sp_main; end if;
if(i_current_date >= (select Flight_Date from Flight where Airline_Name = i_airline_name  and Flight_Num = i_flight_num)) then leave sp_main; end if;
update book
set Was_Cancelled = 1 where Airline_Name = i_airline_name and Customer = i_customer_email and Flight_Num = i_flight_num;
end //
delimiter ;

-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as
select flight.Flight_Num as flight_id, Flight_Date as flight_date, Airline_Name as airline, To_Airport as destination, 
Cost as seat_cost, num_empty_seats, total_spent from flight join 
(select flight.Flight_Num, CASE WHEN sum(book.Num_Seats) is not null then (flight.Capacity - sum(book.Num_Seats)) 
ELSE flight.Capacity END as num_empty_seats from flight left outer join book 
on book.Flight_Num = flight.Flight_Num and book.Was_Cancelled = 0 group by flight.Flight_Num) as t1 join
(select flight.Flight_Num, coalesce(sum(if(book.Was_Cancelled = 0, flight.Cost*book.Num_Seats, flight.Cost*0.2*book.Num_Seats)),0) 
as total_spent from flight left outer join book on flight.Flight_Num = book.Flight_Num group by flight.Flight_Num) as t2 
where t1.Flight_Num = flight.Flight_Num and t2.Flight_Num = flight.Flight_Num group by flight.Flight_Num;

-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin
if (exists (select * from property where Street = i_street and City = i_city and State = i_state and Zip = i_zip)) then leave sp_main; end if;
if (exists (select * from property where Property_Name = i_property_name and Owner_Email = i_owner_email)) then leave sp_main; end if;
insert into property (Property_Name, Owner_Email, Descr, Capacity, Cost, Street, City, State, Zip) values 
(i_property_name, i_owner_email, i_description, i_capacity, i_cost, i_street, i_city, i_state, i_zip);
if (i_nearest_airport_id is not null and i_dist_to_airport is not null and i_nearest_airport_id in (select Airport_Id from airport))
and not exists (select Property_Name, Owner_Email, Airport from is_close_to where Property_Name = i_property_name 
and Owner_Email = i_owner_email and Airport = i_nearest_airport_id) then
insert into is_close_to (Property_Name, Owner_Email, Airport, Distance) values 
(i_property_name, i_owner_email, i_nearest_airport_id, i_dist_to_airport); end if;
end //
delimiter ;
select * from property;

-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin
if (exists (select * from reserve where Property_Name = i_property_name and Owner_Email = i_owner_email and Was_Cancelled = 0 
and i_current_date between Start_Date and End_Date)) then leave sp_main; end if;

delete from reserve where Owner_Email = i_owner_email and Property_Name = i_property_name;
delete from amenity where Property_Owner = i_owner_email and Property_Name = i_property_name;
delete from is_close_to where Owner_Email = i_owner_email and Property_Name = i_property_name;
delete from property where Owner_Email = i_owner_email and Property_Name = i_property_name;
    
end //
delimiter ;

-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin 
if(i_start_date < i_current_date) then leave sp_main; end if;
if(exists (select Property_Name, Owner_Email, Customer from reserve 
where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;
if(exists (select * from reserve where Customer = i_customer_email and (i_start_date between Start_Date and End_Date 
or i_end_date between Start_Date and End_Date))) then leave sp_main; end if;
if (not exists (select Property_Name from property where Property_Name = i_property_name))
then leave sp_main; end if;
if(i_num_guests > (select Capacity from property where Property_Name = i_property_name)-
(select sum(Num_Guests) from reserve where Property_Name = i_property_name and (Start_Date between i_start_date and i_end_date
or End_Date between i_start_date and i_end_date) and Was_Cancelled = 0 group by Property_Name)) then leave sp_main; end if;
insert into reserve (Property_Name, Owner_Email, Customer, Start_Date, End_Date, Num_Guests, Was_Cancelled) values
(i_property_name, i_owner_email, i_customer_email, i_start_date, i_end_date, i_num_guests,0);
end//
delimiter ;

-- ID: 5b
-- Name: cancel_property_reservation
drop procedure if exists cancel_property_reservation;
delimiter //
delimiter //
create procedure cancel_property_reservation ( 
in i_property_name varchar(50),  
in i_owner_email varchar(50),  
in i_customer_email varchar(50), 
in i_current_date date
) 
sp_main: begin 
if (not exists (select Property_Name, Owner_Email, Customer from reserve 
where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;
if(i_current_date >= (select Start_Date from reserve where Property_Name = i_property_name and Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if ((select Was_Cancelled from reserve where Property_Name = i_property_name and Customer = i_customer_email 
and Owner_Email = i_owner_email) = 1) then leave sp_main; end if;

update reserve
set Was_Cancelled = 1 where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email;
end//
delimiter ;

-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property ( 
in i_property_name varchar(50),  
in i_owner_email varchar(50),  
in i_customer_email varchar(50),  
in i_content varchar(500),  
in i_score int,  
in i_current_date date) 
sp_main: begin
if(i_current_date < (select Start_Date from reserve where Property_Name = i_property_name and Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if ((select Was_Cancelled from reserve where Property_Name = i_property_name and Customer = i_customer_email 
and Owner_Email = i_owner_email) = 1) then leave sp_main; end if;
if (exists (select Property_Name, Owner_Email, Customer from review where
Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;

insert into review (Property_Name, Owner_Email, Customer, Content, Score) values
(i_property_name, i_owner_email, i_customer_email, i_content, i_score);

end//
delimiter ;

-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
select property.Property_Name as property_name, avg(review.Score) as average_rating, 
Descr as description, concat(Street,', ',City,', ',State,', ',Zip) as address, Capacity as capacity,
Cost as cost_per_night from property left outer join review on
property.Property_Name = review.Property_Name group by property.Property_Name;
select * from view_properties;

-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50) ) 
    sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations as
select reserve.Property_Name as property_name, Start_Date as start_date, End_Date as end_date, reserve.Customer as customer_email, 
customer_phone_num, cast(total_booking_cost as decimal(8,2)), rating_score, review from reserve 
join (select distinct reserve.Customer, Phone_Number as customer_phone_num from clients,reserve where Email = Customer) as t1
join (select reserve.Owner_Email, reserve.Customer, 
if(reserve.Was_Cancelled = 0, property.Cost*(datediff(reserve.End_Date,reserve.Start_Date)+1), 0.2*property.Cost*(datediff(reserve.End_Date,reserve.Start_Date)+1)) 
as total_booking_cost from Property,reserve where property.Property_Name = reserve.Property_Name) as t2
join (select reserve.Property_Name, reserve.Customer, Score as rating_score, Content as review from reserve,review,property 
where property.Property_Name = review.Property_Name
and review.Property_Name = reserve.Property_Name and reserve.Customer = review.Customer) as t3
where reserve.Property_Name = i_property_name and t1.Customer = reserve.Customer and t2.Customer = reserve.Customer
and t3.Customer = reserve.Customer and t2.Owner_Email = i_owner_email and t3.Customer = reserve.Customer group by reserve.Customer;
end//
delimiter ;

-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
if(i_current_date < (select Start_Date from reserve where Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if(not exists (select customer.Email from customer where customer.Email = i_customer_email) 
or not exists (select owners.Email from owners where owners.Email = i_owner_email)) then leave sp_main; end if;
if (not exists (select * from reserve where Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if(exists (select Owner_Email, Customer from customers_rate_owners
where Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;
insert into customers_rate_owners (Customer, Owner_Email, Score) values
(i_customer_email, i_owner_email, i_score);
end//
delimiter ;

-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //

create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
if(i_current_date < (select Start_Date from reserve where Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if(not exists (select customer.Email from customer where customer.Email = i_customer_email) 
or not exists (select owners.Email from owners where owners.Email = i_owner_email)) then leave sp_main; end if;
if(not exists (select * from reserve where Customer = i_customer_email 
and Owner_Email = i_owner_email)) then leave sp_main; end if;
if(exists (select Owner_Email, Customer from owners_rate_customers
where Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;
insert into owners_rate_customers (Customer, Owner_Email, Score) values
(i_customer_email, i_owner_email, i_score);
end//
delimiter ;

-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as 
select airport.Airport_Id, Airport_Name, airport.Time_Zone, Flights_Arriving, 
Flights_Departing, Average_Cost from airport join 
(select Airport_Id, count(To_Airport) as Flights_Arriving from airport 
left outer join flight on To_Airport = Airport_Id group by Airport_Id) as f1 join 
(select Airport_Id, count(From_Airport) as Flights_Departing from airport 
left outer join flight on From_Airport = Airport_Id group by Airport_Id) as f2 join 
(select Airport_Id, avg(Cost) as Average_Cost from airport 
left outer join flight on From_Airport = Airport_Id group by Airport_Id) as f3 
where airport.Airport_Id = f1.Airport_Id and airport.Airport_Id = f2.Airport_Id 
and airport.Airport_Id = f3.Airport_Id group by airport.Airport_Id;

-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 
    total_flights, 
    min_flight_cost
) as 
select airline.Airline_Name, Rating, count(flight.To_Airport) as Total_flights, 
min(Cost) as Minimum_Cost from airline left outer join flight on 
airline.Airline_Name = flight.Airline_Name group by airline.Airline_Name;

-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as
select concat(First_Name, ' ' , Last_Name) as customer_Name, avg(owners_rate_customers.Score) as average_Rating,
Location as location, CASE WHEN owners.email is not null then 1 ELSE 0 END as is_owner, 
coalesce(sum(book.Num_Seats),0) as total_seats_purchased from customer 
left outer join owners_rate_customers on owners_rate_customers.Customer = customer.Email
left outer join book on customer.Email = book.Customer 
left outer join accounts on customer.Email = accounts.Email 
left outer join owners on owners.Email = customer.Email
group by customer.Email;

-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as
select concat(First_Name, ' ' , Last_Name) as owner_name, avg(customers_rate_owners.Score) as avg_rating,
coalesce(num_properties_owned,0) as num_properties_owned, avg(review.Score) as avg_property_rating 
from owners 
left outer join customers_rate_owners on customers_rate_owners.Owner_Email = owners.Email
left outer join (select Owner_Email, count(property.Owner_Email) as num_properties_owned
from property group by Owner_Email) as o1 on o1.Owner_Email = owners.Email
left outer join accounts on owners.Email = accounts.Email 
left outer join review on review.Owner_Email = owners.Email
group by owners.Email;

-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin
update customer
join book on
book.Customer = customer.Email and book.Was_Cancelled = 0 
join flight on book.Flight_Num = flight.Flight_Num and customer.Email in (select book.Customer from flight join book on flight.Flight_Num = book.Flight_Num and 
flight.Flight_Date = i_current_date group by book.Customer having count(Num_Seats)<=1)
join airport on flight.To_Airport = airport.Airport_Id 
set Location = airport.State;    
end //
delimiter ;


