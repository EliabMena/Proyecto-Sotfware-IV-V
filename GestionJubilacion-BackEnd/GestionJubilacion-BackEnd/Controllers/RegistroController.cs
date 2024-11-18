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

            var planExistente = await applicationDbContext.planes_de_jubilacion
            .FirstOrDefaultAsync(p => p.id_plan == nuevoUsuario.id_plan);
            if (planExistente == null)
            {
                return NotFound("El plan especificado no existe.");
            }

            nuevoUsuario.rol = "usuario";

            var encriptar = new Encriptar();
            nuevoUsuario.contraseña_hash = encriptar.GenerarHash(nuevoUsuario.contraseña_hash);
            //Problemas con la fehca
            nuevoUsuario.fecha_registro = DateTime.Now.ToLocalTime();
            //nuevoUsuario.fecha_registro = DateTime.Now;


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

        [HttpPatch("actualizar")]
        public async Task<ActionResult> ActualizarUsuario(int id_usuario, [FromBody] UsuarioActualizar usuario)
        {
            if (id_usuario <= 0)
            {
                return BadRequest("El id_usuario debe ser un número válido y mayor a 0.");
            }

            var usuarioActual = await applicationDbContext.usuarios.FirstOrDefaultAsync(u => u.id_usuario == id_usuario);

            if (usuarioActual == null)
            {
                return NotFound("No se encontraron datos del usuario");
            }

            try
            {
                // Solo actualiza los campos que se reciban en el cuerpo del PATCH
                if (!string.IsNullOrEmpty(usuario.nombre))
                {
                    usuarioActual.nombre = usuario.nombre;
                }
                if (!string.IsNullOrEmpty(usuario.direccion))
                {
                    usuarioActual.direccion = usuario.direccion;
                }
                if (!string.IsNullOrEmpty(usuario.contacto))
                {
                    usuarioActual.contacto = usuario.contacto;
                }
                if (!string.IsNullOrEmpty(usuario.contraseña_hash))
                {
                    var encriptar = new Encriptar();
                    usuarioActual.contraseña_hash = encriptar.GenerarHash(usuario.contraseña_hash);
                }

                //siempre es la bendita fecha
                //usuarioActual.fecha_registro = usuarioActual.fecha_registro;
                usuarioActual.fecha_registro = DateTime.Now;


                applicationDbContext.usuarios.Update(usuarioActual);
                await applicationDbContext.SaveChangesAsync();

                return Ok("Usuario actualizado correctamente");
            }
            catch (Exception e)
            {
                var errorMessage = $"Error al actualizar el usuario: {e.Message}";
                if (e.InnerException != null)
                {
                    errorMessage += $" - Detalle: {e.InnerException.Message}";
                }
                return StatusCode(500, errorMessage);
            }
        }


    }
}

