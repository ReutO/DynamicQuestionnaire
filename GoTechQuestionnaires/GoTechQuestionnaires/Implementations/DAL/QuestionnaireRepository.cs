using Dapper;
using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class QuestionnaireRepository : SourceBase, ISaver<SaveQuestionnaireRequest, Questionnaire>, IGetter<GetQuestionnaireRequest, Questionnaire>
    {
        private readonly Type[] _mappingTypes = new Type[4] { typeof(Questionnaire), typeof(Question), typeof(AnswerOption), typeof(Answer) };
        private ICompleter<Questionnaire> _completer;

        public QuestionnaireRepository(IConnectionFactory connectionFactory, ICompleter<Questionnaire> completer) : base(connectionFactory)
        {
            _completer = completer ?? throw new ArgumentNullException(nameof(completer));
        }

        public Questionnaire Get(GetQuestionnaireRequest request)
        {
            if(request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            const string procedure = "[GoTech].[dbo].[GetQuestionnaire]";
            var cacheKey = $"{nameof(QuestionnaireRepository)}::{nameof(GetQuestionnaireRequest)}::{nameof(request.ID)}:{request.Language}";

            var parameters = new DynamicParameters();
            parameters.Add("@ID", request.ID, DbType.Int32);
            parameters.Add("@LanguageID", (int)request.Language, DbType.Int32);

            return Call((connection) =>
            {
                var result = connection.Query(procedure, _mappingTypes, param: parameters, commandType: CommandType.StoredProcedure, map: GetMapper())?.Distinct();

                if (result == null || result.Count() != 1)
                {
                    return null;
                }

                return _completer.Complete(result.First());

            }, cacheKey);


        }

        public Questionnaire Save(SaveQuestionnaireRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            if(request.Answers == null || !request.Answers.Any())
            {
                throw new ArgumentNullException(nameof(request));
            }

            const string procedure = "[GoTech].[dbo].[SaveORUpdateQuestionnaireAnswers]";

            var parameters = new DynamicParameters();
            parameters.Add("@ID", request.ID, DbType.Int32);
            parameters.Add("@LanguageID", (int)request.Language, DbType.Int32);

            var answersTable = new DataTable();
            answersTable.Columns.Add("QuestionID", typeof(int));
            answersTable.Columns.Add("Value", typeof(string));
            DataRow row;

            foreach(var answer in request.Answers)
            {
                row = answersTable.NewRow();
                row["QuestionID"] = answer.QuestionID;
                row["Value"] = answer.Value;
                answersTable.Rows.Add(row);
            }

            parameters.Add("@Answers", answersTable.AsTableValuedParameter("[dbo].[QuestionAnswers]"));

            return Call((connection) =>
            {
                var result = connection.Query(procedure, _mappingTypes, param: parameters, commandType: CommandType.StoredProcedure, map: GetMapper())?.Distinct();

                if(result == null || result.Count() != 1)
                {
                    return null;
                }

                return _completer.Complete(result.First());

            });
        }


        private Func<object[], Questionnaire> GetMapper()
        {
            var questionnaireDictionary = new Dictionary<int, Questionnaire>();
            var questionDictionary = new Dictionary<int, Question>();

            return objects =>
            {
                var questionnaire = objects[0] as Questionnaire;
                var question = objects[1] as Question;
                var option = objects[2] as AnswerOption;
                var answer = objects[3] as Answer;

                Questionnaire QuestionnaireEntry = null;
                Question questionEntry = null;

                if (question != null)
                {
                    if (!questionDictionary.TryGetValue(question.ID, out questionEntry))
                    {
                        questionEntry = question;
                        questionEntry.AnswerOptions = new List<AnswerOption>();
                        questionEntry.Answers = new List<Answer>();
                        questionDictionary.Add(questionEntry.ID, questionEntry);
                    }

                    if (answer != null && !questionEntry.Answers.Any(a => a.ID == answer.ID))
                    {
                        questionEntry.Answers.Add(answer);
                    }

                    if (option != null && !questionEntry.AnswerOptions.Any(o => o.ID == option.ID))
                    {
                        questionEntry.AnswerOptions.Add(option);
                    }
                }

                if (!questionnaireDictionary.TryGetValue(questionnaire.ID, out QuestionnaireEntry))
                {
                    QuestionnaireEntry = questionnaire;
                    QuestionnaireEntry.Questions = new List<Question>();
                    questionnaireDictionary.Add(QuestionnaireEntry.ID, QuestionnaireEntry);
                }

                if (questionEntry != null && !QuestionnaireEntry.Questions.Any(q => q.ID == questionEntry.ID))
                {
                    QuestionnaireEntry.Questions.Add(questionEntry);
                }

                return QuestionnaireEntry;
            };
        }
    }
}
