console.log("Funcionando correctamente...");

// Ejercicio 1: Calcular la edad
function declararVariables() {
    let ahora = parseInt(prompt("Ingrese el año actual:"));
    let fecha_nac = parseInt(prompt("Ingrese su año de nacimiento:"));

    let edad = ahora - fecha_nac;

    alert("Tu edad es: " + edad + ".");
}

// Ejercicio 2: Asignación de valores
function asignarValores() {
    let var1 = prompt("Ingresa un valor:");
    let var2 = var1;

    alert("El valor de var2 es: " + var2 + ".");
}

// Ejercicio 3: Operaciones matemáticas
function realizarOperaciones() {
    let num1 = parseInt(prompt("Ingrese num1:"));
    let num2 = parseInt(prompt("Ingrese num2:"));
    let num3 = parseInt(prompt("Ingrese num3:")); // Antes estabas pidiendo 'num1' dos veces

    let suma = num1 + num2 + num3;
    let resta = num1 - num3; // Corregí la operación para que sea la resta de 'num1' con 'num3'
    let multiplica = num2 * num3; // Antes estaba sumando en lugar de multiplicar
    let divide = num1 / 120; // Había un error de sintaxis aquí

    alert("Resultados:\n" +
        "Suma: " + suma + "\n" +
        "Resta: " + resta + "\n" +
        "Multiplicación: " + multiplica + "\n" +
        "División: " + divide);
}

// Ejercicio 4: Manipulación de cadenas
function manipularCadenas() {
    let direccion = prompt("Ingrese su dirección:");
    let n_casa = prompt("Ingrese su número de casa:");
    let direccioncompleta = direccion + " " + n_casa;

    let longitudMensaje = direccioncompleta.length;
    let antepenultimoCaracter = direccioncompleta.charAt(longitudMensaje - 3); // Obtiene el antepenúltimo carácter

    alert("La dirección es: " + direccioncompleta + 
        "\nCantidad de caracteres: " + longitudMensaje + 
        "\nCarácter antepenúltimo: " + antepenultimoCaracter);
}
