// Selección de elementos del slider
const slides = document.querySelectorAll(".slide");
const navBtns = document.querySelectorAll(".nav-btn");

let currentIndex = 0;

// Función para mostrar el slide actual
function showSlide(index) {
  // Ocultar todos los slides
  slides.forEach((slide, i) => {
    slide.classList.remove("active");
    slide.style.zIndex = i === index ? 1 : 0; // Asegura que el slide activo esté en el frente
  });

  // Actualizar los botones de navegación
  navBtns.forEach((btn, i) => {
    btn.classList.toggle("active", i === index);
  });

  // Mostrar el slide correspondiente
  slides[index].classList.add("active");
}

// Event listeners para la navegación manual
navBtns.forEach((btn, i) => {
  btn.addEventListener("click", () => {
    currentIndex = i;
    showSlide(currentIndex);
  });
});

// Navegación automática cada 5 segundos
setInterval(() => {
  currentIndex = (currentIndex + 1) % slides.length; // Ciclar el índice
  showSlide(currentIndex);
}, 5000);
// Mostrar el primer slide al cargar la página
showSlide(currentIndex);

// Modal, para una ventanita bien épica
// Datos de los planes
const plansInfo = {
  economico: {
    title: "Plan Económico",
    description: `
        Este plan está diseñado para aquellos que buscan comenzar a planificar su jubilación con un presupuesto ajustado. 
        Es ideal para quienes recién inician su vida laboral o tienen otras prioridades financieras.
        <br><br>
        <strong>Características principales:</strong>
        <ul>
          <li>Aportes mensuales bajos.</li>
          <li>Acceso básico a asesoría financiera.</li>
          <li>Rentabilidad moderada.</li>
          <li>Cobertura limitada a necesidades esenciales de retiro.</li>
        </ul>
        <br>
        <strong>Ventajas:</strong>
        <ul>
          <li>Fácil de mantener.</li>
          <li>Flexibilidad para incrementar aportes en el futuro.</li>
          <li>Sin penalizaciones por retiros anticipados.</li>
          <li>Puedes agregar beneficiarios.</li>
        </ul>
      `,
  },
  basico: {
    title: "Plan Básico",
    description: `
        Perfecto para quienes desean equilibrar sus aportes y beneficios, este plan ofrece una sólida base para asegurar un retiro tranquilo.
        Combina rentabilidad y accesibilidad.
        <br><br>
        <strong>Características principales:</strong>
        <ul>
          <li>Aportes mensuales moderados.</li>
          <li>Acceso a asesoría personalizada una vez al trimestre.</li>
          <li>Rentabilidad superior al promedio del mercado.</li>
          <li>Posibilidad de transferir beneficios a familiares cercanos.</li>
        </ul>
        <br>
        <strong>Ventajas:</strong>
        <ul>
          <li>Excelente relación costo-beneficio.</li>
          <li>Flexibilidad para personalizar los aportes según tus metas.</li>
          <li>Beneficios fiscales atractivos en muchos casos.</li>
          <li>Posibilidad de transferir beneficios a familiares cercanos.</li>
        </ul>
      `,
  },
  premium: {
    title: "Plan Premium",
    description: `
        Diseñado para quienes buscan maximizar sus beneficios de jubilación, este plan garantiza un retiro sin preocupaciones y con comodidades.
        Es ideal para quienes están cerca de la jubilación o buscan opciones de inversión de alto rendimiento.
        <br><br>
        <strong>Características principales:</strong>
        <ul>
          <li>Aportes mensuales altos.</li>
          <li>Acceso ilimitado a asesoría financiera personalizada.</li>
          <li>Rentabilidad superior con opciones de inversión diversificadas.</li>
          <li>Cobertura médica y servicios exclusivos en la jubilación.</li>
        </ul>
        <br>
        <strong>Ventajas:</strong>
        <ul>
          <li>Beneficios exclusivos (viajes, eventos, y más).</li>
          <li>Acceso a planes de sucesión y herencia.</li>
          <li>Posibilidad de transferir beneficios a familiares cercanos.</li>
        </ul>
      `,
  },
};

const modal = document.getElementById("modal");
const modalTitle = document.getElementById("modal-title");
const modalDescription = document.getElementById("modal-description");
const closeBtn = document.querySelector(".close");

// Abrir el modal
document.querySelectorAll(".boton").forEach((button) => {
  button.addEventListener("click", () => {
    const planId = button.closest(".plan").id; // Obtiene el ID del plan (economico, basico, premium)
    modalTitle.innerHTML = plansInfo[planId].title; // Inserta el título
    modalDescription.innerHTML = plansInfo[planId].description; // Inserta la descripción (admite HTML)
    modal.style.display = "flex"; // Mostrar modal
  });
});

// Cerrar el modal al hacer clic en la X
closeBtn.addEventListener("click", () => {
  modal.style.display = "none"; // Ocultar modal
});

// Cerrar modal al hacer clic fuera del contenido
window.addEventListener("click", (event) => {
  if (event.target === modal) {
    modal.style.display = "none"; // Ocultar modal
  }
});
