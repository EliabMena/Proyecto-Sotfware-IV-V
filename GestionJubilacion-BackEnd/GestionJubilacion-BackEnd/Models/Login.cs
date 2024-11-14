using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class usuario
    {
        [Key]
        public string cedula { get; set; }
        public string contraseña_hash { get; set; }
        public string nombre { get; set; }
        public string direccion { get; set; }
        public string rol {  get; set; }
        public string contacto { get; set; }
        public DateTime fecha_registro { get; set; } 
    }
}

