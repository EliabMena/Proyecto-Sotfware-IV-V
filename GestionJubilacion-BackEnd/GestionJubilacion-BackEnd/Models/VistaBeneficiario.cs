using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    [Keyless]
    [Table("vista_beneficiarios")]
    public class VistaBeneficiario
    {
        public int id_usuario { get; set; }
        public string? cedula_beneficiario { get; set; }
        public string? nombre_beneficiario { get; set; }
        public string? relacion { get; set; }
        public float? porcentaje_asignado { get; set; }
    }
}
