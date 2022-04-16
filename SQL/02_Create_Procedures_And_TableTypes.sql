USE [GoTech]
GO

/**Create User-defined Table Type**/

CREATE TYPE [dbo].[QuestionAnswers] AS TABLE 
(
	[QuestionID] int NOT NULL, 
	[Value] nvarchar(max) NULL
)
GO

/**Create Procedures**/
-- ================================


-- =============================================
-- Author:		Reut
-- Create date: 16/04/2022
-- Description:	Get Dynamic Questionnaire
-- =============================================
CREATE PROCEDURE [dbo].[GetQuestionnaire]
	@ID int,
	@LanguageID int = NULL

AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT DISTINCT m.[ID], lmt.[Label] as [TitleLabel], lms.[Label] as [SubtitleLabe],
				    q.[ID], q.[QuestionnaireID], lqq.[Label] as [QuestionLabel], lqp.[Label] as [PlaceholderLabel], 
				    q.[TypeID] as [Type], q.[Required],
				    o.[ID], o.[QuestionID], lo.[Label] as [AnswerLabel], o.[ConditionalQuestionID],
				    a.[ID], a.[QuestionID], a.[Value]
	FROM [dbo].[Questionnaires] m
	LEFT JOIN [dbo].[Questions] q ON q.[QuestionnaireID] = m.[ID]
	LEFT JOIN [dbo].[AnswerOptions] o ON o.[QuestionID] = q.[ID]
	LEFT JOIN [dbo].[Answers] a ON a.[QuestionID] = q.[ID]
	--Questionnaire TitleLabel
	LEFT JOIN [dbo].[LabelKeys] kmt ON kmt.[ID] = m.[TitleLabelKeyID]
	LEFT JOIN [dbo].[Labels] lmt ON lmt.[LabelKeyID] = kmt.[ID] AND lmt.[LanguageID] = @LanguageID
	--Questionnaire SubtitleLabel
	LEFT JOIN [dbo].[LabelKeys] kms ON kms.[ID] = m.[SubtitleLabelKeyID]
	LEFT JOIN [dbo].[Labels] lms ON lms.[LabelKeyID] = kms.[ID] AND lms.[LanguageID] = @LanguageID
	--Question QuestionLabel
	LEFT JOIN [dbo].[LabelKeys] kqq ON kqq.[ID] = q.[QuestionLabelKeyID]
	LEFT JOIN [dbo].[Labels] lqq ON lqq.[LabelKeyID] = kqq.[ID] AND lqq.[LanguageID] = @LanguageID
	--Question PlaceholderLabel
	LEFT JOIN [dbo].[LabelKeys] kqp ON kqp.[ID] = q.[PlaceholderLabelKeyID]
	LEFT JOIN [dbo].[Labels] lqp ON lqp.[LabelKeyID] = kqp.[ID] AND lqp.[LanguageID] = @LanguageID
	--AnswerOption AnswerLabel
	LEFT JOIN [dbo].[LabelKeys] ko ON ko.[ID] = o.[AnswerLabelKeyID]
	LEFT JOIN [dbo].[Labels] lo ON lo.[LabelKeyID] = ko.[ID] AND lo.[LanguageID] = @LanguageID
	WHERE m.ID = @ID

END
GO


-- =============================================
-- Author:		Reut
-- Create date: 16/04/2022
-- Description:	Save or update Dynamic Questionnaire answers
-- =============================================
CREATE PROCEDURE [dbo].[SaveORUpdateQuestionnaireAnswers]
	@ID int,
	@LanguageID int = NULL,
	@Answers [dbo].[QuestionAnswers] readonly

AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT * INTO #Answers FROM @Answers


	IF EXISTS(SELECT TOP 1 1 FROM [dbo].[Questionnaires] WHERE ID = @ID)
		AND EXISTS(SELECT TOP 1 1 FROM #Answers)
	BEGIN

		DELETE a
		FROM [dbo].[Answers] a
		INNER JOIN [dbo].[Questions] q ON q.[ID] = a.[QuestionID]
		INNER JOIN [dbo].[Questionnaires] m ON m.[ID] = q.[QuestionnaireID]
		WHERE m.[ID] = @ID


		INSERT INTO [dbo].[Answers]
			   ([QuestionID]
			   ,[Value])
		SELECT a.[QuestionID]
			  ,a.[Value]
		FROM #Answers a
		INNER JOIN [dbo].[Questions] q ON a.[QuestionID] = q.[ID]
		INNER JOIN [dbo].[Questionnaires] m ON m.[ID] = q.[QuestionnaireID]
		WHERE m.[ID] = @ID


	END

	DROP TABLE #Answers

	EXEC [dbo].[GetQuestionnaire] @ID = @ID, @LanguageID = @LanguageID

END
GO