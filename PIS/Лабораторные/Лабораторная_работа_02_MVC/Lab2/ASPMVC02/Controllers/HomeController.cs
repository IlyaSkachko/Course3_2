using ASPMVC02.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace ASPMVC02.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}