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
                string.IsNullOrEmpty(nuevoUsuario.contacto) || string.IsNullOrEmpty(nuevoUsuario.contraseña_hash) || nuevoUsuario.id_plan <= 0)
            {
                return BadRequest("Todos los campos son requeridos.");
            }

            var usuarioExistente = await applicationDbContext.usuarios.FirstOrDefaultAsync(u => u.cedula == nuevoUsuario.cedula);
            if (usuarioExistente != null)
            {
                return Conflict("El usuario ya existe.");
            }

            var planExistente = await applicationDbContext.planes_de_jubilacion
            .FirstOrDefaultAsync(p => p.id_plan == nuevoUsuario.id_plan);
            if (planExistente == null)
            {
                return NotFound("El plan especificado no existe.");
            }

            nuevoUsuario.rol = "usuario";

            var encriptar = new Encriptar();
            nuevoUsuario.contraseña_hash = encriptar.GenerarHash(nuevoUsuario.contraseña_hash);

            try
            {
                await applicationDbContext.usuarios.AddAsync(nuevoUsuario);
                await applicationDbContext.SaveChangesAsync();

                return CreatedAtAction(nameof(Registrar), new { id = nuevoUsuario.id_usuario }, new
                {
                    message = "Usuario registrado exitosamente.",
                    nuevoUsuario.id_usuario
                });
            }
            catch (Exception ex)
            {
                // Log de error completo con detalles de la excepción interna
                var errorMessage = $"Error al guardar los cambios: {ex.Message}";
                if (ex.InnerException != null)
                {
                    errorMessage += $" - Detalle: {ex.InnerException.Message}";
                }
                return StatusCode(500, errorMessage); // Devolver el error detallado
            }
        }

    }
}

