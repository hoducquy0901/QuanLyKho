

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
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    BrandId INT NOT NULL,
    CategoryId INT NOT NULL,
    Unit NVARCHAR(50),
    ImportPrice DECIMAL(18,2) NOT NULL,
    SellingPrice DECIMAL(18,2) NOT NULL,
    QuantityInStock INT DEFAULT 0,
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
    ProductId INT NOT NULL,
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
    ReceiptId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Amount AS (Quantity * UnitPrice),

    PRIMARY KEY (ReceiptId, ProductId),

    CONSTRAINT FK_Detail_Receipt
        FOREIGN KEY (ReceiptId)
        REFERENCES ImportReceipt(ReceiptId),

    CONSTRAINT FK_Detail_Product
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
);

select * from Users