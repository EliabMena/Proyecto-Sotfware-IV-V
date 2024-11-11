using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd
{
    [Table("Pagos")]
    public class Pago
    {
        [Key]
        public int id_pago { get; set; }

        [ForeignKey("Usuario")]
        public int id_usuario { get; set; }
        public Usuario Usuario { get; set; } // Relación con la tabla Usuarios

        [Required]
        public DateTime fecha_pago { get; set; }

        [Required]
        [Column(TypeName = "numeric(10,2)")] // Aseguramos el tipo NUMERIC(10, 2)
        public decimal monto { get; set; }

        [MaxLength(50)]
        public string metodo_pago { get; set; }

        [Required]
        [MaxLength(20)]
        public string estado { get; set; } // 'completado' o 'pendiente'
    }
}
