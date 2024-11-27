const container = document.querySelector(".container");
const btnSesion = document.getElementById("btn-sesion");
const btnRegistro = document.getElementById("btn-registro");

btnSesion.addEventListener("click", ()=> {
   container.classList.remove("toggle");
});

btnRegistro.addEventListener("click", ()=> {
    container.classList.add("toggle");
});