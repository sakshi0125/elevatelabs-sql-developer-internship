USE MahilaBachatDB;

-- 1.Create a view to show members with their group names
CREATE VIEW MemberGroupView AS
SELECT m.MemberID, m.Name AS MemberName, g.GroupName, m.JoinDate
FROM Members m
JOIN MahilaGroups g ON m.GroupID = g.GroupID;

-- 2️. Create a view to display total savings per member
CREATE VIEW MemberSavingsView AS
SELECT m.MemberID, m.Name, SUM(s.Amount) AS TotalSavings
FROM Members m
JOIN Savings s ON m.MemberID = s.MemberID
GROUP BY m.MemberID, m.Name;

-- 3️ Create a view for active loans (Status = 'Active')
CREATE VIEW ActiveLoansView AS
SELECT l.LoanID, m.Name AS MemberName, l.LoanAmount, l.IssueDate, l.Status
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
WHERE l.Status = 'Active';

-- 4️ Update through a view (only possible if view meets conditions)
-- Example: Updating JoinDate via MemberGroupView
UPDATE MemberGroupView
SET JoinDate = '2024-01-01'
WHERE MemberID = 1;

-- 5️ Drop a view if no longer needed
DROP VIEW IF EXISTS ActiveLoansView;
