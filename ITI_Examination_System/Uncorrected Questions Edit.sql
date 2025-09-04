CREATE OR ALTER PROCEDURE Debug_Get_UncorrectedQuestions_SP
    @ExamID INT
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Step 1️⃣: Show Student_Exam_Questions for this ExamID';
    SELECT TOP 20 *
    FROM Student_Exam_Questions
    WHERE ExamID = @ExamID;

    PRINT 'Step 2️⃣: Show related Question_Pool records (no DISTINCT to avoid TEXT issue)';
    SELECT QP.QuestionID, QP.QuestionType, QP.QuestionDegree, QP.Questions
    FROM Student_Exam_Questions SEQ
    INNER JOIN Question_Pool QP ON SEQ.QuestionID = QP.QuestionID
    WHERE SEQ.ExamID = @ExamID;

    PRINT 'Step 3️⃣: Show related Student_Answer records (may fail if ExamID not stored)';
    SELECT TOP 20 SA.*
    FROM Student_Answer SA
    WHERE SA.ExamID = @ExamID;

    PRINT 'Step 4️⃣: Final join result (uncorrected questions only)';
    SELECT 
        SEQ.StudentID,
        SEQ.QuestionID,
        QP.QuestionType,
        CONVERT(NVARCHAR(MAX), SA.StudentAnswer) AS StudentAnswer
    FROM Student_Exam_Questions SEQ
    INNER JOIN Question_Pool QP 
        ON SEQ.QuestionID = QP.QuestionID
    LEFT JOIN Student_Answer SA
        ON SEQ.StudentID = SA.StudentID 
       AND SEQ.ExamID = SA.ExamID
       AND SEQ.QuestionID = SA.QuestionID
    WHERE SEQ.ExamID = @ExamID
      AND SEQ.StudentDegree IS NULL;
END;
GO
