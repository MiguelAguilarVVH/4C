// Contadores de likes para cada usuario
let contadoresLikes = {
    neil: 9,      // Contador inicial para Neil M
    nichole: 12,  // Contador inicial para Nichole K  
    jim: 9        // Contador inicial para Jim R
};

// Función principal para aumentar likes
function aumentarLikes(nombreUsuario) {
    // Aumentar el contador en 1
    contadoresLikes[nombreUsuario]++;
    
    // Actualizar el número en la pantalla
    document.getElementById('likes-' + nombreUsuario).textContent = contadoresLikes[nombreUsuario];
}

// Función opcional para mostrar el total de likes (puedes usarla si quieres)
function mostrarTotalLikes() {
    let total = contadoresLikes.neil + contadoresLikes.nichole + contadoresLikes.jim;
    console.log('Total de likes en toda la red: ' + total);
    return total;
}

// Función opcional para resetear likes de un usuario específico
function resetearLikes(nombreUsuario) {
    contadoresLikes[nombreUsuario] = 0;
    document.getElementById('likes-' + nombreUsuario).textContent = 0;
}