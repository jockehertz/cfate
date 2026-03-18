import sys
from colorama import Fore
from lib.errors import *
from lib.linalg import Vector3d, Plane
from lib.mathassets import generate_sphere

CRITICAL_ERROR_MESSAGE = "Exiting since a critical error was encountered..."

MODES = {
        "cartesian": "1",
        "spherical": "2",
        "exit": "3"
        }

WELCOME_MESSAGE = f"""
Welcome to the sphere illumination simulator!

We'll start of by getting the light coordinates. 
If you want to input cartesian coordinates, select {MODES["cartesian"]}.
If you want to input spherical coordinates, select {MODES["spherical"]}.
If you want to exit the program, select {MODES["exit"]}.

Choice: 
"""

INPUT_MESSAGE = f"""
If you want to input cartesian coordinates, select {MODES["cartesian"]}.
If you want to input spherical coordinates, select {MODES["spherical"]}.
If you want to exit the program, select {MODES["exit"]}.

Choice: 
"""

INVALID_INPUT_MESSAGE = f"""
Invalid mode!

If you want to input cartesian coordinates, select {MODES["cartesian"]}.
If you want to input spherical coordinates, select {MODES["spherical"]}.
If you want to exit the program, select {MODES["exit"]}.

Choice: 
"""

def print_error(message, solution):
    print(Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible solution:", Fore.RESET, solution)

def main():
    choice = input(WELCOME_MESSAGE)

    while not choice in MODES.values():
        choice = input(INVALID_INPUT_MESSAGE)

    light_source = Vector3d(0,0,0)

    if choice == MODES["cartesian"]:
        try:
            light_x = float(input("x coordinate of light source: "))
            light_y = float(input("y coordinate of light source: "))
            light_z = float(input("z coordinate of light source: "))
        except ValueError:
            print_error(
                    "Could not take input for numeric value(s)",
                    "Values must be numeric values, with \".\" as the decimal point"
                    )
            print(CRITICAL_ERROR_MESSAGE)
            sys.exit(1)

        light_source.set(light_x, light_y, light_z)

    elif choice == MODES["spherical"]:
        try:
            light_phi = float(input("phi (rotation): "))
            light_theta = float(input("theta (azimuth): "))
            light_radius = float(input("radius (distance from origin): "))
        except ValueError:
            print_error(
                    "Could not take input for numeric value(s)",
                    "Values must be numeric values, with \".\" as the decimal point"
                    )
            print(CRITICAL_ERROR_MESSAGE)
            sys.exit(1)

        light_source.from_spherical(rotation=light_phi, azimuth=light_theta, radius=light_radius)
        
    elif choice == MODES["exit"]:
        print("Exiting...")
        sys.exit(0)

    print("Now, you will input the radius of the sphere.")

    try:
        radius = float(input("Input the radius here: "))
    except ValueError as value:
        print_error(
                f"Could not format {value} to a decimal number",
                "Values must be numeric values, with \".\" as the decimal point"
                )
        print(CRITICAL_ERROR_MESSAGE)
        sys.exit(1)

    while radius >= light_source.norm():
        print_error(
                "This radius is greater than or equal to the distance to the light source, so the light source is inside the sphere",
                "Decrease the radius",
                )
        try:
            radius = float(input("Input the radius here: "))
        except ValueError:
            print_error(
                    "Could not take input for numeric value(s)",
                    "Values must be numeric values, with \".\" as the decimal point"
                    )
            print(CRITICAL_ERROR_MESSAGE)
            sys.exit(1)

    sphere = generate_sphere(radius, light_source)


if __name__ == "__main__":
    main()
