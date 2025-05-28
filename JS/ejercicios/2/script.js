// Ejercicio 2: Simulador de Caja Registradora
// Crear un arreglo con algunos productos iniciales
let productos = ["manzana", "pan", "leche"];
let ventasRealizadas = [];
let contadorVentas = 0;

// Función para actualizar la visualización del inventario
function actualizarInventario() {
    const listaDiv = document.getElementById('listaProductos');
    const estadoDiv = document.getElementById('estadoInventario');
    
    // Limpiar contenido anterior
    listaDiv.innerHTML = '';
    
    if (productos.length === 0) {
        estadoDiv.innerHTML = '<div class="sin-stock"> SIN STOCK - No hay productos disponibles</div>';
        document.getElementById('btnVender').disabled = true;
        document.getElementById('btnVender5').disabled = true;
    } else {
        estadoDiv.innerHTML = `<div style="background: #e6fffa; padding: 10px; border-radius: 6px; text-align: center; font-weight: 600;">📦 Productos disponibles: ${productos.length}</div>`;
        document.getElementById('btnVender').disabled = false;
        document.getElementById('btnVender5').disabled = false;
        
        // Mostrar cada producto (el último será el próximo en venderse)
        productos.forEach((producto, index) => {
            const productoDiv = document.createElement('div');
            productoDiv.className = 'producto-item';
            const esProximo = index === productos.length - 1;
            productoDiv.innerHTML = `
                <span>${index + 1}. ${producto} ${esProximo ? '← Próximo a vender' : ''}</span>
                <span style="font-size: 12px; color: #666;">${esProximo ? '(último en cola)' : ''}</span>
            `;
            if (esProximo) {
                productoDiv.style.borderLeftColor = '#f56565';
                productoDiv.style.background = '#fff5f5';
            }
            listaDiv.appendChild(productoDiv);
        });
    }
}

// Función para simular una venta individual
function simularVenta() {
    // Usar if para verificar si el arreglo está vacío antes de usar pop()
    if (productos.length === 0) {
        const mensaje = 'Sin stock';
        agregarLineaConsola(mensaje, 'consola-error');
        console.log(mensaje);
        return;
    }
    
    // Usar pop() para "vender" el último producto
    const productoVendido = productos.pop();
    contadorVentas++;
    
    // Agregar a las ventas realizadas
    ventasRealizadas.push({
        numero: contadorVentas,
        producto: productoVendido,
        hora: new Date().toLocaleTimeString()
    });
    
    // Mostrar cuál producto fue vendido
    const mensaje = `Producto vendido: ${productoVendido}`;
    agregarLineaConsola(mensaje, 'consola-venta');
    console.log(mensaje);
    
    // Actualizar visualización
    actualizarInventario();
    actualizarResumenVentas();
}

// Función para simular 5 ventas usando un bucle for
function simular5Ventas() {
    agregarLineaConsola('--- INICIANDO SIMULACIÓN DE 5 VENTAS ---', 'consola-info');
    
    // Usar un bucle for para repetir la acción 5 veces
    for (let i = 0; i < 5; i++) {
        agregarLineaConsola(`Venta ${i + 1}:`, 'consola-info');
        
        // Usar if dentro del bucle para verificar si el arreglo está vacío
        if (productos.length === 0) {
            const mensaje = 'Sin stock';
            agregarLineaConsola(mensaje, 'consola-error');
            console.log(mensaje);
        } else {
            // Usar pop() para vender el producto
            const productoVendido = productos.pop();
            contadorVentas++;
            
            // Agregar a las ventas realizadas
            ventasRealizadas.push({
                numero: contadorVentas,
                producto: productoVendido,
                hora: new Date().toLocaleTimeString()
            });
            
            const mensaje = `Producto vendido: ${productoVendido}`;
            agregarLineaConsola(mensaje, 'consola-venta');
            console.log(mensaje);
        }
    }
    
    agregarLineaConsola('--- SIMULACIÓN COMPLETADA ---', 'consola-info');
    
    // Actualizar visualización
    actualizarInventario();
    actualizarResumenVentas();
}

// Función para reponer productos usando push()
function reponerProducto() {
    const nuevoProductoInput = document.getElementById('nuevoProducto');
    const nuevoProducto = nuevoProductoInput.value.trim();
    
    if (nuevoProducto === '') {
        alert('Por favor, ingrese el nombre del producto');
        return;
    }
    
    // Usar push() para agregar el producto al inventario
    productos.push(nuevoProducto);
    
    const mensaje = `Producto repuesto: ${nuevoProducto}`;
    agregarLineaConsola(mensaje, 'consola-info');
    console.log(mensaje);
    
    // Limpiar input
    nuevoProductoInput.value = '';
    
    // Actualizar visualización
    actualizarInventario();
}

// Función para actualizar el resumen de ventas
function actualizarResumenVentas() {
    const resumenDiv = document.getElementById('resumenVentas');
    
    if (ventasRealizadas.length === 0) {
        resumenDiv.innerHTML = '<p style="text-align: center; color: #666;">No se han realizado ventas aún</p>';
        return;
    }
    
    let html = `<div style="background: #e6fffa; padding: 10px; border-radius: 6px; margin-bottom: 15px; text-align: center;">
        <strong>Total de ventas realizadas: ${ventasRealizadas.length}</strong>
    </div>`;
    
    // Mostrar las últimas 10 ventas
    const ventasRecientes = ventasRealizadas.slice(-10).reverse();
    
    ventasRecientes.forEach(venta => {
        html += `<div class="venta-item">
            <strong>Venta #${venta.numero}</strong> - ${venta.producto} 
            <span style="float: right; font-size: 12px; color: #666;">${venta.hora}</span>
        </div>`;
    });
    
    if (ventasRealizadas.length > 10) {
        html += `<p style="text-align: center; color: #666; font-size: 12px;">
            ... y ${ventasRealizadas.length - 10} ventas más
        </p>`;
    }
    
    resumenDiv.innerHTML = html;
}

// Función para agregar línea a la consola simulada
function agregarLineaConsola(texto, clase = '') {
    const consolaDiv = document.getElementById('consola');
    const lineaDiv = document.createElement('div');
    lineaDiv.className = `consola-line ${clase}`;
    lineaDiv.textContent = texto;
    consolaDiv.appendChild(lineaDiv);
    
    // Hacer scroll hacia abajo
    consolaDiv.scrollTop = consolaDiv.scrollHeight;
}

// Función para reiniciar el inventario
function reiniciarInventario() {
    productos = ["manzana", "pan", "leche"];
    ventasRealizadas = [];
    contadorVentas = 0;
    
    // Limpiar visualización
    document.getElementById('resumenVentas').innerHTML = '<p style="text-align: center; color: #666;">No se han realizado ventas aún</p>';
    document.getElementById('consola').innerHTML = '';
    document.getElementById('nuevoProducto').value = '';
    
    // Actualizar inventario
    actualizarInventario();
    
    // Mensaje en consola
    agregarLineaConsola('--- INVENTARIO REINICIADO ---', 'consola-info');
    agregarLineaConsola('Productos iniciales: manzana, pan, leche', 'consola-info');
}

// Event listener para permitir reponer con Enter
document.getElementById('nuevoProducto').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        reponerProducto();
    }
});

// Inicializar cuando se carga la página
window.onload = function() {
    actualizarInventario();
    actualizarResumenVentas();
    agregarLineaConsola('--- SIMULADOR DE CAJA REGISTRADORA INICIADO ---', 'consola-info');
    agregarLineaConsola('Productos iniciales: manzana, pan, leche', 'consola-info');
    agregarLineaConsola('Listo para simular ventas...', 'consola-info');
};