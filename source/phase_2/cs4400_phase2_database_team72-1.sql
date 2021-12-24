-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase II: Create Table & Insert Statements [v0] Thursday, October 14, 2021 @ 2:00pm EDT

-- Team 72
-- Aishwarya Mahale(amahale6@gatech.edu)
-- Upasanna Krishnan (ukrishnan3@gatech.edu)
-- Rohan Bukhar (rbukhar3@gatech.edu)


-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

-- ------------------------------------------------------
-- CREATE TABLE STATEMENTS AND INSERT STATEMENTS BELOW
-- ------------------------------------------------------
DROP DATABASE IF EXISTS travelmgt;
CREATE DATABASE IF NOT EXISTS travelmgt;
USE travelmgt;

DROP TABLE IF EXISTS account;
CREATE TABLE account (
    email varchar(30) NOT NULL,
	fname char(20) NOT NULL, 
	lname char(20) NOT NULL, 
	password char(20) NOT NULL,
	PRIMARY KEY (email)
) ENGINE=InnoDB;
INSERT INTO account VALUES ('mmoss1@travelagency.com','Mark','Moss','password1'),('asmith@travelagency.com','Aviva','Smith','password2'),('mscott22@gmail.com','Michael','Scott','password3'),('arthurread@gmail.com','Arthur','Read','password4'),('jwayne@gmail.com','John','Wayne','password5'),('gburdell3@gmail.com','George','Burdell','password6'),('mj23@gmail.com','Michael','Jordan','password7'),('lebron6@gmail.com','Lebron','James','password8'),('msmith5@gmail.com','Michael','Smith','password9'),('ellie2@gmail.com','Ellie','Johnson','password10'),('scooper3@gmail.com','Sheldon','Cooper','password11'),('mgeller5@gmail.com','Monica','Geller','password12'),('cbing10@gmail.com','Chandler','Bing','password13'),('hwmit@gmail.com','Howard','Wolowitz','password14'),('swilson@gmail.com','Samantha','Wilson','password16'),('aray@tiktok.com','Addison','Ray','password17'),('cdemilio@tiktok.com','Charlie','Demilio','password18'),('bshelton@gmail.com','Blake','Shelton','password19'),('lbryan@gmail.com','Luke','Bryan','password20'),('tswift@gmail.com','Taylor','Swift','password21'),('jseinfeld@gmail.com','Jerry','Seinfeld','password22'),('maddiesmith@gmail.com','Madison','Smith','password23'),('johnthomas@gmail.com','John','Thomas', 'password24'),('boblee15@gmail.com','Bob','Lee','password25');

DROP TABLE IF EXISTS client;
CREATE TABLE client (
	client_email varchar (30) NOT NULL,
    phone_number decimal(10,0) NOT NULL,
    PRIMARY KEY (phone_number),
	CONSTRAINT client_ibfk_1 FOREIGN KEY (client_email) REFERENCES account (email) 
) ENGINE=InnoDB;
INSERT INTO client VALUES ('mscott22@gmail.com',5551234567),('arthurread@gmail.com',5552345678),('jwayne@gmail.com',5553456789),('gburdell3@gmail.com',5554567890),('mj23@gmail.com',5555678901),('lebron6@gmail.com',5556789012),('msmith5@gmail.com',5557890123),('ellie2@gmail.com',5558901234),('scooper3@gmail.com',6781234567),('mgeller5@gmail.com',6782345678),('cbing10@gmail.com',6783456789),('hwmit@gmail.com',6784567890),('swilson@gmail.com',7701234567),('aray@tiktok.com',7702345678),('cdemilio@tiktok.com',7703456789),('bshelton@gmail.com',7704567890),('lbryan@gmail.com',7705678901),('tswift@gmail.com',7706789012),('jseinfeld@gmail.com',7707890123),('maddiesmith@gmail.com',7708901234),('johnthomas@gmail.com',4047705555),('boblee15@gmail.com', 4046785555);

DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
	admin_email varchar(30) NOT NULL,
    PRIMARY KEY (admin_email),
    CONSTRAINT admin_ibfk_1 FOREIGN KEY (admin_email) REFERENCES account (email)
) ENGINE=InnoDB;
INSERT INTO admin VALUES ('mmoss1@travelagency.com'),('asmith@travelagency.com'); 


DROP TABLE IF EXISTS owner;
CREATE TABLE owner (
    owner_email VARCHAR(30) NOT NULL,
    PRIMARY KEY (owner_email),
    CONSTRAINT owner_ibfk_1 FOREIGN KEY (owner_email) REFERENCES account (email)
) ENGINE=InnoDB;
INSERT INTO owner VALUES ('mscott22@gmail.com'),('arthurread@gmail.com'),('jwayne@gmail.com'),('gburdell3@gmail.com'),('mj23@gmail.com'),('lebron6@gmail.com'),('msmith5@gmail.com'),('ellie2@gmail.com'),('scooper3@gmail.com'),('mgeller5@gmail.com'),('cbing10@gmail.com'),('hwmit@gmail.com');

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	customer_email varchar(30) NOT NULL,
	current_location char(50),
	credit_card_no decimal(16,0) NOT NULL,
	cvv int(5) NOT NULL,
    exp_date date NOT NULL,
    PRIMARY KEY (credit_card_no),
	CONSTRAINT customer_ibfk_1 FOREIGN KEY (customer_email) REFERENCES account (email)  
) ENGINE=InnoDB;
INSERT INTO customer VALUES ('scooper3@gmail.com',NULL, 6518555974461663,551,'2024-02-01'),('mgeller5@gmail.com',NULL, 2328567043101965,644,'2024-03-01'),('cbing10@gmail.com',NULL, 8387952398279291,201,'2023-02-01'),('hwmit@gmail.com', NULL,6558859698525299,102,'2023-04-01'),('swilson@gmail.com', NULL, 9383321241981836,455,'2022-08-01'),('aray@tiktok.com', NULL, 3110266979495605,744,'2022-08-01'),('cdemilio@tiktok.com', NULL, 2272355540784744,606,'2025-02-01'),('bshelton@gmail.com', NULL, 9276763978834273,862,'2023-09-01'),('lbryan@gmail.com', NULL, 4652372688643798,258,'2023-05-01'),('tswift@gmail.com', NULL, 5478842044367471,857,'2024-12-01'),('jseinfeld@gmail.com', NULL, 3616897712963372,295,'2022-06-01'),('maddiesmith@gmail.com', NULL, 9954569863556952,794,'2022-07-01'),('johnthomas@gmail.com', NULL,7580327437245356,269,'2025-10-01'),('boblee15@gmail.com',NULL,7907351371614248,858,'2025-11-01');

DROP TABLE IF EXISTS airline;
CREATE TABLE airline (
	name varchar(30) NOT NULL,
    rating decimal(5,2) NOT NULL,
    PRIMARY KEY (name)
) ENGINE=InnoDB;
INSERT INTO airline VALUES ('Delta Airlines',4.7),('Southwest Airlines',4.4),('American Airlines',4.6),('United Airlines',4.2),('JetBlue Airways',3.6),('Spirit Airlines',3.3),('WestJet',3.9),('Interjet',3.7);

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
    airport_id varchar(10) NOT NULL,
	name varchar(50) NOT NULL,
    timezone varchar(5) NOT NULL,
    street varchar(20) NOT NULL,
    city varchar(20) NOT NULL,
    state char(2) NOT NULL,
    zip int(8) NOT NULL,
	PRIMARY KEY (airport_id),
    UNIQUE KEY name (name)
) ENGINE=InnoDB;
INSERT INTO airport VALUES ('ATL','Atlanta Hartsfield Jackson Airport','EST','6000 N Terminal Pkwy','Atlanta','GA',30320),('JFK','John F Kennedy International Airport','EST','455 Airport Ave','Queens','NY',11430),('LGA','Laguardia Airport','EST','790 Airport St','Queens','NY',11371),('LAX','Lost Angeles International Airport','PST','1 World Way','Los Angeles','CA',90045),('SJC','Norman Y. Mineta San Jose International Airport','PST','1702 Airport Blvd','San Jose','CA',95110),('ORD','OHare International Airport','CST','10000 W OHare Ave','Chicago','IL',60666),('MIA','Miami International Airport','EST','2100 NW 42nd Ave','Miami','FL',33126),('DFW','Dallas International Airport','CST','2400 Aviation DR','Dallas','TX',75261);

DROP TABLE IF EXISTS property;
CREATE TABLE property (
    name varchar(50) NOT NULL,
    owner_email varchar(30) NOT NULL,
    description varchar(200),
    capacity int(10) NOT NULL,
    cost_per_night_per_person int(20) NOT NULL,
    street varchar(20) NOT NULL,
    city varchar(10) NOT NULL,
    state char(2) NOT NULL,
    zip int(8) NOT NULL,  
    PRIMARY KEY (name,owner_email),
    CONSTRAINT property_ibfk_1 FOREIGN KEY (owner_email) REFERENCES owner (owner_email)
) ENGINE=InnoDB;
INSERT INTO property VALUES ('Atlanta Great Property','scooper3@gmail.com','This is right in the middle of Atlanta near many attractions!',4,600 ,'2nd St','ATL','GA',30008),('House near Georgia Tech','gburdell3@gmail.com','Super close to bobby dodde stadium!',3,275 ,'North Ave','ATL','GA',30008),('New York City Property','cbing10@gmail.com','A view of the whole city. Great property!',2,750 ,'123 Main St','NYC','NY',10008),('Statue of Libery Property','mgeller5@gmail.com','You can see the statue of liberty from the porch',5,1000,'1st St','NYC','NY',10009),('Los Angeles Property','arthurread@gmail.com',NULL,3,700,'10th St','LA','CA',90008),('LA Kings House','arthurread@gmail.com','This house is super close to the LA kinds stadium!',4,750 ,'Kings St','La','CA',90011),('Beautiful San Jose Mansion','arthurread@gmail.com','Huge house that can sleep 12 people. Totally worth it!',12,900 ,'Golden Bridge Pkwt','San Jose','CA',90001),('LA Lakers Property','lebron6@gmail.com','This house is right near the LA lakers stadium. You might even meet Lebron James!',4,850 ,'Lebron Ave','LA','CA',90011),('Chicago Blackhawks House','hwmit@gmail.com','This is a great property!',3,775 ,'Blackhawks St','Chicago','IL',60176),('Chicago Romantic Getaway','mj23@gmail.com','This is a great property!',2,1050,'23rd Main St','Chicago','IL',60176),('Beautiful Beach Property','msmith5@gmail.com','You can walk out of the house and be on the beach!',2,975 ,'456 Beach Ave','Miami','FL',33101),('Family Beach House','ellie2@gmail.com','You can literally walk onto the beach and see it from the patio!',6,850 ,'1132 Beach Ave','Miami','FL',33101),('Texas Roadhouse','mscott22@gmail.com','This property is right in the center of Dallas, Texas!',3,450 ,'17th Street','Dallas','TX',75043),('Texas Longhorns House','mscott22@gmail.com','You can walk to the longhorns stadium from here!',10,600 ,'1125 Longhorns Way','Dallas','TX',75001);

DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
	flight_num varchar(10) NOT NULL UNIQUE,
    airline_name varchar(30) NOT NULL,
    departure_airport_id varchar(30) NOT NULL,
    arrival_airport_id varchar(30) NOT NULL,
    departure_time time NOT NULL,
    arrival_time time NOT NULL,
    date date NOT NULL,
    cost_per_seat decimal(5,2) NOT NULL,
    capacity int(10) NOT NULL,
    PRIMARY KEY (airline_name,flight_num),
    CONSTRAINT flight_ibfk_1 FOREIGN KEY (arrival_airport_id) REFERENCES airport (airport_id),
    CONSTRAINT flight_ibfk_2 FOREIGN KEY (departure_airport_id) REFERENCES airport (airport_id),
    CONSTRAINT flight_ibfk_3 FOREIGN KEY (airline_name) REFERENCES airline (name)
) ENGINE=InnoDB;
INSERT INTO flight VALUES ('1','Delta Airlines','ATL','JFK','10:00','12:00','2021-10-18',400,150),('2','Southwest Airlines','ORD','MIA','10:30','14:30','2021-10-18',350,125),('3','American Airlines','MIA','DFW','13:00','16:00','2021-10-18',350,125),('4','United Airlines','ATL','LGA','16:30','18:30','2021-10-18',400,100),('5','JetBlue Airways','LGA','ATL','11:00','13:00','2021-10-18',400,130),('6','Spirit Airlines','SJC','ATL','12:30','21:30','2021-10-19',650,140),('7','WestJet','LGA','SJC','13:00','16:00','2021-10-19',700,100),('8','Interjet','MIA','ORD','19:30','21:30','2021-10-19',350,125),('9','Delta Airlines','JFK','ATL','8:00','10:00','2021-10-21',375,150),('10','Delta Airlines','LAX','ATL','9:15','18:15','2021-10-20',700,110),('11','Southwest Airlines','LAX','ORD','12:07','19:07','2021-10-20',600,95),('12','United Airlines','MIA','ATL','15:35','17:35','2021-10-21',275,115);

DROP TABLE IF EXISTS rates;
CREATE TABLE rates (
    owner_email varchar(30) NOT NULL,
    customer_email varchar(30) NOT NULL,
    score float(2),
    PRIMARY KEY (owner_email,customer_email),
    CONSTRAINT rates_ibfk_1 FOREIGN KEY (owner_email) REFERENCES owner (owner_email),
    CONSTRAINT rates_ibfk_2 FOREIGN KEY (customer_email) REFERENCES customer (customer_email)
) ENGINE=InnoDB;
INSERT INTO rates VALUES ('gburdell3@gmail.com','swilson@gmail.com',5),('cbing10@gmail.com','aray@tiktok.com',5),('mgeller5@gmail.com','bshelton@gmail.com',3),('arthurread@gmail.com','lbryan@gmail.com',4),('arthurread@gmail.com','tswift@gmail.com',4),('lebron6@gmail.com','jseinfeld@gmail.com',1),('hwmit@gmail.com','maddiesmith@gmail.com',2);

DROP TABLE IF EXISTS is_rated_by;
CREATE TABLE is_rated_by (
    owner_email varchar(30) NOT NULL,
    customer_email varchar(30) NOT NULL,
    score float(2),
    PRIMARY KEY (owner_email,customer_email),
    CONSTRAINT is_rated_by_ibfk_1 FOREIGN KEY (owner_email) REFERENCES owner (owner_email),
    CONSTRAINT is_rated_by_ibfk_2 FOREIGN KEY (customer_email) REFERENCES customer (customer_email)
) ENGINE=InnoDB;
INSERT INTO is_rated_by VALUES ('gburdell3@gmail.com','swilson@gmail.com',5),('cbing10@gmail.com','aray@tiktok.com',5),('mgeller5@gmail.com','bshelton@gmail.com',4),('arthurread@gmail.com','lbryan@gmail.com',4),('arthurread@gmail.com','tswift@gmail.com',3),('lebron6@gmail.com','jseinfeld@gmail.com',2),('hwmit@gmail.com','maddiesmith@gmail.com',5);

DROP TABLE IF EXISTS review;
CREATE TABLE review (
    property_name varchar(50) NOT NULL,
    owner_email varchar(30) NOT NULL,
    customer_email varchar(30) NOT NULL,
    content varchar(400),
    score float(2),
    PRIMARY KEY (property_name,customer_email,owner_email),
    CONSTRAINT review_ibfk_1 FOREIGN KEY (customer_email) REFERENCES customer (customer_email),
	CONSTRAINT review_ibfk_2 FOREIGN KEY (property_name) REFERENCES property (name),
    CONSTRAINT review_ibfk_3 FOREIGN KEY (owner_email) REFERENCES owner (owner_email)  
) ENGINE=InnoDB;
INSERT INTO review VALUES ('House near Georgia Tech','gburdell3@gmail.com','swilson@gmail.com','This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!',5),('New York City Property','cbing10@gmail.com','aray@tiktok.com','This was the best 5 days ever! I saw so much of NYC!',5),('Statue of Libery Property','mgeller5@gmail.com','bshelton@gmail.com','This was truly an excellent experience. I really could see the Statue of Liberty from the property!',4),('Los Angeles Property','arthurread@gmail.com','lbryan@gmail.com','I had an excellent time!',4),('Beautiful San Jose Mansion','arthurread@gmail.com','tswift@gmail.com','We had a great time, but the house wasnt fully cleaned when we arrived',3),('LA Lakers Property','lebron6@gmail.com','jseinfeld@gmail.com','I was disappointed that I did not meet lebron james',2),('Chicago Blackhawks House','hwmit@gmail.com','maddiesmith@gmail.com','This was awesome! I met one player on the chicago blackhawks!',5);
 
DROP TABLE IF EXISTS reserve;
CREATE TABLE reserve (
    property_name varchar(50) NOT NULL,
	owner_email varchar(30) NOT NULL,
	customer_email VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    num_guests INT(20) NOT NULL,
    CONSTRAINT reserve_ibfk_1 FOREIGN KEY (customer_email) REFERENCES customer (customer_email),
    CONSTRAINT reserve_ibfk_2 FOREIGN KEY (property_name) REFERENCES property (name),
    CONSTRAINT reserve_ibfk_3 FOREIGN KEY (owner_email) REFERENCES owner (owner_email)
) ENGINE=InnoDB;
INSERT INTO reserve VALUES ('House near Georgia Tech','gburdell3@gmail.com','swilson@gmail.com','2021-10-19','2021-10-25',3),('New York City Property','cbing10@gmail.com','aray@tiktok.com','2021-10-18','2021-10-23',2),('New York City Property','cbing10@gmail.com','cdemilio@tiktok.com','2021-10-24','2021-10-30',2),('Statue of Libery Property','mgeller5@gmail.com','bshelton@gmail.com','2021-10-18','2021-10-22',4),('Los Angeles Property','arthurread@gmail.com','lbryan@gmail.com','2021-10-19','2021-10-25',2),('Beautiful San Jose Mansion','arthurread@gmail.com','tswift@gmail.com','2021-10-19','2021-10-22',10),('LA Lakers Property','lebron6@gmail.com','jseinfeld@gmail.com','2021-10-19','2021-10-24',4),('Chicago Blackhawks House','hwmit@gmail.com','maddiesmith@gmail.com','2021-10-19','2021-10-23',2),('Chicago Romantic Getaway','mj23@gmail.com','aray@tiktok.com','2021-11-01','2021-11-07',2),('Beautiful Beach Property','msmith5@gmail.com','cbing10@gmail.com','2021-10-18','2021-10-25',2),('Family Beach House','ellie2@gmail.com','hwmit@gmail.com','2021-10-18','2021-10-28',5);

DROP TABLE IF EXISTS is_close_to;
CREATE TABLE is_close_to (
    property_name varchar(50) NOT NULL,
	owner_email varchar(20) NOT NULL,
    airport_id varchar(10) NOT NULL,
    distance int(4), 
    PRIMARY KEY (owner_email,property_name,airport_id),
    CONSTRAINT is_close_to_ibfk_1 FOREIGN KEY (owner_email) REFERENCES property (owner_email),
    CONSTRAINT is_close_to_ibfk_2 FOREIGN KEY (property_name) REFERENCES property (name),
    CONSTRAINT is_close_to_ibfk_3 FOREIGN KEY (airport_id) REFERENCES airport (airport_id)
) ENGINE=InnoDB;
INSERT INTO is_close_to VALUES ('Atlanta Great Property','scooper3@gmail.com','ATL',12),('House near Georgia Tech','gburdell3@gmail.com','ATL',7),('New York City Property','cbing10@gmail.com','JFK',10),('Statue of Libery Property','mgeller5@gmail.com','JFK',8),('New York City Property','cbing10@gmail.com','LGA',25),('Statue of Libery Property','mgeller5@gmail.com','LGA',19),('Los Angeles Property','arthurread@gmail.com','LAX',9),('LA Kings House','arthurread@gmail.com','LAX',12),('Beautiful San Jose Mansion','arthurread@gmail.com','SJC',8),('Beautiful San Jose Mansion','arthurread@gmail.com','LAX',30),('LA Lakers Property','lebron6@gmail.com','LAX',6),('Chicago Blackhawks House','hwmit@gmail.com','ORD',11),('Chicago Romantic Getaway','mj23@gmail.com','ORD',13),('Beautiful Beach Property','msmith5@gmail.com','MIA',21),('Family Beach House','ellie2@gmail.com','MIA',19),('Texas Roadhouse','mscott22@gmail.com','DFW',8),('Texas Longhorns House','mscott22@gmail.com','DFW',17);
 
DROP TABLE IF EXISTS book;
CREATE TABLE book (
    customer_email VARCHAR(30) NOT NULL,
    flight_num varchar(10) NOT NULL,
    airline_name varchar(30) NOT NULL,
    num_seats int(4) NOT NULL,
    PRIMARY KEY (airline_name,customer_email,flight_num),
	CONSTRAINT book_ibfk_1 FOREIGN KEY (customer_email) REFERENCES customer (customer_email),
    CONSTRAINT book_ibfk_3 FOREIGN KEY (airline_name) REFERENCES flight (airline_name)
) ENGINE=InnoDB;
INSERT INTO book VALUES ('swilson@gmail.com','5','JetBlue Airways',3),('aray@tiktok.com','1','Delta Airlines',2),('bshelton@gmail.com','4','United Airlines',4),('lbryan@gmail.com','7','WestJet',2),('tswift@gmail.com','7','WestJet',2),('jseinfeld@gmail.com','7','WestJet',4),('maddiesmith@gmail.com','8','Interjet',2),('cbing10@gmail.com','2','Southwest Airlines',2),('hwmit@gmail.com','2','Southwest Airlines',5);

DROP TABLE IF EXISTS property_amenity;
CREATE TABLE property_amenity (
    property_name varchar(50) NOT NULL,
    property_owner varchar(30) NOT NULL,
	amenity_name char(100) NOT NULL, 
    PRIMARY KEY (property_name,property_owner,amenity_name),
    CONSTRAINT property_amenity_ibfk_1 FOREIGN KEY (property_name) REFERENCES property (name),
    CONSTRAINT property_amenity_ibfk_2 FOREIGN KEY (property_owner) REFERENCES property (owner_email)
) ENGINE=InnoDB;
INSERT INTO property_amenity VALUES ('Atlanta Great Property','scooper3@gmail.com','A/C & Heating'),('Atlanta Great Property','scooper3@gmail.com','Pets allowed'),('Atlanta Great Property','scooper3@gmail.com','Wifi & TV'),('Atlanta Great Property','scooper3@gmail.com','Washer and Dryer'),('House near Georgia Tech','gburdell3@gmail.com','Wifi & TV'),('House near Georgia Tech','gburdell3@gmail.com','Washer and Dryer'),('House near Georgia Tech','gburdell3@gmail.com','Full Kitchen'),('New York City Property','cbing10@gmail.com','A/C & Heating'),('New York City Property','cbing10@gmail.com','Wifi & TV'),('Statue of Libery Property','mgeller5@gmail.com','A/C & Heating'),('Statue of Libery Property','mgeller5@gmail.com','Wifi & TV'),('Los Angeles Property','arthurread@gmail.com','A/C & Heating'),('Los Angeles Property','arthurread@gmail.com','Pets allowed'),('Los Angeles Property','arthurread@gmail.com','Wifi & TV'),('LA Kings House','arthurread@gmail.com','A/C & Heating'),('LA Kings House','arthurread@gmail.com','Wifi & TV'),('LA Kings House','arthurread@gmail.com','Washer and Dryer'),('LA Kings House','arthurread@gmail.com','Full Kitchen'),('Beautiful San Jose Mansion','arthurread@gmail.com','A/C & Heating'),('Beautiful San Jose Mansion','arthurread@gmail.com','Pets allowed'),('Beautiful San Jose Mansion','arthurread@gmail.com','Wifi & TV'),('Beautiful San Jose Mansion','arthurread@gmail.com','Washer and Dryer'),('Beautiful San Jose Mansion','arthurread@gmail.com','Full Kitchen'),('LA Lakers Property','lebron6@gmail.com','A/C & Heating'),('LA Lakers Property','lebron6@gmail.com','Wifi & TV'),('LA Lakers Property','lebron6@gmail.com','Washer and Dryer'),('LA Lakers Property','lebron6@gmail.com','Full Kitchen'),('Chicago Blackhawks House','hwmit@gmail.com','A/C & Heating'),('Chicago Blackhawks House','hwmit@gmail.com','Wifi & TV'),('Chicago Blackhawks House','hwmit@gmail.com','Washer and Dryer'),('Chicago Blackhawks House','hwmit@gmail.com','Full Kitchen'),('Chicago Romantic Getaway','mj23@gmail.com','A/C & Heating'),('Chicago Romantic Getaway','mj23@gmail.com','Wifi & TV'),('Beautiful Beach Property','msmith5@gmail.com','A/C & Heating'),('Beautiful Beach Property','msmith5@gmail.com','Wifi & TV'),('Beautiful Beach Property','msmith5@gmail.com','Washer and Dryer'),('Family Beach House','ellie2@gmail.com','A/C & Heating'),('Family Beach House','ellie2@gmail.com','Pets allowed'),('Family Beach House','ellie2@gmail.com','Wifi & TV'),('Family Beach House','ellie2@gmail.com','Washer and Dryer'),('Family Beach House','ellie2@gmail.com','Full Kitchen'),('Texas Roadhouse','mscott22@gmail.com','A/C & Heating'),('Texas Roadhouse','mscott22@gmail.com','Pets allowed'),('Texas Roadhouse','mscott22@gmail.com','Wifi & TV'),('Texas Roadhouse','mscott22@gmail.com','Washer and Dryer'),('Texas Longhorns House','mscott22@gmail.com','A/C & Heating'),('Texas Longhorns House','mscott22@gmail.com','Pets allowed'),('Texas Longhorns House','mscott22@gmail.com','Wifi & TV'),('Texas Longhorns House','mscott22@gmail.com','Washer and Dryer'),('Texas Longhorns House','mscott22@gmail.com','Full Kitchen');
 
DROP TABLE IF EXISTS airport_attraction;
CREATE TABLE airport_attraction (
    airport_id varchar(10) NOT NULL,
    attraction_name varchar(40) NOT NULL,
    PRIMARY KEY (airport_id,attraction_name),
	CONSTRAINT airport_attraction_ibfk_1 FOREIGN KEY (airport_id) REFERENCES airport (airport_id)
) ENGINE=InnoDB;
INSERT INTO airport_attraction VALUES ('ATL','The Coke Factory'),('ATL','The Georgia Aquarium'),('JFK','The Statue of Liberty'),('JFK','The Empire State Building'),('LGA','The Statue of Liberty'),('LGA','The Empire State Building'),('LAX','Lost Angeles Lakers Stadium'),('LAX','Los Angeles Kings Stadium'),('SJC','Winchester Mystery House'),('SJC','San Jose Earthquakes Soccer Team'),('ORD','Chicago Blackhawks Stadium'),('ORD','Chicago Bulls Stadium'),('MIA','Crandon Park Beach'),('MIA','Miami Heat Basketball Stadium'),('DFW','Texas Longhorns Stadium'),('DFW','The Original Texas Roadhouse');

ALTER TABLE book ADD CONSTRAINT fk1 FOREIGN KEY (flight_num) REFERENCES flight(flight_num);
