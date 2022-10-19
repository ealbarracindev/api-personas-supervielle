using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Personas.Api.Core.Entities;
using Personas.Api.Core.EntitiesSP;
using Personas.Api.Core.Interfaces;
using Personas.Api.Infrastructure.Context;

namespace Personas.Api.Infrastructure.Services
{
    public class PersonaService : IPersonaServices
    {
        private readonly PersonasContext _context;
        

        public PersonaService(PersonasContext context)
        {
            _context = context;
            
        }

        public async Task<IEnumerable<Persona>> GetPersonasAsync()
        {
            return await _context.Personas
                            .Include(x => x.Pais)
                            .Include(x => x.TipoDocumento)
                            .Include(x => x.TipoSexo)
                            .ToListAsync();
        }

        public async Task<Persona> GetPersonaAsync(int id)
        {
            var resp = await _context.Personas
                                .Include(x => x.Pais)
                                .Include(x => x.TipoDocumento)
                                .Include(x => x.TipoSexo)
                                .FirstOrDefaultAsync(p => p.Id == id); 
            return resp;
        }

        public async Task<PersonaEstadisticaSP> GetEstadisticaAsync()
        {
            var result = await _context.PersonaEstadisticaSP
                         .FromSqlRaw<PersonaEstadisticaSP>($"GetPersonaEstadistica")
                         .ToListAsync();
            return result[0];

        }

        public async Task<Persona> RegisterPersonaAsync(Persona persona)
        {
            await _context.Personas.AddAsync(persona);
            await _context.SaveChangesAsync();

            return persona;
        }
        public async Task<bool> UpdatePersonaAsync(Persona persona)
        {
            _context.Personas.Update(persona);
            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> DeletePersonaAsync(Persona persona)
        {
            _context.Personas.Remove(persona);
            await _context.SaveChangesAsync();
            return true;
        }

        private int CalcularEdad(DateTime fechaNacimiento)
        {
            DateTime n = DateTime.Now;
            int age = n.Year - fechaNacimiento.Year;

            if (n.Month < fechaNacimiento.Month || (n.Month == fechaNacimiento.Month && n.Day < fechaNacimiento.Day))
                age--;

            return age;
        }

        public async Task<bool> ExistePersonaAsync(Persona persona)
        {
            var query = await _context.Personas
                        .Where(per =>per.TipoDocumentoId == persona.TipoDocumentoId
                             && per.DocumentoNro == persona.DocumentoNro
                             && per.PaisId == persona.PaisId
                             && per.TipoSexoId == persona.TipoSexoId)
                         .FirstOrDefaultAsync();
            return (query is null) ? false : true;
        }

        private bool EsMayor18(int edad)
        {
            return edad >= 18 ? true : false;
        }        

        public async Task<string> GetParentezcoAsync(int id1, int id2)
        {
            var resp = await _context.PersonasParentezcos
                .Where(pp => pp.Persona1Id == id1 && pp.Persona2Id == id2 && pp.TipoParentezcoId == 1)
                .FirstOrDefaultAsync();

            return resp is null ? "No hay coincidencia de padre e hijo." 
                                : $"Id1:{ id1 } es padre de Id2:{ id2 }.";
        }

        public async Task<string> GetRelacionesAsync(int id1, int id2)
        {
            int[] ids = { 3, 4, 5 };
            var resp = await _context.PersonasParentezcos
                .Include(x => x.TipoParentezco)
                .Where( pp => 
                pp.Persona1Id == id1 && pp.Persona2Id == id2 
                && ids.Contains(pp.TipoParentezcoId))
                .FirstOrDefaultAsync();

            return resp is null ? "No hay coincidencia de parentezco." 
                                : $"Id1:{id1} es { resp.TipoParentezco.Descripcion } de Id2:{ id2 }.";
        }
    }
}
