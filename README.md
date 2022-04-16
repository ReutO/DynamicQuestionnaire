# DynamicQuestionnaire

Need SQL Server Database 
You can change the ConnectionStrings in appsettings.json files.
You can see the tables diagram in SQL/diagram.JPG

Run the scripts in SQL folder on this order:
1. 01_Create_DB_And_Tables.sql
2. 02_Create_Procedures_And_TableTypes.sql
3. 03_Add_Data.sql


The launchUrl is "Questionnaire?id=1&language=1". You can change this in launchSettings.json file.

Example model for debug testing to save the data:

var save = new SaveQuestionnaireRequest()
{
    ID = 1,
    Language = LanguageType.English,
    Answers = new List<AnswerRequest>()
    {
        new AnswerRequest()
        {
            QuestionID = 1,
            Value = "2"
        },
        new AnswerRequest()
        {
            QuestionID = 4,
            Value = "4 kljngfkjnkjn kljhdfkjn"
        },
        new AnswerRequest()
        {
            QuestionID = 2,
            Value = "2 sdfiluhb olikjsdncv yk"
        },
        new AnswerRequest()
        {
            QuestionID = 3,
            Value = "7"
        },
        new AnswerRequest()
        {
            QuestionID = 5,
            Value = "5 sdxgf gfsgfsgsf"
        }
    }
};

var processor = QuestionnaireFactory.GetSaveQuestionnaireProcessor();
return processor.Process(save);
