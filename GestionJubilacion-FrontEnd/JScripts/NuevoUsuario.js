document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('registroForm');
    if (form) {
        form.addEventListener('submit', registrarUsuario);
    }
});

async function registrarUsuario(event) {
    // Evitar recarga automática
    event.preventDefault();

    // Captura los datos del formulario
    const nombre = document.getElementById('regNombre').value;
    const cedula = document.getElementById('regCedula').value;
    const correo = document.getElementById('regCorreo').value;
    const contraseña = document.getElementById('regContraseña').value;
    const direccion = document.getElementById('regDireccion').value;
    const contacto = document.getElementById('regContacto').value;
    const idPlan = document.getElementById('regOpciones').value;

    // Crear el objeto del nuevo usuario
    const nuevoUsuario = {
        cedula,
        nombre,
        gmail: correo,
        contraseña_hash: contraseña, //SHA256
        direccion,
        contacto,
        id_plan: idPlan ? parseInt(idPlan.replace('opcion', '')) : null,
    };

    try {
        // Realizar el fetch
        const response = await fetch('http://localhost:5235/api/Registro', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(nuevoUsuario),
        });

        // Manejo de la respuesta
        if (response.ok) {
            const data = await response.json();

            if (data.id_usuario) {
                localStorage.setItem('usuarioId', data.id_usuario);
                console.log("ID de usuario guardado en localStorage:", data.id_usuario);
                alert(`ID de usuario guardado: ${data.id_usuario}`);
            }

            alert(data.message || 'Usuario registrado exitosamente.');

            // Recuperar el ID del usuario desde localStorage
            const usuarioId = localStorage.getItem('usuarioId');
            console.log("ID de usuario recuperado:", usuarioId);
            window.location.href = "../Vistas/usuario2.html";
        } else if (response.status === 400) {
            const error = await response.text();
            alert('Error: ' + error);
        } else if (response.status === 409) {
            alert('Error: El usuario ya existe.');
        } else {
            alert('Error desconocido. Intenta nuevamente.');
        }
    } catch (error) {
        alert('Error al conectarse con la API: ' + error.message);
    }
}
