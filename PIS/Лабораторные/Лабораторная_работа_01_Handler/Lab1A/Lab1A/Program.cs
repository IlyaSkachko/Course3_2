

using Microsoft.Extensions.Primitives;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();


app.MapGet("/{name}.SIA", async (context) =>
{
    var parmA = context.Request.Query["ParmA"];
    var parmB = context.Request.Query["ParmB"];

    string response;
    if( !StringValues.IsNullOrEmpty(parmA) && !StringValues.IsNullOrEmpty(parmB))
    {
        response = $"GET-Http-SIA: ParmA = {parmA}, ParmB = {parmB}";
    }
    else
    {
        response = $"GET-Http-SIA: Parameters not provided";
    }
    context.Response.ContentType = "text/plain";

    await context.Response.WriteAsync(response);
});

app.MapPost("/{name}.SIA", async (context) =>
{
    var parmA = context.Request.Query["ParmA"];
    var parmB = context.Request.Query["ParmB"];

    string response;

    if (!StringValues.IsNullOrEmpty(parmA) && !StringValues.IsNullOrEmpty(parmB))
    {
        response = $"POST-Http-SIA: ParmA = {parmA}, ParmB = {parmB}";
    }
    else
    {
        response = $"POST-Http-SIA: Parameters not provided";
    }

    context.Response.ContentType = "text/plain";

    await context.Response.WriteAsync(response);
});

app.MapPut("/{name}.SIA", async (context) =>
{
    var parmA = context.Request.Query["ParmA"];
    var parmB = context.Request.Query["ParmB"];

    string response;

    if (!StringValues.IsNullOrEmpty(parmA) && !StringValues.IsNullOrEmpty(parmB))
    {
        response = $"PUT-Http-SIA: ParmA = {parmA}, ParmB = {parmB}";
    }
    else
    {
        response = $"PUT-Http-SIA: Parameters not provided";
    }

    context.Response.ContentType = "text/plain";

    await context.Response.WriteAsync(response);
});


// WIN-APP


app.MapPost("/sum", async (context) =>
{
    var parms = await context.Request.ReadFormAsync();


    try
    {
        var X = int.Parse(parms["X"]);
        var Y = int.Parse(parms["Y"]);

        context.Response.ContentType = "text/plain";

        await context.Response.WriteAsync((X + Y).ToString());
    }
    catch (Exception ex)
    {
        await context.Response.WriteAsync(ex.Message);
    }

});


// WEB

app.MapGet("/task5", async (context) =>
{
    context.Response.ContentType = "text/html";
    await context.Response.SendFileAsync("wwwroot/index.html");
});

app.MapPost("/task5", async (context) =>
{
    using (StreamReader reader = new StreamReader(context.Request.Body))
    {
        string requestBody = await reader.ReadToEndAsync();
        string[] values = requestBody.Split(';');

        if (values.Length != 2)
        {
            context.Response.StatusCode = StatusCodes.Status400BadRequest;
            return;
        }

        if (!int.TryParse(values[0], out int x) || !int.TryParse(values[1], out int y))
        {
            context.Response.StatusCode = StatusCodes.Status400BadRequest;
            return;
        }

        int mul = x * y;

        context.Response.StatusCode = 200;
        context.Response.ContentType = "text/plain";
        await context.Response.WriteAsync(mul.ToString());
    }
});


app.MapGet("/task6", async (context) =>
{
    context.Response.ContentType = "text/html";
    await context.Response.SendFileAsync("wwwroot/task6.html");

});

app.MapPost("/task6", async (context) =>
{
    var form = context.Request.Form;

    if (!int.TryParse(form["x"], out int x) || !int.TryParse(form["y"], out int y))
    {
        Console.WriteLine($"Invalid input: x={form["x"]}, y={form["y"]}");

        context.Response.StatusCode = 400;
        context.Response.ContentType = "text/html";
        await context.Response.WriteAsync("<div><p>Error: Invalid input</p></div>");
        return;
    }

    int mul = x * y;

    context.Response.StatusCode = 200;
    context.Response.ContentType = "text/html";
    await context.Response.WriteAsync($"<div><p>Mul: {mul}</p></div>");

});


app.Run();
