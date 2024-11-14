using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class usuario
    {
        [Key]
        public string cedula { get; set; }
        public string contraseña_hash { get; set; }
    }
}

