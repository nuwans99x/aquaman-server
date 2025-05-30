-- Create Users table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Customer', 'Administrator')),
    CreatedAt DATETIME DEFAULT GETDATE()
);
 
-- Create Products table
CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    ImageUrl NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE()
);
 
-- Create Orders table
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Processed', 'Completed')),
    CreatedAt DATETIME DEFAULT GETDATE()
);
 
-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);
 
-- Create ShoppingCart table
CREATE TABLE ShoppingCart (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL
);

-- Insert sample data into Users table
INSERT INTO Users (Username, PasswordHash, Role)
VALUES
('john_doe', 'hashed_password_123', 'Customer'),
('admin_user', 'hashed_password_456', 'Administrator');
 
-- Insert sample data into Products table
INSERT INTO Products (Name, Price, Stock, ImageUrl)
VALUES
('Laptop', 999.99, 10, 'https://example.com/images/laptop.jpg'),
('Smartphone', 499.99, 20, 'https://example.com/images/smartphone.jpg'),
('Headphones', 79.99, 50, 'https://example.com/images/headphones.jpg');
 
-- Insert sample data into Orders table
INSERT INTO Orders (UserId, TotalAmount, Status)
VALUES
(1, 1079.98, 'Pending'),
(2, 499.99, 'Processed');
 
-- Insert sample data into OrderDetails table
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price)
VALUES
(1, 1, 1, 999.99),
(1, 3, 1, 79.99),
(2, 2, 1, 499.99);
 
-- Insert sample data into ShoppingCart table
INSERT INTO ShoppingCart (UserId, ProductId, Quantity)
VALUES
(1, 2, 1),
(1, 3, 2),
(2, 1, 1);