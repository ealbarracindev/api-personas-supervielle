
using Personas.Api.Core.Entities;
using Personas.Api.Core.EntitiesSP;

namespace Personas.Api.Core.Interfaces
{
    public interface ITipoParentezcoServices
    {
        Task<IEnumerable<TipoParentezco>> GetTiposParentezcosAsync();
        Task<PersonaParentezco> RegisterParentezcoAsync(PersonaParentezco personaParentezco);        
    }
}
