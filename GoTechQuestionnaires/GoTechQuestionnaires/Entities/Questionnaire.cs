using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Entities
{
    public class Questionnaire
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string TitleLabel { get; set; }
        [DataMember]
        public string SubtitleLabe { get; set; }
        [DataMember]
        public List<Question> Questions { get; set; }
    }
}
