// Cambiar el texto del botón Login a Logout
function cambiarLogin(boton) {
    if (boton.innerText === "Login") {
        boton.innerText = "Logout";
    } else {
        boton.innerText = "Login";
    }
}

// Ocultar el botón Add Definition cuando se hace clic
function ocultar(boton) {
    boton.remove();
}

// Mostrar notificación amarilla y aumentar el contador cuando se hace clic en un botón de "likes"
function meGusta(boton) {
    // Obtener el span con el número de likes
    const spanLikes = boton.querySelector('span');
    
    // Aumentar el número de likes
    let likesActuales = parseInt(spanLikes.innerText);
    likesActuales++;
    spanLikes.innerText = likesActuales;
    
    // Mostrar la notificación
    const notificacion = document.getElementById('notificacion');
    notificacion.style.display = 'block';
    
    // Ocultar la notificación después de 3 segundos
    setTimeout(function() {
        notificacion.style.display = 'none';
    }, 3000);
}