using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface ICompleter<T>
    {
        T Complete(T value);
    }
}
