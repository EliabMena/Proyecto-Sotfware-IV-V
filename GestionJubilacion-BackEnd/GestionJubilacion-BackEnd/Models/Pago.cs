using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class Pago
    {
        [Key]
        public int id_pago { get; set; }
        [ForeignKey("usuarios")]
        public int id_usuario { get; set; }
        public DateTime fecha_pago { get; set; } = DateTime.Now;
        [Required]
        public decimal monto { get; set; }
        [Required]
        [StringLength(50)]
        public string metodo_pago { get; set; }
        [Required]
        [StringLength(15)]
        public string estado { get; set; } = "pendiente"; // Valor por defecto
    }

}
