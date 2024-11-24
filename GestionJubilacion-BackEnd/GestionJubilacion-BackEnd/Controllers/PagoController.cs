using GestionJubilacion_BackEnd.Contexts;
using GestionJubilacion_BackEnd.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PagoController : ControllerBase
    {
        private readonly ApplicationDbContext applicationDbContext;
        public PagoController(ApplicationDbContext applicationDbContext)
        {
            this.applicationDbContext = applicationDbContext;
        }

        [HttpPost]
        public async Task<ActionResult> InsertarPago([FromBody] Pago nuevoPago)
        {
            if (!ModelState.IsValid){ return BadRequest("Datos inválidos."); }

            try
            {
                await applicationDbContext.pagos.AddAsync(nuevoPago);
                await applicationDbContext.SaveChangesAsync();

                return Ok(new
                {
                    Mensaje = "Pago registrado con éxito.",
                    FacturaNoFiscal = new
                    {
                        nuevoPago.id_pago,
                        nuevoPago.id_usuario,
                        nuevoPago.fecha_pago,
                        nuevoPago.monto,
                        nuevoPago.metodo_pago,
                        nuevoPago.estado
                    }
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

        [HttpGet]
        public async Task<ActionResult> HistoriaPagos(int id_usuario)
        {
            try
            {
                if (id_usuario <= 0)
                {
                    return BadRequest("El ID del usuario debe ser un número positivo.");
                }

                var historial = await applicationDbContext.pagos.FromSqlRaw($"SELECT * FROM vista_historial_pagos WHERE id_usuario = {id_usuario}").ToListAsync();

                if (historial == null || !historial.Any())
                {
                    return NotFound("No se encontraron pagos para el usuario.");
                }

                return Ok(historial);
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
