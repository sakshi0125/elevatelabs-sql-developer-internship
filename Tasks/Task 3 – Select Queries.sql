use MahilaBachatDB;
-- 1. Get all members
SELECT * FROM Members;

-- 2. Get only names and phone numbers of members
SELECT Name, Phone FROM Members;

-- 3. Filter: Members aged between 25 and 35
SELECT * FROM Members WHERE Age BETWEEN 25 AND 35;

-- 4. Filter: Members from group ID 1 or 2
SELECT * FROM Members WHERE GroupID IN (1, 2);

-- 5. Filter using pattern: Members with name containing 'a'
SELECT * FROM Members WHERE Name LIKE '%a%';

-- 6. Filter using AND: Members from Group 1 and above age 30
SELECT * FROM Members WHERE GroupID = 1 AND Age > 30;

-- 7. Filter using OR: Members aged <25 or joined after 2022
SELECT * FROM Members WHERE Age < 25 OR JoinDate > '2022-01-01';

-- 8. Use DISTINCT: Unique Group IDs
SELECT DISTINCT GroupID FROM Members;

-- 9. ORDER BY Age ascending
SELECT * FROM Members ORDER BY Age ASC;

-- 10. ORDER BY Age descending
SELECT * FROM Members ORDER BY Age DESC;

-- 11. Use alias: Show member name and contact number
SELECT Name AS MemberName, Phone AS Contact FROM Members;

-- 12. LIMIT: Show top 3 members
SELECT * FROM Members LIMIT 3;
