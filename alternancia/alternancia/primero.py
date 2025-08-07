import tkinter as tk
from tkinter import messagebox
from datetime import date



def calcular_edad():
    nombre = entry_nombre.get()
    anio = entry_anio.get()

    if not anio.isdigit():
        messagebox.showerror("Error","El año debe ser un numero")
    anio_nac = int(anio)
    anio_actual = date.today().year
    edad = anio_actual - anio_nac
    messagebox.showinfo("Hola", f"{nombre},Su edad acutal es: {edad} años" )


    
ventana = tk.Tk()
ventana.title("Calculadora de edad")
ventana.geometry("500x300")

tk.Label(ventana,text="Nombre").pack(pady=5)
entry_nombre = tk.Entry(ventana)
entry_nombre.pack()

tk.Label(ventana, text="Ingrese año de nacimiento").pack(pady=5)
entry_anio = tk.Entry(ventana)
entry_anio.pack()


tk.Button(ventana, text="Calcular edad", command=calcular_edad).pack(pady=15)




ventana.mainloop()