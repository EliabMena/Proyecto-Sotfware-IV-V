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

        [HttpPatch]
        public async Task<ActionResult> ActualizarBeneficiario(int id_usuario, string nombre_beneficiario, [FromBody] BeneficiarioActualizar beneficiario)
        {
            if (id_usuario <= 0)
            {
                return BadRequest("El id_usuario debe ser un número válido y mayor a 0.");
            }

            if (string.IsNullOrEmpty(nombre_beneficiario))
            {
                return BadRequest("El nombre del beneficiario es obligatorio.");
            }

            // Buscar al beneficiario específico
            var beneficiarioActual = await applicationDbContext.beneficiarios
                .FirstOrDefaultAsync(b => b.id_usuario == id_usuario && b.nombre_beneficiario == nombre_beneficiario);

            if (beneficiarioActual == null)
            {
                return NotFound("No se encontró el beneficiario asociado al usuario.");
            }

            try
            {
                // Actualizar solo los campos proporcionados
                if (!string.IsNullOrEmpty(beneficiario.nombre_beneficiario))
                {
                    beneficiarioActual.nombre_beneficiario = beneficiario.nombre_beneficiario;
                }
                if (!string.IsNullOrEmpty(beneficiario.relacion))
                {
                    beneficiarioActual.relacion = beneficiario.relacion;
                }
                if (beneficiario.porcentaje_asignado > 0 && beneficiario.porcentaje_asignado <= 100)
                {
                    beneficiarioActual.porcentaje_asignado = (decimal)beneficiario.porcentaje_asignado;
                }
                if (!string.IsNullOrEmpty(beneficiario.cedula_beneficiario))
                {
                    beneficiarioActual.cedula_beneficiario = beneficiario.cedula_beneficiario;
                }

                // Guardar cambios en la base de datos
                applicationDbContext.beneficiarios.Update(beneficiarioActual);
                await applicationDbContext.SaveChangesAsync();

                return Ok("Beneficiario actualizado correctamente.");
            }
            catch (Exception e)
            {
                var errorMessage = $"Error al actualizar el beneficiario: {e.Message}";
                if (e.InnerException != null)
                {
                    errorMessage += $" - Detalle: {e.InnerException.Message}";
                }
                return StatusCode(500, errorMessage);
            }
        }

    }
}

