using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface IGetter<in K, T>
    {
        T Get(K request);
    }
}
