using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Personas.Api.Core.Entities;
using Personas.Api.Core.EntitiesSP;
using Personas.Api.Core.Interfaces;
using Personas.Api.Infrastructure.Context;

namespace Personas.Api.Infrastructure.Services
{
    public class TipoParentezcoService : ITipoParentezcoServices
    {
        private readonly PersonasContext _context;
        

        public TipoParentezcoService(PersonasContext context)
        {
            _context = context;
            
        }       

        public async Task<IEnumerable<TipoParentezco>> GetTiposParentezcosAsync()
        {
            return await _context.TiposParentezcos.ToListAsync();

        }

        public async Task<PersonaParentezco> RegisterParentezcoAsync(PersonaParentezco personaParentezco)
        {
            await _context.PersonasParentezcos.AddAsync(personaParentezco);
            await _context.SaveChangesAsync();

            return personaParentezco;
        }        
    }
}
