using GoTechQuestionnaires.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class QuestionnaireCompleter : ICompleter<Questionnaire>
    {
        public Questionnaire Complete(Questionnaire value)
        {
            if(value == null)
            {
                return value;
            }

            var conditionalQuestionIDs = value.Questions
                ?.SelectMany(q => q.AnswerOptions)
                ?.Where(o => o.ConditionalQuestionID.HasValue)
                ?.Select(o => o.ConditionalQuestionID.Value);

            if(conditionalQuestionIDs == null || !conditionalQuestionIDs.Any()) 
            {
                return value;
            }

            var questions = value.Questions.Where(q => !conditionalQuestionIDs.Contains(q.ID));

            foreach(var option in questions.SelectMany(q => q.AnswerOptions).Where(o => o.ConditionalQuestionID.HasValue))
            {
                option.ConditionalQuestion = value.Questions.FirstOrDefault(q => q.ID == option.ConditionalQuestionID.Value);
            }

            value.Questions = questions.ToList();

            return value;
        }
    }
}
