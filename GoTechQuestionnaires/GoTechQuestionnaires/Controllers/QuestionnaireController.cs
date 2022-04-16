using GoTechQuestionnaires.Entities;
using GoTechQuestionnaires.Implementations;
using GoTechQuestionnaires.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class QuestionnaireController : ControllerBase
    {
        private readonly ILogger<QuestionnaireController> _logger;

        public QuestionnaireController(ILogger<QuestionnaireController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public Questionnaire Get([FromQuery] GetQuestionnaireRequest request)
        {
            if(request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            var processor = QuestionnaireFactory.GetQuestionnaireProcessor();
            return processor.Process(request);
        }
        
        [HttpPut]
        public Questionnaire Put([FromBody] SaveQuestionnaireRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            var processor = QuestionnaireFactory.GetSaveQuestionnaireProcessor();
            return processor.Process(request);
        }
    }
}
