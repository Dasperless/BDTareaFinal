using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebRutaCiclistica.Controllers
{
    public class vistaCiclistaController : Controller
    {
        // GET: vistaCiclistaController
        public ActionResult Index()
        {
            return View();
        }

        // GET: vistaCiclistaController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: vistaCiclistaController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: vistaCiclistaController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: vistaCiclistaController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: vistaCiclistaController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: vistaCiclistaController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: vistaCiclistaController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
