using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata.Ecma335;

namespace ASPMVC04.Controllers
{
    public class StatusController : Controller
    {
        [Route("/Status/S200")]
        public async Task S200()
        {
            Response.StatusCode = 200;
            await Response.WriteAsync("OK");
        }
        [Route("/Status/S300")]
        public async Task S300()
        {
            Response.StatusCode = 300;
            await Response.WriteAsync("REDIRECT");
        }
        public IActionResult S500()
        {
            return View();
        }
        [Route("/Status/S500/Error")]
        public async Task DevideByZero()
        {
            try
            {
                int a = 10;
                var result = a / 0;


                Response.StatusCode = 200;
                await Response.WriteAsync($"OK");
            }
            catch (DivideByZeroException)
            {
                Response.StatusCode = 500;
                await Response.WriteAsync($"{Response.StatusCode} Internal Server Error");
            }
        }
    }
}
