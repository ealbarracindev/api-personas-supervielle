using Microsoft.AspNetCore.Mvc;
using Personas.Api.Core.Entities;
using Personas.Api.Core.Interfaces;

namespace Personas.Api.Controllers.V1
{
    [ApiVersion("1.0")]
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiController]
    public class TiposParentezcosController : ControllerBase
    {
        private readonly ITipoParentezcoServices _tipoParentezcoServices;

        public TiposParentezcosController(ITipoParentezcoServices tipoParentezcoServices)
        {
            _tipoParentezcoServices = tipoParentezcoServices;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> RegisterParentezco(PersonaParentezco personaParentezco)
        {
            var entity = await _tipoParentezcoServices.RegisterParentezcoAsync(personaParentezco);
            // Return 201
            return StatusCode(StatusCodes.Status201Created, entity);
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> TiposParentezcos() =>
            Ok(await _tipoParentezcoServices.GetTiposParentezcosAsync());
    }
}
