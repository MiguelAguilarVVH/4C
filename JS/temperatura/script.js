console.log("funcionando correcto");

function checkTemperatura() {
    let temperatura = 15; 

    if (temperatura < 0) {
        alert("Hace frío");
    } else if (temperatura >= 0 && temperatura <= 25) {
        alert("La temperatura es agradable");
    } else {
        alert("Hace calor");
    }
}

function checkAcceso() {
    let nombreUsuario = "usuario123";
    let contraseña = "secreto";

    if (nombreUsuario === "usuario123" && contraseña === "secreto") {
        alert("Acceso concedido");
    } else {
        alert("Acceso denegado");
    }
}

function checkPuntuacion() {
    let puntuacion = 85; 

    if (puntuacion >= 90) {
        alert("Excelente");
    } else if (puntuacion >= 70 && puntuacion <= 89) {
        alert("Buen trabajo");
    } else {
        alert("Necesitas mejorar");
    }
}