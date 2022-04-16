using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public static class QuestionnaireFactory
    {
        private static QuestionnaireRepository _questionnaireRepository;

        static QuestionnaireFactory()
        {
            _questionnaireRepository = new QuestionnaireRepository(
                connectionFactory: new SqlConnectionFactory(Startup.GoTechConnectionString),
                completer: new QuestionnaireCompleter());
        }

        public static IProcessor<GetQuestionnaireRequest, Questionnaire> GetQuestionnaireProcessor()
        {
            return new GetQuestionnaireProcessor(_questionnaireRepository);
        }
        
        public static IProcessor<SaveQuestionnaireRequest, Questionnaire> GetSaveQuestionnaireProcessor()
        {
            return new SaveQuestionnaireProcessor(
                saver: _questionnaireRepository,
                validator: new CompositValidator<SaveQuestionnaireRequest>(
                    new RequiredQuestionsValidator(_questionnaireRepository)
                    //More validators can be added here, like IDs, Regex, length, conditional questions, answer options and cetera...
                    ));
        }
    }
}
