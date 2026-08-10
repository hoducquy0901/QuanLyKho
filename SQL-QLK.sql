CREATE DATABASE QKL;
GO QKL

--quản lí, nhân viên
CREATE TABLE Users(
    UsersId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
	Role VARCHAR(20) NOT NULL
		CHECK (Role IN ('Manager', 'Employee'))
);


-- nhà cung cấp

CREATE TABLE Supplier (
    SupplierId INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);


-- danh mục hàng

CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

-- hàng hóa
CREATE TABLE Brand (
    BrandId INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(100) NOT NULL,
    Country NVARCHAR(100),
    Description NVARCHAR(500)
);
CREATE TABLE Product (
    ProductId INT  IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    BrandId INT NOT NULL,
    CategoryId INT NOT NULL,
    Unit NVARCHAR(50),
    ImportPrice DECIMAL(18,2) NOT NULL,
    SellingPrice DECIMAL(18,2) NOT NULL,
    Description NVARCHAR(500),

    CONSTRAINT FK_Product_Brand
        FOREIGN KEY (BrandId)
        REFERENCES Brand(BrandId),

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId)
);


-- hàng tồn kho

CREATE TABLE Inventory (
    InventoryId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL UNIQUE,
    Quantity INT DEFAULT 0,
    LastUpdated DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Inventory_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
);


-- Biên nhận của kho

CREATE TABLE ImportReceipt (
    ReceiptId INT IDENTITY(1,1) PRIMARY KEY,
    ImportDate DATETIME DEFAULT GETDATE(),
    SupplierId INT NOT NULL,
    UsersId INT NOT NULL,
    TotalAmount DECIMAL(18,2) DEFAULT 0,

    CONSTRAINT FK_Receipt_Supplier
        FOREIGN KEY (SupplierId)
        REFERENCES Supplier(SupplierId),

    CONSTRAINT FK_Receipt_Employee
        FOREIGN KEY (UsersId)
        REFERENCES Users(UsersId)
);


-- chi tiết biên nhận

CREATE TABLE ImportReceiptDetail (
    DetailId INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Amount AS (Quantity * UnitPrice),

    FOREIGN KEY (ReceiptId) REFERENCES ImportReceipt(ReceiptId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);
INSERT INTO Users (FullName, Email, Phone, Username, Password, Role)
VALUES
(N'Hồ Đức Quý', 'quy@gmail.com', '0909123456', 'admin', 'quy123', 'Manager'),
(N'Huỳnh Hoàn Hào', 'hao@gmail.com', '0934123456', 'employee1', 'hao123', 'Employee');
INSERT INTO Supplier (SupplierName, Address, Phone, Email)
VALUES
(N'Công ty TNHH AAA', N'123 Nguyễn Huệ, TP.HCM', '0909232323', 'aaa@gmail.com'),
(N'Công ty Minh Phát', N'45 Lê Lợi, TP.HCM', '0909454545', 'minhphat@gmail.com'),
(N'Công ty Hoàng Long', N'88 Trần Phú, TP.HCM', '0909565656', 'hoanglong@gmail.com');
INSERT INTO Category (CategoryName)
VALUES
(N'Điện thoại'),
(N'Laptop'),
(N'Phụ kiện');
INSERT INTO Brand (BrandName, Country, Description)
VALUES
(N'Samsung', N'Hàn Quốc', N'Thương hiệu điện thoại Samsung'),
(N'Apple', N'Mỹ', N'Thương hiệu Apple'),
(N'Xiaomi', N'Trung Quốc', N'Thương hiệu Xiaomi');
INSERT INTO Product
(ProductName, BrandId, CategoryId, Unit, ImportPrice, SellingPrice, Description)
VALUES
(N'Samsung Galaxy S27',1,1,N'Cái',18000000,21000000,N'Điện thoại Samsung'),
(N'iPhone 17',2,1,N'Cái',25000000,29000000,N'Điện thoại Apple'),
(N'Redmi Note 17',3,1,N'Cái',5000000,6500000,N'Điện thoại Xiaomi'),
(N'MacBook Air M5',2,2,N'Cái',28000000,33000000,N'Laptop Apple'),
(N'Sạc nhanh 67W',1,3,N'Cái',300000,450000,N'Phụ kiện');
INSERT INTO Inventory
(ProductId, Quantity, LastUpdated)
VALUES
(1,15,GETDATE()),
(2,10,GETDATE()),
(3,25,GETDATE()),
(4,8,GETDATE()),
(5,50,GETDATE());
INSERT INTO ImportReceipt
(ImportDate,SupplierId,UsersId,TotalAmount)
VALUES
(GETDATE(),1,1,270000000),
(GETDATE(),2,2,250000000),
(GETDATE(),3,1,50000000);
INSERT INTO ImportReceiptDetail
(ReceiptId,ProductId,Quantity,UnitPrice)
VALUES
(1,1,10,18000000),
(1,5,30,300000),
(2,2,10,25000000),
(3,3,10,5000000);
SELECT * from Users