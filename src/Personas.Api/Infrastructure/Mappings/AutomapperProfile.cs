using AutoMapper;
using Personas.Api.Core.Dtos;
using Personas.Api.Core.Entities;

namespace Personas.Api.Infrastructure.Mappings
{
    public class AutomapperProfile : Profile
    {
        public AutomapperProfile()
        {
            CreateMap<Persona, PersonaDto>()
                .ForMember(dest =>
                           dest.TipoDocumento,
                    opt => opt.MapFrom(src => src.TipoDocumento.Descripcion))
                .ForMember(dest =>
                           dest.TipoSexo,
                    opt => opt.MapFrom(src => src.TipoSexo.Descripcion))
                .ForMember(dest =>
                           dest.Pais,
                    opt => opt.MapFrom(src => src.Pais.Nombre)).ReverseMap();

            CreateMap<Persona, PersonaCreateDto>()
                .ForMember(pdto =>
                           pdto.TipoDocumentoId,
                    opt => opt.MapFrom(src => src.TipoDocumentoId))
                .ForMember(dest =>
                           dest.TipoSexoId,
                    opt => opt.MapFrom(src => src.TipoSexoId))
                .ForMember(dest =>
                           dest.PaisId,
                    opt => opt.MapFrom(src => src.PaisId))
                .ReverseMap();


            CreateMap<PersonaUpdateDto, Persona>()
                .ForMember(pdto =>
                           pdto.TipoDocumentoId,
                    opt => opt.MapFrom(src => src.TipoDocumentoId))
                .ForMember(dest =>
                           dest.TipoSexoId,
                    opt => opt.MapFrom(src => src.TipoSexoId))
                .ForMember(dest =>
                           dest.PaisId,
                    opt => opt.MapFrom(src => src.PaisId))
                .ReverseMap();
        }
    }
}
