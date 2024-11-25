using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class usuario
    {
        [Key]
        [RegularExpression(@"^((\d{1,2}|[E|N|PE])-?\d{1,4}-?\d{1,5})$")]
        public string cedula { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id_usuario { get; set; }

        public string contraseña_hash { get; set; }
        public string? nombre { get; set; }
        public string? direccion { get; set; }
        public string rol { get; set; } = "usuario";
        [RegularExpression(@"^6\d{3}-?\d{4}$")]
        public string? contacto { get; set; }

        //[Column(TypeName = "timestamp")]
        [Column(TypeName = "timestamp without time zone")]
        public DateTime fecha_registro { get; set; } = DateTime.Now;

        [RegularExpression("^(1|2|3|0)$")]
        public int? id_plan { get; set; }
        [RegularExpression(@"^[a-zA-Z0-9._%+-]+@gmail\.com$")]
        public string? gmail { get; set; }
    }
}