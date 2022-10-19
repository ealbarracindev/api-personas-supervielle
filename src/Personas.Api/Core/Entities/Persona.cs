using Personas.Api.Core.Enumerations;

namespace Personas.Api.Core.Entities
{
    public class Persona : BaseEntity
    {
        public string Nombres { get; set; } = null!;
        public string Apellidos { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Telefono { get; set; }        
        public int TipoDocumentoId { get; set; }
        public virtual TipoDocumento TipoDocumento { get; set; } = null!;
        public string DocumentoNro { get; set; } = null!;
        public int PaisId { get; set; }
        public Pais Pais { get; set; } = null!;
        public int TipoSexoId { get; set; }
        public TipoSexo TipoSexo { get; set; } = null!;
        public int Edad { get; set; }        
        //public DateTime FechaNacimiento { get; set; }        
    }
}
