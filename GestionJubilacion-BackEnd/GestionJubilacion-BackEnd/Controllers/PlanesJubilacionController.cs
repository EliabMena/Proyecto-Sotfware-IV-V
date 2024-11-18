using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace GestionJubilacion_BackEnd.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PlanesController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;

        public PlanesController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        // Endpoint para obtener todos los planes de jubilación
        [HttpGet]
        public async Task<ActionResult> ObtenerPlanes()
        {
            try
            {
                var planes = await applicationDbContext.planes_de_jubilacion.ToListAsync();
                if (!planes.Any())
                {
                    return NotFound("No se encontraron planes de jubilación.");
                }


                return Ok(planes);
            }
            catch (Exception ex)
            {
                var errorMessage = $"Error al obtener los planes: {ex.Message}";
                if (ex.InnerException != null)
                {
                    errorMessage += $" - Detalle: {ex.InnerException.Message}";
                }
                return StatusCode(500, errorMessage);
            }
        }

        // Endpoint para obtener el plan activo de un usuario por su id_usuario
        [HttpGet("plan-activo/{id_usuario}")]
        public async Task<ActionResult> ObtenerPlanActivo(int id_usuario)
        {
            if (id_usuario <= 0)
            {
                return BadRequest("El id_usuario debe ser un número válido y mayor a 0.");
            }

            try
            {
                // Buscar el plan activo directamente relacionado con el usuario
                var planActivo = await applicationDbContext.usuarios
                    .Where(u => u.id_usuario == id_usuario)
                    .Select(u => u.id_plan) 
                    .FirstOrDefaultAsync();

                if (planActivo == null)
                {
                    return NotFound("El usuario no tiene un plan activo o no existe.");
                }

                // Buscar el plan por su id
                var plan = await applicationDbContext.planes_de_jubilacion
                    .FirstOrDefaultAsync(p => p.id_plan == planActivo);

                if (plan == null)
                {
                    return NotFound("Plan no encontrado.");
                }

                // Retornar la información del plan
                return Ok(new
                {
                    plan.id_plan,
                    plan.tipo_plan,
                    plan.monto_minimo_aportacion,
                    plan.tasa_interes,
                    plan.descripcion,
                    plan.cuotas_necesarias
                });
            }
            catch (Exception ex)
            {
                var errorMessage = $"Error al obtener el plan activo: {ex.Message}";
                if (ex.InnerException != null)
                {
                    errorMessage += $" - Detalle: {ex.InnerException.Message}";
                }
                return StatusCode(500, errorMessage);
            }
        }

    }
}
