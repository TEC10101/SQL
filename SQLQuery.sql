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
	bookId int IDENTITY(1,1) NOT NULL,
	bookTitle varchar(30) PRIMARY KEY,
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
	branchId int IDENTITY(1,1) NOT NULL,
	branchName varchar(30) PRIMARY KEY,
	[address] varchar(60) NOT NULL
	)
GO
INSERT INTO [dbo].[LIBRARY_BRANCH]
VALUES
	('sharpstown','4 five street'),
	('central','5 six blvd'),
	('opal','1 two road'),
	('hamburg','2 three ave')
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
	('John','111 2nd ave','1234567890'),
	('Mary','222 3rd st','1234567890'),
	('Jane','333 4th rd','1234567890'),
	('Matt','444 5rd trail (in BFE, that''s why it''s 5rd)','1234567890'),
	('Samm','555 6th ct','1234567890'),
	('Tomm','666 7th blvd','1234567890'),
	('Carl','777 8th way','1234567890'),
	('Pete','888 9th pl','1234567890')
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
VALUES
	(1,1,2),(1,2,4),(1,3,6),(1,4,8),(2,1,2),(2,2,2),(2,3,2),(2,4,2),
	(3,1,2),(3,2,2),(3,3,2),(3,4,2),(4,1,2),(4,2,2),(4,3,2),(4,4,2),
	(5,1,2),(5,2,2),(5,3,2),(5,4,2),(6,1,2),(6,2,2),(6,3,2),(6,4,2),
	(7,1,2),(7,2,2),(7,3,2),(7,4,2),(8,1,2),(8,2,2),(8,3,2),(8,4,2),
	(9,1,2),(9,2,2),(9,3,2),(9,4,2),(10,1,2),(10,2,2),(10,3,2),(10,4,2),
	(11,1,2),(11,2,2),(11,3,2),(11,4,2),(12,1,2),(12,2,2),(12,3,2),(12,4,2),
	(13,1,2),(13,2,2),(13,3,2),(13,4,2),(14,1,2),(14,2,2),(14,3,2),(14,4,2),
	(15,1,2),(15,2,2),(15,3,2),(15,4,2),(16,1,2),(16,2,2),(16,3,2),(16,4,2),
	(17,1,2),(17,2,2),(17,3,2),(17,4,2),(18,1,2),(18,2,2),(18,3,2),(18,4,2),
	(19,1,2),(19,2,2),(19,3,2),(19,4,2),(20,1,2),(20,2,2),(20,3,2),(20,4,2)
GO--SELECT * FROM BOOK_COPIES

use libMgmt
--DROP TABLE BOOKS_LOANS
CREATE TABLE BOOK_LOANS --50 loans, 2 borrowers with >5 loans
	(
	cardNo int NULL,
	branchId int NULL,
	bookId int NULL,
	dateOut varchar(20) NULL,
	dueDate varchar(20) NULL
	)
GO
INSERT INTO [dbo].[BOOK_LOANS]
VALUES
	(1,1,1,'09/22/2016','09/29/2016'),(1,1,2,'09/23/2016','09/30/2016'),(1,1,3,'09/28/2016',null),(1,1,4,'09/28/2016',null),(1,1,5,'09/28/2016',null),(1,1,6,'09/28/2016',null),
	(2,2,1,'09/28/2016',null),(2,2,2,'09/28/2016',null),(2,2,3,'09/28/2016',null),(2,2,4,'09/28/2016',null),(2,2,5,'09/28/2016',null),(2,2,6,'09/28/2016',null)
GO --SELECT * FROM BOOK_LOANS
--DELETE BOOK_LOANS


/*
SELECT * FROM [dbo].[BOOK]
SELECT * FROM [dbo].[BOOK_AUTHORS]
SELECT * FROM [dbo].[BOOK_COPIES]
SELECT * FROM [dbo].[BOOK_LOANS]
SELECT * FROM [dbo].[BORROWER]
SELECT * FROM [dbo].[LIBRARY_BRANCH]
SELECT * FROM [dbo].[PUBLISHER]
*/

--1, how many copies the lost tribe branch sharpstown
SELECT *
FROM LIBRARY_BRANCH
INNER JOIN BOOK_COPIES
ON LIBRARY_BRANCH.branchId = BOOK_COPIES.branchId
INNER JOIN BOOK
ON BOOK.bookId = BOOK_COPIES.bookId
WHERE LIBRARY_BRANCH.branchName = 'sharpstown'
AND BOOK.bookTitle = 'The Lost Tribe'


--2, copies book lost tribe owned by each lib branch?
SELECT l_b.branchId, l_b.branchName, b_c.bookId, b_c.noOfCopies, b.bookTitle, b.publisherName
FROM LIBRARY_BRANCH as l_b
INNER JOIN BOOK_COPIES as b_c
ON l_b.branchId = b_c.branchId
INNER JOIN BOOK as b
ON b_c.bookId = b.bookId
WHERE bookTitle = 'The Lost Tribe'


--3, who has no books checked out, their name?
SELECT *
FROM BORROWER as bor
LEFT OUTER JOIN BOOK_LOANS as b_l
ON bor.cardNo = b_l.cardNo
WHERE b_l.cardNo IS NULL


--4, for each book loaned from sharpstown branch, and due date today: book title, borrower name, borrow address
SELECT b_l.dueDate, b.bookTitle, bor.name, bor.[address]
FROM LIBRARY_BRANCH as l_b

INNER JOIN BOOK_LOANS as b_l
ON l_b.branchId = b_l.branchId

INNER JOIN BORROWER as bor
ON b_l.cardNo = bor.cardNo

INNER JOIN BOOK as b
ON b_l.bookId = b.bookId

WHERE l_b.branchName = 'sharpstown'
AND b_l.dueDate = '09/29/2016'


--5, for each branch: branch name and total number of books loaned from that branch
SELECT l_b.branchName, /*b_l.dueDate,*/
	COUNT (l_b.branchName) AS totalLoans
FROM [dbo].[BOOK_LOANS] as b_l

RIGHT OUTER JOIN [dbo].[LIBRARY_BRANCH] as l_b
ON b_l.branchId = l_b.branchId
WHERE b_l.dateOut IS NOT NULL
GROUP BY l_b.branchName


/*
SELECT * FROM [dbo].[BOOK]
SELECT * FROM [dbo].[BOOK_AUTHORS]
SELECT * FROM [dbo].[BOOK_COPIES]
SELECT * FROM [dbo].[BOOK_LOANS]
SELECT * FROM [dbo].[BORROWER]
SELECT * FROM [dbo].[LIBRARY_BRANCH]
SELECT * FROM [dbo].[PUBLISHER]
*/


--6, get name addy and # of books checked out for all borrowers who have >5 books
SELECT COUNT (b_l.dateOut), BORROWER.[name], BORROWER.[address]
	/*COUNT (b_l.bookId) as totalLoans*/
FROM BORROWER
INNER JOIN BOOK_LOANS as b_l
ON BORROWER.cardNo = b_l.cardNo
/*WHERE b_l.dateOut IS NOT NULL*/
GROUP BY BORROWER.name, BORROWER.[address]
HAVING COUNT(b_l.dateOut) > 5


--7, for each book authored by stephen king, get the title and number of copies owned by the library whos name is central
SELECT b_a.bookId, b_a.bookAuthor, b_c.noOfCopies, l_b.branchName, l_b.branchId
FROM [dbo].[BOOK_AUTHORS] as b_a
INNER JOIN BOOK_COPIES as b_c
ON b_a.bookId = b_c.bookId

INNER JOIN [dbo].[LIBRARY_BRANCH] as l_b
ON b_c.branchId = l_b.branchId

INNER JOIN BOOK
ON book.bookId = b_a.bookId
WHERE l_b.branchName = 'central'
AND b_a.bookAuthor = 'Stephen King'


--8 create stored procedure
CREATE PROC uspGetDueTodaySharpstown AS
SELECT b_l.dueDate, b.bookTitle, bor.name, bor.[address]
FROM LIBRARY_BRANCH as l_b

INNER JOIN BOOK_LOANS as b_l
ON l_b.branchId = b_l.branchId

INNER JOIN BORROWER as bor
ON b_l.cardNo = bor.cardNo

INNER JOIN BOOK as b
ON b_l.bookId = b.bookId

WHERE l_b.branchName = 'sharpstown'
AND b_l.dueDate = '09/29/2016'

--stored proc:
EXEC uspGetDueTodaySharpstown