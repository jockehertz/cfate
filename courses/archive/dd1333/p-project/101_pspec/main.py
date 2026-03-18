import sys
import tkinter as tk
import tkinter.font as tkf
from math import sqrt
from colorama import Fore
from datetime import datetime
from lib.errors import *
from lib.linalg import Vector3d, Plane
from lib.mathassets import generate_sphere


#syntactic sugar to print a pretty error
def print_error(message, solution):
    pass


#stringify the sphere, returns a string to be printed
def stringify_sphere(sphere, symbol_set):
    pass


#get float input with error handling
def input_float(name):
    pass


#moves the light source to a different point on the sphere
def change_light_source(root, event, **kwargs):
    pass


#Displays the sphere in a TKinter window
def display_sphere(sphere_string, sphere, radius):


def main():
    pass
    #Get the coordinates for the sphere

    #Check if the point is inside the sphere

    #Calculate z_0

    #Create a vector for the light source
    light_source = Vector3d(x_0, y_0, z_0)

    #The sphere is a matrix of light levels
    #Generates a sphere to be used    
    sphere = generate_sphere(radius, light_source)

    #Make the sphere a string to be printed
    sphere_string = stringify_sphere(sphere, SYMBOLS)

    # Display the sphere in a window (TKinter)
    # Otherwise, the program will just print here
    display_sphere(sphere_string, sphere, radius)

    #Ask the user if they want it to be output to a file

    #If the user gave an invalid input, keep trying again until it is valid.

    #If the user wants to output the file, ask if they want the default filename (generated from datetime)
    # or if they want to give it their own name

        #Make sure that the input is valid, if not, keep trying until it is

        #Ask the user for a different file name if they want to change it, 
        # otherwise, set the filename as the default

        #Write the file


#Run main()
if __name__ == "__main__":
    main()
