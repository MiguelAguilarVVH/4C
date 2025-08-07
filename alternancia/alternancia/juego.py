import random 

print("Bienvenido al juego adivina el numero")
print("")
print("Voy a pensar un numero del 1 al 100, lo tienes que adivinar")
pensar = random.randint(1, 100)
numero = int(input("Para comenzar ingrese un numero 1-100"))
while pensar != numero :
 
    if numero > pensar:
        print("Numero que pense es menor")
    if numero < pensar:
         print("Numero que pense es mayor")
    numero = int(input("Para comenzar ingrese un numero 1-100")) 

    print(f"Ganaste,el numero que pense es:{pensar}")

