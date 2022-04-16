/**Config language labels**/

INSERT INTO [dbo].[LanguageTypes]
			([ID]
			,[Name])
		VALUES
			(1
			,'English'),
			(2
			,'Hebrew')


GO

-------------------------


INSERT INTO [dbo].[LabelKeys]
           (ID
		   ,[NameKey]
           ,[Description]
           ,[CreationDate]
           ,[UpdateDate])
     VALUES
           (1
		   ,'GoTech_Questionnaire'
           ,'GoTech Questionnaire title'
           ,GETDATE()
           ,GETDATE()),
		   (2
		   ,'GoTech_Questionnaire_Show_Me_What_You_Got'
           ,'GoTech Questionnaire subtitle'
           ,GETDATE()
           ,GETDATE()),
		   (3
		   ,'GoTech_Questionnaire_Favorite_Language'
           ,'GoTech Questionnaire Favorite Language question'
           ,GETDATE()
           ,GETDATE()),
		   (4
		   ,'GoTech_Questionnaire_Favorite_Language_Javascript'
           ,'GoTech Questionnaire Favorite Language option'
           ,GETDATE()
           ,GETDATE()),
		   (5
		   ,'GoTech_Questionnaire_Favorite_Language_TypeScript'
           ,'GoTech Questionnaire Favorite Language option'
           ,GETDATE()
           ,GETDATE()),
		   (6
		   ,'GoTech_Questionnaire_Favorite_Language_CoffeeScript'
           ,'GoTech Questionnaire Favorite Language option'
           ,GETDATE()
           ,GETDATE()),
		   (7
		   ,'GoTech_Questionnaire_Like_In_Programing'
           ,'GoTech Questionnaire free text question'
           ,GETDATE()
           ,GETDATE()),
		   (8
		   ,'GoTech_Questionnaire_Assignment_Difficulty_Level'
           ,'GoTech Questionnaire Assignment Difficulty Level question'
           ,GETDATE()
           ,GETDATE()),
		   (9
		   ,'GoTech_Questionnaire_Assignment_Difficulty_Level_Easy'
           ,'GoTech Questionnaire Assignment Difficulty Level option'
           ,GETDATE()
           ,GETDATE()),
		   (10
		   ,'GoTech_Questionnaire_Assignment_Difficulty_Level_Normal'
           ,'GoTech Questionnaire Assignment Difficulty Level option'
           ,GETDATE()
           ,GETDATE()),
		   (11
		   ,'GoTech_Questionnaire_Assignment_Difficulty_Level_Hard'
           ,'GoTech Questionnaire Assignment Difficulty Level option'
           ,GETDATE()
           ,GETDATE()),
		   (12
		   ,'GoTech_Questionnaire_Assignment_Difficulty_Level_Other'
           ,'GoTech Questionnaire Assignment Difficulty Level option'
           ,GETDATE()
           ,GETDATE()),
		   (13
		   ,'GoTech_Questionnaire_Favorite_Language_Why_Like_TypeScript'
           ,'GoTech Questionnaire Conditional Question for choosing TypeScript'
           ,GETDATE()
           ,GETDATE()),
		   (14
		   ,'GoTech_Questionnaire_Favorite_Language_Placeholder_Other'
           ,'GoTech Questionnaire Favorite Language Placeholder Other'
           ,GETDATE()
           ,GETDATE())
GO

-------------------------


INSERT INTO [dbo].[Labels]
           ([LabelKeyID]
           ,[LanguageID]
           ,[Label])
     VALUES
           (1
           ,1
           ,'GoTech Questionnaire'),
		   (1
           ,2
           ,'שאלון גוטק'),
		   (2
           ,1
           ,'Show Me What You Got!'),
		   (2
           ,2
           ,'תראה לי מה יש לך!'),
		   (3
           ,1
           ,'What language is your favorite?'),
		   (3
           ,2
           ,'איזו טכנולוגיה את/ה אוהב/ת?'),
		   (4
           ,1
           ,'Javascript'),
		   (4
           ,2
           ,'ג&apos;בה סקריפט'),
		   (5
           ,1
           ,'TypeScript'),
		   (5
           ,2
           ,'טייפ סקריפט'),
		   (6
           ,1
           ,'CoffeeScript'),
		   (6
           ,2
           ,'קפה סקריפט'),
		   (7
           ,1
           ,'What do you like about programing?'),
		   (7
           ,2
           ,'מה את/ה אוהב/ת בפיתוח?'),
		   (8
           ,1
           ,'How was the assignment?'),
		   (8
           ,2
           ,'איך היתה המשימה?'),
		   (9
           ,1
           ,'Easy'),
		   (9
           ,2
           ,'קל'),
		   (10
           ,1
           ,'Normal'),
		   (10
           ,2
           ,'בינוני'),
		   (11
           ,1
           ,'Hard'),
		   (11
           ,2
           ,'קשה'),
		   (12
           ,1
           ,'Other'),
		   (12
           ,2
           ,'אחר'),
		   (13
           ,1
           ,'Why do you like TypeScript?'),
		   (13
           ,2
           ,'למה את/ה אוהב/ת טייפ סקריפט?'),
		   (14
           ,1
           ,'Your answer'),
		   (14
           ,2
           ,'הזינו תשובה')
GO


/**Config Questionnaire**/



INSERT INTO [dbo].[QuestionTypes]
           ([ID]
           ,[Name]
           ,[Description])
     VALUES
           (1
           ,'Radio'
           ,'html input type radio element'),
		   (2
           ,'Text'
           ,'html input type text element'),
		   (3
           ,'checkbox'
           ,'html input type checkbox element')

GO

-------------------------

DECLARE @QuestionnaireID int

INSERT INTO [dbo].[Questionnaires]
           ([Name]
           ,[Description]
           ,[TitleLabelKeyID]
           ,[SubtitleLabelKeyID]
           ,[CreationDate]
           ,[UpdateDate])
     VALUES
           ('GoTech Questionnaire'
           ,'Development GoTech Questionnaire'
           ,1
           ,2
           ,GETDATE()
           ,GETDATE())


SELECT @QuestionnaireID = SCOPE_IDENTITY()



INSERT INTO [dbo].[Questions]
           ([ID]
		   ,[QuestionnaireID]
           ,[Name]
           ,[Description]
           ,[QuestionLabelKeyID]
           ,[TypeID]
           ,[Required]
		   ,[PlaceholderLabelKeyID])
     VALUES
           (1
		   ,@QuestionnaireID
           ,'Favorite Language'
           ,'To see if the developer likes our languages'
           ,3
           ,1
           ,1
		   ,NULL),
		   (2
		   ,@QuestionnaireID
           ,'Like In Programing'
           ,'To see what the developer like in programing'
           ,7
           ,2
           ,0
		   ,NULL),
		   (3
		   ,@QuestionnaireID
           ,'Assignment Difficulty Level'
           ,'To see if the assignment wasd difficult for the developer'
           ,8
           ,1
           ,1
		   ,NULL),
		   (4
		   ,@QuestionnaireID
           ,'Conditional Question Why like TypeScript'
           ,'Extra free text'
           ,13
           ,2
           ,1
		   ,NULL),
		   (5
		   ,@QuestionnaireID
           ,'Conditional Question Other free text'
           ,'Extra free text'
           ,NULL
           ,2
           ,1
		   ,14)
GO


-------------------------

INSERT INTO [dbo].[AnswerOptions]
           ([QuestionID]
           ,[Name]
           ,[Description]
           ,[AnswerLabelKeyID]
           ,[ConditionalQuestionID])
     VALUES
           (1
           ,'Javascript'
           ,NULL
           ,4
           ,NULL),
		   (1
           ,'TypeScript'
           ,NULL
           ,5
           ,4),
		   (1
           ,'CoffeeScript'
           ,NULL
           ,6
           ,NULL),
		   (3
           ,'Easy'
           ,NULL
           ,9
           ,NULL),
		   (3
           ,'Normal'
           ,NULL
           ,10
           ,NULL),
		   (3
           ,'Hard'
           ,NULL
           ,11
           ,NULL),
		   (3
           ,'Other'
           ,'Free Text'
           ,12
           ,5)
GO




