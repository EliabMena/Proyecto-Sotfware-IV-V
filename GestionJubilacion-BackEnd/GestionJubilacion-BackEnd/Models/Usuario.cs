using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class usuario
    {
        [Key]
        public string cedula { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id_usuario { get; set; }

        public string contraseña_hash { get; set; }
        public string? nombre { get; set; }
        public string? direccion { get; set; }
        public string rol { get; set; } = "usuario";
        public string? contacto { get; set; }

        //[Column(TypeName = "timestamp")]
        [Column(TypeName = "timestamp without time zone")]
        public DateTime fecha_registro { get; set; } = DateTime.Now;

        public int id_plan { get; set; }
        public string? gmail { get; set; }
    }
}