using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd
{
    [Table("Usuarios")]
    public class Usuario
    {
        [Key]  // Aseguramos que es la clave primaria
        public int id_usuario { get; set; }

        [Required]  // Aseguramos que no puede ser nulo
        [MaxLength(100)]  // Definir una longitud máxima
        public string nombre { get; set; }

        public string direccion { get; set; }

        [MaxLength(50)]  // Asumiendo un límite razonable para el contacto
        public string contacto { get; set; }

        public byte[] datos_financieros { get; set; }

        [Required]
        [MaxLength(20)]  // Limitar la longitud del rol
        public string rol { get; set; }

        [Required]
        public DateTime fecha_registro { get; set; }  // Cambiado a DateTime para que sea más adecuado

        [Required]
        public string contraseña_hash { get; set; }
    }
}
