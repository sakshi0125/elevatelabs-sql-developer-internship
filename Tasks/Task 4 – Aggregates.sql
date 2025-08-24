USE MahilaBachatDB;

-- Total savings contributed by each member
SELECT MemberID, SUM(Amount) AS TotalSavings
FROM Savings
GROUP BY MemberID;

-- Average loan amount per member
SELECT MemberID, AVG(LoanAmount) AS AverageLoan
FROM Loans
GROUP BY MemberID;

-- Total loan amount issued by status (Paid, Unpaid, Pending)
SELECT Status, SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY Status;

-- Count of members in each group
SELECT GroupID, COUNT(*) AS TotalMembers
FROM Members
GROUP BY GroupID;

-- Groups with more than 1 member
SELECT GroupID, COUNT(*) AS MemberCount
FROM Members
GROUP BY GroupID
HAVING COUNT(*) > 1;

-- Average age of members per group
SELECT GroupID, ROUND(AVG(Age), 1) AS AvgAge
FROM Members
WHERE Age IS NOT NULL
GROUP BY GroupID;

-- Count distinct loan statuses
SELECT COUNT(DISTINCT Status) AS StatusTypes FROM Loans;

-- Total savings collected by all members
SELECT SUM(Amount) AS TotalCollected FROM Savings;

-- Highest saving amount per member
SELECT MemberID, MAX(Amount) AS MaxSaving
FROM Savings
GROUP BY MemberID;

-- Count of loans per member having more than 1 loan
SELECT MemberID, COUNT(*) AS LoanCount
FROM Loans
GROUP BY MemberID
HAVING COUNT(*) > 1;
