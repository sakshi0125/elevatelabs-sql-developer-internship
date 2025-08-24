USE MahilaBachatDB;

-- 1. Scalar Subquery: Show members whose age is equal to the average age of all members
SELECT Name, Age
FROM Members
WHERE Age = (SELECT ROUND(AVG(Age)) FROM Members);

-- 2. IN Subquery: Show members who have taken loans
SELECT Name
FROM Members
WHERE MemberID IN (SELECT MemberID FROM Loans);

-- 3. EXISTS Subquery: Show members who have savings
SELECT Name
FROM Members m
WHERE EXISTS (
    SELECT 1
    FROM Savings s
    WHERE s.MemberID = m.MemberID
);

-- 4. Correlated Subquery: Show members who have savings greater than the average savings of that group
SELECT m.Name, s.Amount
FROM Members m
JOIN Savings s ON m.MemberID = s.MemberID
WHERE s.Amount > (
    SELECT AVG(s2.Amount)
    FROM Savings s2
    JOIN Members m2 ON s2.MemberID = m2.MemberID
    WHERE m2.GroupID = m.GroupID
);

-- 5.Subquery in FROM clause (Derived Table): Average loan by group
SELECT g.GroupName, AVG_Loan
FROM MahilaGroups g
JOIN (
    SELECT m.GroupID, AVG(l.LoanAmount) AS AVG_Loan
    FROM Members m
    JOIN Loans l ON m.MemberID = l.MemberID
    GROUP BY m.GroupID
) AS LoanData ON g.GroupID = LoanData.GroupID;
