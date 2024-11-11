using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd
{
    [Table("Beneficiarios")]
    public class Beneficiario
    {
        [Key]
        public int id_beneficiario { get; set; }

        [ForeignKey("Usuario")]
        public int id_usuario { get; set; }
        public Usuario Usuario { get; set; } // Relación con la tabla Usuarios

        [Required]
        [MaxLength(100)]
        public string nombre_beneficiario { get; set; }

        [MaxLength(50)]
        public string relacion { get; set; }

        [Range(0, 100)]
        public decimal porcentaje_asignado { get; set; }
    }
}
