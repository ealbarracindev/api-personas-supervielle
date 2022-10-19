namespace Personas.Api.Core.Entities
{
    public class PersonaParentezco : BaseEntity
    {
        public int Persona1Id { get; set; }
        public int Persona2Id { get; set; }
        public int TipoParentezcoId { get; set; }
        public virtual TipoParentezco TipoParentezco { get; set; } = null!;
    }
}
