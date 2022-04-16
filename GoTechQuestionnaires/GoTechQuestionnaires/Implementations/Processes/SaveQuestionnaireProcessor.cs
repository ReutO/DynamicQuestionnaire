using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class SaveQuestionnaireProcessor : IProcessor<SaveQuestionnaireRequest, Questionnaire>
    {
        private IValidator<SaveQuestionnaireRequest> _validator;
        private ISaver<SaveQuestionnaireRequest, Questionnaire> _saver;

        public SaveQuestionnaireProcessor(IValidator<SaveQuestionnaireRequest> validator, ISaver<SaveQuestionnaireRequest, Questionnaire> saver)
        {
            _saver = saver ?? throw new ArgumentNullException(nameof(saver));
            _validator = validator ?? throw new ArgumentNullException(nameof(validator));
        }

        public Questionnaire Process(SaveQuestionnaireRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            //can be checked in a new Attribute but for the sake of the assignment:
            if (request.Answers == null || !request.Answers.Any()) 
            {
                throw new ArgumentNullException(nameof(request));
            }

            if (!_validator.Validate(request))
            {
                //I would create a validator Exeption that will contain the validator info 
                //and using Exception Filter I'll customize how Web API handle this exeption and return HttpResponseMessage 400
                //but for the sake of the assignment:
                throw new ArgumentException("Request is not valid"); 
            }

            return _saver.Save(request);
        }
    }
}
