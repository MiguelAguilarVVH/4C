//bucle while
// contar del 10 al 9

function buclewhile(){
    let count = 10;
    let array = [];
    while(count >= 1){
        array.push(count);
        count--;
    }
    alert(`los numeros son: ${array.join(" - ")}`);
    
}


function buclefor() {
    let array = [];  
    for ( i = 10; i >= 1; i--) { // en un for es i no cambia la variable
        array.push(i); // inserta valor a array  
    }
    alert(`Los números son: ${array.join(" - ")}`); // el signo $ sirve para poner una instruccion en una comentario como ejemplo  'hola'
}

function contarnNumeros(){
    let n = parseInt(prompt("Ingrese un numero entero:"));
    count = 1;
    let array = []
    while(count <= n){
        array.push(count); // psuh pone los datos al finla del array
        count++
    }
    alert(`contando: ${array.join (" - ")}`)
}

function sumarNumeros(){
    let suma = 0;
    let array = [];
    for(i= 1; i <=5; i++){
        suma+= i; // sumar i en cada iteración
        array.push(i);
    }
    alert(suma)


}