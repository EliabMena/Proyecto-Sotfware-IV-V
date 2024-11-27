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

        const loginData = {
            cedula: cedula,
            id_usuario: 0,
            contraseña_hash: contraseña,
            nombre: "",
            direccion: "",
            rol: "",
            contacto: "",
            fecha_registro: new Date().toISOString(),
            id_plan: 0,
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