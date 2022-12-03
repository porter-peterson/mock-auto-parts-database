

------------------------------------------------
--         Some Simple User Queries           --
------------------------------------------------
SELECT * FROM Part WHERE inventoryID = 1 

SELECT * FROM Rental WHERE toolID = 4

SELECT * FROM Employee WHERE isManager = 1

SELECT * FROM Customer WHERE isCommercial = 0

SELECT phone, storeID, firstName FROM Customer WHERE customerID = 6

SELECT firstName, middleName, lastName, dob FROM Employee WHERE dob < '20000101'



SELECT employeeID FROM ShoppingCart WHERE employeeID IN (SELECT cartID FROM Sales WHERE saleDate = '20221202')

SELECT customerAddress, firstName, lastName, phone FROM Customer WHERE customerID IN (SELECT saleID FROM Sales WHERE isDeliver = 1)

SELECT customerID, employeeID, partID, rentalID FROM ShoppingCart WHERE cartID IN (SELECT saleID FROM Sales WHERE saleID > 0)

SELECT partName FROM Part WHERE partID IN (SELECT inventoryID FROM Inventory WHERE inventoryID = 1)


UPDATE Customer
SET isCommercial = 1
WHERE customerID = 1

UPDATE Employee
SET isManager = 1
WHERE employeeID = 2

------------------------------------------------
--                 Views                      --
------------------------------------------------


GO 
CREATE VIEW [Customers with Emails] AS
SELECT firstName, middleName, lastName, email
FROM Customer
WHERE email IS NOT NULL

GO
SELECT * FROM [Customers with Emails]

GO 
CREATE VIEW [Sales to Deliver] AS
SELECT saleID, totalCost, saleDate, isDeliver 
FROM Sales
WHERE isDeliver = 1

GO
SELECT * FROM [Sales to Deliver]

GO 
CREATE VIEW [Is Commerical Customer] AS 
SELECT firstName, middleName, lastName, email, phone, isCommercial, customerAddress
FROM Customer
Where isCommercial = 1 AND  email IS NOT NULL

GO
SELECT * FROM [Is Commerical Customer]


------------------------------------------------
--               Procedures                   --
------------------------------------------------

DROP PROCEDURE IF EXISTS getTotalCost
GO
CREATE PROCEDURE getTotalCost
AS
    BEGIN
        DECLARE 
            @saleID INT

        SET 
            @saleID = 11

        SELECT s.saleID, p.partCost, t.toolCost
        INTO ##tempTable
        FROM Sales s
        INNER JOIN ShoppingCart sc ON s.cartID = sc.cartID
        LEFT JOIN Part p ON p.partID = sc.partID AND s.cartID = sc.cartID
        LEFT JOIN Rental r ON r.rentalID = sc.rentalID AND s.cartID = sc.cartID
        LEFT JOIN Tool t ON t.toolID = r.toolID

        ALTER TABLE ##tempTable
        ADD total DECIMAL NULL

        UPDATE ##tempTable
        SET partCost = 0
        WHERE partCost IS NULL

        UPDATE ##tempTable
        SET toolCost = 0
        WHERE toolCost IS NULL

        UPDATE ##tempTable
        SET total = partCost + toolCost
        WHERE saleID = @saleID

        UPDATE Sales
        SET totalCost = (SELECT total FROM ##tempTable WHERE saleID = @saleID)
        WHERE saleID = @saleID

        DROP TABLE ##tempTable

        SELECT * FROM Sales
    END

EXEC getTotalCost

GO
CREATE PROCEDURE SelectAllManger
AS
SELECT * FROM Employee
Where isManager = 1

EXEC SelectAllManger

SELECT * FROM Employee

GO
CREATE PROCEDURE SelectAllCommercialCustomers
AS
SELECT * FROM Customer
Where isCommercial = 1

EXEC SelectAllCommercialCustomers
SELECT * FROM Customer

------------------------------------------------
--                Triggers                    --
------------------------------------------------

DROP TRIGGER IF EXISTS reminder1
GO
CREATE TRIGGER reminder1  
ON Sales
AFTER INSERT
AS EXEC getTotalCost
GO  

DROP TRIGGER IF EXISTS reminder2
GO
CREATE TRIGGER reminder1  
ON Customer
AFTER INSERT, UPDATE
AS RAISERROR ('Is it a commercial customer?', 16, 10);  
GO  

DROP TRIGGER IF EXISTS reminder3
GO
CREATE TRIGGER reminder2  
ON Employee
AFTER INSERT, UPDATE
AS RAISERROR ('Is this a Manager?', 16, 10);  
GO  
  

------------------------------------------------
--                 Ussers                     --
------------------------------------------------

CREATE LOGIN manager WITH PASSWORD = 'Manpasscode2';

CREATE USER manager FOR LOGIN manager;


CREATE LOGIN employee WITH PASSWORD = 'emppassw213';

CREATE USER employee FOR LOGIN employee;

