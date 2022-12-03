

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


