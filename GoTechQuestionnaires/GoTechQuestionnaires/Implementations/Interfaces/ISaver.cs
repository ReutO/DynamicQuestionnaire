using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface ISaver<in K, T>
    {
        T Save(K request);
    }
}
