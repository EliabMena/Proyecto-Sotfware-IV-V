using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd
{
    [Table("Estados_de_Cuenta")]
    public class EstadoDeCuenta
    {
        [Key]
        public int id_estado { get; set; }

        [ForeignKey("Usuario")]
        public int id_usuario { get; set; }
        public Usuario Usuario { get; set; } // Relación con la tabla Usuarios

        [Column(TypeName = "numeric(12,2)")] // Aseguramos el tipo NUMERIC(12, 2)
        public decimal saldo_actual { get; set; } = 0;

        [Column(TypeName = "numeric(12,2)")] // Aseguramos el tipo NUMERIC(12, 2)
        public decimal aportaciones_realizadas { get; set; } = 0;

        [Column(TypeName = "numeric(12,2)")] // Aseguramos el tipo NUMERIC(12, 2)
        public decimal intereses_acumulados { get; set; } = 0;

        public DateTime ultima_actualizacion { get; set; } = DateTime.Now;
    }
}
