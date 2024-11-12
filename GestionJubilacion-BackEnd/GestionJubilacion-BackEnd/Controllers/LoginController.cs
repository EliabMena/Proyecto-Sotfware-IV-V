using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using GestionJubilacion_BackEnd;

namespace GestionJubilacion_BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly AppDbContext _context;

        public LoginController(AppDbContext context)
        {
            _context = context;
        }

        // POST: api/Login
        [HttpPost]
        public async Task<ActionResult<string>> PostLogin(Login login)
        {
            // Buscar el usuario en la base de datos
            // y el primer resultado que encuntra lo retorna
            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(u => u.nombre == login.Usuario);

            // Verificar si el usuario existe
            if (usuario == null)
            {
                return Unauthorized("El usuario no existe.");
            }

            // Verificar si la contraseña es correcta utilizando BCrypt
            // (POR ALGUNA RAZON SI IMPORTO LA LIBRERIA EL VERIFY NO FUNCIONA SOLO SI LO AHGO DIRECTAMENTE)
            if (!BCrypt.Net.BCrypt.Verify(login.Contraseña, usuario.contraseña_hash))
            {
                return Unauthorized("Contraseña incorrecta.");
            }

            // Si la autenticación es exitosa, puedes generar un token JWT si lo deseas
            return Ok("Login exitoso");
        }
    }
}
