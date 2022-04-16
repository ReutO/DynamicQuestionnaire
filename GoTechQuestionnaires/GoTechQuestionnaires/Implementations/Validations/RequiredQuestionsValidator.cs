using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class RequiredQuestionsValidator : IValidator<SaveQuestionnaireRequest>
    {
        private IGetter<GetQuestionnaireRequest, Questionnaire> _getter;
        public RequiredQuestionsValidator(IGetter<GetQuestionnaireRequest, Questionnaire> getter)
        {
            _getter = getter ?? throw new ArgumentNullException(nameof(getter));
        }

        public bool Validate(SaveQuestionnaireRequest request)
        {
            if(request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            var questionnaire = _getter.Get(new GetQuestionnaireRequest() { ID = request.ID });

            var conditionalQuestionIDs = questionnaire?.Questions
                ?.SelectMany(q => q.AnswerOptions)
                ?.Where(o => o.ConditionalQuestionID.HasValue)
                ?.Select(o => o.ConditionalQuestionID.Value);

            var requiredQuestions = questionnaire?.Questions?.Where(q => q.Required && !conditionalQuestionIDs.Contains(q.ID));

            if(requiredQuestions == null || !requiredQuestions.Any())
            {
                return true;
            }

            AnswerRequest answerRequest;

            foreach (var question in requiredQuestions)
            {
                answerRequest = request.Answers.FirstOrDefault(a => a.QuestionID == question.ID);

                if(answerRequest == null || string.IsNullOrWhiteSpace(answerRequest.Value))
                {
                    return false;
                }
            }

            return true;
        }
    }
}
