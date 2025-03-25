// Función para calcular el promedio y mostrar el resultado
function calcularPromedio() {
    // Obtener los valores de las notas ingresadas
    let nota1 = parseFloat(document.getElementById("nota1").value);
    let nota2 = parseFloat(document.getElementById("nota2").value);
    let nota3 = parseFloat(document.getElementById("nota3").value);

    // Verificar si las notas son válidas
    if (isNaN(nota1) || isNaN(nota2) || isNaN(nota3)) {
        document.getElementById("resultado").innerText = "Por favor ingresa todas las notas correctamente.";
        return;
    }

    // Calcular el promedio
    let promedio = (nota1 + nota2 + nota3) / 3;

    // Mostrar el resultado en función del promedio
    if (promedio < 4.0) {
        document.getElementById("resultado").innerText = "Reprobado";
    } else {
        document.getElementById("resultado").innerText = "Aprobado";
    }
}
