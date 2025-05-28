// Ejercicio 1: Registro de Participantes
// Crear un arreglo vacío llamado participantes
let participantes = [];

// Función para agregar participantes
function agregarParticipante() {
    const nombreInput = document.getElementById('nombreInput');
    const nombre = nombreInput.value.trim();
    
    // Verificar si el usuario escribió "salir"
    if (nombre.toLowerCase() === 'salir') {
        finalizarRegistro();
        return;
    }
    
    // Verificar que el nombre no esté vacío
    if (nombre === '') {
        alert('Por favor, ingrese un nombre válido');
        return;
    }
    
    // Agregar el nombre al arreglo con push()
    participantes.push(nombre);
    
    // Mostrar en consola simulada
    agregarLineaConsola(`Nombre agregado: ${nombre}`);
    
    // Actualizar la visualización
    actualizarLista();
    
    // Limpiar el input
    nombreInput.value = '';
    nombreInput.focus();
}

// Función para finalizar el registro
function finalizarRegistro() {
    // Mostrar la cantidad total de participantes
    const total = participantes.length;
    
    // Mostrar los nombres de los participantes
    const lista = participantes.join(', ');
    
    // Mostrar resultados en consola simulada
    agregarLineaConsola('--- REGISTRO FINALIZADO ---');
    agregarLineaConsola(`Total de participantes: ${total}`);
    if (total > 0) {
        agregarLineaConsola(`Lista: ${lista}`);
    }
    
    // Usar if para verificar si hay más de 5 participantes
    if (total > 5) {
        const mensaje = '¡Excelente! Hay más de 5 participantes registrados.';
        agregarLineaConsola(mensaje);
        mostrarMensajeEspecial(mensaje);
    }
    
    // Mostrar también en consola real del navegador
    console.log(`Total de participantes: ${total}`);
    console.log(`Lista: ${lista}`);
    if (total > 5) {
        console.log('¡Excelente! Hay más de 5 participantes registrados.');
    }
}

// Función para actualizar la lista visual
function actualizarLista() {
    const listaDiv = document.getElementById('listaParticipantes');
    const totalDiv = document.getElementById('totalParticipantes');
    
    // Limpiar contenido anterior
    listaDiv.innerHTML = '';
    
    // Mostrar cada participante
    participantes.forEach((participante, index) => {
        const participanteDiv = document.createElement('div');
        participanteDiv.className = 'participante-item';
        participanteDiv.innerHTML = `
            <span>${index + 1}. ${participante}</span>
            <button onclick="eliminarParticipante(${index})" style="background: #e53e3e; padding: 5px 10px; font-size: 12px;">Eliminar</button>
        `;
        listaDiv.appendChild(participanteDiv);
    });
    
    // Mostrar total
    totalDiv.innerHTML = `<div class="total-participantes">Total de participantes: ${participantes.length}</div>`;
}

// Función para eliminar un participante
function eliminarParticipante(index) {
    const participanteEliminado = participantes[index];
    participantes.splice(index, 1);
    agregarLineaConsola(`Participante eliminado: ${participanteEliminado}`);
    actualizarLista();
    
    // Limpiar mensaje especial si ya no hay más de 5 participantes
    if (participantes.length <= 5) {
        document.getElementById('mensajeEspecial').innerHTML = '';
    }
}

// Función para mostrar mensaje especial
function mostrarMensajeEspecial(mensaje) {
    const mensajeDiv = document.getElementById('mensajeEspecial');
    mensajeDiv.innerHTML = `<div class="mensaje-especial">${mensaje}</div>`;
}

// Función para agregar línea a la consola simulada
function agregarLineaConsola(texto) {
    const consolaDiv = document.getElementById('consola');
    const lineaDiv = document.createElement('div');
    lineaDiv.className = 'consola-line';
    lineaDiv.textContent = texto;
    consolaDiv.appendChild(lineaDiv);
    
    // Hacer scroll hacia abajo
    consolaDiv.scrollTop = consolaDiv.scrollHeight;
}

// Función para reiniciar el registro
function reiniciarRegistro() {
    participantes = [];
    document.getElementById('listaParticipantes').innerHTML = '';
    document.getElementById('totalParticipantes').innerHTML = '';
    document.getElementById('mensajeEspecial').innerHTML = '';
    document.getElementById('consola').innerHTML = '';
    document.getElementById('nombreInput').value = '';
    agregarLineaConsola('--- REGISTRO REINICIADO ---');
}

// Event listener para permitir agregar con Enter
document.getElementById('nombreInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        agregarParticipante();
    }
});

// Inicializar
window.onload = function() {
    agregarLineaConsola('--- REGISTRO DE PARTICIPANTES INICIADO ---');
    agregarLineaConsola('Ingrese nombres de participantes o escriba "salir" para finalizar');
    document.getElementById('nombreInput').focus();
};