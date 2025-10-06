import sys
import tkinter as tk
import tkinter.font as tkf
from math import sqrt
from colorama import Fore
from datetime import datetime
from lib.errors import *
from lib.linalg import Vector3d, Plane
from lib.mathassets import generate_sphere

CRITICAL_ERROR_MESSAGE = "Exiting since a critical error was encountered..."

SYMBOLS = {
    "no_light": "M",
    "dark": "*",
    "slightly_dark": "+",
    "slightly_bright": "-",
    "bright": ".",
    "fully_bright": " ",
}

SPHERE_FONT = {
        "family": "Courier",
        "size": 6,
        "weight": "normal",
}


#syntactic sugar to print a pretty error
def print_error(message, solution):
    print(Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible solution:", Fore.RESET, solution)


#stringify the sphere
def stringify_sphere(sphere, symbol_set):
    sphere_string = ""
    for row in sphere:
        for e in row:
            symbol = ""
            if e == None:
                symbol = " "
            elif e <= 0:
                symbol = symbol_set["no_light"]
            elif 0 < e and e <= 0.3:
                symbol = symbol_set["dark"]
            elif 0.3 < e and e <= 0.5:
                symbol = symbol_set["slightly_dark"]
            elif 0.5 < e and e <= 0.7:
                symbol = symbol_set["slightly_bright"]
            elif 0.7 < e and e <= 0.9:
                symbol = symbol_set["bright"] 
            else:
                symbol = symbol_set["fully_bright"]

            sphere_string += symbol
        sphere_string += "\n"

    return sphere_string


#get float input with error handling
def input_float(name):
    while True:
        try:
            num = float(input(f"Please input {name}: "))
            break
        except ValueError:
            print_error(
                    "Invalid input",
                    "\".\" Must be used for the decimal point."
                    )
            continue

    return num


#moves the light source to a different point on the sphere
def change_light_source(root, event, **kwargs):

    #get some values to work with
    radius = float(kwargs["radius"])
    label = kwargs["label"]
    sphere = kwargs["sphere"]
    font = tkf.Font(family=SPHERE_FONT["family"], size=SPHERE_FONT["size"], weight=SPHERE_FONT["weight"])
    rows = len(sphere)
    width = font.measure("0") * len(sphere[rows//2])
    height = font.metrics("linespace")*len(sphere)
    x_center = root.winfo_width()/2
    y_center = root.winfo_height()/2

    #get the new x_0 and y_0 for the light source
    x_diff = event.x - x_center
    y_diff = event.y - y_center 
    x_0 = x_diff/(width/2)*radius
    y_0 = -y_diff/(height/2)*radius
    discriminant = radius**2 - x_0**2 - y_0**2

    #if the selected point is outside the sphere, do not change the light source.
    if discriminant < 0:
        return None
    
    z_0 = sqrt(discriminant)

    #create the new light source
    light_source = Vector3d(x_0, y_0, z_0)

    sphere = generate_sphere(radius, light_source)
    sphere_string = stringify_sphere(sphere, SYMBOLS)

    #update the label to show the new sphere
    label.configure(text=sphere_string)
    

def rebind_root(root, radius, label, sphere):
    root.unbind("<Button-1>")
    root.bind("<Button-1>", lambda event: change_light_source(root, event, radius=radius, label=label, sphere=sphere))


#Displays the sphere in a TKinter window
def display_sphere(sphere_string, sphere, radius):
    #initalise tkinter and the sphere as a label in the root window
    root = tk.Tk()
    label = tk.Label(root, text=sphere_string, font=(SPHERE_FONT["family"], SPHERE_FONT["size"]))
    label.pack()

    #bind left click to change the light source position.
    #triggers change_light_source
    root.bind("<Button-1>", lambda event: change_light_source(root, event, radius=radius, label=label, sphere=sphere))
    root.bind("<Configure>", rebind_root(root, radius, label, sphere))
    root.mainloop()


def main():
    print("Welcome to the sphere lighting simulator!")

    #Get the coordinates for the sphere
    x_0 = input_float("x0")
    y_0 = input_float("y0")
    radius = input_float("radius")

    #Check if the point is inside the sphere
    discriminant = radius**2 - x_0**2 - y_0**2
    while discriminant < 0:
        print_error(
                "Light source point not inside the sphere!",
                "Use a pair of x0 and y0 which exist inside the sphere."
                )
        print("Try a new set of values.")
        x_0 = input_float("x0")
        y_0 = input_float("y0")
        radius = input_float("radius")
        discriminant = radius**2 - x_0**2 - y_0**2

    z_0 = sqrt(discriminant)

    #Create a vector for the light source
    light_source = Vector3d(x_0, y_0, z_0)

    #The sphere is a matrix of light levels
    sphere = generate_sphere(radius, light_source)

    sphere_string = stringify_sphere(sphere, SYMBOLS)

    # Display the sphere in a window
    display_sphere(sphere_string, sphere, radius)

    #Ask the user if they want it to be output to a file
    file_output = input("\nWould you like to have this written to a file [Y/n]? ").upper().strip()

    #If the user gave an invalid input, keep trying again until it is valid.
    while not file_output in ["Y", "N"]:
        print(Fore.RED + "Not an option." + Fore.RESET)
        file_output = input("Would you like to have this written to a file [Y/n]? ").upper().strip()

    if file_output == "Y":
        file_output = True
    else:
        file_output = False

    #If the user wants to output the file, ask if they want the default filename (generated from datetime)
    # or if they want to give it their own name
    if file_output:
        default_filename = datetime.today().strftime("%Y-%m-%d_%H:%M") + "_sphere.txt"
        
        different_file_name = input(
                f"The default filename will be {default_filename}, would you like to call it something else [Y/n]? "
                ).upper().strip()

        #Make sure that the input if valid, if not, keep trying until it is
        while not different_file_name in ["Y", "N"]:
            print(Fore.RED + "Not an option." + Fore.RESET)
            different_file_name = input(
                    f"The default filename will be {default_filename}, would you like to call it something else [Y/n]? "
                    ).upper().strip()

        #Ask the user for a different file name if they want to change it, 
        # otherwise, set the filename as the default
        if different_file_name == "Y":
            file_name = input("What would you like to call the file? ")
        else:
            file_name = default_filename

        #Write the file
        file = open(file_name, "w")
        file.write(sphere_string)
        print(Fore.GREEN + f"{file_name} written." + Fore.RESET)
        file.close()


#Run main()
if __name__ == "__main__":
    main()
