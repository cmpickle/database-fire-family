-- Database Creation Script 
-- This creates the Fire Family database
-- Uses MySQL database

DROP DATABASE IF EXISTS Fire_Family;

CREATE DATABASE Fire_Family;

-- With the Fire_Family database now created, switch to it and begin creating the individual 
-- tables for the database

USE Fire_Family;

CREATE TABLE User
(
    UserID          SMALLINT        NOT NULL  AUTO_INCREMENT, 
    Firstname       VARCHAR(20)     NOT NULL, 
    Lastname        VARCHAR(20)     NOT NULL, 
    Email           VARCHAR(200)    NOT NULL, 
    Username        VARCHAR(30)     NOT NULL,
    Password        VARCHAR(30)     NOT NULL,
    Salt            VARCHAR(30)     NOT NULL,
    PRIMARY KEY(UserID)
);

CREATE TABLE Session
(
    SessionID   SMALLINT    NOT NULL AUTO_INCREMENT,
    UserID      SMALLINT    NOT NULL,
    TimeStamp   DATETIME    NOT NULL,
    State       VARCHAR(6)  NOT NULL,
    PRIMARY KEY(SessionID)
);

CREATE TABLE InventoryScanning
(
    InventoryScanningID SMALLINT    NOT NULL  AUTO_INCREMENT,
    InventoryID         SMALLINT    NOT NULL,
    UserID              SMALLINT    NOT NULL,
    ChangeQuantity      SMALLINT    NOT NULL,
    TimeStamp           DATETIME    NOT NULL,
    PRIMARY KEY(InventoryScanningID)
);

CREATE TABLE Product
(
    ProductID               SMALLINT        NOT NULL  AUTO_INCREMENT,
    ProductName             SMALLINT        NOT NULL,
    InventoryID             SMALLINT        NOT NULL,
    NotificationQuantity    SMALLINT        NOT NULL,
    Color                   VARCHAR(20)     NULL,
    TrimColor               VARCHAR(20)     NULL,
    Size                    VARCHAR(15)     NULL,
    Price                   DECIMAL(10,2)   NOT NULL,
    Dimensions              VARCHAR(200)    NULL,
    SKU                     SMALLINT        NOT NULL,
    Deleted                 tinyint(1)      NOT NULL,
    PRIMARY KEY(ProductID)
);

CREATE TABLE Inventory
(
    InventoryID             SMALLINT    NOT NULL  AUTO_INCREMENT,
    Quantity                SMALLINT    NOT NULL,
    DateLastUpdated         DATETIME    NOT NULL,
    ProductID               SMALLINT    NOT NULL,
    PRIMARY KEY(InventoryID)
);
    
-- Alter tables to set up foreign keys 
ALTER TABLE Session
  ADD CONSTRAINT fk_session_userid
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
    
ALTER TABLE InventoryScanning
    ADD CONSTRAINT fk_inventoryscanning_userid
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE InventoryScanning
    ADD CONSTRAINT fk_inventoryscanning_inventoryid
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Inventory
  ADD CONSTRAINT fk_inventory_productid
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
    
ALTER TABLE Product
  ADD CONSTRAINT fk_product_inventoryid
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Add Unique Constraints
ALTER TABLE Product
  ADD CONSTRAINT unique_key_product_sku
  UNIQUE (SKU);

-- Add defaults
ALTER TABLE InventoryScanning
  ALTER ChangeQuantity SET DEFAULT -1;
    
ALTER TABLE Product
  ALTER NotificationQuantity SET DEFAULT 10;