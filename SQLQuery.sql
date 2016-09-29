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
	bookPublisher varchar(50) NOT NULL/*,
	bookAuthorId int NOT NULL*/
	)
GO --SELECT * FROM BOOK




CREATE TABLE PUBLISHER
	(
	pubName varchar(50) PRIMARY KEY,
	pupAddress varchar(60) NULL,
	pubPhone varchar(11) --This means that I have to FORMAT the result if I want 1(503)123-4567 to display
	)
GO




CREATE TABLE LIBRARY_BRANCH --4 branches, sharpstown & central
	(
	branchId int IDENTITY(1,1) PRIMARY KEY,
	branchName varchar(30) NOT NULL,
	branchAddress varchar(60) NOT NULL
	)
GO




CREATE TABLE BORROWER --at least 8 borrowers, and at least 2 with >5 books loaned
	(
	cstName varchar(60) NOT NULL,
	cstAddress varchar(60) NOT NULL,
	cstCardNo int IDENTITY(1,1) PRIMARY KEY,
	cstPhone varchar(11)
	)
GO


--DROP TABLE BOOK_AUTHORS
CREATE TABLE BOOK_AUTHORS --10 authors, stephen king
	(
	bookId int PRIMARY KEY,
	bookAuthor varchar(50) NOT NULL
	)
GO
--SELECT * FROM BOOK_AUTHORS


--DROP TABLE BOOK_COPIES
CREATE TABLE BOOK_COPIES --10 books in each, and at least 2x copies
	(
	bookId int IDENTITY(1,1) PRIMARY KEY,
	branchId int NULL,
	noOfCopies int NOT NULL
	)
GO --SELECT * FROM BOOK_COPIES



--DROP TABLE BOOKS_LOANS
CREATE TABLE BOOK_LOANS --50 loans, 2 borrowers with >5 loans
	(
	bookId int FOREIGN KEY REFERENCES BOOK(bookid),
	branchId int FOREIGN KEY REFERENCES LIBRARY_BRANCH(branchId),
	cstCardNo int FOREIGN KEY REFERENCES BORROWER(cstCardNo),
	dateOut varchar(20) NOT NULL,
	dueDate varchar(20) NULL
	)
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



INSERT INTO [dbo].[PUBLISHER]
VALUES 
	('pub1','111 south st Jacksonville, FL 12345','1234567890'),
	('pub2','222 north st Portlad, OR 97230','15031234567')
GO

INSERT INTO [dbo].[LIBRARY_BRANCH]
VALUES
	('branch1','1 two road'),
	('branch2','2 three ave'),
	('sharpstown','4 five street'),
	('central','5 six blvd')
GO

INSERT INTO BORROWER
VALUES
	('cst1','111','1234567890'),
	('cst2','222','1234567890'),
	('cst3','333','1234567890'),
	('cst4','444','1234567890'),
	('cst5','555','1234567890'),
	('cst6','666','1234567890'),
	('cst7','777','1234567890'),
	('cst8','888','1234567890')
GO

INSERT INTO BOOK_AUTHORS
VALUES
	(1,'auth1'),
	(2,'auth2'),
	(3,'auth3'),
	(4,'auth4'),
	(5,'auth5'),
	(6,'auth6'),
	(7,'auth7'),
	(8,'auth8'),
	(9,'auth9'),
	(10,'Stephen King'),
	(11,'auth1'),
	(12,'auth2'),
	(13,'auth3'),
	(14,'auth4'),
	(15,'auth5'),
	(16,'auth6'),
	(17,'auth7'),
	(18,'auth8'),
	(19,'auth9'),
	(20,'Stephen King')
GO--SELECT * FROM BOOK_AUTHORS

INSERT INTO BOOK_LOANS
VALUES
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),
	('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null),('09/28/2016',null)
GO

INSERT INTO [dbo].[BOOK] --must be 20 books
VALUES 
	('The Lost Tribe','pub1','1'),
	('Book2','pub1','2'),
	('book3','pub2','3'),
	('book4','pub1','4'),
	('book5','pub2','5'),
	('book6','pub1','6'),
	('book7','pub2','7'),
	('book8','pub1','8'),
	('book9','pub2','9'),
	('book10','pub1','10'),
	('book11','pub2','1'),
	('book12','pub1','2'),
	('book13','pub2','3'),
	('book14','pub1','4'),
	('book15','pub2','5'),
	('book16','pub1','6'),
	('book17','pub2','7'),
	('book18','pub1','8'),
	('book19','pub2','9'),
	('book20','pub1','10')
GO

INSERT INTO BOOK_COPIES
VALUES
	(2),
	(3),
	(4),
	(5),
	(6),
	(7),
	(8),
	(9),
	(10),
	(11)
GO