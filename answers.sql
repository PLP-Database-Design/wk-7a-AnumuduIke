-- For SQL Server
SELECT 
    OrderID, 
    CustomerName, 
    TRIM(value) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');


-- Manually normalized version
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Create a new table for Customers to remove the partial dependency
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique OrderID and CustomerName pairs
INSERT INTO Customers (OrderID, CustomerName) VALUES (101, 'John Doe');
INSERT INTO Customers (OrderID, CustomerName) VALUES (102, 'Jane Smith');
INSERT INTO Customers (OrderID, CustomerName) VALUES (103, 'Emily Clark');

-- Create a new table for OrderDetails with full dependency on the composite key (OrderID, Product)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- Insert order details
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (101, 'Laptop', 2);
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (101, 'Mouse', 1);
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (102, 'Tablet', 3);
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (102, 'Keyboard', 1);
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (102, 'Mouse', 2);
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES (103, 'Phone', 1);
