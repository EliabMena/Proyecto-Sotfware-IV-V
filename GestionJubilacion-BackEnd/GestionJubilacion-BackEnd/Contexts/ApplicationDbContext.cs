using GestionJubilacion_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd.Contexts
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<Usuario> usuarios { get; set; }
        public DbSet<Beneficiario> beneficiarios { get; set; }

    }

}
