
using Personas.Api.Core.Entities;
using Personas.Api.Core.EntitiesSP;
using Personas.Api.Core.Filters;

namespace Personas.Api.Core.Interfaces
{
    public interface IPersonaServices
    {
        Task<IEnumerable<Persona>> GetPersonasAsync(PaginationFilter filter);
        Task<int> CountAsync();
        Task<Persona> GetPersonaAsync(int id);
        Task<PersonaEstadisticaSP> GetEstadisticaAsync();
        Task<Persona> RegisterPersonaAsync(Persona persona);
        Task<bool> UpdatePersonaAsync(Persona persona);
        Task<bool> DeletePersonaAsync(Persona persona);
        Task<bool> ExistePersonaAsync(Persona persona);                
        Task<string> GetParentezcoAsync(int id1, int id2);        
        Task<string> GetRelacionesAsync(int id1, int id2);        
    }
}
