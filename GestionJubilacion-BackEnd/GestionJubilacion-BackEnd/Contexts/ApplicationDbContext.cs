using GestionJubilacion_BackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd.Contexts
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<usuario> usuarios { get; set; }
        public DbSet<Beneficiario> beneficiarios { get; set; }
        public DbSet<VistaUsuario> VistaUsuario { get; set; }
        public DbSet<VistaBeneficiario> VistaBeneficiarios { get; set; }
        public DbSet<PlanesJubilacion> planes_de_jubilacion { get; set; }
        public DbSet<Pago> pagos { get; set; }
    }

}
