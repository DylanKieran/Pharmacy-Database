/* 
Dylan Kieran
C15321906
Lab Group C
*/

-- DROP TABLES --
DROP TABLE Non_Drug_Sale CASCADE CONSTRAINTS PURGE;
DROP TABLE DrugProductSale CASCADE CONSTRAINTS PURGE;
DROP TABLE Prescription CASCADE CONSTRAINTS PURGE;
DROP TABLE Staff CASCADE CONSTRAINTS PURGE;
DROP TABLE StaffRole CASCADE CONSTRAINTS PURGE;
DROP TABLE Doctor CASCADE CONSTRAINTS PURGE;
DROP TABLE Products CASCADE CONSTRAINTS PURGE;
DROP TABLE PackSize CASCADE CONSTRAINTS PURGE;
DROP TABLE Supplier CASCADE CONSTRAINTS PURGE;
DROP TABLE Brand CASCADE CONSTRAINTS PURGE;
DROP TABLE MedicalCard CASCADE CONSTRAINTS PURGE;
DROP TABLE Customer CASCADE CONSTRAINTS PURGE;

-- CREATE TABLES --

--Customer Table
CREATE TABLE Customer
(
	custID               NUMBER(6) NOT NULL ,
	custName             VARCHAR2(20) NULL ,
	custAddress          VARCHAR2(50) NULL ,
	custPhone            NUMBER(10) NULL ,
	custMedicalCard      VARCHAR2(1) NULL ,
	CONSTRAINT Customer_pk PRIMARY KEY (custID)
);

--Medical Card Table
CREATE TABLE MedicalCard
(
	custID               NUMBER(6) NOT NULL ,
	medicalcardNumber    NUMBER(6) NOT NULL ,
	CONSTRAINT MedicalCard_pk PRIMARY KEY (custID),
	CONSTRAINT MedicalCard_Customer_fk FOREIGN KEY (custID) REFERENCES Customer (custID)
);

--Brand Table
CREATE TABLE Brand
(
	brandID              NUMBER(6) NOT NULL ,
	brandName            VARCHAR2(20) NULL ,
	CONSTRAINT Brand_pk PRIMARY KEY (brandID)
);

--Supplier Table
CREATE TABLE Supplier
(
	supplierID           NUMBER(6) NOT NULL ,
	supplierName         VARCHAR2(20) NULL ,
	supplierAddress      VARCHAR2(50) NULL ,
	supplierPhone        NUMBER(10) NULL ,
	CONSTRAINT Supplier_pk PRIMARY KEY (supplierID)
);

--Pack Size Table
CREATE TABLE PackSize
(
	PackSizeID           NUMBER(6) NOT NULL ,
	PackSizeDesc         VARCHAR2(20) NULL ,
	CONSTRAINT  PackSize_pk PRIMARY KEY (PackSizeID)
);

--Products Table
CREATE TABLE Products
(
	productStockCode     NUMBER(6) NOT NULL ,
	productDesc          VARCHAR2(50) NULL ,
	productCost          NUMBER(5,2) NOT NULL ,
	productRetail        NUMBER(5,2) NOT NULL ,
	PackSizeID           NUMBER(6) NOT NULL ,
	brandID              NUMBER(6) NULL ,
	supplierID           NUMBER(6) NULL ,
	productDrugType      NUMBER(1) NOT NULL ,
	CONSTRAINT Products_pk PRIMARY KEY (productStockCode),
	CONSTRAINT Products_Brand_fk FOREIGN KEY (brandID) REFERENCES Brand (brandID),
	CONSTRAINT Products_Supplier_fk FOREIGN KEY (supplierID) REFERENCES Supplier (supplierID),
	CONSTRAINT Products_PackSize_fk FOREIGN KEY (PackSizeID) REFERENCES PackSize (PackSizeID)
);

--Doctor Table
CREATE TABLE Doctor
(
	doctorID             NUMBER(6) NOT NULL ,
	doctorName           VARCHAR2(20) NOT NULL ,
	doctorSurgery        VARCHAR2(20) NOT NULL ,
	doctorSurgeryAddress VARCHAR2(50) NOT NULL ,
	CONSTRAINT  Doctor_pk PRIMARY KEY (doctorID)
);

--Staff Role Table
CREATE TABLE StaffRole
(
	staffRoleID          NUMBER(6) NOT NULL ,
	staffRoleDesc        VARCHAR2(50) NOT NULL ,
	CONSTRAINT StaffRole_pk PRIMARY KEY (staffRoleID)
);

--Staff Table
CREATE TABLE Staff
(
	staffID              NUMBER(6) NOT NULL ,
	staffName            VARCHAR2(20) NULL ,
	staffAddress         VARCHAR2(50) NULL ,
	staffPhone           NUMBER(10) NULL ,
	staffEmail           VARCHAR2(50) DEFAULT  'email@email.com',
	staffPPS             NUMBER(6) NULL ,
	staffRoleID          NUMBER(2) NULL ,
	CONSTRAINT staffEmail_chk CHECK(staffEmail LIKE '%@%'),
	CONSTRAINT Staff_pk PRIMARY KEY (staffID),
	CONSTRAINT Staff_StaffRole_fk FOREIGN KEY (staffRoleID) REFERENCES StaffRole (staffRoleID)
);

--Prescription Table
CREATE TABLE Prescription
(
	prescriptionID       NUMBER(6) NOT NULL ,
	doctorID             NUMBER(6) NOT NULL ,
	custID               NUMBER(6) NOT NULL ,
	prescriptionDetails  VARCHAR2(50) NOT NULL ,
	staffID              NUMBER(6) NOT NULL ,
	CONSTRAINT Prescription_pk PRIMARY KEY (prescriptionID,doctorID,custID),
	CONSTRAINT Prescription_Doctor_fk FOREIGN KEY (doctorID) REFERENCES Doctor (doctorID),
	CONSTRAINT Prescription_Customer_fk FOREIGN KEY (custID) REFERENCES Customer (custID),
	CONSTRAINT Prescription_Staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID)
);

--Drug Sale Table
CREATE TABLE DrugProductSale
(
	drugTransactionID    NUMBER(6) NOT NULL ,
	productStockCode     NUMBER(6) NOT NULL ,
	staffID              NUMBER(6) NOT NULL ,
	drugName             VARCHAR2(20) NOT NULL ,
	drugDosage           VARCHAR2(20) NOT NULL ,
	drugPrescription     VARCHAR2(1) NOT NULL ,
	drugDispensingInst   VARCHAR2(50) NOT NULL ,
	drugUseInst          VARCHAR2(50) NOT NULL ,
	prescriptionID       NUMBER(6) NULL ,
	doctorID             NUMBER(6) NULL ,
	custID               NUMBER(6) NULL ,
	drugDateTime		 TIMESTAMP NOT NULL,
	CONSTRAINT DrugProductSale_pk PRIMARY KEY (drugTransactionID),
	CONSTRAINT DrugProductSale_Products_fk FOREIGN KEY (productStockCode) REFERENCES Products (productStockCode),
	CONSTRAINT DrugProductSale_Pres_fk FOREIGN KEY (prescriptionID, doctorID, custID) REFERENCES Prescription (prescriptionID, doctorID, custID),
	CONSTRAINT DrugProductSale_Staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID)
);

--Non Drug Sales Table
CREATE TABLE Non_Drug_Sale
(
	ndTransactionID       NUMBER(6) NOT NULL ,
	productStockCode     NUMBER(6) NOT NULL ,
	staffID              NUMBER(6) NOT NULL ,
	ndAmountSold         NUMBER(6) NOT NULL ,
	ndDateTime           TIMESTAMP NOT NULL ,
	CONSTRAINT Non_Drug_Sale_pk PRIMARY KEY (ndTransactionID),
	CONSTRAINT Non_Drug_Sale_Products_fk FOREIGN KEY (productStockCode) REFERENCES Products (productStockCode),
	CONSTRAINT Non_Drug_Sale_Staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID)
);

-- INSERTS --

-- Brand
INSERT INTO	brand(BRANDID, BRANDNAME) 
VALUES	(1, 'L''oreal');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(2, 'Colgate');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(3, 'Lynx');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(4, 'Benylin');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(5, 'Panadol');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(6, 'Prinivil');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(7, 'Omeprazole');

INSERT INTO brand(BRANDID, BRANDNAME) 
VALUES	(8, 'Zithromax');

--Supplier
INSERT INTO supplier(SUPPLIERID,SUPPLIERNAME,SUPPLIERADDRESS,SUPPLIERPHONE)
VALUES	(1001 ,'Supplier 1','Supp1 Address','0435678939');

INSERT INTO supplier(SUPPLIERID,SUPPLIERNAME,SUPPLIERADDRESS,SUPPLIERPHONE)
VALUES	(1002 ,'Supplier 2','Supp2 Address','0520329962');

INSERT INTO staffRole(STAFFROLEID,STAFFROLEDESC) 
VALUES	(1, 'Counter Staff');

INSERT INTO staffRole(STAFFROLEID,STAFFROLEDESC) 
VALUES	(2, 'Manager');

INSERT INTO staffRole(STAFFROLEID,STAFFROLEDESC) 
VALUES	(3, 'Dispensing Pharmacist');

--Staff
INSERT INTO staff(STAFFID,STAFFNAME,STAFFADDRESS,STAFFPHONE,STAFFEMAIL,STAFFPPS,STAFFROLEID)
VALUES(101,'M.Fleming','17 Standhouse Lawns','0879223976','mfleming@gmail.com',126436,1);

INSERT INTO staff(STAFFID,STAFFNAME,STAFFADDRESS,STAFFPHONE,STAFFEMAIL,STAFFPPS,STAFFROLEID)
VALUES(102,'George','23 Evergreen Terrace','0823223598','george123@gmail.com',285642,3);

INSERT INTO staff(STAFFID,STAFFNAME,STAFFADDRESS,STAFFPHONE,STAFFEMAIL,STAFFPPS,STAFFROLEID)
VALUES(103,'Kevin','32 Allenview','0824567124','coolkevin@gmail.com',603286,1);

INSERT INTO staff(STAFFID,STAFFNAME,STAFFADDRESS,STAFFPHONE,STAFFEMAIL,STAFFPPS,STAFFROLEID)
VALUES(100,'Richard','123 Hamptons','0865461943','bossman@gmail.com',867369,2);

--Pack Size
INSERT INTO PackSize(PACKSIZEID,PACKSIZEDESC)
VALUES(1,'20 Tablets');

INSERT INTO PackSize(PACKSIZEID,PACKSIZEDESC)
VALUES(2,'50 ml');

INSERT INTO PackSize(PACKSIZEID,PACKSIZEDESC)
VALUES(3,'30 Tablets');

INSERT INTO PackSize(PACKSIZEID,PACKSIZEDESC)
VALUES(4,'1 Pack');

INSERT INTO PackSize(PACKSIZEID,PACKSIZEDESC)
VALUES(5,'Multipack');

--Products
INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1001,'Toothpaste', 2.00, 3.00, 4, 2, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1009,'Mouth Wash', 1.00, 3.50, 4, 2, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1002,'Shampoo', 3.00, 4.00, 5, 1, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1010,'Conditioner', 3.00, 4.00, 5, 1, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1012,'Night Cream', 5.00, 8.00, 5, 1, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1003,'Deodorant', 2.00, 3.50, 5, 3, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1011,'Body Wash', 2.00, 3.50, 5, 3, 1002, 0);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1004,'Cough Bottle', 4.00, 6.00, 2, 4, 1001, 1);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1005,'Paracetemol', 1.50, 3.25, 1, 5, 1001, 1);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1006,'Lisinopril', 5.00, 7.00, 3, 6, 1001, 1);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1007,'Generic Prilosec', 5.00, 9.00, 3, 7, 1001, 1);

INSERT INTO Products(PRODUCTSTOCKCODE,PRODUCTDESC,PRODUCTCOST,PRODUCTRETAIL,PACKSIZEID,BRANDID,SUPPLIERID,PRODUCTDRUGTYPE)
VALUES(1008,'Azithromycin', 9.00, 12.00, 2, 8, 1001, 1);

--Non Drug Sales
INSERT INTO Non_Drug_Sale(NDTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,NDAMOUNTSOLD,NDDATETIME)
VALUES(201,1001,101,1,to_timestamp('01 December 2016 12:00','DD MON YYYY HH:MI'));

INSERT INTO Non_Drug_Sale(NDTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,NDAMOUNTSOLD,NDDATETIME)
VALUES(204,1001,101,1,to_timestamp('01 December 2016 12:00','DD MON YYYY HH:MI'));

INSERT INTO Non_Drug_Sale(NDTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,NDAMOUNTSOLD,NDDATETIME)
VALUES(202,1003,102,1,to_timestamp('01 December 2016 3:38','DD MON YYYY HH:MI'));

INSERT INTO Non_Drug_Sale(NDTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,NDAMOUNTSOLD,NDDATETIME)
VALUES(203,1002,102,2,to_timestamp('02 December 2016 11:46','DD MON YYYY HH:MI'));

--Doctor
INSERT INTO Doctor(DOCTORID,DOCTORNAME,DOCTORSURGERY,DOCTORSURGERYADDRESS)
VALUES(2001,'Dr.Nick','Shankill', '123 Shankill Road');

INSERT INTO Doctor(DOCTORID,DOCTORNAME,DOCTORSURGERY,DOCTORSURGERYADDRESS)
VALUES(2002,'Dr.Hibbert', 'Springfield', '145 Springfield Avenue');

INSERT INTO Doctor(DOCTORID,DOCTORNAME,DOCTORSURGERY,DOCTORSURGERYADDRESS)
VALUES(2003,'Dr.Harris', 'Shelbyville', '145 Shelbyville Avenue');

--Customer
INSERT INTO Customer(CUSTID,CUSTNAME,CUSTADDRESS,CUSTPHONE,CUSTMEDICALCARD)
VALUES(1001,'H.Simpson','742 Evergreen Terrace','0124569335', 'N');

INSERT INTO Customer(CUSTID,CUSTNAME,CUSTADDRESS,CUSTPHONE,CUSTMEDICALCARD)
VALUES(1002,'N.Flanders','743 Evergreen Terrace','0124762333', 'Y');

INSERT INTO Customer(CUSTID,CUSTNAME,CUSTADDRESS,CUSTPHONE,CUSTMEDICALCARD)
VALUES(1003,'Barney Gumble','Moes Tavern','5677851223', 'Y');

INSERT INTO Customer(CUSTID,CUSTNAME,CUSTADDRESS,CUSTPHONE,CUSTMEDICALCARD)
VALUES(1004,'Patty Bouvier','123 Springfield Apt 7','0861456785', 'N');

--Medical Card
INSERT INTO MedicalCard(CUSTID,MEDICALCARDNUMBER)
VALUES(1002, 452997);

INSERT INTO MedicalCard(CUSTID,MEDICALCARDNUMBER)
VALUES(1003, 234786);

--Prescription
INSERT INTO Prescription(PRESCRIPTIONID,DOCTORID,CUSTID,PRESCRIPTIONDETAILS,STAFFID)
VALUES(4001,2001,1001,'Lisinopril',102);

INSERT INTO Prescription(PRESCRIPTIONID,DOCTORID,CUSTID,PRESCRIPTIONDETAILS,STAFFID)
VALUES(4002,2002,1002,'Generic Prilosec',102);

INSERT INTO Prescription(PRESCRIPTIONID,DOCTORID,CUSTID,PRESCRIPTIONDETAILS,STAFFID)
VALUES(4003,2003,1003,'Azithromycin',102);

INSERT INTO Prescription(PRESCRIPTIONID,DOCTORID,CUSTID,PRESCRIPTIONDETAILS,STAFFID)
VALUES(4004,2001,1001,'Generic Prilosec',102);

--Drug Product Sale
INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(101,1006,101,'Azithromycin','50ml per Week','P','No more than 1 sold per person','1 spoon full 5ml twice daily',4003,2003,1003,to_timestamp('01 December 2016 1:13','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(102,1005,103,'Paracetemol','20 tablets','N','Not to be sold in bulk','2 tablets twice per day','','','',to_timestamp('02 December 2016 3:16','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(103,1005,101,'Paracetemol','20 tablets','N','Not to be sold in bulk','2 tablets twice per day','','','',to_timestamp('01 December 2016 2:23','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(104,1004,103,'Cough Bottle','50ml','N','Not to be sold in bulk','5ml spoons 3 times daily','','','',to_timestamp('02 December 2016 3:16','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(105,1006,101,'Lisinopril','30 tablets per week','P','No more than 1 sold per person','2 tablets twice daily',4001,2001,1001,to_timestamp('02 December 2016 6:17','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(106,1007,101,'Generic Prilosec','30 tablets per week','P','No more than 1 sold per person','3 tablets once daily',4004,2001,1001,to_timestamp('02 December 2016 6:17','DD MON YYYY HH:MI'));

INSERT INTO DrugProductSale(DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFID,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGDISPENSINGINST,DRUGUSEINST,PRESCRIPTIONID,DOCTORID,CUSTID,DRUGDATETIME)
VALUES(107,1007,101,'Generic Prilosec','30 tablets per week','P','No more than 1 sold per person','3 tablets once daily',4002,2002,1002,to_timestamp('01 December 2016 11:23','DD MON YYYY HH:MI'));

-- SELECTS --

--Inner Join of Products and Non Drug Sales
--Inner join to view all information for the sale of non-drug products
SELECT ndTransactionID,ProductStockCode, ProductDesc, ProductRetail, ndDateTime
FROM Products
INNER JOIN Non_Drug_Sale USING (ProductStockCode);


--Inner join of Products with Brand, Pack Size and Supplier
--Inner join to view all information provided of a particular product icluding brand name,pack description and supplier
SELECT PRODUCTSTOCKCODE "Product Stock Code",PRODUCTDESC "Product Description",PRODUCTCOST "Product Price",PACKSIZEDESC "Pack Description",BRANDNAME "Brand Name",SUPPLIERNAME "Supplier Name"
FROM Products
INNER JOIN Brand USING (brandID)
INNER JOIN PackSize USING (PackSizeID)
INNER JOIN Supplier USING (SupplierID);

--Outer Join of DrugProductSale and Prescription 
--Outer Join to see all DrugProducts sold that were prescribed and also non prescribed drug sales
SELECT DrugTransactionID"Transaction ID",DRUGNAME"Drug Name",drugPrescription"Prescription",PRESCRIPTIONID"Prescription ID"
FROM DrugProductSale
LEFT OUTER JOIN Prescription USING (prescriptionID);

--Outer Join of Customer and Medical card
--Outer Join of Customer and Medical card to view a customers medical card number for viewing or using puposes
SELECT custName, medicalcardNumber
FROM MedicalCard
RIGHT OUTER JOIN Customer USING (custID);

--Single Row Function PART of Inner join but just for clarity put here
--Single Row Function to add euro symbol to Prices
SELECT ndTransactionID,ProductStockCode, ProductDesc, TO_CHAR(ProductRetail, 'U999.99'), ndDateTime
FROM Products
INNER JOIN Non_Drug_Sale USING (ProductStockCode);


--Single Row Function to display Drug Transactions with formatted date and time
SELECT DRUGTRANSACTIONID,PRODUCTSTOCKCODE,STAFFNAME,DRUGNAME,DRUGDOSAGE,DRUGPRESCRIPTION,DRUGUSEINST,PRESCRIPTIONID,DOCTORNAME,CUSTNAME,TO_CHAR(DrugDateTime, 'DD-MON-YYYY HH24:MI') AS "Date and Time of Sale" 
FROM DrugProductSale
INNER JOIN Staff USING (StaffID)
INNER JOIN Doctor USING (DoctorID)
INNER JOIN Customer USING (CustID);

--Aggregate Function with Group to get the total profit and display products with profit greater than €2
SELECT 	ProductDesc "Product",  TO_CHAR(ProductCost, 'U999.99') "Product Cost",  TO_CHAR(ProductRetail, 'U999.99') "Product Retail Cost", TO_CHAR(SUM(Products.ProductRetail - Products.ProductCost), 'U999.99')"Profit"
FROM Products
GROUP BY Products.ProductDesc, Products.ProductCost, Products.ProductRetail
HAVING SUM(Products.ProductRetail - Products.ProductCost) > 2;

--Aggregate Function with Group to display the number of products a particular brand supplies
SELECT BrandName, COUNT(BrandID)
FROM Products
INNER JOIN Brand USING (BrandID)
GROUP BY BrandName
ORDER BY COUNT(BrandID) DESC;

--Add Column
ALTER TABLE Doctor 
ADD DoctorEmail VARCHAR2(31);

--Add Constraint 
ALTER TABLE Doctor 
ADD CONSTRAINT doctorEmail_chk CHECK(doctorEmail LIKE '%@%');

--Modify Column
ALTER TABLE Doctor 
MODIFY DoctorEmail VARCHAR2(51);

--Drop Constraint
ALTER TABLE Doctor 
DROP CONSTRAINT doctorEmail_chk;

--Drop Column
ALTER TABLE Doctor 
DROP COLUMN DoctorEmail;

--Update Or Delete using SubQuery to change the pricing of a particular brand if it goes up in cost
UPDATE Products
SET ProductRetail = ProductCost * 2
WHERE BrandID IN
    (SELECT BrandID 
     FROM Brand
     WHERE BrandName = 'Lynx');
