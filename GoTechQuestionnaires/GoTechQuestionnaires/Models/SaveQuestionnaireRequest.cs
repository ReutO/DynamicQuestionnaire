using GoTechQuestionnaires.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Models
{
    public class SaveQuestionnaireRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int ID { get; set; }

        [Required]
        [Range(1, 2)]
        public LanguageType Language { get; set; }

        [Required]
        public IEnumerable<AnswerRequest> Answers { get; set; }
    }
}
