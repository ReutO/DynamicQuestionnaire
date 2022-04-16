using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class GetQuestionnaireProcessor : IProcessor<GetQuestionnaireRequest, Questionnaire>
    {
        private IGetter<GetQuestionnaireRequest, Questionnaire> _getter;

        public GetQuestionnaireProcessor(IGetter<GetQuestionnaireRequest, Questionnaire> getter)
        {
            _getter = getter ?? throw new ArgumentNullException(nameof(getter));
        }

        public Questionnaire Process(GetQuestionnaireRequest request)
        {
            if(request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            //New we don't need this class to be the "middle man", but there could be more implementations in the future
            return _getter.Get(request);
        }
    }
}
