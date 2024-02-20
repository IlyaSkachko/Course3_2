using Microsoft.AspNetCore.Mvc;

namespace ASPMVC03.Controllers.Start
{
    public class StartController : Controller
    {
        [Route("/Start/Index")]
        public IActionResult Index()
        {
            return View();
        }

        [Route("/Start/One")]
        public async Task One()
        {
            Response.ContentType = "text/html";
            await Response.WriteAsync("<h1>Start/One</h1>");
        }
        [Route("/Start/Two")]
        public async Task Two()
        {
            Response.ContentType = "text/html";
            await Response.WriteAsync("<h1>Start/Two</h1>");
        }
        [Route("/Start/Three")]
        public async Task Three()
        {
            Response.ContentType = "text/html";
            await Response.WriteAsync("<h1>Start/Three</h1>");
        }
    }
}
