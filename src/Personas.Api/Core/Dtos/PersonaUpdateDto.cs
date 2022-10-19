using System.ComponentModel.DataAnnotations;

namespace Personas.Api.Core.Dtos
{
    public class PersonaUpdateDto
    {
        public int Id { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string DocumentoNro { get; set; }

        [StringLength(100, ErrorMessage = "Email field must not exceed 100 characters.")]
        [EmailAddress(ErrorMessage = "El email no tiene un formato esperado.")]  
        public string Email { get; set; }
        public string? Telefono { get; set; }
        public int PaisId { get; set; }
        public int TipoDocumentoId { get; set; }
        public int TipoSexoId { get; set; }
        [Range(18, int.MaxValue, ErrorMessage = "No pueden registrarse personas menores a 18 años.")]
        public int Edad { get; set; }
        

    }

}
