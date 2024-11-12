using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using GestionJubilacion_BackEnd;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GestionJubilacion_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlanesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public PlanesController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/PlanesDeJubilacion
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PlanDeJubilacion>>> GetPlanesDeJubilacion()
        {
            return await _context.PlanesDeJubilacion.ToListAsync();
        }

        // GET: api/PlanesDeJubilacion/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PlanDeJubilacion>> GetPlanDeJubilacion(int id)
        {
            var planDeJubilacion = await _context.PlanesDeJubilacion.FindAsync(id);

            if (planDeJubilacion == null)
            {
                return NotFound();
            }

            return planDeJubilacion;
        }

        // PUT: api/PlanesDeJubilacion/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPlanDeJubilacion(int id, PlanDeJubilacion planDeJubilacion)
        {
            if (id != planDeJubilacion.id_plan)
            {
                return BadRequest();
            }

            _context.Entry(planDeJubilacion).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PlanDeJubilacionExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/PlanesDeJubilacion
        [HttpPost]
        public async Task<ActionResult<PlanDeJubilacion>> PostPlanDeJubilacion(PlanDeJubilacion planDeJubilacion)
        {
            _context.PlanesDeJubilacion.Add(planDeJubilacion);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPlanDeJubilacion", new { id = planDeJubilacion.id_plan }, planDeJubilacion);
        }

        // DELETE: api/PlanesDeJubilacion/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePlanDeJubilacion(int id)
        {
            var planDeJubilacion = await _context.PlanesDeJubilacion.FindAsync(id);
            if (planDeJubilacion == null)
            {
                return NotFound();
            }

            _context.PlanesDeJubilacion.Remove(planDeJubilacion);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PlanDeJubilacionExists(int id)
        {
            return _context.PlanesDeJubilacion.Any(e => e.id_plan == id);
        }
    }
}
