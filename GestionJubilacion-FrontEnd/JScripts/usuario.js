
//INICIO DE SESION
document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnEnviarActualizacion").addEventListener("click", async (e) => {
        e.preventDefault(); // Prevenir el comportamiento por defecto del formulario

        // Obtener valores de los campos
        const cedula = document.getElementById("usuarioCedula").value.trim();
        const contraseña = document.getElementById("contraseñaUsuario").value.trim();

        // Validar campos
        if (!cedula || !contraseña) {
            alert("Por favor, complete todos los campos.");
            return;}
       //  else if(!ValidarCedula(cedula)){
        //    alert("Cedula no valida")
        //    return;
       // }

        // Crear el payload en formato JSON con todos los campos requeridos por la API
        const loginData = {
            cedula: cedula,
            id_usuario: 0, // Puedes ajustar este valor según el comportamiento de la API
            contraseña_hash: contraseña,
            nombre: "", // Puedes agregar datos reales si los tienes
            direccion: "",
            rol: "",
            contacto: "",
            fecha_registro: new Date().toISOString(), // Generar la fecha actual
            id_plan: 0, // Puedes ajustar según el contexto
            gmail: ""
        };

        let usuarioId = parseInt(null);

        try {
            // Llamar a la API
            const response = await fetch("http://localhost:5235/api/Login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(loginData)
            });

            // Verificar si la respuesta es JSON
            let responseData;
            try {
                responseData = await response.json(); // Intentar leer la respuesta como JSON
            } catch (error) {
                // Si la respuesta no es un JSON válido, leerla como texto
                responseData = await response.text();
            }

            if (response.ok) {
                usuarioId = responseData.id_usuario; // Asignar el ID recibido
                localStorage.setItem('usuarioId', usuarioId);//GUARDAMOS EL ID EN LA MEMORIA LOCAL DEL CLIENTE
                window.location.href = "../Vistas/usuario2.html";

            } else if (response.status === 401) {
                alert(responseData || "Usuario o contraseña incorrectos.");
            } else {
                alert(responseData || "Usuario o contraseña incorrectos.");
            }
        } catch (error) {
            console.error("Error en la solicitud:", error);
            alert("No se pudo conectar con el servidor.");
        }
    });
});


//CARGAR DATOS DEL USUARIO
async function loadUserData() {
    try {
        let usuarioId = localStorage.getItem('usuarioId');
        const response = await fetch(`http://localhost:5235/api/VistaUsuario/${usuarioId}`);

        const data = await response.json();

        // Verificar si los datos existen
        if (!data || !data.usuario) {
            console.error("Datos recibidos:", data); // Depuración
            throw new Error("Datos del usuario no encontrados en la respuesta.");
        }

        // Usuario
        const usuario = data.usuario;
        document.getElementById("nombreUsuario").textContent = usuario.nombre;
        document.getElementById("nombrePlan").textContent = usuario.tipo_plan;
        document.getElementById("saldoActual").textContent = `$${usuario.saldo_actual}`;
        document.getElementById("tasaInteres").textContent = `${usuario.tasa_interes}%`;
        document.getElementById("cuotasTotales").textContent = usuario.cuotas_necesarias;
        document.getElementById("cuotasPagadas").textContent = usuario.cuotas_pagadas;
        document.getElementById("cuotasFaltantes").textContent = usuario.cuotas_necesarias - usuario.cuotas_pagadas;
        document.getElementById("gmailUsuario").textContent = usuario.gmail;
        document.getElementById("direccionUsuario").textContent = usuario.direccion;

        // Beneficiarios
        const beneficiariosContainer = document.getElementById("beneficiariosList");
        beneficiariosContainer.innerHTML = "";
        //beneficiarios válidos
        const validBeneficiarios = data.beneficiarios.filter(beneficiario => beneficiario.nombre_beneficiario && beneficiario.cedula_beneficiario);

        if (validBeneficiarios.length > 0) {
            validBeneficiarios.forEach((beneficiario) => {
                const item = document.createElement("div");
                item.classList.add("beneficiario");

                // Contenido del beneficiario
                item.innerHTML = `
                    <p><strong>Nombre:</strong> ${beneficiario.nombre_beneficiario}</p>
                    <p><strong>Relación:</strong> ${beneficiario.relacion}</p>
                    <p><strong>Porcentaje Asignado:</strong> ${beneficiario.porcentaje_asignado}%</p>
                    <div class="beneficiario-buttons">
                        <button class="update-btn" onclick="updateBeneficiario(${beneficiario.id_usuario}, '${beneficiario.nombre_beneficiario}')">Actualizar Beneficiario</button>
                        <button class="delete-btn" onclick="removerBeneficiario(${beneficiario.id_usuario}, '${beneficiario.nombre_beneficiario}')">Eliminar Beneficiario</button>
                    </div>
                `;
                beneficiariosContainer.appendChild(item);

            });

            //Guardar Los beneficiarios
            localStorage.setItem('beneficiarios', JSON.stringify(validBeneficiarios));

        } else {
            // Mostrar mensaje de "No tiene beneficiarios"
            const mensaje = document.createElement("p");
            mensaje.textContent = "Este usuario no cuenta con beneficiarios.";
            beneficiariosContainer.appendChild(mensaje);
        }

            // Mostrar botón para agregar nuevo beneficiario
            const botonAgregar = document.createElement("button");
            botonAgregar.textContent = "Agregar Nuevo Beneficiario";
            botonAgregar.classList.add("btn-agregar-beneficiario");
            botonAgregar.addEventListener("click", agregarBeneficiario); // Llamar función para agregar beneficiario
            beneficiariosContainer.appendChild(botonAgregar);


    } catch (error) {
        console.error("Error al cargar los datos del usuario:", error.message);
        document.getElementById("nombreUsuario").textContent = "Error al cargar datos";
    }
}

//ACTUALIZAR USUARIO
document.getElementById("btnEnviarActualizacion").addEventListener("click", async () => {

    //Obtener el Id
    let usuarioId = localStorage.getItem('usuarioId');
    // Obtener los valores del formulario
    const direccion = document.getElementById("direccion").value;
    const contacto = document.getElementById("contacto").value;
    const contraseña_hash = document.getElementById("contraseña").value;
    const gmail = document.getElementById("correo").value;

    if(!verificarContacto(contacto)){
        alert("El número de contacto no es válido. Debe comenzar con '6' y seguir el formato '6000-0000'.");
        return;
    } else if(!verificarCorreo(gmail)){
        alert("El correo electrónico no es válido. Solo se permiten dominios: gmail.com, outlook.com, hotmail.com.");
        return;
    } else if(!verificarContrasena(contraseña_hash)){
        alert("La contraseña debe tener almenos 6 digitos");
        return;
    }

    // Crear el cuerpo del JSON
    const userData = {
        direccion: direccion.trim(),
        contacto: contacto.trim(),
        contraseña_hash: contraseña_hash.trim(),
        gmail: gmail.trim()
    };

    console.log("Enviando datos:", userData); // Depuración

    //CONSTRUIMOS LA URL
    const url = `http://localhost:5235/api/Registro/actualizar?id_usuario=${usuarioId}`;


    try {
        const response = await fetch(url, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(userData)
        });

        if (!response.ok) {
            // Manejar errores de respuesta
            const errorText = await response.text();
            throw new Error(`Error al actualizar los datos: ${errorText}`);
        }

        // Procesar respuesta
        const result = await response.json();
        alert("Datos actualizados con éxito.");
        console.log("Respuesta de la API:", result);

        document.getElementById("direccionUsuario").textContent = userData.direccion;
        document.getElementById("gmailUsuario").textContent = userData.gmail;

    } catch (error) {
        console.error("Error al enviar datos a la API:", error);
        alert("Hubo un error al intentar actualizar los datos. Por favor, intenta nuevamente.");
    }
    //ACTUALIZAMOS LOS DATOS DEL USUARIO EN PANTALLA
    await loadUserData();
});

//ELIMINAR BENEFICIARIO
async function removerBeneficiario(idUsuario, nombreBeneficiario) {
    if (!confirm(`¿Estás seguro de que deseas eliminar al beneficiario "${nombreBeneficiario}"?`)) {
        return; //CANCELAR
    }

    try {
        const response = await fetch(`http://localhost:5235/api/Beneficiarios?id_usuario=${idUsuario}&nombre_beneficiario=${encodeURIComponent(nombreBeneficiario)}`, {
            method: "DELETE",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                id_usuario: idUsuario,
                nombre_beneficiario: nombreBeneficiario,
            }),
        });

        if (response.ok) {
            alert("Beneficiario eliminado correctamente.");
            // Recargar los datos después de eliminar
            await loadUserData();
        } else {
            const error = await response.text();
            alert(`Error al eliminar el beneficiario: ${error}`);
        }
    } catch (error) {
        console.error("Error al eliminar beneficiario:", error);
        alert("Ocurrió un error al eliminar el beneficiario. Por favor, inténtalo de nuevo.");
    }
}

//AÑADIR NUEVO BENEFICIARIO
document.getElementById("btnEnviarBeneficiario").addEventListener("click", async () => {
    let usuarioId = localStorage.getItem('usuarioId');
    const nombre = document.getElementById("nombreBeneficiario").value.trim();
    const relacion = document.getElementById("relacionBeneficiario").value.trim();
    const porcentaje = parseInt(document.getElementById("porcentajeBeneficiario").value);
    const cedula = document.getElementById("cedulaBeneficiario").value.trim();

    if (!nombre || !relacion || !porcentaje || !cedula) {
        alert("Todos los campos son obligatorios.");
        return;
    }

    const nuevoBeneficiario = {
        id_usuario: usuarioId,
        nombre_beneficiario: nombre,
        relacion: relacion,
        porcentaje_asignado: porcentaje,
        cedula_beneficiario: cedula
    };

    try {
        const response = await fetch("http://localhost:5235/api/Beneficiarios", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(nuevoBeneficiario)
        });

        if (response.ok) {
            alert("Beneficiario agregado con éxito.");
            document.getElementById("panelAgregarBeneficiario").style.display = "none";
            loadUserData(); // Recargar datos del usuario
        } else {
            const error = await response.text();
            alert(`Error: ${error}`);
        }
    } catch (error) {
        console.error("Error al agregar beneficiario:", error);
        alert("Ocurrió un error al agregar el beneficiario.");
    }
});

//ACTUALIZAR BENEFICIARIO
document.getElementById("btnActualizarBeneficiario").onclick = async function () {
    let idUsuario = parseInt(localStorage.getItem('usuarioId'));
    let beneficiarios = JSON.parse(localStorage.getItem('beneficiarios'));
    const nuevaRelacion = document.getElementById("ActualizarRelacionBeneficiario").value;
    const nuevoPorcentaje = document.getElementById("ActualizarporcentajeBeneficiario").value;

    // Validar los datos del formulario
    /*if (nuevoPorcentaje <= 0 && nuevoPorcentaje >= 100) {
        alert("El porcentaje tiene que ser mayor a 0 pero menor a 100");
        return;
    }*/

    // Crear el objeto JSON para enviar a la API
    const datosActualizados = {
        relacion: nuevaRelacion,
        porcentaje_asignado: parseInt(nuevoPorcentaje)
    };
    console.log("Enviando datos:", nuevaRelacion, nuevoPorcentaje); // Depuración
    try {
        // Realizar la solicitud PATCH para actualizar los datos
        const response = await fetch(`http://localhost:5235/api/Beneficiarios?id_usuario=${idUsuario}&nombre_beneficiario=${encodeURIComponent(beneficiarios)}`, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(datosActualizados)
        });

        if (response.ok) {
            alert("Beneficiario actualizado con éxito.");
            document.getElementById("panelActualizarBeneficiario").style.display = "none"; // Cerrar panel
            loadUserData(); // Recargar lista de beneficiarios para reflejar los cambios
        } else {
            const errorMsg = await response.text();
            alert(`Error al actualizar: ${errorMsg}`);
        }
    } catch (error) {
        console.error("Error al actualizar beneficiario:", error);
        alert("Hubo un problema al intentar actualizar el beneficiario.");
    }
};


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// OBTEBNER EL NUMERO DEL PLAN.
document.querySelectorAll(".plan-button").forEach(button => {
    button.addEventListener("click", function() {
        // Cuando se hace clic en un botón, almacenamos el id del plan seleccionado
        selectedPlan = button.getAttribute("data-plan");
    });
});

//ACTUALIZAR PLAN
document.getElementById("enviarActualizacionPlan").addEventListener("click", async function() {
    // Verificar si se ha seleccionado un plan
    if (!selectedPlan) {
        alert("Por favor, selecciona un plan antes de enviar.");
        return;
    }

    // Hacer la solicitud PATCH a la API con el plan seleccionado
    const response = await fetch('http://localhost:5235/api/Registro/actualizar?id_usuario=1', {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id_plan: parseInt(selectedPlan, 10) // Convertir a número
        })
    });

    // Manejo de la respuesta
    if (response.ok) {
        alert("Plan actualizado correctamente");
        document.getElementById("panelActualizarPlan").style.display = "none";
    } else {
        const errorMessage = await response.text();
        alert("Error al actualizar el plan: " + errorMessage);
    }
});


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//EVENTOS PARA MOSTRAR LOS PANELES DE ACTUALIZACION......
    //PANLE DE USUARIO....
    document.getElementById("btnActualizarDatos").addEventListener("click", function() {
        document.getElementById("panelActualizarDatos").style.display = "flex";
    });
    document.getElementById("cerrarPanel").addEventListener("click", function() {
        document.getElementById("panelActualizarDatos").style.display = "none";
    });
    window.addEventListener("click", function(event) {
        const panel = document.getElementById("panelActualizarDatos");
        if (event.target === panel) {
            panel.style.display = "none";
        }
    });

    //PANEL PARA ACTUALIZAR EL PLAN....
    document.getElementById("btnCambiarPlan").addEventListener("click", function() {
        document.getElementById("panelActualizarPlan").style.display = "flex";
    });
    document.getElementById("cerrarPanel").addEventListener("click", function() {
        document.getElementById("panelActualizarPlan").style.display = "none";
    });
    window.addEventListener("click", function(event) {
        const panel = document.getElementById("panelActualizarPlan");
        if (event.target === panel) {
            panel.style.display = "none";
        }
    });

    //Paneles para actualizar y agregar beneficiarios
    function agregarBeneficiario() {
    const panel = document.getElementById("panelAgregarBeneficiario");
    panel.style.display = "flex";

    // Cerrar el panel al hacer clic en el botón "cerrar"
    const cerrar = document.getElementById("cerrarPanelAgregar");
    cerrar.addEventListener("click", () => {
        panel.style.display = "none";
    });
}
    function updateBeneficiario() {
    const panel = document.getElementById("panelActualizarBeneficiario");
    panel.style.display = "flex";
    document.getElementById("cerrarPanelActualizarBeneficiario").onclick = function () {
        panel.style.display = "none";
    };
    document.getElementById(ActualizarRelacionBeneficiario)
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//EVENTO DESPLEGAR EN ACTUALIZAR PLAN
    const planButtons = document.querySelectorAll(".plan-button");
    planButtons.forEach(button => {
        button.addEventListener("click", function() {
            const planDetails = this.nextElementSibling;
            const allDetails = document.querySelectorAll(".plan-details");

            // Cerrar todos los detalles antes de abrir el seleccionado
            allDetails.forEach(detail => {
                if (detail !== planDetails) {
                    detail.style.display = "none";
                }
            });

            // Alternar visibilidad del detalle correspondiente
            planDetails.style.display = planDetails.style.display === "block" ? "none" : "block";
        });
    });

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Llamar a la función al cargar la página
document.addEventListener("DOMContentLoaded", loadUserData);

