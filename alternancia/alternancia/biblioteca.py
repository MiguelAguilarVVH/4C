import tkinter as tk
from tkinter import messagebox
import oracledb

def conexion():
    conn = oracledb.connect(
        user ="C##biblioteca",
        password = "Holitas01",
        dsn = "localhost/xe"
    )
    cursor = conn.cursor()
    return conn, cursor

#Funcion para ingresar datos

def insertar_biblioteca():
    try:
        id_bib = int(entry_id.get())
        Nombre =entry_Nombre.get()
        Municipalidad = entry_Municipalidad.get()

        if not Nombre or not Municipalidad:
            messagebox.showerror("Error","todos los campos son obligatorios")
            return
        
        conn, cursor = conexion()
        
        cursor.execute("""
                       INSERT INTO biblioteca (id_biblioteca,nombres,municipalidad)
                       VALUES (:1, :2, :3)
                       """,(id_bib,Nombre,Municipalidad))
        conn.commit()
        cursor.close()
        conn.close()

        messagebox.showinfo("Exito","Biblioteca Registrada Exitosamente")
        entry_id.delete(0, tk.END)
        entry_Nombre.delete(0, tk.END)
        entry_Municipalidad.delete(0, tk.END)

    except oracledb.DatabaseError as e:
        messagebox.showerror("Error en DB", str(e))
    except ValueError:
        messagebox.showerror("Error","EL ID debe ser un numero")

def mostrar_biblioteca():
        try:

            conn, cursor = conexion()

            cursor.execute("SELECT id_biblioteca, nombres," \
                               "municipalidad FROM biblioteca")
            resultado = cursor.fetchall()

            cursor.close()
            conn.close()

            if not resultado:
                    messagebox.showinfo("biblioteca","No hay Bibliotecas Registradas")
                    return
                
                    #Crear una nueva ventana 
            ventana_lista = tk.Tk()
            ventana_lista.title("Listado de biblioteca")
            ventana_lista.geometry("500x400")

            tk.Label(ventana_lista, text="ID |Nombre | Municipalidad",
                        font=("Arial", 10, "bold")).pack(pady=5)
                
            for fila in resultado:
                        texto= f"({(fila[0])} |  {fila[1]}  | {fila[2]})"
            tk.Label(ventana_lista, text=texto).pack()

        except oracledb.DatabaseError as e: 
            messagebox.showerror("Error en BD", str(e))
                
 

#Crear ventana principal
ventana = tk.Tk()
ventana.title("registro de Biblioteca")
ventana.geometry("700x500")

#Etiqueta y campos
tk.Label(ventana, text="ID Biblioteca").pack(pady=5)
entry_id= tk.Entry(ventana)
entry_id.pack()

tk.Label(ventana, text="Nombre:").pack(pady=5)
entry_Nombre = tk.Entry(ventana)
entry_Nombre.pack()

tk.Label(ventana, text="Municipalidad:").pack(pady=5)
entry_Municipalidad = tk.Entry(ventana)
entry_Municipalidad.pack()

#Boton insertar
tk.Button(ventana, text="Registrar Biblioteca", command=insertar_biblioteca).pack(pady=15)

#Boton mostrar
tk.Button(ventana, text="Mostrar Biblioteca", command= mostrar_biblioteca).pack(pady=35)

ventana.mainloop()

