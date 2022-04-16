using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public interface IConnectionFactory
    {
        IDbConnection CreateConnection();
    }
}
