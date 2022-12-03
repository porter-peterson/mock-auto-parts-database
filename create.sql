DROP DATABASE IF EXISTS AutoPartsStore

------------------------------------------------
-- Create table for our Mock Auto Parts Store --
------------------------------------------------
CREATE DATABASE AutoPartsMonopoly

------------------------------------------------
--         Create tables section              --
------------------------------------------------
CREATE TABLE Store 
(
    storeID INT IDENTITY(1,1) PRIMARY KEY,
    storeName VARCHAR(255) NOT NULL,
    storeAddress VARCHAR(500) NOT NULL
)

CREATE TABLE Inventory 
( 
    inventoryID INT IDENTITY(1,1) PRIMARY KEY,
    storeID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Store(storeID),
    inventoryName VARCHAR(255) NOT NULL
)

CREATE TABLE Employee 
(
    employeeID INT IDENTITY(1,1) PRIMARY KEY,
    storeID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Store(storeID),
    isManager BIT NOT NULL,
    canDeliver BIT NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    middleName VARCHAR(255),
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255) NOT NULL,
    employeeAddress VARCHAR(255) NOT NULL,
    dob DATE
)

CREATE TABLE Customer 
(
    customerID INT IDENTITY(1,1) PRIMARY KEY,
    storeID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Store(storeID),
    firstName VARCHAR(255) NOT NULL,
    middleName VARCHAR(255),
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255) NOT NULL,
    customerAddress VARCHAR(255) NOT NULL,
    isCommercial BIT
)

CREATE TABLE Tool 
(
    toolID INT IDENTITY(1,1) PRIMARY KEY,
    inventoryID INT NOT NULL,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID),
    partName VARCHAR(255),
    toolCost DECIMAL(38, 2) NOT NULL ----- POSSIBLY NEED TO CHANGE
)

CREATE TABLE Rental 
(
    rentalID INT IDENTITY(1,1) PRIMARY KEY,
    toolID INT NOT NULL,
    FOREIGN KEY (toolID) REFERENCES Tool(toolID),
    rentalPeriod INT
)

CREATE TABLE Part 
(
    partID INT IDENTITY(1,1) PRIMARY KEY,
    inventoryID INT NOT NULL,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID),
    partCost DECIMAL(38, 2) NOT NULL, ----- POSSIBLY NEED TO CHANGE
    partName VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL
)

CREATE TABLE ShoppingCart 
(
    cartID INT NOT NULL PRIMARY KEY,
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    employeeID INT,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    partID INT,
    FOREIGN KEY (partID) REFERENCES Part(partID),
    rentalID INt,
    FOREIGN KEY (rentalID) REFERENCES Rental(rentalID),
)

CREATE TABLE Sales 
(
    saleID INT IDENTITY(1,1) PRIMARY KEY,
    cartID INT NOT NULL,
    FOREIGN KEY(cartID) REFERENCES ShoppingCart(cartID),
    totalCost DECIMAL(38, 2), ----- POSSIBLY NEED TO CHANGE
    isDeliver BIT NOT NULL,
    saleDate DATE NOT NULL
)

------------------------------------------------
--       Insert "Fake" Test Data              --
------------------------------------------------

INSERT INTO Store (storeName, storeAddress)
    VALUES 
        ('Cedar City Store', '123 Cedar City, UT, USA'),
        ('Richfield Store', '123 Richfield, UT, USA'),
        ('Ogden Store', '123 Ogden, UT, USA'),
        ('Salt Lake City Store', '123 Salt Lake City, UT, USA'),
        ('Lehi Store', '123 Lehi, UT, USA'),
        ('Provo Store', '123 Provo, UT, USA'),
        ('Las Vegas Store', '123 Las Vegas, NV, USA'),
        ('Henderson Store', '123 Henderson, NV, USA'),
        ('Reno Store', '123 Reno, NV, USA'),
        ('Carson City Store', '123 Carson City, NV, USA'),
        ('Mesquite Store', '123 Mesquite, NV, USA')

SELECT * FROM Store


INSERT INTO Inventory (storeID, inventoryName)
    VALUES
        ((SELECT storeID FROM Store WHERE storeID = 1), 'Cedar City Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 2), 'Richfield Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 3), 'Ogden Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 4), 'Salt Lake City Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 5), 'Lehi Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 6), 'Provo Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 7), 'Las Vegas Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 8), 'Henderson Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 9), 'Reno Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 10), 'Carson City Inventory'),
        ((SELECT storeID FROM Store WHERE storeID = 11), 'Mesquite Inventory')

SELECT * FROM Inventory

INSERT INTO Employee (storeID, isManager, canDeliver, firstName, middleName, lastName, email, phone, employeeAddress, dob)
    VALUES
        ((SELECT storeID FROM Store WHERE storeID = 1), 1, 1, 'Billy', NULL, 'Jones', NULL, '435-123-1234', '123 Cedar City Dr, Cedar City, UT', '19901010'),
        ((SELECT storeID FROM Store WHERE storeID = 1), 0, 1, 'Sergio', 'Andres', 'Reyescordova', 'serg65@gmail,com', '435-874-5345', '138 Foumders Dr, Cedar City, UT', '19960416'),
        ((SELECT storeID FROM Store WHERE storeID = 1), 0, 0, 'Porter', 'Redd', 'Peterson', 'redPeter@yahoo.com', '435-235-5420', '989 Typerson Dr, Cedar City, UT', '19800320'),
        ((SELECT storeID FROM Store WHERE storeID = 2), 1, 1, 'Howard', NULL, 'Stones', 'Hstones@hotmail.com', '435-098-0989', '738 Richfield Dr, , UT', '19880819'),
        ((SELECT storeID FROM Store WHERE storeID = 4), 1, 1, 'Ricardo', NULL, 'Gonzalez', NULL, '801-214-4655', '1425 West Dr, Salt Lake City, UT', '20001021'),
        ((SELECT storeID FROM Store WHERE storeID = 4), 0, 1, 'Andy', NULL, 'Hill', NULL, '801-999-0982', '1782 North Dr, Salt Lake City, UT', '19900101'),
        ((SELECT storeID FROM Store WHERE storeID = 5), 0, 1, 'Anna', 'Bell', 'Finn', 'Annfin@outlook.com', '435-847-4890', '8499 Main ST, Lehi, UT', '20010712'),
        ((SELECT storeID FROM Store WHERE storeID = 6), 1, 0, 'Nancy', NULL, 'Wells', NULL, '801-214-1111', '7288 Candy Lane, Provo, UT', '19950705'),
        ((SELECT storeID FROM Store WHERE storeID = 7), 1, 1, 'Riley', NULL, 'Under', 'Runders21@gmail.com', '702-344-8093', '1798 Golden Tree Dr, Las Vegas, NV', '20021109'),
        ((SELECT storeID FROM Store WHERE storeID = 8), 0, 0, 'Paul', 'Jones', 'Eber', NULL, '702-781-4390', '8939 Craig Dr, Henderson, NV', '19801212'),
        ((SELECT storeID FROM Store WHERE storeID = 9), 1, 0, 'Vinnie', 'Hold', 'Ontoers', 'Vhold78423@gmail.com', '702-412-6531', '9920 Down Trunk Dr, Reno, NV', '20000828')

SELECT * FROM Employee

INSERT INTO Tool (inventoryID, partName, toolCost)
    VALUES 
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 1), 'Socket Set', 19.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 2), 'Hammer', 14.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 3), 'Wrench', 4.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 4), 'Pilers', 2.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 5), 'Screwdriver', 2.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 6), 'Trolly Jack', 49.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 7), 'Multimeter', 29.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 8), 'Pick Set', 9.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 9), 'Breaker Bar', 59.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 10), 'Impact Wrench', 89.99),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 11), 'Tire Pressure Gauge', 6.99)

SELECT * FROM Tool

INSERT INTO Customer (storeID, firstName, middleName, lastName, email, phone, customerAddress, isCommercial)
    VALUES
        ((SELECT storeID FROM Store WHERE storeID = 1), 'Ollie', NULL, 'Swintho', 'Oswin21@gmail.com', '435-091-8431', '832 Main St, Cedar City, UT', 0),
        ((SELECT storeID FROM Store WHERE storeID = 1), 'Anderson', 'Ann', 'Ross', 'ArossA@yahoo.com', '435-012-2311', '312 East St, Cedar City, UT', 1),
        ((SELECT storeID FROM Store WHERE storeID = 1), 'Aguilar', 'Alexander', 'Brian', 'BrainA@yahoo.com.com', '435-112-2211', '982 Cedar City Dr, Cedar City, UT', 1),
        ((SELECT storeID FROM Store WHERE storeID = 3), 'Baker', NULL, 'Jayden', NULL, '435-091-8431', '732 Builder St, Ogden, UT', 0),
        ((SELECT storeID FROM Store WHERE storeID = 4), 'Cahalin', 'Bridget', 'Erin', NULL, '801-932-2182', '993 Beaver Dr, Salt Lake City, UT', 0),
        ((SELECT storeID FROM Store WHERE storeID = 7), 'Dempsey', 'Clarissa', 'Kylee', 'Dempsey28923@gmail.com', '702-832-1200', '0219 Bridgewater St, Las Vegas, NV', 1),
        ((SELECT storeID FROM Store WHERE storeID = 8), 'Denton', NULL, 'Brayden', 'Denton32Bray@outlook.com', '702-902-9201', '9320 Boulder Dr, Henderson, NV', 1),
        ((SELECT storeID FROM Store WHERE storeID = 9), 'Ebbert', NULL, 'Haley', NULL, '702-904-9530', '0932 High Land Dt, Reno, NV', 0),
        ((SELECT storeID FROM Store WHERE storeID = 9), 'Flores', 'Anthony', 'Devon', 'DAFLO842@gmail.com', '702-843-5432', '9320 Upper Leval Dr, Reno, NV', 0),
        ((SELECT storeID FROM Store WHERE storeID = 10), 'Hall', NULL, 'Jake', NULL, '702-555-5584', '3299 Homeland St, Carson City, NV', 0),
        ((SELECT storeID FROM Store WHERE storeID = 11), 'Jules', 'Grant', 'Sawyer', 'Julesdoes32@hotmail.com', '702-753-7546', '8329 Fever Dr, Mesquite, NV', 1)

SELECT * FROM Customer

INSERT INTO Part (inventoryId, partCost, partName, category)
    VALUES
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 1), 59.99, 'Control Arm', 'Suspension'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 2), 29.99, 'Ball Joint', 'Suspension'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 3), 79.99, 'Shocks/Struts', 'Suspension'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 4), 5.99, 'Spark Plugs', 'Ignition'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 5), 99.99, 'Ignition Coil Pack', 'Ignition'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 6), 119.99, 'Radiator Assembly', 'Cooling'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 7), 49.99, 'Upper Radiator Hose', 'Cooling'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 8), 49.99, 'Lower Radiator Hose', 'Cooling'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 9), 39.99, 'Brake Pads', 'Brakes'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 10), 99.99, 'Rotors', 'Brakes'),
        ((SELECT inventoryID FROM Inventory WHERE inventoryID = 11), 89.99, 'Calipers', 'Brakes')

SELECT * FROM Part

INSERT INTO Rental (toolID, rentalPeriod)
    VALUES
        ((SELECT toolID FROM Tool WHERE toolID = 1), 5),
        ((SELECT toolID FROM Tool WHERE toolID = 5), 3),
        ((SELECT toolID FROM Tool WHERE toolID = 2), 8),
        ((SELECT toolID FROM Tool WHERE toolID = 7), 2),
        ((SELECT toolID FROM Tool WHERE toolID = 10), 1),
        ((SELECT toolID FROM Tool WHERE toolID = 11), 9),
        ((SELECT toolID FROM Tool WHERE toolID = 3), 10),
        ((SELECT toolID FROM Tool WHERE toolID = 4), 15),
        ((SELECT toolID FROM Tool WHERE toolID = 9), 6),
        ((SELECT toolID FROM Tool WHERE toolID = 1), 5),
        ((SELECT toolID FROM Tool WHERE toolID = 8), 12)

SELECT * FROM Rental

INSERT INTO ShoppingCart (cartID, customerID, employeeID, partID, rentalID)
    VALUES
        (1, (SELECT customerID FROM Customer WHERE customerID = 1), (SELECT employeeId FROM Employee WHERE employeeId = 1), (SELECT partID FROM Part WHERE partID = 1), (SELECT rentalID FROM Rental WHERE rentalID = 1)),
        (2, (SELECT customerID FROM Customer WHERE customerID = 1), (SELECT employeeId FROM Employee WHERE employeeId = 1), (SELECT partID FROM Part WHERE partID = 3), NULL),
        (3, (SELECT customerID FROM Customer WHERE customerID = 1), (SELECT employeeId FROM Employee WHERE employeeId = 1), (SELECT partID FROM Part WHERE partID = 6), (SELECT rentalID FROM Rental WHERE rentalID = 4)),
        (4, (SELECT customerID FROM Customer WHERE customerID = 1), (SELECT employeeId FROM Employee WHERE employeeId = 1), NULL, (SELECT rentalID FROM Rental WHERE rentalID = 9)),
        (5, (SELECT customerID FROM Customer WHERE customerID = 2), (SELECT employeeId FROM Employee WHERE employeeId = 6), (SELECT partID FROM Part WHERE partID = 10), NULL),
        (6, (SELECT customerID FROM Customer WHERE customerID = 2), (SELECT employeeId FROM Employee WHERE employeeId = 6), (SELECT partID FROM Part WHERE partID = 2), NULL),
        (7, (SELECT customerID FROM Customer WHERE customerID = 3), (SELECT employeeId FROM Employee WHERE employeeId = 6), (SELECT partID FROM Part WHERE partID = 10), NULL),
        (8, (SELECT customerID FROM Customer WHERE customerID = 5), (SELECT employeeId FROM Employee WHERE employeeId = 2), (SELECT partID FROM Part WHERE partID = 10), NULL),
        (9, (SELECT customerID FROM Customer WHERE customerID = 5), (SELECT employeeId FROM Employee WHERE employeeId = 2), (SELECT partID FROM Part WHERE partID = 10), NULL),
        (10, (SELECT customerID FROM Customer WHERE customerID = 2), (SELECT employeeId FROM Employee WHERE employeeId = 1), (SELECT partID FROM Part WHERE partID = 10), NULL),
        (11, (SELECT customerID FROM Customer WHERE customerID = 2), (SELECT employeeId FROM Employee WHERE employeeId = 1), (SELECT partID FROM Part WHERE partID = 2), NULL)

SELECT * FROM ShoppingCart


INSERT INTO Sales (cartID, totalCost, isDeliver, saleDate)
    VALUES 
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 1), NULL, 0, '20221130'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 2), NULL, 1, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 3), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 4), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 5), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 6), NULL, 1, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 7), NULL, 1, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 8), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 9), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 10), NULL, 0, '20221202'),
        ((SELECT cartID FROM ShoppingCart WHERE cartID = 11), NULL, 0, '20221202')

SELECT * FROM Sales        