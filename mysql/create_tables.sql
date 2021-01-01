CREATE DATABASE xiaoshou;
USE xiaoshou;


-- Accounts
CREATE TABLE Accounts (
    AccountNo int AUTO_INCREMENT PRIMARY KEY,
    AccountID varchar(20) NOT NULL,
    AccountEmail varchar(70) NOT NULL,
    AccountPassword varchar(40) NOT NULL,
    AccountDisplayName nvarchar(40) NOT NULL DEFAULT '小手用户',
    AccountStatus ENUM('active', 'verified', 'vip', 'pending', 'delete', 'removed', 'inactive', 'update') NOT NULL DEFAULT 'update',
    AccountCreateDate TIMESTAMP NOT NULL,
    AccountModifyDate TIMESTAMP NOT NULL,
    AccountPhoto BLOB,
    AccountCellphone varchar(20),
    AccountWechatID varchar(20),
    AccountDescription nvarchar(500),
    PaymentAccountOwnerName nvarchar(20),
    PaymentCardNumber varchar(40),
    PaymentBankName nvarchar(40),
    PaymentBankProvince nvarchar(20),
    PaymentBankCity nvarchar(20),
    PaymentBankDisctrict nvarchar(20),
    PaymentBankBranchName nvarchar(80),
    StoresCount int NOT NULL DEFAULT 0
);

INSERT INTO Accounts (
    AccountID, AccountEmail, AccountPassword, AccountDisplayName, AccountStatus,
    AccountCreateDate, AccountModifyDate, AccountCellphone, AccountWechatID, AccountDescription,
    PaymentAccountOwnerName, PaymentCardNumber, PaymentBankName,
    PaymentBankProvince, PaymentBankCity, PaymentBankDisctrict, PaymentBankBranchName,
    StoresCount)
VALUES ('carllee1991', 'carl@email.com', '123', '烂漫小豆', 'vip',
    '2020-01-01 10:10:10', '2020-01-01 10:10:10', '+1-631', 'carllee1991', 'Hello, Xiaoshou! 你好，小手！',
    '李xx', '4147202215464588', 'CMB',
    '北京', '北京', '东城区', '东直门支行东直门支行东直门支行东直门支行东直门支行',
    1);

INSERT INTO Accounts (
    AccountID, AccountEmail, AccountPassword,
    AccountCreateDate, AccountModifyDate)
VALUES ('carllee1992', 'carl2@email.com', '123',
    now(), now());

-- Stores
CREATE TABLE Stores (
    StoreNo int AUTO_INCREMENT PRIMARY KEY,
    StoreDisplayName nvarchar(40) NOT NULL,
    StoreStatus ENUM('active', 'verified', 'vip', 'pending', 'delete', 'removed', 'inactive', 'update') NOT NULL DEFAULT 'pending',
    StoreCreateDate TIMESTAMP NOT NULL,
    StoreModifyDate TIMESTAMP NOT NULL,
    StorePhoto BLOB,
    StoreDescription nvarchar(500),
    ItemsCount int NOT NULL,
    AccountNo int NOT NULL,
    FOREIGN KEY (AccountNo)
        REFERENCES Accounts(AccountNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Stores (StoreDisplayName, StoreStatus,
    StoreCreateDate, StoreModifyDate, StoreDescription, ItemsCount, AccountNo)
VALUES ('李哥定制大裤衩工作室', 'verified',
    '2020-01-01 10:10:20', '2020-01-01 10:10:20', 'Test xiaoshou Stores!', 1, 1);


-- Items
CREATE TABLE Items (
    ItemNo int AUTO_INCREMENT PRIMARY KEY,
    ItemDisplayName nvarchar(40) NOT NULL,
    ItemInventory int NOT NULL DEFAULT 0,
    ItemStatus ENUM('active', 'inactive', 'pending', 'delete', 'removed', 'update') NOT NULL DEFAULT 'pending',
    ItemType ENUM('customize', 'instock') NOT NULL,
    ItemReturnPolicy ENUM('nonreturnable', '7days', '14days', '30days', '60days', '90days') NOT NULL DEFAULT 'nonreturnable',
    ItemPhotos BLOB(20),
    ItemDescription nvarchar(2000) NOT NULL,
    ManufacturePhotos BLOB(20),
    ManufactureDescription nvarchar(2000),
    Material nvarchar(200),
    Dimension nvarchar(200),
    CustomizeRequiredInfo nvarchar(1000),
    CustomizeNotes nvarchar(1000),
    PriceSet nvarchar(100) NOT NULL,
    ShippingFee varchar(20),
    ShippingDays varchar(20),
    ItemCreateDate TIMESTAMP NOT NULL,
    ItemModifyDate TIMESTAMP NOT NULL,
    OrdersCount int NOT NULL,
    StoreNo int NOT NULL,
    AccountNo int NOT NULL,
    FOREIGN KEY (AccountNo)
        REFERENCES Accounts(AccountNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StoreNo)
        REFERENCES Stores(StoreNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Items (
    ItemDisplayName, ItemInventory,
    ItemStatus, ItemType, ItemReturnPolicy, ItemDescription,
    ManufactureDescription, Material, Dimension, CustomizeRequiredInfo, CustomizeNotes,
    PriceSet, ShippingFee, ShippingDays, ItemCreateDate, ItemModifyDate, OrdersCount,
    StoreNo, AccountNo)
VALUES ('心', 1,
    'active', 'instock', 'nonreturnable', 'all my love',
    'do odo od', 'blood', '砂锅大的拳头', '生辰八字', '全凭眼缘',
    'priceless', '$12 or ¥90', '512', '2020-01-01 10:10:30', '2020-01-01 10:10:30', 10000,
    2, 1);


-- Customers
CREATE TABLE Customers (
    CustomerNo int AUTO_INCREMENT PRIMARY KEY,
    CustomerCreateDate TIMESTAMP NOT NULL,
    CustomerEmail varchar(70),
    CustomerName nvarchar(40),
    CustomerAddress nvarchar(2000),
    CustomerCellphone varchar(20),
    CustomerWechatID varchar(20)
);


-- Orders
CREATE TABLE Orders (
    OrderNo int AUTO_INCREMENT PRIMARY KEY,
    OrderStatus ENUM('pending_ship', 'arriving', 'delivered', 'closed', 'cancelled', 'update') NOT NULL,
    ShippingFee int NOT NULL DEFAULT 0,
    OrderCreateDate TIMESTAMP NOT NULL,
    OrderCloseDate TIMESTAMP,
    OrderTax int,
    OrderTotal int NOT NULL,
    CustomerNo int NOT NULL,
    StoreNo int NOT NULL,
    AccountNo int NOT NULL,
    FOREIGN KEY (AccountNo)
        REFERENCES Accounts(AccountNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StoreNo)
        REFERENCES Stores(StoreNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CustomerNo)
        REFERENCES Customers(CustomerNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- OrderItems
CREATE TABLE OrderItems (
    OrderItemNo int AUTO_INCREMENT PRIMARY KEY,
    OrderStatus ENUM('pending_ship', 'arriving', 'delivered', 'closed', 'cancelled', 'update') NOT NULL,
    ShippingFee int NOT NULL DEFAULT 0,
    CustomizeRequiredInfo nvarchar(1000) NOT NULL,
    CustomizeNotes nvarchar(1000),
    CustomerNo int NOT NULL,
    OrderNo int NOT NULL,
    ItemNo int NOT NULL,
    StoreNo int NOT NULL,
    AccountNo int NOT NULL,
    FOREIGN KEY (AccountNo)
        REFERENCES Accounts(AccountNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StoreNo)
        REFERENCES Stores(StoreNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CustomerNo)
        REFERENCES Customers(CustomerNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ItemNo)
        REFERENCES Items(ItemNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (OrderNo)
        REFERENCES Orders(OrderNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);
