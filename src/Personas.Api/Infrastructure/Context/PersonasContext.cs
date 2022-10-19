using Microsoft.EntityFrameworkCore;
using Personas.Api.Core.Entities;
using Personas.Api.Core.EntitiesSP;
using System.Reflection;

namespace Personas.Api.Infrastructure.Context
{
    public class PersonasContext : DbContext
    {
        public PersonasContext(DbContextOptions<PersonasContext> options)
            : base(options) { }

        public DbSet<Persona> Personas { get; set; }
        
        public DbSet<PersonaParentezco> PersonasParentezcos { get; set; }
        public DbSet<PersonaContacto> PersonasContactos { get; set; }
        public DbSet<Pais> Paises { get; set; }
        public DbSet<TipoDocumento> TiposDocumentos { get; set; }
        public DbSet<TipoSexo> TiposSexos { get; set; }
        public DbSet<TipoParentezco> TiposParentezcos { get; set; }

        #region Stored Procedures
        public DbSet<PersonaEstadisticaSP> PersonaEstadisticaSP { get; set; }        
        #endregion
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PersonaEstadisticaSP>().HasNoKey();
            
            
        }
    }
}
