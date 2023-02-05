CREATE DATABASE dvd_rental_shop;
USE dvd_rental_shop;
CREATE TABLE Customers (
    Account_number Int primary key,
	First_Name varchar(255),
    Last_Name varchar(255),
    DOB Int,
    Mobile_number BigInt,
    email varchar(255),
    House_number Int,
    Post_code varchar(255),
    number_of_visits Int
    );
    
INSERT INTO Customers (Account_number ,First_Name,Last_Name, DOB, Mobile_number, email, House_number, Post_code, number_of_visits)
VALUES
(1010, 'Mary', 'Jones', 1980, 07801098981,'mary.jones@gmail.com', 21, 'SG120GH', 2),
(999, 'Julie', 'Smith', 1979, 07752289099, 'julie.smith@gmail.com', 3, 'CM200FG', 4),
(677, 'Joanna', 'Bates', 1952, 07775337010, 'joannab@yahoo.com', 7, 'SG120PH', 10),
(111, 'Adam', 'Perry', 2002, 07775220022, 'adam.perry@gail.com', 3, 'CM210DH', 0),
(105, 'Stacy', 'Willingham', 1967, 07990321012, 'stacyw@gmail.com', 10, 'CM170AA',7);


    
CREATE TABLE Branches (
    Branch_id int primary key,
    Branch_Name varchar (255),
    Location varchar  (255),
    Sells_Food varchar (255)
    );
    
INSERT INTO Branches (Branch_id, Branch_Name,Location, Sells_Food)
VALUES
(20, 'Harlow', 'Staple_Tye', 'yes'),
(55, 'London', 'Balham_High_Road', 'no'),
(75, 'Oregon', 'Revere Ave', 'yes'),
(91, 'Mississauga', 'Eglinton_Avenue_West', 'no');
 
    
CREATE TABLE Films (
   Film_Title varchar(255) primary key,
   Age_Rating Int,
   Genre varchar(255),
   Runtime Int,
   Rental_Status varchar(255),
   Rental_Price Int
   );
   
INSERT INTO Films (Film_Title, Age_Rating, Genre,Runtime, Rental_Status, Rental_Price)
VALUES
('Alice_in_Wonderland', 9, 'Adventure', 108, 'On_shelf', 3),
('Secret_Window', 15, 'Drama', 96, 'Rented', 2),
('Chocolat', 11, 'Romance', '121', 'On_shelf', 4),
('Evita', 13, 'Biography', '135', 'Rented', 3);
      
CREATE TABLE Customer_Film_rating (
	Film_Title varchar(255),
	Rating float (2.4),
	primary key (rating),
	foreign key (Film_Title) references Films (Film_Title)
	);         
INSERT INTO Customer_Film_rating (Film_Title, rating)
VALUES
('Alice_in_Wonderland', 7.4),
('Secret_Window', 8.4 ),
('Chocolat', 7.3 ),
('Evita', 9.8); 
         
CREATE TABLE Reservations (
   Account_number Int,
   Film_Title varchar(255),
   date_reserved DATE,
   Prebooked varchar(255),
   Collected varchar (255),
   primary key (date_reserved),
   foreign key (Account_number) references Customers (Account_number),
   foreign key (Film_Title) references Films (Film_Title)
   );
INSERT INTO Reservations (Account_number, Film_Title, date_reserved, Prebooked, Collected)
VALUES
(1010,'Alice_in_Wonderland',  20081230, 'yes', 'no'),
(999,'Secret_Window',  19991015, 'no', 'no'),
(677,'Chocolat',  20081210, 'yes', 'yes'),
(105,'Evita',  20091015, 'yes', 'yes');
CREATE TABLE Food_supplier (
	Supplier_name varchar(255) primary key,
	Phone_number bigint,
	Website varchar (255)
	);
       
INSERT INTO Food_supplier (Supplier_name, Phone_number, Website)
VALUES
('Costco', 02044884444, 'www.costco.com'),
('Aldi', 01279990711, 'www.aldi.com'),
('Tesco', 012788888820, 'www.tesco.com'),
('Waitrose', 02083676226, 'www.waitrose.com');
      
CREATE TABLE Food (
	Item varchar(255),
	Price float (2.4),
	Brand varchar (255),
	Supplier_name varchar(255),
	primary key (item),
	foreign key (Supplier_name) references Food_supplier (Supplier_name)
	);
INSERT INTO Food (Item, Price, Brand, Supplier_name)
VALUES
('Haribo_Starmix', 1.50, 'Haribo', 'Costco'),
('Crisps', 1.60, 'Walkers', 'Tesco'),
('Mars_bar', 0.70,'Mars', 'Aldi'),
('Twix_bar', 1.00, 'Twix', 'Waitrose');
	
CREATE TABLE Staff (
     Employee_number Int,
     First_Name varchar(255),
	 Last_Name varchar(255),
     DOB Int,
     Mobile_number BigInt,
     email varchar(255),
     House_number Int,
     Post_code varchar(255),
     salary Int,
     Branch_id Int,
     primary key (Employee_number),
	 foreign key (Branch_id) references Branches (Branch_id)
	);
INSERT INTO Staff (Employee_number, First_Name, Last_Name, DOB, Mobile_number, email, House_number, Post_code, Salary, Branch_id)
VALUES
(12, 'Jane', 'Smith', 1980, 07910191919, 'janes2@gmail.com',  23, 'CM200GH',20000, 20),
(43, 'Patrick', 'Sharp', 1978, 07888567891, 'sharp_p@yahoo.com', 15, 'SG102AS',23000, 55),
(23, 'Garry', 'Avery', 1957, 07988901098, 'avery_g@gmail.com', 18, 'SW1W0NY', 18000, 75),
(45, 'Kate', 'Johnson', 1987, 07791923345,'kate_johnson@gmail.com',10,'GU167HF', 15000, 91);
​
#triggers
delimiter $$
CREATE TRIGGER  Check_age  AFTER INSERT ON Customers
FOR EACH ROW
BEGIN
IF DOB < 2004 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: 
         ACCESS DENIED';
END IF;
END; $$
delimiter $$

# extracting data with GROUP BY

SELECT COUNT(Film_title), rental_price
FROM Films
GROUP BY rental_price
ORDER BY COUNT(Film_title) DESC;

#create procedure with multiple parameters
DELIMITER //
CREATE PROCEDURE SelectAllCustomers (
in First_name varchar(255),
in Post_code varchar(255)
)
BEGIN
SELECT * FROM Customers WHERE First_name = First_name AND Post_code = Post_code;
END//
DELIMITER ;
CALL SelectAllCustomers ('Julie', 'CM200FG');


