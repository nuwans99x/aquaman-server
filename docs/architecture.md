# Architecture

- Client side is a react application
- Server side is a .Net core rest api.
- Database is a MS SQL hosted in Azure.
- We manage the identity internlly using the same database.

# Database Schema

## Users

- `UserId` (INT, Primary Key, Identity)
- `Username` (NVARCHAR(50), Not Null)
- `PasswordHash` (NVARCHAR(MAX), Not Null)
- `Role` (NVARCHAR(20), Not Null, Check: 'Customer', 'Administrator')
- `CreatedAt` (DATETIME, Default: GETDATE())

## Products

- `ProductId` (INT, Primary Key, Identity)
- `Name` (NVARCHAR(100), Not Null)
- `Price` (DECIMAL(10, 2), Not Null)
- `Stock` (INT, Not Null)
- `ImageUrl` (NVARCHAR(MAX))
- `CreatedAt` (DATETIME, Default: GETDATE())

## Orders

- `OrderId` (INT, Primary Key, Identity)
- `UserId` (INT, Not Null, Foreign Key: Users(UserId))
- `TotalAmount` (DECIMAL(10, 2), Not Null)
- `Status` (NVARCHAR(20), Not Null, Check: 'Pending', 'Processed', 'Completed')
- `CreatedAt` (DATETIME, Default: GETDATE())

## OrderDetails

- `OrderDetailId` (INT, Primary Key, Identity)
- `OrderId` (INT, Not Null, Foreign Key: Orders(OrderId))
- `ProductId` (INT, Not Null, Foreign Key: Products(ProductId))
- `Quantity` (INT, Not Null)
- `Price` (DECIMAL(10, 2), Not Null)

## ShoppingCart

- `CartId` (INT, Primary Key, Identity)
- `UserId` (INT, Not Null, Foreign Key: Users(UserId))
- `ProductId` (INT, Not Null, Foreign Key: Products(ProductId))
- `Quantity` (INT, Not Null)