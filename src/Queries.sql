create database BookstoreDB;
use BookstoreDB;

create table Books(bookID INT AUTO_INCREMENT PRIMARY KEY,
                   Title VARCHAR(255),
                   Author VARCHAR(100),
                   Genre VARCHAR(50),
                   Price DECIMAL(10,2),
                   QuantityInStock INT
);

INSERT INTO Books(Title, Author, Genre, Price, QuantityInStock) VALUES
                                                                    ('Book 1 Title', 'Author 1', 'Fiction', 19.99, 50),
                                                                    ('Book 2 Title', 'Author 2', 'Non-fiction', 24.50, 30),
                                                                    ('Book 3 Title', 'Author 3', 'Science', 15.75, 20),
                                                                    ('Book 4 Title', 'Author 4', 'Thriller', 12.00, 40),
                                                                    ('Book 5 Title', 'Author 5', 'Romance', 29.95, 15),
                                                                    ('Book 6 Title', 'Author 6', 'Fantasy', 18.25, 25),
                                                                    ('Book 7 Title', 'Author 7', 'Fiction', 22.99, 10),
                                                                    ('Book 8 Title', 'Author 8', 'Biography', 14.50, 35),
                                                                    ('Book 9 Title', 'Author 9', 'History', 32.00, 5),
                                                                    ('Book 10 Title', 'Author 10', 'Fantasy', 27.75, 12);

create table Customers(customerID INT AUTO_INCREMENT PRIMARY KEY,
                       Name VARCHAR(50) NOT NULL ,
                       Email VARCHAR(255) NOT NULL,
                       Phone VARCHAR(255) NOT NULL
);

INSERT INTO Customers(Name,Email,Phone) VALUES
                                            ('Alice', 'alice@example.com', '+1234567890'),
                                            ('Bob', 'bob@example.com', '+1987654321'),
                                            ('Charlie', 'charlie@example.com', '+1122334455'),
                                            ('David', 'david@example.com', '+15550998877'),
                                            ('Eve', 'eve@example.com', '+14159265359');

INSERT INTO Customers (Name, Email, Phone) VALUES
                                               ('Fiona', 'fiona@example.com', '+1654321876'),
                                               ('George', 'george@example.com', '+1209876543'),
                                               ('Hannah', 'hannah@example.com', '+1789456123'),
                                               ('Isaac', 'isaac@example.com', '+1888777666'),
                                               ('Jack', 'jack@example.com', '+1999888777');

CREATE TABLE Sales(SaleID INT AUTO_INCREMENT PRIMARY KEY,
                   BookID INT,
                   CustomerID INT,
                   DateOfSale DATE,
                   QuantitySold INT,
                   TotalPrice DECIMAL(10, 2),
                   FOREIGN KEY (BookID) REFERENCES Books(BookID),
                   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Sales (BookID, CustomerID, DateOfSale, QuantitySold, TotalPrice) VALUES
                                                                                 (1, 1, '2023-01-10', 2, 39.98),
                                                                                 (2, 2, '2023-02-15', 1, 24.50),
                                                                                 (3, 3, '2023-03-20', 3, 47.25),
                                                                                 (4, 4, '2023-04-25', 2, 24.00),
                                                                                 (5, 5, '2023-05-30', 1, 29.95);

INSERT INTO Sales (BookID, CustomerID, DateOfSale, QuantitySold, TotalPrice) VALUES
                                                                                 (6, 6, '2023-06-05', 2, 45.80),
                                                                                 (7, 7, '2023-07-12', 1, 22.99),
                                                                                 (8, 8, '2023-08-18', 4, 58.00),
                                                                                 (9, 9, '2023-09-25', 3, 96.00),
                                                                                 (10, 10, '2023-10-30', 2, 55.50);

SELECT Books.Title AS BookTitle, Customers.Name AS CustomerName, Sales.DateOfSale
FROM Sales
         JOIN Books ON Sales.BookID = Books.BookID
         JOIN Customers ON Sales.CustomerID = Customers.CustomerID;

SELECT b.Genre, SUM(s.TotalPrice) AS TotalRevenue
FROM Books b
         JOIN Sales s ON b.BookID = s.BookID
GROUP BY b.Genre;


CREATE TRIGGER updateQuantityInStock
    AFTER INSERT ON Sales
    FOR EACH ROW
BEGIN
    UPDATE Books
    SET QuantityInStock = QuantityInStock - NEW.QuantitySold
    WHERE BookID = NEW.BookID;
END;


