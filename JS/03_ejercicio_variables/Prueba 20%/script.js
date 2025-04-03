/**
 * Función que realiza cálculos básicos entre dos números
 */
function calcular() {
    // Obtener los valores ingresados
    var numero1 = parseFloat(document.getElementById("numero1").value);
    var numero2 = parseFloat(document.getElementById("numero2").value);
    var operacion = document.getElementById("operacion").value;
    var resultado = 0;
    
    // Pedir confirmación al usuario
    var respuesta = prompt("¿Desea realizar esta operación? Escriba 'si' para continuar:");
    
    // Verificar la respuesta del usuario
    if (respuesta !== "si") {
        alert("Operación cancelada");
        return; // Terminar si no confirmó
    }
    
    // Comprobar que los valores son números válidos
    if (isNaN(numero1) || isNaN(numero2)) {
        alert("Error: Debe ingresar números válidos");
        return;
    }
    
    // Realizar la operación seleccionada
    if (operacion === "suma") {
        resultado = numero1 + numero2;
    } 
    else if (operacion === "resta") {
        resultado = numero1 - numero2;
    } 
    else if (operacion === "multiplicacion") {
        resultado = numero1 * numero2;
    } 
    else if (operacion === "division") {
        // Evitar división por cero
        if (numero2 === 0) {
            alert("Error: No se puede dividir por cero, (Autista)");
            return;
        }
        resultado = numero1 / numero2;
    }
    
    // Mostrar el resultado
    document.getElementById("valorResultado").textContent = resultado;
    document.getElementById("resultado").style.display = "block";
}