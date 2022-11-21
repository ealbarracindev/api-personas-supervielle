using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Personas.Api.Core.Dtos;
using Personas.Api.Core.Entities;
using Personas.Api.Core.Exceptions;
using Personas.Api.Core.Filters;
using Personas.Api.Core.Interfaces;
using Personas.Api.Infrastructure.Helpers;

namespace Personas.Api.Controllers.V1
{
    [ApiVersion("1.0")]
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiController]
    public class PersonasController : ControllerBase
    {
        private readonly IPersonaServices personaServices;
        private readonly IMapper mapper;
        private readonly IUriService uriService;
        public PersonasController(IPersonaServices personaServices, IMapper mapper, IUriService uriService)
        {
            this.personaServices = personaServices;
            this.mapper = mapper;
            this.uriService = uriService;
        }

        [HttpGet]
        public async Task<IActionResult> Personas([FromQuery] PaginationFilter filter) 
        {
            var route = Request.Path.Value;
            var validFilter = new PaginationFilter(filter.PageNumber, filter.PageSize);
            var resp =  await personaServices.GetPersonasAsync(validFilter);
            var pagedData = mapper.Map<List<PersonaDto>>(resp);
            var totalRecords = await personaServices.CountAsync();
            var pagedReponse = PaginationHelper.CreatePagedReponse<PersonaDto>(pagedData, validFilter, totalRecords, uriService, route);
            return Ok(pagedReponse);
        }
        
        [HttpGet("{id}")]
        public async Task<IActionResult> Persona([FromRoute] int id)
        {
            var resp = await personaServices.GetPersonaAsync(id);
            return Ok(mapper.Map<PersonaDto>(resp));            
        }
            
        /// <summary>
        /// Register Persona
        /// </summary>
        /// <param name="personaCreateDto"></param>
        /// <returns></returns>
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Registrar(PersonaCreateDto personaCreateDto)
        {
            var persona = mapper.Map<Persona>(personaCreateDto);

            if (await personaServices.ExistePersonaAsync(persona))
                throw new BusinessException("Existe una persona registrada con el mismo tipo de documento, número, pais y sexo");

            var entity = await personaServices.RegisterPersonaAsync(persona);

            var resp = await personaServices.GetPersonaAsync(persona.Id);
            // Return 201
            return StatusCode(StatusCodes.Status201Created, mapper.Map<PersonaDto>(resp));
        }

        [HttpPut("{id:int}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Actualizar([FromRoute] int id, PersonaUpdateDto persona)
        {
            if (id != persona.Id)
            {
                return BadRequest("Identificador incorrecto");
            }
            var entity = await personaServices.GetPersonaAsync(id);
            if (entity is null) return NotFound();

            var personaToSave = mapper.Map<PersonaUpdateDto, Persona>(persona, entity);
            await personaServices.UpdatePersonaAsync(personaToSave);
            return Ok(persona);
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]        
        public async Task<IActionResult> EliminarPersona([FromRoute] int id)
        {
            var entity = await personaServices.GetPersonaAsync(id);
            if (entity is null) return NotFound();
            
            await personaServices.DeletePersonaAsync(entity);
            return NoContent();
        }

        [HttpGet()]
        [Route("Estadisticas")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> Estadisticas() =>
            Ok(await personaServices.GetEstadisticaAsync());


        [HttpPost("parentezco/{id1:int}/padre/{id2:int}", Name = "Parentezco")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Parentezco(int id1, int id2) =>
            Ok(await personaServices.GetParentezcoAsync(id1, id2));
        
        [HttpGet("relaciones/{id1:int}/{id2:int}", Name = "Relaciones")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Relaciones(int id1, int id2)=>
            Ok(await personaServices.GetRelacionesAsync(id1, id2));
    }
}
