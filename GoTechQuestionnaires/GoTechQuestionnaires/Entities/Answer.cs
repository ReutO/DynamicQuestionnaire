using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Entities
{
    public class Answer
    {
        [DataMember]
        public int ID { get; set; }
        public int QuestionID { get; set; }
        [DataMember]
        public string Value { get; set; }
    }
}
