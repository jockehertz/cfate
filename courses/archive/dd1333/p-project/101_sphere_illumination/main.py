import sys
import tkinter as tk
import tkinter.font as tkf
from math import sqrt
from colorama import Fore
from datetime import datetime
from lib.errors import *
from lib.linalg import Vector3d, Plane
from lib.mathassets import generate_sphere, Shadow

CRITICAL_ERROR_MESSAGE = "Exiting since a critical error was encountered..."

INSTRUCTION_TEXT = "Click on the sphere to move the light source!"

ZOOM = 2

SYMBOLS = {
    "no_light": "M",
    "dark": "*",
    "slightly_dark": "+",
    "slightly_bright": "-",
    "bright": ".",
    "fully_bright": " ",
    "shadow": "F",
}


SPHERE_FONT = {
        "family": "Courier",
        "size": 6,
        "weight": "normal",
}


#syntactic sugar to print a pretty error
# inputs: message (str): error message, solution (str): suggested solution 
# outputs: no output
def print_error(message: str, solution: str):
    print(Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible solution:", Fore.RESET, solution)


#stringify the sphere
# inputs: sphere (list(list(float))) containing light levels
# outputs: sphere_string (str) the string to be printed to display the sphere
def stringify_sphere(sphere: list[list[float]], symbol_set:dict[str]) -> str:
    sphere_string: str = ""
    for row in sphere:
        for e in row:
            symbol: str = ""
            if e == None:
                symbol: str = " "
            elif e == "shadow":
                symbol: str = symbol_set["shadow"]
            elif e <= 0:
                symbol: str = symbol_set["no_light"]
            elif 0 < e and e <= 0.3:
                symbol: str = symbol_set["dark"]
            elif 0.3 < e and e <= 0.5:
                symbol: str = symbol_set["slightly_dark"]
            elif 0.5 < e and e <= 0.7:
                symbol: str = symbol_set["slightly_bright"]
            elif 0.7 < e and e <= 0.9:
                symbol: str = symbol_set["bright"] 
            else:
                symbol: str = symbol_set["fully_bright"]

            sphere_string += symbol
        sphere_string += "\n"

    return sphere_string


#get float input with error handling
# inputs: name (str) the name of the float which is presented to the user 
# outputs: num (float) the number that was received from the user
def input_float(name: str) -> float:
    while True:
        try:
            num: float = float(input(f"Please input {name}: "))
            break
        except ValueError:
            print_error(
                    "Invalid input",
                    "\".\" Must be used for the decimal point."
                    )
            continue

    return num


#moves the light source to a different point on the sphere 
# inputs: root (tk.Tk): the root window, event (tk.Event): the event which triggered the change,
#           KWARGS:
#               radius (float): the radius of the sphere 
#               label (tk.Label): the label to be updated
#               instruction_label (tk.Label): the label containing user instructions
#               sphere (list[list[any]]): the matrix containing light levels
#
# outputs: no output
def change_light_source(root: tk.Tk, event: tk.Event, **kwargs: dict[any]):

    #get some values to work with
    radius: float = float(kwargs["radius"])
    label: tk.Label = kwargs["label"]
    instruction_label: tk.Label = kwargs["instruction_label"]

    sphere: list[list[any]] = kwargs["sphere"]
    font: tkf.Font = tkf.Font(family=SPHERE_FONT["family"], size=SPHERE_FONT["size"], weight=SPHERE_FONT["weight"])
    rows: float = len(sphere)
    width: float = (font.measure("0") * len(sphere[rows//2]))
    height: float = (font.metrics("linespace")*len(sphere))
    x_center: float = width/2
    y_center: float = height/2

    #get the new x_0 and y_0 for the light source
    # NOTE: the tk.Event class has no getters, so the caller must access the 
    # API:s readonly attributes (event.x and event.y) directly
    x_diff: float = event.x - x_center
    y_diff: float = event.y - y_center 
    x_0: float = x_diff/(width/(2))*(radius*ZOOM)
    y_0: float = -y_diff/(height/2)*(radius*ZOOM)
    discriminant: float = radius**2 - x_0**2 - y_0**2

    #if the selected point is outside the sphere, do not change the light source.
    if discriminant < 0:
        instruction_label.configure(text="That is not a point in the sphere! Try another point", fg="red")
        return None
    
    #shows the text "Simulating..." while the simulation is running
    instruction_label.configure(text="Simulating...", fg="black")
    root.update_idletasks()
    
    z_0: float = sqrt(discriminant)

    #create the new light source
    light_source: Vector3d = Vector3d(x_0, y_0, z_0)

    sphere: list[list[any]] = generate_sphere(radius, light_source, ZOOM)
    sphere_string: str = stringify_sphere(sphere, SYMBOLS)

    instruction_label.configure(text="Simulation done!", fg="green")

    #update the label to show the new sphere
    label.configure(text=sphere_string)
    

#Displays the sphere in a TKinter window
# inputs: sphere_string (str): the string for the sphere to be displayed,
#         sphere (list[list[any]]): the matrix of light levels for the sphere 
#         radius (float): the radius of the sphere
def display_sphere(sphere_string: str, sphere: list[list[any]], radius: float):
    #initalise tkinter and the sphere as a label in the root window
    root = tk.Tk()
    instruction_label = tk.Label(root, text=INSTRUCTION_TEXT)
    instruction_label.pack()
    label = tk.Label(root, text=sphere_string, font=(SPHERE_FONT["family"], SPHERE_FONT["size"]))
    label.pack()

    #bind left click to change the light source position.
    #triggers change_light_source
    label.bind("<Button-1>", lambda event: change_light_source(root, event, radius=radius, label=label, sphere=sphere, instruction_label=instruction_label))
    root.mainloop()


def main():
    print("Welcome to the sphere lighting simulator!")

    #Get the coordinates for the sphere
    x_0: float = input_float("x0")
    y_0: float = input_float("y0")
    radius: float = input_float("radius")

    #Check if the point is inside the sphere
    discriminant: float = radius**2 - x_0**2 - y_0**2
    while discriminant < 0:
        print_error(
                "Light source point not inside the sphere!",
                "Use a pair of x0 and y0 which exist inside the sphere."
                )
        print("Try a new set of values.")
        x_0: float = input_float("x0")
        y_0: float = input_float("y0")
        radius: float = input_float("radius")
        discriminant: float = radius**2 - x_0**2 - y_0**2

    z_0: float = sqrt(discriminant)

    #Create a vector for the light source
    light_source: Vector3d = Vector3d(x_0, y_0, z_0)

    #The sphere is a matrix of light levels
    sphere: list[list[float | str | None]] = generate_sphere(radius, light_source, ZOOM)

    sphere_string: str = stringify_sphere(sphere, SYMBOLS)

    # Display the sphere in a window
    display_sphere(sphere_string, sphere, radius)

    #Ask the user if they want it to be output to a file
    file_output: str = input("\nWould you like to have this written to a file [Y/n]? ").upper().strip()

    #If the user gave an invalid input, keep trying again until it is valid.
    while not file_output in ["Y", "N"]:
        print(Fore.RED + "Not an option." + Fore.RESET)
        file_output = input("Would you like to have this written to a file [Y/n]? ").upper().strip()

    if file_output == "Y":
        file_output: bool = True
    else:
        file_output: bool = False

    #If the user wants to output the file, ask if they want the default filename (generated from datetime)
    # or if they want to give it their own name
    if file_output:
        default_filename: str = datetime.today().strftime("%Y-%m-%d_%H:%M") + "_sphere.txt"
        
        different_file_name: str = input(
                f"The default filename will be {default_filename}, would you like to call it something else [Y/n]? "
                ).upper().strip()

        #Make sure that the input if valid, if not, keep trying until it is
        while not different_file_name in ["Y", "N"]:
            print(Fore.RED + "Not an option." + Fore.RESET)
            different_file_name: str = input(
                    f"The default filename will be {default_filename}, would you like to call it something else [Y/n]? "
                    ).upper().strip()

        #Ask the user for a different file name if they want to change it, 
        # otherwise, set the filename as the default
        if different_file_name == "Y":
            file_name: str = input("What would you like to call the file? ")
        else:
            file_name: str = default_filename

        #Write the file
        file: File = open(file_name, "w")
        file.write(sphere_string)
        print(Fore.GREEN + f"{file_name} written." + Fore.RESET)
        file.close()


#Run main()
if __name__ == "__main__":
    main()
