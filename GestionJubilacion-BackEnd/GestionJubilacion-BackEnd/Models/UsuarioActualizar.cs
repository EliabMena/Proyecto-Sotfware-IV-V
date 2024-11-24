using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class UsuarioActualizar
    {
        [StringLength(50)]
        public string? direccion { get; set; }
        [StringLength(9)]
        public string? contacto { get; set; }
        [StringLength(50)]
        public string? contraseña_hash { get; set; }
        [StringLength(50)]
        public string? gmail { get; set; }
        public int? id_plan { get; set; }

    }
}
