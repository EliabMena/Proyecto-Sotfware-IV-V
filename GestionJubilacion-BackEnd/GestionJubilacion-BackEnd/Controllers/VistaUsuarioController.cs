using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace GestionJubilacion_BackEnd.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VistaUsuarioController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;

        public VistaUsuarioController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        [HttpGet("{id_usuario}")]
        public async Task<ActionResult<VistaUsuario>> vistaUsuario(int id_usuario)
        {
            if (id_usuario < 0)
            {
                return BadRequest("El id de usuario es requerido y debe ser un valor positivo.");
            }

            try
            {
                var usuario = await applicationDbContext.VistaUsuario.FromSqlRaw("SELECT * FROM vista_usuario WHERE id_usuario = {0}", id_usuario).FirstOrDefaultAsync();

                if (usuario == null)
                {
                    return NotFound($"No se encontró un usuario con el id {id_usuario}.");
                }

                var beneficiarios = await applicationDbContext.VistaBeneficiarios
                .FromSqlRaw("SELECT * FROM vista_beneficiarios WHERE id_usuario  = {0}", usuario.id_usuario)
                .ToListAsync();


                return Ok(new
                {
                    Usuario = usuario,
                    Beneficiarios = beneficiarios
                });
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
