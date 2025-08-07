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

#funcion ingreso de datos

def insertar_libros():
    try:
        id_lib = int(entry_id_libro.get())
        categoria = entry_categoria.get()
        autor = entry_autor.get()
        biblioteca_id = int(entry_id_biblioteca.get())

        if not categoria:
            messagebox.showerror("Error","La categoria es obligatoria")
            return
        
        conn, cursor = conexion()
        
        cursor.execute("""
            INSERT INTO Libros (id_libro, categoria, autor, BIBLIOTECA_ID_BIBLIOTECA)
            VALUES (:1, :2, :3, :4)
        """, (id_lib, categoria, autor, biblioteca_id))
        conn.commit()
        cursor.close()
        conn.close()

        messagebox.showinfo("Éxito","Libro registrado exitosamente")
        entry_id_libro.delete(0, tk.END)
        entry_categoria.delete(0, tk.END)
        entry_autor.delete(0, tk.END)
        entry_id_biblioteca.delete(0, tk.END)

    except oracledb.DatabaseError as e:
        messagebox.showerror("Error en DB", str(e))
    except ValueError:
        messagebox.showerror("Error","El ID debe ser un número")

def mostrar_libros():
    try:
        conn, cursor = conexion()
        cursor.execute("SELECT id_libro, categoria, autor FROM Libros")
        resultado = cursor.fetchall()
        cursor.close()
        conn.close()
        
        if not resultado:
            messagebox.showinfo("Libros","No hay libros registrados")
            return
        
        #crear nueva ventana
        ventana_lista = tk.Tk()
        ventana_lista.title("Lista de Libros")
        ventana_lista.geometry("500x400")

        tk.Label(ventana_lista, text= "ID | categoria | Autor",
                 font=("Arial", 10, "bold")).pack(pady=5)
        
        for fila in resultado:
            texto = f"({fila[0]} | {fila[1]} | {fila[2]})"
            tk.Label(ventana_lista, text=texto).pack()

    except oracledb.DatabaseError as e:
        messagebox.showerror("Error en BD", str(e))


ventana = tk.Tk()
ventana.title("Registro de Libros")
ventana.geometry("700x500")

#etiquetas y campos
tk.Label(ventana, text="ID Libro:").pack(pady=5)
entry_id_libro = tk.Entry(ventana)
entry_id_libro.pack()

tk.Label(ventana, text="categoria:").pack(pady=5)
entry_categoria = tk.Entry(ventana)
entry_categoria.pack()

tk.Label(ventana, text="Autor:").pack(pady=5)
entry_autor = tk.Entry(ventana)
entry_autor.pack()

tk.Label(ventana, text="ID biblioteca:").pack(pady=5)
entry_id_biblioteca = tk.Entry(ventana)
entry_id_biblioteca.pack()

#boton insertar
tk.Button(ventana, text="Registrar Libros", command=insertar_libros).pack(pady=15)
#boton mostrar
tk.Button(ventana, text="Mostrar Libros", command=mostrar_libros).pack(pady=35)

ventana.mainloop()
