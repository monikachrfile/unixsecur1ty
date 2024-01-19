import pandas as pd
import os
import glob

# Define the columns
columns = ["Hostname", "IP Address", "Operating System", "Mac Address", "Open Ports", "Users", "Hardware"]

# Initialize a dataframe
df = pd.DataFrame(columns=columns)

# Get all the inventory files
files = glob.glob('path_to_your_files/*.txt')

for file in files:
    with open(file, 'r') as f:
        lines = f.readlines()

    # Initialize a dictionary to hold the data
    data = {column: "" for column in columns}

    # Parse the file
    for line in lines:
        if "Static hostname" in line:
            data["Hostname"] = line.split(":")[1].strip()
        elif "Operating System" in line:
            data["Operating System"] = line.split(":")[1].strip()
        elif "interface[ens" in line:
            ip_index = lines.index(line) + 1
            mac_index = lines.index(line) + 2
            data["IP Address"] = lines[ip_index].split(":")[1].strip()
            data["Mac Address"] = lines[mac_index].split(":")[1].strip()
        elif "Inventory Ports & Services to Copy For Inventory Sheet:" in line:
            port_index = lines.index(line) + 1
            while "==== More Info on ports: ====" not in lines[port_index]:
                data["Open Ports"] += lines[port_index].strip() + ", "
                port_index += 1
        elif "Users with UID 0 (root or equivalent; anyone other root here is BAD):" in line:
            user_index = lines.index(line) + 1
            while "==== Regular Users (UID >= 1000): ====" not in lines[user_index]:
                data["Users"] += lines[user_index].strip() + ", "
                user_index += 1
            user_index += 1
            while "==== Service Users (UID < 1000): ====" not in lines[user_index]:
                data["Users"] += lines[user_index].strip() + ", "
                user_index += 1
        elif "===== Hardware (Place as Extra Notes if No Hardware Section on Exel Sheet): =====" in line:
            hardware_index = lines.index(line) + 1
            while hardware_index < len(lines) and lines[hardware_index].strip() != "":
                data["Hardware"] += lines[hardware_index].strip() + "\n"
                hardware_index += 1

    # Append the data to the dataframe
    df = df._append(data, ignore_index=True)

# Write the dataframe to an Excel file
df.to_excel('inventory.xlsx', index=False)
