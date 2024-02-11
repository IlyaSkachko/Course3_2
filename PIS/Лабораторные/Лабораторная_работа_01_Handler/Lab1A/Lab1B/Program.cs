using System.Net.WebSockets;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
builder.WebHost.UseUrls("https://localhost:7222");
var app = builder.Build();


app.UseWebSockets();

app.UseStaticFiles();

app.Use(async (context, next) =>
{
    if (context.Request.Path == "/ws")
    {
        if (context.WebSockets.IsWebSocketRequest)
        {
            WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
            await HandleWebSocketAsync(webSocket);
        }
        else
        {
            context.Response.StatusCode = 400;
        }
    }
    else
    {
        await next();
    }
});

app.Run();

async Task HandleWebSocketAsync(WebSocket webSocket)
{
    try
    {
        while (webSocket.State == WebSocketState.Open)
        {
            string message = DateTime.Now.ToString("HH:mm:ss");
            byte[] buffer = Encoding.UTF8.GetBytes(message);
            await webSocket.SendAsync(new ArraySegment<byte>(buffer), WebSocketMessageType.Text, true, CancellationToken.None);

            await Task.Delay(2000);
        }
    }
    catch (WebSocketException ex)
    {
        Console.WriteLine(ex.Message);
    }
}