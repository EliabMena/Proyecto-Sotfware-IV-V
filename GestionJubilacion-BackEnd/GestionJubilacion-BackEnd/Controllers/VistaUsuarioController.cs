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

        [HttpGet("{cedula}")]
        public async Task<ActionResult<VistaUsuario>> vistaUsuario(string cedula)
        {
            if (string.IsNullOrEmpty(cedula))
            {
                return BadRequest("La cédula es requerida.");
            }

            var usuario = await applicationDbContext.VistaUsuario
                .FromSqlRaw("SELECT * FROM vista_usuario WHERE cedula = {0}", cedula)
                .FirstOrDefaultAsync();

            if (usuario == null)
            {
                return NotFound($"No se encontró un usuario con la cédula {cedula}.");
            }
            return Ok(usuario);
        }
    }
}
