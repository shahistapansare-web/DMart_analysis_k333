-- LAB 1 
-- -----------------------------------------------

create database BankingDB;

use BankingDB;

create table customers (
CustomerID int primary key, 
Firstname Varchar  (50),
Lastname varchar (50),
Email varchar (100),
Phone varchar (15), 
AccountCreations date 
);

describe Customers;

-- --------------------------------------------------
-- LAB 2 
-- ---------------------------------------------------

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- added dateofbirth column to customers table
ALTER TABLE Customers ADD COLUMN  DateOfBirth DATE;
describe customers;

-- modify existing column 
alter table Customers modify phone varchar (20);

--  Constraints can also be added using ALTER to enforce business rules.
-- Adding a minimum balance rule to the Accounts table.
alter table Accounts add constraint chk_MinBalance
check (Balance >= 1000);

show create table accounts;

-- use  drop for deleting the table AccountBranches 
drop table AccountBranches;

-- Apply constraint for banking data

-- Apply pk to customers id

-- add customerID column in accounts table 
alter table Accounts add customerID int;

-- Connect Customers and Accounts table using FK
alter table Accounts 
add constraint fk_Accounts_Customers
foreign key(CustomerID)
references Customers(CustomerID);

-- apply not null to firstname ccolumn in Customers table 
alter table Customers modify FirstName varchar(50) Not Null;

-- apply unique constraint to get unique customer email
alter table Customers
 add constraint uq_Email unique (Email);
 
 -- Activity 
 
-- Accounts → Connect with Branches
-- Add a foreign key on BranchID that references Branches(BranchID).
alter table Branches add primary key(BranchID);
alter table Accounts add BranchID int;
ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

-- Transactions → Connect with Accounts
-- Add a foreign key on AccountID that references Accounts(AccountID).
alter table Accounts add primary key(AccountID);
alter table Transactions add AccountID int;
ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

-- Loans → Connect with Customers
--  a foreign key on CustomerID that references Customers(CustomerID).
-- Add a foreign key on AccountID that references Accounts(AccountID).
alter table Loans add CustomerID int;
ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- --------------------------------------------------------------------------------------
-- LAB 5 

-- TASK 1

select * from Customers where Firstname like "A%";

select * from Customers where Email like "%gmail%";

select * from Customers where Lastname like "%kar";

-- Activity

select * from Customers where FirstName like "R%";

select * from Customers where Email like "%yahoo%";

select * from Customers where LastName like "P%";

select * from Customers where Phone like "%99";

-- Task 2

select * from Accounts where AccountType in ("Savings","Current");

select * from Transactions where TransactionType in ("Deposit","Withdraw");

select * from customers where CustomerID IN (101,102,105);

-- Activity 

SELECT * from accounts where accounttype in ("savings","salary");

select * from transactions where transactiontype in ("payment","deposit");

select * from customers where customerid in (103,104);

select * from accounts where accountid in (103);


-- Task 2

select * from customers order by Lastname asc;

select * from customers order by Lastname desc;

SELECT * FROM Transactions ORDER BY TransactionDate DESC;

-- Activity

select * from customers order by FirstName asc;

select * from accounts order by accounttype asc;

select * from transactions order by amount desc;

select * from customers order by dateofbirth asc;


-- Task 4

select * from Accounts order by Balance desc limit 5;

select * from customers limit 3;

select * from transactions limit 5 offset 3;

-- Activity

select * from transactions order by amount desc limit 3;

select * from customers limit 4;

select * from accounts limit 3 offset 2;

select * from transactions order by transactiondate desc limit 5;


-- Task 5

select * from accounts where accounttype = "savings"
order by balance desc;

select * from customers where FirstName like "S%"
limit 5;

SELECT *
FROM Transactions
WHERE TransactionType IN ('Deposit','Withdraw')
ORDER BY TransactionDate DESC;

-- ------------------------------------------------------------------------------------
-- LAB 6 
 
 -- Task 1
 
 select * from customers;
 
 select FirstName, upper (firstname) as uppercasename
 from customers;
 
 select FirstName, lower (firstname) as lowercasename
 from customers;
 
 select FirstName, length (firstname) as namelength
 from customers;
 
 select FirstName, left (firstname,3) as initials
 from customers;
 
 select FirstName, concat(firstname,"_",lastname) as fullname
 from customers;
 
 select round(123456.75) as rounded_value;
 
 select ceil(1256.25) as ceiling_value;
 
 select FLOOR(1256.75) AS floor_Value;
 
 select ABS(-2500) AS Absolute_Value;
 
 select MOD(25,4) AS Remainder;
 
 select * from customers;
 
 SELECT CURDATE(); 
 
 SELECT NOW();
 
 SELECT CustomerID,
YEAR(DateOfBirth) AS BirthYear
FROM customers;

SELECT CustomerID,
MONTH(DateOfBirth) AS BirthMonth
FROM customers;

SELECT CustomerID,
DATEDIFF(CURDATE(),DateOfBirth) AS Days
FROM customers;


SELECT FirstName,
    DateOfBirth,
    IF(YEAR(DateOfBirth) <= 1995,
       'Adult',
       'Young') AS Category
FROM Customers;

SELECT FirstName,
    IFNULL(Phone, 'Not Available') AS PhoneNumber
FROM Customers;

SELECT GREATEST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS LatestBirthDate;

SELECT LEAST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS EarliestBirthDate;

SELECT FirstName,
NULLIF(FirstName,'Priya') AS Result
FROM Customers;

select sum(balance) as total_balance from accounts;

select avg(balance) as average_balance from accounts;

SELECT MAX(Balance) AS highest_balance
FROM Accounts;

SELECT MIN(Balance) AS lowest_balance
FROM Accounts;

SELECT COUNT(*) AS total_accounts
FROM Accounts;

-- Task 3

SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType

-- Task 4

SELECT  AccountType,
SUM(balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(balance) > 25000;

-- --------------------------------------------------------------------------------------------------
-- LAB 7 
-- TASK 2
SELECT * FROM loans;

select loanid,customerid,loanamount,
rank() over (order by loanamount desc) as ' loan_rank'
from loans;

-- Task 3
select loanid,customerid,loanamount,
dense_rank() over (order by loanamount desc)as 'loan_denserank'
from loans;

-- Task 4 
select loanid , customerid, loanamount,
row_number() over(ORDER BY LoanAmount DESC) AS RowNumber
FROM Loans;

-- Task 5
Select LoanID,CustomerID,LoanAmount,
    Row_number() Over(partition by CustomerID
	Order By LoanAmount Desc) As RowNum
From Loans; 

-- Task 6 
select loanid ,customerid,loanamount,
sum(loanamount) over (order by loanamount desc) as runningtotal
 from loans;
 
 -- Task 7 
 
 -- LAG FINCTION - retrive the values from the previous row in the result set. 
 -- use to compare current record with the immediately preceding record. 

 select loanid ,customerid,loanamount,
 lag(loanamount) over (order by loanamount desc) as previousloanamount
 from loans;

-- Task 8 
-- LEAD() function -  retrieves the value from the next row in the result set.
-- It allows users to compare the current row with the following row without writing complex self-joins.

select loanid ,customerid,loanamount,
lead(loanamount) over (order by loanamount desc ) as nextloanamount
from loans;
 
-- --------------------------------------------------------------------------------------------------
-- LAB - 8 
-- Task 1 
select  a.accountid,a.accounttype,a.balance,
t.transactionid,t.transactiondate,t.transactiontype,t.amount
from accounts a
inner join transactions t
on a.accountid = t.accountid;

-- Task 2
select  a.accountid,a.accounttype,a.balance,
t.transactionid,t.transactiondate,t.transactiontype,t.amount
from accounts a
left join transactions t
on a.accountid = t.accountid;

-- Task 3
select  a.accountid,a.accounttype,a.balance,
t.transactionid,t.transactiondate,t.transactiontype,t.amount
from accounts a
inner join transactions t
on a.accountid = t.accountid
where t.transactiontype = 'deposit';

-- Task 4
select a.accountid,a.accounttype,a.balance,
t.transactionid,
t.transactiondate,
t.transactiontype,
t.amount
from accounts a 
inner join transactions t
on a.accountid = t.accountid
where a.balance >30000
order by a.balance desc;

-- ----------------------------------------------------------------------------------------------------
-- LAB 9 
-- TASK 1
select * from transactions 
where amount >
(
select avg(amount)
from transactions
);

-- Task 2
select accountid,
accounttype,
balance,
customerid
from accounts 
where balance >
(
select avg(balance) 
from accounts
)
order by balance desc;

-- Task 3
select accountid,
accounttype,
balance,
customerid
from accounts
where accountid in
(
select accountid
from transactions
where transactiontype = 'deposit'
);

-- Task 4
select accountid,
accounttype,
balance,
customerid
from accounts
where balance =
(
select max(balance)
from accounts
);

-- ------------------------------------------------------------------------------------------------------
-- LAB 10
-- TASK 1
create view high_balance_accounts as
select a.accountid, accounttype, balance, customerid
from accounts 
where balance > 30000;

-- Task 2
select * from high_balance_accounts;

-- Task 3
create or replace view high_balance_accounts as
select a.accountid,a.accounttype,a.balance,a.customerid,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from accounts a
inner join transactions t on a.accountid = t.accountid
where a.balance > 30000;

-- Task 4
select
 accountid,
 accounttype,
 balance,
 customerid,
 transactionid,
 transactiondate,
 transactiontype,
 amount
 from high_balance_accounts
 order by balance desc;
 
 







