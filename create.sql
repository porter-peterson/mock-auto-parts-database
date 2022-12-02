------------------------------------------------
-- Create table for our Mock Auto Parts Store --
------------------------------------------------
CREATE DATABASE AutoPartsStore

------------------------------------------------
--         Create tables section              --
------------------------------------------------
CREATE TABLE Store 
(
    storeID INT NOT NULL PRIMARY KEY,
    storeName VARCHAR(255) NOT NULL,
    storeAddress VARCHAR(500) NOT NULL
)

CREATE TABLE Inventory 
( ------------------- alter and make FK not null
    inventoryID INT NOT NULL PRIMARY KEY,
    storeID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Store(storeID)
)

CREATE TABLE Employee 
(
    employeeID INT NOT NULL PRIMARY KEY,
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
    customerID INT NOT NULL PRIMARY KEY,
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
    toolID INT NOT NULL PRIMARY KEY,
    inventoryID INT NOT NULL,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID),
    partName VARCHAR(255),
    toolCost DECIMAL(38, 2) NOT NULL ----- POSSIBLY NEED TO CHANGE
)

CREATE TABLE Rental 
(
    rentalID INT NOT NULL PRIMARY KEY,
    toolID INT NOT NULL,
    FOREIGN KEY (toolID) REFERENCES Tool(toolID),
    rentalPeriod INT
)

CREATE TABLE Part 
(
    partID INT NOT NULL PRIMARY KEY,
    inventoryID INT NOT NULL,
    FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID),
    partCost DECIMAL(38, 2) NOT NULL, ----- POSSIBLY NEED TO CHANGE
    partName VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL
)

-- CREATE TABLE ShoppingCart 
-- (
--     cartID INT NOT NULL PRIMARY KEY,
--     customerID INT NOT NULL,
--     FOREIGN KEY (customerID) REFERENCES Customer(customerID),
--     employeeID INT NOT NULL,
--     FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
--     partID INT NOT NULL,
--     FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
-- )

-- CREATE TABLE Sales 
-- (
--     saleID INT NOT NULL PRIMARY KEY,
--     cartID INT NOT NULL,
--     FOREIGN KEY(cartID) REFERENCES ShoppingCart(cartID),
--     totalCost DECIMAL(38, 2) NOT NULL, ----- POSSIBLY NEED TO CHANGE
--     isDeliver BIT NOT NULL,
--     saleDate DATE NOT NULL
-- )


------------------------------------------------
--       Insert "Fake" Test Data              --
------------------------------------------------


