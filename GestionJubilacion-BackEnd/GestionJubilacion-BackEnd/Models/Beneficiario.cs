using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class Beneficiario
    {
        [Key]
        public int id_beneficiario { get; set; }

        [ForeignKey("usuarios")]
        public int id_usuario { get; set; }
        [Required]
        [StringLength(50)]
        public string nombre_beneficiario { get; set; }
        [Required]
        [StringLength(50)]
        public string relacion { get; set; }
        [Range(0, 90)]
        public decimal porcentaje_asignado { get; set; }
        [Required]
        public string cedula_beneficiario { get; set; }

    }
}
