using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Personas.Api.Core.Exceptions;
using Personas.Api.Infrastructure.Diagnostics;
using Personas.Api.Infrastructure.Middlewares;
using Personas.Api.Infrastructure.Responses;
using System.Net;
using System.Text.Json;

namespace Personas.Api.Infrastructure.Middlewares
{
    public class ErrorHandlerMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ErrorHandlerMiddleware> _logger;
        public ErrorHandlerMiddleware(RequestDelegate next, ILogger<ErrorHandlerMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);

            }
            catch (Exception error)
            {
                var response = context.Response;
                response.ContentType = "application/json";
                var responseModel = new ApiResponse<string>()
                {
                    traceId = string.IsNullOrEmpty(context.TraceIdentifier) ? Guid.NewGuid().ToString() : context.TraceIdentifier,
                    isSuccess = false,
                    message = error?.Message,
                    instance = context.Request.Path
                };

                switch (error)
                {
                    case BusinessException e:
                        response.StatusCode = (int)HttpStatusCode.BadRequest;
                        _logger.LogInformationCustom($"[{response.StatusCode}]: {e?.Message}");
                        break;
                    case ApiException e:
                        // custom application error
                        response.StatusCode = (int)HttpStatusCode.BadRequest;
                        _logger.LogWarningCustom($"[{response.StatusCode}]: {e?.Message}");
                        break;
                    case DbUpdateException e:
                        // sql exception
                        response.StatusCode = (int)HttpStatusCode.BadRequest;
                        _logger.LogErrorCustom($"[{response.StatusCode}]: {error?.Message}", error?.InnerException);
                        break;
                    case KeyNotFoundException e:
                        // not found error
                        response.StatusCode = (int)HttpStatusCode.NotFound;
                        _logger.LogErrorCustom($"[{response.StatusCode}]: {error?.Message}", error?.InnerException);
                        break;
                    default:
                        // unhandled error
                        response.StatusCode = (int)HttpStatusCode.InternalServerError;
                        _logger.LogErrorCustom($"[{response.StatusCode}]: {error?.Message}", error?.InnerException);
                        break;
                }
                responseModel.status = response.StatusCode;
                var result = JsonSerializer.Serialize(responseModel);
                await response.WriteAsync(result);
            }
        }
    }
}

public static class ErrorHandlerMiddlewareExtensions
{
    public static void UseErrorHandlingMiddleware(this IApplicationBuilder app)
    {
        app.UseMiddleware<ErrorHandlerMiddleware>();
    }
}


