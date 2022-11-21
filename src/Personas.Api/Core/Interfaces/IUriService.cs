using Personas.Api.Core.Filters;

namespace Personas.Api.Core.Interfaces
{
    public interface IUriService
    {
        public Uri GetPageUri(PaginationFilter filter, string route);
    }
}
