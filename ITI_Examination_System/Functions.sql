--======================================================================================================
-- function take (intake, branshes) and return tracks in this branch
CREATE FUNCTION dbo.fn_IntakeTracks
(
    @IntakeID INT,
    @BranchID INT
)
RETURNS @Tracks TABLE
(
    TrackID INT,
    TrackName NVARCHAR(100),
    IntakeID INT,
    IntakeName NVARCHAR(100),
    BranchID INT,
    BranchName NVARCHAR(100)
)
AS
BEGIN
    INSERT INTO @Tracks
    SELECT 
        T.TrackID,
        T.TName AS TrackName,
        InT.IntakeID,
        InT.IntakeName,
        B.BranchID,
        B.BranchName
    FROM Track T
    INNER JOIN Branch_Intake_Track BIT
        ON T.TrackID = BIT.TrackID
    INNER JOIN Intake InT
        ON BIT.IntakeID = InT.IntakeID
    INNER JOIN Branch B
        ON BIT.BranchID = B.BranchID
    WHERE InT.IntakeID = @IntakeID
      AND B.BranchID  = @BranchID;

    RETURN;
END;
GO

SELECT * FROM dbo.fn_IntakeTracks(6, 1);
GO
--============================================================================
/* fn_GetStudentPerformance: Returns all exams taken by
a student in a specific course, including their score, max degree, and percentage.*/

CREATE FUNCTION dbo.fn_GetStudentPerformance
(
    @StudentID INT,
    @CourseID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        E.ExamID,
        C.CourseName,
        E.ExamType,
        E.Degree,
        ISNULL(SUM(SEQ.StudentDegree), 0) AS StudentScore,
        CAST((ISNULL(SUM(SEQ.StudentDegree),0) * 100.0 / E.Degree) AS DECIMAL(5,2)) AS Percentage
    FROM Exam E
    INNER JOIN Student_Exam_Questions SEQ 
        ON E.ExamID = SEQ.ExamID AND SEQ.StudentID = @StudentID
    INNER JOIN Course C ON E.CourseID = C.CourseID
    WHERE E.CourseID = @CourseID
    GROUP BY E.ExamID, C.CourseName, E.ExamType, E.Degree
);
GO

SELECT * FROM dbo.fn_GetStudentPerformance(55, 1);
GO
--=====================================================================================
/*fn_IsExamOpen: hecks if an exam is currently active (open) by
comparing the current server time (GETDATE()) with its StartTime and EndTime.*/

CREATE FUNCTION dbo.fn_IsExamOpen (@ExamID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Message NVARCHAR(50);

    IF EXISTS (
        SELECT 1
        FROM Exam
        WHERE ExamID = @ExamID
          AND GETDATE() BETWEEN StartTime AND EndTime
    )
    BEGIN
        SET @Message = 'Exam is currently OPEN';
    END
    ELSE
    BEGIN
        SET @Message = 'Exam is CLOSED';
    END

    RETURN @Message;
END;
GO

SELECT dbo.fn_IsExamOpen(6) AS IsExamOpen;
