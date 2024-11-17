using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BeneficiariosController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;

        public BeneficiariosController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        [HttpPost]
        public async Task<ActionResult> RegistrarBeneficiario([FromBody] Beneficiario beneficiario)
        {
            if (beneficiario == null ||
                beneficiario.id_usuario < 0 ||
                string.IsNullOrEmpty(beneficiario.nombre_beneficiario) ||
                beneficiario.porcentaje_asignado <=0 ||
                beneficiario.porcentaje_asignado > 100 || beneficiario.cedula_beneficiario == null)
            {
                return BadRequest("Datos inválidos. Verifique la información enviada.");
            }

            // Validar que el usuario exista antes de registrar un beneficiario.
            var usuario = await applicationDbContext.usuarios.FirstOrDefaultAsync(u => u.id_usuario == beneficiario.id_usuario);
            if (usuario == null)
            {
                return NotFound("El usuario asociado no existe.");
            } 

            try
            {
                await applicationDbContext.beneficiarios.AddAsync(beneficiario);
                await applicationDbContext.SaveChangesAsync();

                return Ok("Beneficiario registrado con éxito.");
            }
            catch (Exception ex){
                //por si falla algo en la conexion de la bse dedatos puse esto con el ex, ya luego quito el ex ydejo el mensaje
                return StatusCode(500, $"Error interno del servidor: {ex.InnerException?.Message ?? ex.Message}");
            }
        }
    }
}

