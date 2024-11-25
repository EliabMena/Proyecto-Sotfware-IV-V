using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class BeneficiarioActualizar
    {
        public string? nombre_beneficiario { get; set; }
        public string? relacion { get; set; }
        [Range(0, 90)]
        public decimal? porcentaje_asignado { get; set; }
        public string? cedula_beneficiario { get; set; }
    }
}
