from lib.linalg import Vector3d
from math import pi
from numpy import linspace 

def get_light_level(point: Vector3d, light_source: Vector3d) -> float:
    return 0.0

def generate_sphere(radius: float, light_source: Vector3d):
    sphere_points = list()

    for phi in linspace(0, 2*pi, num=100):
        for theta in linspace(0, pi, num=100):
            point = Vector3d(0,0,0).from_spherical(rotation=phi, azimuth=theta, radius=radius)

            light_level = get_light_level(point, light_source)
            point_light_level = Vector3d(0,0,0).from_spherical(rotation=phi, azimuth=theta, radius=light_level)

            sphere_points.append(point_light_level)
            
    return sphere_points
