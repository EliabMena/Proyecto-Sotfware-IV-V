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
    public class EstadosDeCuentaController : ControllerBase
    {
        private readonly AppDbContext _context;

        public EstadosDeCuentaController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/EstadosDeCuenta
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EstadoDeCuenta>>> GetEstadosDeCuenta()
        {
            return await _context.EstadosDeCuenta.Include(e => e.Usuario).ToListAsync();
        }

        // GET: api/EstadosDeCuenta/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EstadoDeCuenta>> GetEstadoDeCuenta(int id)
        {
            var estadoDeCuenta = await _context.EstadosDeCuenta.Include(e => e.Usuario).FirstOrDefaultAsync(e => e.id_estado == id);

            if (estadoDeCuenta == null)
            {
                return NotFound();
            }

            return estadoDeCuenta;
        }

        // PUT: api/EstadosDeCuenta/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEstadoDeCuenta(int id, EstadoDeCuenta estadoDeCuenta)
        {
            if (id != estadoDeCuenta.id_estado)
            {
                return BadRequest();
            }

            _context.Entry(estadoDeCuenta).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EstadoDeCuentaExists(id))
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

        // POST: api/EstadosDeCuenta
        [HttpPost]
        public async Task<ActionResult<EstadoDeCuenta>> PostEstadoDeCuenta(EstadoDeCuenta estadoDeCuenta)
        {
            _context.EstadosDeCuenta.Add(estadoDeCuenta);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetEstadoDeCuenta", new { id = estadoDeCuenta.id_estado }, estadoDeCuenta);
        }

        // DELETE: api/EstadosDeCuenta/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEstadoDeCuenta(int id)
        {
            var estadoDeCuenta = await _context.EstadosDeCuenta.FindAsync(id);
            if (estadoDeCuenta == null)
            {
                return NotFound();
            }

            _context.EstadosDeCuenta.Remove(estadoDeCuenta);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool EstadoDeCuentaExists(int id)
        {
            return _context.EstadosDeCuenta.Any(e => e.id_estado == id);
        }
    }
}
