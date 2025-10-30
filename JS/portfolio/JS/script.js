// Animación de habilidades al cargar la página
window.addEventListener('DOMContentLoaded', () => {
    const fills = document.querySelectorAll('.skill-fill');
    fills.forEach(fill => {
        const width = fill.style.width;
        fill.style.width = '0';
        setTimeout(() => {
            fill.style.width = width;
        }, 100);
    });
});

// Scroll al formulario de contacto
function scrollToContacto() {
    const contacto = document.getElementById('contacto');
    contacto.scrollIntoView({ behavior: 'smooth' });
}

// Validación simple del formulario
document.getElementById('contactForm').addEventListener('submit', function(e){
    e.preventDefault();
    alert('¡Mensaje enviado correctamente!');
    this.reset();
});
