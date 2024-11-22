
function verificarContacto(contacto) {
    const regex = /^6\d{3}-\d{4}$/;

    if(!contacto || contacto.trim() === ""){
        return true;
    } else if(regex.test(contacto)){
        return true;
    } else {
        return false;
    }
}


function verificarCorreo(correo) {
    const regex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|outlook\.com|hotmail\.com)$/;

    if(!correo || correo.trim() === ""){
        return true;
    } else if(regex.test(correo)){
        return true;
    } else {
        return false;
    }
}

function verificarContrasena(contrasena) {
    const regex = /^\d{6,}$/;

    if(!contrasena || contrasena.trim() === ""){
        return true;
    } else if(regex.test(contrasena)){
        return true;
    } else {
        return false;
    }
}

function ValidarCedula(cedula) {
    if (!cedula) {
        return false;
    }
    cedula = cedula.toUpperCase();

    const cedulaRegex = /^[0-9E]-\d{2,4}-\d{4}$/;

    if (!cedulaRegex.test(cedula)) {
        return false;
    }

    return true;
}

