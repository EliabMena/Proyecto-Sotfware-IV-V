using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;

        public LoginController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        [HttpPost]
        public async Task<ActionResult> Login([FromBody] usuario login)
        {
            if (login == null || string.IsNullOrEmpty(login.cedula) || string.IsNullOrEmpty(login.contraseña_hash))
            {
                return BadRequest("La cédula y la contraseña son requeridas.");
            }

            var usuario = await applicationDbContext.usuarios.FirstOrDefaultAsync(u => u.cedula == login.cedula);

            if (usuario == null)
            {
                return Unauthorized("Usuario no encontrado.");
            }

            var encriptar = new Encriptar();

            string password = encriptar.GenerarHash(login.contraseña_hash);

            if (usuario.contraseña_hash != password)
            {
                return Unauthorized("Contraseña incorrecta.");
            }

            return Ok(new
            {
                message = "Login exitoso.",
                usuario.id_usuario
            });
        }


    }
}
