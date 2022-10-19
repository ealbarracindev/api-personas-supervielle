using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Personas.Api.Core.Entities;

namespace Personas.Api.Infrastructure.Context.Configurations
{
    public class PersonaConfiguration : IEntityTypeConfiguration<Persona>
    {
        public void Configure(EntityTypeBuilder<Persona> builder)
        {
            //builder.HasIndex(p => new { p.TipoDocumentoId, p.DocumentoNro, p.PaisId, p.TipoSexoId })
            //    .IsUnique();
            //builder.HasQueryFilter(e => !e.Eliminado);
        }
    }
}

