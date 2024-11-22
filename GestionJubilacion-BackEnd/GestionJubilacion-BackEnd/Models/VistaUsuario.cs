using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionJubilacion_BackEnd.Models
{
    [Keyless]
    [Table("vista_usuario")]
    public class VistaUsuario
    {
        public int id_usuario { get; set; }
        public string nombre { get; set; }
        public string tipo_plan { get; set; }
        public decimal monto_minimo_aportacion { get; set; }
        public float tasa_interes { get; set; }
        public int cuotas_necesarias { get; set; } 
        public decimal saldo_actual { get; set; }
        public int aportaciones_realizadas { get; set; }
        public decimal intereses_acumulados { get; set; }
        public int cuotas_pagadas { get; set; }
        public string gmail { get; set; }
        public string  cedula { get; set; }
        public string direccion { get; set; }


    }
}
