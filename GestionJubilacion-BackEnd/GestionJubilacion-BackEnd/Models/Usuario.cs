using System;
using System.ComponentModel.DataAnnotations;

namespace GestionJubilacion_BackEnd.Models
{
    public class Usuario
    {
        [Key]
        public string cedula { get; set; }
        public int id_usuario { get; set; }
        public string contraseña_hash { get; set; }
        public string nombre { get; set; }
        public string direccion { get; set; }
        public string rol { get; set; } = "usuario";
        public string contacto { get; set; }
        public DateTime fecha_registro { get; set; } = DateTime.Now;
    }
}
