import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector

# Database connection configuration
DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',  # Replace with your username
    'password': '',  # Replace with your password
    'database': 'real_estate_db'
}

# Function to fetch properties from the database
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

# Function to update the status of a property
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

# Function to display properties in the treeview
def display_properties():
    for row in tree.get_children():
        tree.delete(row)
    rows = fetch_properties()
    for row in rows:
        tree.insert('', tk.END, values=row)

# Function to handle status update
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

# Main application window
app = tk.Tk()
app.title("Real Estate Property Manager")
app.geometry("800x500")

# Frame for property display
tree_frame = tk.Frame(app)
tree_frame.pack(fill=tk.BOTH, expand=True, pady=10)

# Scrollbar for treeview
scrollbar = tk.Scrollbar(tree_frame)
scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

# Treeview widget to display properties
tree = ttk.Treeview(tree_frame, columns=("PropertyID", "Address", "City", "Type", "Size", "Price", "Status"), show="headings", yscrollcommand=scrollbar.set)
scrollbar.config(command=tree.yview)

tree.heading("PropertyID", text="Property ID")
tree.heading("Address", text="Address")
tree.heading("City", text="City")
tree.heading("Type", text="Type")
tree.heading("Size", text="Size (sq ft)")
tree.heading("Price", text="Price")
tree.heading("Status", text="Status")

tree.column("PropertyID", width=80)
tree.column("Address", width=200)
tree.column("City", width=100)
tree.column("Type", width=100)
tree.column("Size", width=100)
tree.column("Price", width=100)
tree.column("Status", width=100)

tree.pack(fill=tk.BOTH, expand=True)

# Frame for update controls
update_frame = tk.Frame(app)
update_frame.pack(fill=tk.X, pady=10)

# Input for Property ID
tk.Label(update_frame, text="Property ID:").pack(side=tk.LEFT, padx=5)
property_id_entry = tk.Entry(update_frame)
property_id_entry.pack(side=tk.LEFT, padx=5)

# Dropdown for new status
status_label = tk.Label(update_frame, text="New Status:")
status_label.pack(side=tk.LEFT, padx=5)

status_combobox = ttk.Combobox(update_frame, values=["Available", "Sold", "Rented"])
status_combobox.pack(side=tk.LEFT, padx=5)

# Update button
update_button = tk.Button(update_frame, text="Update Status", command=handle_update)
update_button.pack(side=tk.LEFT, padx=10)

# Initial population of data
display_properties()

# Run the application
app.mainloop()
