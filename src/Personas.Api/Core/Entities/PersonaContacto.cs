namespace Personas.Api.Core.Entities
{
    public class PersonaContacto : BaseEntity
    {
        public string Email { get; set; }
        public Persona Persona { get; set; }
    }
}
