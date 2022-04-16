using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Entities
{
    public class AnswerOption
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public int QuestionID { get; set; }
        [DataMember]
        public string AnswerLabel { get; set; }
        public int? ConditionalQuestionID { get; set; }
        [DataMember]
        public Question ConditionalQuestion { get; set; }
    }
}
