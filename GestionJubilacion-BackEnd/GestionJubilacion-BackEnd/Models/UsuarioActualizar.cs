using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class UsuarioActualizar
    {
        [StringLength(50)]
        public string? direccion { get; set; }
        [RegularExpression(@"^6\d{3}-?\d{4}$")]
        public string? contacto { get; set; }
        [StringLength(50)]
        public string? contraseña_hash { get; set; }

        [RegularExpression(@"^[a-zA-Z0-9._%+-]+@gmail\.com$")]
        public string? gmail { get; set; }
        [RegularExpression("^(1|2|3)$")]
        public int? id_plan { get; set; }

    }
}
