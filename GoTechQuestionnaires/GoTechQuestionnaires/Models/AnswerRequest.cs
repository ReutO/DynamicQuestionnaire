using GoTechQuestionnaires.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Models
{
    public class AnswerRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int QuestionID { get; set; }
        
        public string Value { get; set; }
    }
}
