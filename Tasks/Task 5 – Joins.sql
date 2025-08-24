USE MahilaBachatDB;

-- 1. INNER JOIN: Members and their Groups
SELECT m.MemberID, m.Name, g.GroupName
FROM Members m
INNER JOIN MahilaGroups g ON m.GroupID = g.GroupID;

-- 2. LEFT JOIN: All members, even if they don’t have savings
SELECT m.MemberID, m.Name, s.Amount
FROM Members m
LEFT JOIN Savings s ON m.MemberID = s.MemberID;

-- 3. RIGHT JOIN: All savings, even if member details are missing
SELECT m.Name, s.Amount
FROM Members m
RIGHT JOIN Savings s ON m.MemberID = s.MemberID;

-- 4. FULL OUTER JOIN: All members and all savings (matched or not)
-- Not directly supported in MySQL/SQLite; simulate using UNION
SELECT m.MemberID, m.Name, s.Amount
FROM Members m
LEFT JOIN Savings s ON m.MemberID = s.MemberID
UNION
SELECT m.MemberID, m.Name, s.Amount
FROM Members m
RIGHT JOIN Savings s ON m.MemberID = s.MemberID;

-- 5. Joining Members, Groups, and Staff (3-table join)
SELECT m.Name AS MemberName, g.GroupName, st.Name AS StaffName
FROM Members m
INNER JOIN MahilaGroups g ON m.GroupID = g.GroupID
INNER JOIN Staff st ON g.GroupID = st.AssignedGroupID;

-- 6. CROSS JOIN: Each member with every group (Cartesian Product)
SELECT m.Name AS MemberName, g.GroupName
FROM Members m
CROSS JOIN MahilaGroups g;

-- 7. SELF JOIN: Members compared by GroupID (find members from same group)
SELECT A.Name AS Member1, B.Name AS Member2, A.GroupID
FROM Members A
JOIN Members B ON A.GroupID = B.GroupID AND A.MemberID < B.MemberID;
