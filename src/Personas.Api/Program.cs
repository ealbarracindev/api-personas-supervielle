using Personas.Api.Core.Interfaces;
using Personas.Api.Infrastructure.Extensions;
using Personas.Api.Infrastructure.Middlewares;
using Personas.Api.Infrastructure.Services;
using Serilog;

var builder = WebApplication.CreateBuilder();

//create the logger and setup your sinks, filters and properties
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .WriteTo.Console()
    .CreateBootstrapLogger();

builder.Host.UseSerilog();

// Add services to the container.
builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddCustomSwagger();

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

// loading appsettings.json based on environment configurations
builder.Host.ConfigureAppConfiguration((hostingContext, config) =>
{
    var env = hostingContext.HostingEnvironment;

    config.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                        .AddJsonFile($"appsettings.dev.json", optional: true, reloadOnChange: true)
                        .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true, reloadOnChange: true);
    
    config.AddEnvironmentVariables();

    //if (args != null)
    //{
    //    config.AddCommandLine(args);
    //}
});

builder.Services.AddCustomDbContextsPool(builder.Configuration);

// Register Services
builder.Services.AddCustomServices();

// Register and configure CORS
builder.Services.AddCustomCors(builder.Configuration);

// Register and configure Healt Check
builder.Services.AddCustomHealthChecks(builder.Configuration);

// Register and Configure API versioning
builder.Services.AddCustomApiVersioning();

builder.Services.AddHttpContextAccessor();
builder.Services.AddSingleton<IUriService>(o =>
{
    var accessor = o.GetRequiredService<IHttpContextAccessor>();
    var request = accessor.HttpContext.Request;
    var uri = string.Concat(request.Scheme, "://", request.Host.ToUriComponent());
    return new UriService(uri);
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseErrorHandlingMiddleware();

app.UseCustomHealthchecks();

app.MapControllers();

app.Run();
