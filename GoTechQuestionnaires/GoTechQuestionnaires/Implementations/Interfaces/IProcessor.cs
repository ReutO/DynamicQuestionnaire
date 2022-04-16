using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface IProcessor<in K, T>
    {
        T Process(K source);
    }
}
