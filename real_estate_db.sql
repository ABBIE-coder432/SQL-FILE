import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector


DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',  # Replace with your username
    'password': '',  # Replace with your password
    'database': 'real_estate_db'
}

def fetch_properties():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM properties")
        rows = cursor.fetchall()
        return rows
    except mysql.connector.Error as err:
        messagebox.showerror("Database Error", f"Error: {err}")
        return []
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def update_property_status(property_id, new_status):
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        query = "UPDATE properties SET Status = %s WHERE PropertyID = %s"
        cursor.execute(query, (new_status, property_id))
        conn.commit()
        if cursor.rowcount > 0:
            messagebox.showinfo("Success", "Property status updated successfully.")
        else:
            messagebox.showwarning("Warning", "No property found with the given ID.")
    except mysql.connector.Error as err:
        messagebox.showerror("Database Error", f"Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()


def display_properties():
    for row in tree.get_children():
        tree.delete(row)
    rows = fetch_properties()
    for row in rows:
        tree.insert('', tk.END, values=row)


def handle_update():
    try:
        property_id = int(property_id_entry.get())
        new_status = status_combobox.get()
        if not new_status:
            messagebox.showwarning("Input Error", "Please select a new status.")
            return
        update_property_status(property_id, new_status)
        display_properties()
    except ValueError:
        messagebox.showwarning("Input Error", "Please enter a valid Property ID.")
