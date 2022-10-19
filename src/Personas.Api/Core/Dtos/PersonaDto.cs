namespace Personas.Api.Core.Dtos
{
    public class PersonaDto
    {
        public int Id { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string TipoDocumento { get; set; }
        public string DocumentoNro { get; set; }
        public string Email { get; set; }
        public string Telefono { get; set; }
        public string Pais { get; set; }
        public string TipoSexo { get; set; }
        public int Edad { get; set; }

    }

}
