function calcularIMC() {
    // Obtener los valores de peso y altura
    const peso = parseFloat(document.getElementById('peso').value);
    const altura = parseFloat(document.getElementById('altura').value);

    // Calcular el IMC
    const imc = peso / (altura * altura);

    // Determinar el estado según el IMC
    let resultado = '';

    if (imc < 18.5) {
        resultado = "Bajo peso";
    } else if (imc >= 18.5 && imc <= 24.9) {
        resultado = "Peso normal";
    } else if (imc >= 25) {
        resultado = "Sobrepeso";
    }

    // Mostrar el resultado en la página
    document.getElementById('resultado').innerText = `Tu IMC es: ${imc.toFixed(2)} - ${resultado}`;
}
