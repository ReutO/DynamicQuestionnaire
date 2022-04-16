using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoTechQuestionnaires.Implementations
{
    public class CompositValidator<T> : IValidator<T>
    {
        private IValidator<T>[] _validators;
        public CompositValidator(params IValidator<T>[] validators)
        {
            _validators = validators ?? throw new ArgumentNullException(nameof(validators));
        }

        public bool Validate(T value)
        {
            foreach(var validator in _validators)
            {
                if (!validator.Validate(value))
                {
                    return false;
                }
            }

            return true;
        }
    }
}
