using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace GestionJubilacion_BackEnd
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<PlanDeJubilacion> PlanesDeJubilacion { get; set; }
        public DbSet<Beneficiario> Beneficiarios { get; set; }
        public DbSet<Pago> Pagos { get; set; }
        public DbSet<EstadoDeCuenta> EstadosDeCuenta { get; set; }
    }
}