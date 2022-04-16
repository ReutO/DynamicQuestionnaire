using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Caching;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class SourceBase : IDatabaseSource
    {
        private readonly IConnectionFactory _connectionFactory;
        private readonly ObjectCache _cacheProvider;

        public SourceBase(IConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory ?? throw new ArgumentNullException(nameof(connectionFactory));
            _cacheProvider = MemoryCache.Default;
        }

        public T Call<T>(Func<IDbConnection, T> action, string cacheKey = null, DateTimeOffset? absoluteExperation = null)
        {
            using (var connection = _connectionFactory.CreateConnection())
            {
                connection.Open();

                if (!string.IsNullOrWhiteSpace(cacheKey))
                {
                    return Cache<T>(action, connection, cacheKey, absoluteExperation);
                }

                return action(connection);
            }
        }

        private T Cache<T>(
            Func<IDbConnection, T> action,
            IDbConnection connection,
            string key,
            DateTimeOffset? absoluteExperation = null)
        {
            if (!(_cacheProvider.Get(key) is T value))
            {
                value = action(connection);
                Cache(value, key, absoluteExperation);
            }

            return value;
        }

        private void Cache<T>(
            T value,
            string key,
            DateTimeOffset? absoluteExperation = null)
        {

            absoluteExperation = absoluteExperation.HasValue ? absoluteExperation : DateTimeOffset.Now.Add(TimeSpan.FromHours(1));

            var policy = new CacheItemPolicy
            {
                AbsoluteExpiration = absoluteExperation ?? ObjectCache.InfiniteAbsoluteExpiration,
                Priority = CacheItemPriority.Default,
                SlidingExpiration = ObjectCache.NoSlidingExpiration
            };

            if (!(_cacheProvider.Get(key) is T result) && value != null)
            {
                result = value;
                _cacheProvider.Add(key, result, policy);
            }
        }
    }
}
