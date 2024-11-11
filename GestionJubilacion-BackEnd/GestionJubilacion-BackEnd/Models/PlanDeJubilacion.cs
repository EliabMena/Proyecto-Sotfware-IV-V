using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd
{
    [Table("Planes_de_Jubilacion")]
    public class PlanDeJubilacion
    {
        [Key]
        public int id_plan { get; set; }

        [Required]
        [MaxLength(50)]
        public string tipo_plan { get; set; }

        [Required]
        [Column(TypeName = "numeric(10,2)")] // Aseguramos el tipo NUMERIC(10, 2)
        public decimal monto_minimo_aportacion { get; set; }

        [Required]
        [Column(TypeName = "numeric(5,2)")] // Aseguramos el tipo NUMERIC(5, 2)
        public decimal tasa_interes { get; set; }

        public string descripcion { get; set; }
    }
}
