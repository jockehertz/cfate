from lib.linalg import Vector3d
from math import pi, sqrt
from numpy import linspace 

X_STEPS = 140
Y_STEPS = 70

#Given a point and light source, get the light level of that point
def get_light_level(point: Vector3d, light_source: Vector3d, radius: float) -> float:
    pass

#Iterate over all x and y values, and get the light level of that point.
#Should be saved in a matrix as the light level (if on the sphere), or None if not on the sphere
#This then returns the sphere as a matrix of light levels
def generate_sphere(radius: float, light_source: Vector3d):
    pass
