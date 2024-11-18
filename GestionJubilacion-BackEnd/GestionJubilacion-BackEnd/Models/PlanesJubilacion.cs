using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class PlanesJubilacion
    {
        [Key]
        public int id_plan { get; set; } 
        public string tipo_plan { get; set; } 
        public decimal monto_minimo_aportacion { get; set; } 
        public decimal tasa_interes { get; set; } 
        public string descripcion { get; set; } 
        public int cuotas_necesarias { get; set; } 

    }
}
