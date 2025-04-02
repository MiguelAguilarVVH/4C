console.log("Vinculado correctamente...")

// Verificación de Acceso con Condiciones Múltiples
function condiciones() {
    let edad = parseInt(prompt("¿Cuál es tu edad?"));
    let terminos = confirm("¿Aceptas los términos y condiciones?");
    if (edad >= 18 && terminos == true) {
        alert("Acceso permitido.");
    } else {
        alert("Acceso denegado.");
    }
}

// Elegibilidad para un Descuento
function descuento() {
    let edad = parseInt(prompt("¿Cuál es tu edad?"));
    let esEstudiante = confirm("¿Eres estudiante?");
    if (edad >= 60 || esEstudiante == true) {
        alert("Descuento aplicado.");
    } else {
        alert("No tienes descuento.");
    }
}

// Validación de Usuario y Contraseña con NOT
function verificarUsuario() {
    let usuario = prompt("Usuario:");
    let contraseña = prompt("Contraseña:");
    if (!(usuario == "usuario123"  && contraseña == "secreto")) {
        alert("Error: Debes ingresar usuario y contraseña.");
    } else {
        alert("Inicio de sesión exitoso.");
    }
}

// Encendido de una Máquina con Condiciones Lógicas
function encendidoMaquina() {
    let energiaSuficiente = confirm("¿La máquina tiene suficiente energía?");
    let interruptorEncendido = confirm("¿El interruptor está activado?");
    if (energiaSuficiente == true && interruptorEncendido == true) {
        alert("Máquina encendida.");
    } else {
        alert("No se puede encender la máquina.");
    }
}

// Acceso Restringido por Estado de Seguridad
function accesoRestringido() {
    let bloqueado = confirm("¿La zona restringida está bloqueada?");
    let tieneCredenciales = confirm("¿Tienes credenciales válidas?");
    if (!(bloqueado == false || tieneCredenciales == true)) {
        alert("Acceso denegado.");
    } else {
        alert("Acceso permitido.")
    }
}