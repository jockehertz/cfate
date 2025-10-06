from lib.linalg import Vector3d
from math import pi, sqrt
from numpy import linspace 

X_STEPS = 140
Y_STEPS = 70

def get_light_level(point: Vector3d, light_source: Vector3d, radius: float) -> float:
    light_level = (point*light_source)/(radius**2)
    return light_level

def generate_sphere(radius: float, light_source: Vector3d):
    sphere = list(list())
    for y in linspace(radius, -radius, num=Y_STEPS):
        sphere_row = list()
        for x in linspace(-radius, radius, num=X_STEPS):
            discriminant = radius**2 - x**2 - y**2
            if not discriminant < 0:
                z = sqrt(discriminant)
                point = Vector3d(x, y, z)
                light_level = get_light_level(point, light_source, radius)
            else:
                light_level = None

            sphere_row.append(light_level)

        sphere.append(sphere_row)

    return sphere
