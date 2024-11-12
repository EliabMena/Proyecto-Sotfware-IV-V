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
    public class BeneficiariosController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BeneficiariosController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Beneficiarios
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Beneficiario>>> GetBeneficiarios()
        {
            return await _context.Beneficiarios.Include(b => b.Usuario).ToListAsync();
        }

        // GET: api/Beneficiarios/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Beneficiario>> GetBeneficiario(int id)
        {
            var beneficiario = await _context.Beneficiarios.Include(b => b.Usuario).FirstOrDefaultAsync(b => b.id_beneficiario == id);

            if (beneficiario == null)
            {
                return NotFound();
            }

            return beneficiario;
        }

        // PUT: api/Beneficiarios/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBeneficiario(int id, Beneficiario beneficiario)
        {
            if (id != beneficiario.id_beneficiario)
            {
                return BadRequest();
            }

            _context.Entry(beneficiario).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BeneficiarioExists(id))
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

        // POST: api/Beneficiarios
        [HttpPost]
        public async Task<ActionResult<Beneficiario>> PostBeneficiario(Beneficiario beneficiario)
        {
            _context.Beneficiarios.Add(beneficiario);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBeneficiario", new { id = beneficiario.id_beneficiario }, beneficiario);
        }

        // DELETE: api/Beneficiarios/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBeneficiario(int id)
        {
            var beneficiario = await _context.Beneficiarios.FindAsync(id);
            if (beneficiario == null)
            {
                return NotFound();
            }

            _context.Beneficiarios.Remove(beneficiario);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool BeneficiarioExists(int id)
        {
            return _context.Beneficiarios.Any(e => e.id_beneficiario == id);
        }
    }
}
