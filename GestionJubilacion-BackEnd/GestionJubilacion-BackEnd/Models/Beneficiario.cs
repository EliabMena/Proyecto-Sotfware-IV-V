using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    public class beneficiario
    {
        [Key]
        public int id_beneficiario { get; set; }
        
        [ForeignKey("usuarios")]
        //puse cedula porque creo que es mejor usar la cedula que el id
        //ademas de que cuando busco el el id para verificar que exista el modelo
        // tiene cedula como string y llave primaria,pero el modelo de beneficiario
        //tiene la foreing key como id y no puedo hacer la igualdad para comprobar que exista
        
        public string cedula { get; set; }

        public string nombre_beneficiario { get; set; }

        public string relacion { get; set; }

        public decimal porcentaje_asignado { get; set; }

    }
}
