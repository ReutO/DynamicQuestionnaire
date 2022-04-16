using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Entities
{
    public class Question
    {
        [DataMember]
        public int ID { get; set; }
        public int QuestionnaireID { get; set; }
        [DataMember]
        public string QuestionLabel { get; set; }
        [DataMember]
        public string PlaceholderLabel{ get; set; }
        [DataMember]
        public QuestionType Type { get; set; }
        [DataMember]
        public bool Required { get; set; }
        [DataMember]
        public List<AnswerOption> AnswerOptions { get; set; }
        [DataMember]
        public List<Answer> Answers { get; set; }
    }
}
