USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE [name] = 'libMgmt')
DROP DATABASE libMgmt
GO

CREATE DATABASE libMgmt
GO

USE libMgmt
GO

--DROP TABLE BOOK
CREATE TABLE BOOK --must be 20
	(
	bookId int IDENTITY(1,1) PRIMARY KEY,
	bookTitle varchar(30) NOT NULL,
	publisherName varchar(50) NOT NULL/*,
	bookAuthorId int NOT NULL*/
	)
GO --SELECT * FROM BOOK
INSERT INTO [dbo].[BOOK] --must be 20 books
VALUES 
	('The Lost Tribe','Lightnight'),
	('Book2','Lightnight'),
	('book3','Early Evening'),
	('book4','Lightnight'),
	('book5','Early Evening'),
	('book6','Lightnight'),
	('book7','Early Evening'),
	('book8','Lightnight'),
	('book9','Early Evening'),
	('book10','Lightnight'),
	('book11','Early Evening'),
	('book12','Lightnight'),
	('book13','Early Evening'),
	('book14','Lightnight'),
	('book15','Early Evening'),
	('book16','Lightnight'),
	('book17','Early Evening'),
	('book18','Lightnight'),
	('book19','Early Evening'),
	('book20','Lightnight')
GO--SELECT * FROM BOOK


--DROP TABLE PUBLISHER
CREATE TABLE PUBLISHER
	(
	name varchar(50) PRIMARY KEY,
	[address] varchar(60) NULL,
	phone varchar(11) --This means that I have to FORMAT the result if I want 1(503)123-4567 to display
	)
GO
INSERT INTO [dbo].[PUBLISHER]
VALUES 
	('Lightnight','111 south st Jacksonville, FL 12345','1234567890'),
	('Early Evening','222 north st Portlad, OR 97230','15031234567')
GO --SELECT * FROM PUBLISHER


--DROP TABLE LIBRARY_BRANCH
CREATE TABLE LIBRARY_BRANCH --4 branches, sharpstown & central
	(
	branchId int IDENTITY(1,1) PRIMARY KEY,
	branchName varchar(30) NOT NULL,
	[address] varchar(60) NOT NULL
	)
GO
INSERT INTO [dbo].[LIBRARY_BRANCH]
VALUES
	('sharpstown','4 five street'),
	('central','5 six blvd'),
	('branch3','1 two road'),
	('branch4','2 three ave')
GO--SELECT * FROM LIBRARY_BRANCH


--DROP TABLE BORROWER
CREATE TABLE BORROWER --at least 8 borrowers, and at least 2 with >5 books loaned
	(
	name varchar(60) NOT NULL,
	[address] varchar(60) NOT NULL,
	cardNo int IDENTITY(1,1) PRIMARY KEY,
	phone varchar(11)
	)
GO
INSERT INTO [dbo].[BORROWER]
VALUES
	('cst1','111','1234567890'),
	('cst2','222','1234567890'),
	('cst3','333','1234567890'),
	('cst4','444','1234567890'),
	('cst5','555','1234567890'),
	('cst6','666','1234567890'),
	('cst7','777','1234567890'),
	('cst8','888','1234567890')
GO--SELECT * FROM BORROWER

--DROP TABLE BOOK_AUTHORS
CREATE TABLE BOOK_AUTHORS --10 authors, stephen king
	(
	bookId int PRIMARY KEY,
	bookAuthor varchar(50) NOT NULL
	)
GO--SELECT * FROM BOOK_AUTHORS
INSERT INTO [dbo].[BOOK_AUTHORS]
VALUES
	(1,'auth1'),(2,'auth2'),(3,'auth3'),(4,'auth4'),(5,'auth5'),(6,'auth6'),(7,'auth7'),(8,'auth8'),(9,'auth9'),(10,'Stephen King'),
	(11,'auth1'),(12,'auth2'),(13,'auth3'),(14,'auth4'),(15,'auth5'),(16,'auth6'),(17,'auth7'),(18,'auth8'),(19,'auth9'),(20,'Stephen King')
GO--SELECT * FROM BOOK_AUTHORS


--DROP TABLE BOOK_COPIES
CREATE TABLE BOOK_COPIES --10 books in each, and at least 2x copies
	(
	bookId int NOT NULL,
	branchId int NOT NULL,
	noOfCopies int NOT NULL
	)
GO
INSERT INTO [dbo].[BOOK_COPIES]
VALUES--THIS NEEDS WORK 9/28
	(1,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(3,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(5,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(7,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(9,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(11,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(13,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(15,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(17,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(19,1,2),(1,2,2),(1,3,2),(1,4,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2)
GO--SELECT * FROM BOOK_COPIES


--DROP TABLE BOOKS_LOANS
CREATE TABLE BOOK_LOANS --50 loans, 2 borrowers with >5 loans
	(
	bookId int NOT NULL,
	branchId int NOT NULL,
	cardNo int NOT NULL,
	dateOut varchar(20) NOT NULL,
	dueDate varchar(20) NULL
	)
GO
INSERT INTO [dbo].[BOOK_LOANS]
VALUES
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null)
GO


/*
SELECT * FROM [dbo].[BOOK]
SELECT * FROM [dbo].[BOOK_AUTHORS]
SELECT * FROM [dbo].[BOOK_COPIES]
SELECT * FROM [dbo].[BOOK_LOANS]
SELECT * FROM [dbo].[BORROWER]
SELECT * FROM [dbo].[LIBRARY_BRANCH]
SELECT * FROM [dbo].[PUBLISHER]
*/















/*

*/