using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace GestionJubilacion_BackEnd.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RegistroController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;

        public RegistroController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        [HttpPost]
        public async Task<ActionResult> Registrar([FromBody] usuario nuevoUsuario)
        {
            if (nuevoUsuario == null || string.IsNullOrEmpty(nuevoUsuario.cedula) ||
                string.IsNullOrEmpty(nuevoUsuario.nombre) || string.IsNullOrEmpty(nuevoUsuario.direccion) ||
                string.IsNullOrEmpty(nuevoUsuario.contacto) || string.IsNullOrEmpty(nuevoUsuario.contraseña_hash))
            {
                return BadRequest("Todos los campos son requeridos.");
            }

            var usuarioExistente = await applicationDbContext.usuarios.FirstOrDefaultAsync(u => u.cedula == nuevoUsuario.cedula);
            if (usuarioExistente != null)
            {
                return Conflict("El usuario ya existe.");
            }

            nuevoUsuario.rol = "usuario";

            var encriptar = new Encriptar();
            nuevoUsuario.contraseña_hash = encriptar.GenerarHash(nuevoUsuario.contraseña_hash);

            try
            {
                await applicationDbContext.usuarios.AddAsync(nuevoUsuario);
                await applicationDbContext.SaveChangesAsync();

                return CreatedAtAction(nameof(Registrar), new { cedula = nuevoUsuario.cedula }, "Usuario registrado exitosamente.");

            }catch (Exception ex){
                //por si falla algo en la conexion de la bse dedatos puse esto con el ex, ya luego quito el ex ydejo el mensaje
                return StatusCode(500, $"Error interno del servidor");
            }
        }
    }
}
