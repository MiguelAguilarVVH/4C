/**
 * Función que realiza el cálculo basado en los valores ingresados y la operación seleccionada
 */
function calcular() {
    // Obtener los valores ingresados por el usuario
    var numero1 = parseFloat(document.getElementById("numero1").value); // Obtiene y convierte a número el primer valor
    var numero2 = parseFloat(document.getElementById("numero2").value); // Obtiene y convierte a número el segundo valor
    var operacion = document.getElementById("operacion").value; // Obtiene la operación seleccionada
    var resultado = 0; // Inicializa la variable que almacenará el resultado
    
    // Verificar que se ingresaron números válidos (no vacíos o texto)
    if (isNaN(numero1) || isNaN(numero2)) {
        alert("Por favor, ingrese números válidos en ambos campos"); // Muestra un mensaje de error
        return; // Detiene la ejecución de la función
    }
    
    // Realizar la operación seleccionada usando una estructura switch
    switch(operacion) {
        case "suma":
            resultado = numero1 + numero2; // Realiza la suma
            break;
        case "resta":
            resultado = numero1 - numero2; // Realiza la resta
            break;
        case "multiplicacion":
            resultado = numero1 * numero2; // Realiza la multiplicación
            break;
        case "division":
            // Verificar que no se esté dividiendo por cero
            if (numero2 === 0) {
                alert("No se puede dividir por cero"); // Muestra un mensaje de error
                return; // Detiene la ejecución de la función
            }
            resultado = numero1 / numero2; // Realiza la división
            break;
    }
    
    // Mostrar el resultado en la página
    document.getElementById("valorResultado").textContent = resultado; // Asigna el valor del resultado al span
    document.getElementById("resultado").style.display = "block"; // Hace visible el div del resultado
}