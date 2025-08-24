USE MahilaBachatDB;

-- Stored Procedure: Get total savings of a member by ID
DELIMITER //
CREATE PROCEDURE GetMemberSavings(IN member_id INT)
BEGIN
    SELECT m.Name, SUM(s.Amount) AS TotalSavings
    FROM Members m
    JOIN Savings s ON m.MemberID = s.MemberID
    WHERE m.MemberID = member_id
    GROUP BY m.Name;
END //
DELIMITER ;

-- Call the procedure
CALL GetMemberSavings(2);


-- Stored Function: Calculate total loan amount for a member
DELIMITER //
CREATE FUNCTION TotalLoanAmount(member_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(LoanAmount) INTO total
    FROM Loans
    WHERE MemberID = member_id;
    RETURN IFNULL(total, 0.00);
END //
DELIMITER ;

-- Use the function
SELECT Name, TotalLoanAmount(MemberID) AS TotalLoan
FROM Members;
