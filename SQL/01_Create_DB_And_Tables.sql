/**Create Database**/

IF DB_ID('GoTech') IS NULL
BEGIN
	CREATE DATABASE [GoTech]
END


/**Create tables**/

USE [GoTech]
GO

-------------------------

CREATE TABLE [dbo].[LanguageTypes](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	CONSTRAINT [PK_LanguageTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

-------------------------


CREATE TABLE [dbo].[LabelKeys](
	[ID] [int] NOT NULL,
	[NameKey] [varchar](200) NOT NULL,
	[Description] [varchar](250) NULL,
	[CreationDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LabelKeys] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO


CREATE UNIQUE NONCLUSTERED INDEX [IX_LabelKeys] ON [dbo].[LabelKeys]
(
	[NameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LabelKeys] ADD  CONSTRAINT [DF_LabelKeys_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO

ALTER TABLE [dbo].[LabelKeys] ADD  CONSTRAINT [DF_LabelKeys_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

-------------------------


CREATE TABLE [dbo].[Labels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LabelKeyID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Labels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Labels]  WITH CHECK ADD  CONSTRAINT [FK_Labels_LabelKeys] FOREIGN KEY([LabelKeyID])
REFERENCES [dbo].[LabelKeys] ([ID])
GO

ALTER TABLE [dbo].[Labels] CHECK CONSTRAINT [FK_Labels_LabelKeys]
GO

ALTER TABLE [dbo].[Labels]  WITH CHECK ADD  CONSTRAINT [FK_Labels_LanguageTypes] FOREIGN KEY([LanguageID])
REFERENCES [dbo].[LanguageTypes] ([ID])
GO

ALTER TABLE [dbo].[Labels] CHECK CONSTRAINT [FK_Labels_LanguageTypes]
GO


-------------------------


CREATE TABLE [dbo].[QuestionTypes](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
 CONSTRAINT [PK_QuestionTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

-------------------------


CREATE TABLE [dbo].[Questionnaires](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[TitleLabelKeyID] [int] NOT NULL,
	[SubtitleLabelKeyID] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Questionnaires] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Questionnaires] ADD  CONSTRAINT [DF_Questionnaires_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO

ALTER TABLE [dbo].[Questionnaires] ADD  CONSTRAINT [DF_Questionnaires_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[Questionnaires]  WITH CHECK ADD  CONSTRAINT [FK_Questionnaires_LabelKeys] FOREIGN KEY([TitleLabelKeyID])
REFERENCES [dbo].[LabelKeys] ([ID])
GO

ALTER TABLE [dbo].[Questionnaires] CHECK CONSTRAINT [FK_Questionnaires_LabelKeys]
GO

ALTER TABLE [dbo].[Questionnaires]  WITH CHECK ADD  CONSTRAINT [FK_Questionnaires_LabelKeys1] FOREIGN KEY([SubtitleLabelKeyID])
REFERENCES [dbo].[LabelKeys] ([ID])
GO

ALTER TABLE [dbo].[Questionnaires] CHECK CONSTRAINT [FK_Questionnaires_LabelKeys1]
GO


-------------------------


CREATE TABLE [dbo].[Questions](
	[ID] [int] NOT NULL,
	[QuestionnaireID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[QuestionLabelKeyID] [int] NULL,
	[TypeID] [int] NOT NULL,
	[Required] [bit] NOT NULL,
	[PlaceholderLabelKeyID] [int] NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_LabelKeys] FOREIGN KEY([QuestionLabelKeyID])
REFERENCES [dbo].[LabelKeys] ([ID])
GO

ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_LabelKeys]
GO

ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Questionnaires] FOREIGN KEY([QuestionnaireID])
REFERENCES [dbo].[Questionnaires] ([ID])
GO

ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Questionnaires]
GO

ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_QuestionTypes] FOREIGN KEY([TypeID])
REFERENCES [dbo].[QuestionTypes] ([ID])
GO

ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_QuestionTypes]
GO




-------------------------



CREATE TABLE [dbo].[AnswerOptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[AnswerLabelKeyID] [int] NOT NULL,
	[ConditionalQuestionID] [int] NULL,
 CONSTRAINT [PK_AnswerOptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AnswerOptions]  WITH CHECK ADD  CONSTRAINT [FK_AnswerOptions_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([ID])
GO

ALTER TABLE [dbo].[AnswerOptions] CHECK CONSTRAINT [FK_AnswerOptions_Questions]
GO

ALTER TABLE [dbo].[AnswerOptions]  WITH CHECK ADD  CONSTRAINT [FK_AnswerOptions_Questions1] FOREIGN KEY([ConditionalQuestionID])
REFERENCES [dbo].[Questions] ([ID])
GO

ALTER TABLE [dbo].[AnswerOptions] CHECK CONSTRAINT [FK_AnswerOptions_Questions1]
GO






-------------------------


CREATE TABLE [dbo].[Answers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([ID])
GO

ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions]
GO







