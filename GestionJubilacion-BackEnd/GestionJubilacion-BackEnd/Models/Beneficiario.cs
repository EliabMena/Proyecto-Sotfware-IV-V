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

        public string nombre_beneficiario { get; set; }

        public string relacion { get; set; }

        public decimal porcentaje_asignado { get; set; }

        public string cedula_beneficiario { get; set; }

    }
}
