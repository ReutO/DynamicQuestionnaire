using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface IDatabaseSource
    {
        T Call<T>(Func<IDbConnection, T> action, string cacheKey = null, DateTimeOffset? absoluteExperation = null);
    }
}
