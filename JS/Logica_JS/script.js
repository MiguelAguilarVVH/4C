function verificarNumero() {
    // Obtener el número ingresado por el usuario
    const numero = document.getElementById('numero').value;

    // Verificar si el número es múltiplo de 2 usando el operador módulo
    if (numero % 2 === 0) {
        document.getElementById('resultado').innerText = "El número es par";
    } else {
        document.getElementById('resultado').innerText = "El número es impar";
    }
}
