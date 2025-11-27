from lib.linalg import Vector3d
from math import pi, sqrt, fabs
from numpy import linspace 

class Shadow:
    def __init__(self):
        pass

X_STEPS = 100
Y_STEPS = 50
TOLERANCE_TUNING_NUMBER = 2

def get_light_level(point: Vector3d, light_source: Vector3d, radius: float) -> float:
    light_level: float = (point*light_source)/(radius**2)
    return light_level

def generate_sphere(radius: float, light_source: Vector3d, zoom: float) -> list[list[float, None, str]]:
    sphere: list[list[any]] = list(list())
    perpendiculars: list[Vector3d] = list()

    shadow: list[Vector3d] = list()

    x_min, x_max = -zoom*radius, zoom*radius
    y_min, y_max = -zoom*radius, zoom*radius
    y_spacing: float = (y_max - y_min) / Y_STEPS
    x_spacing: float = (x_max - x_min) / X_STEPS
    shadow_tolerance: float = x_spacing**2 + y_spacing**2

    #generates the shadow points
    for y in linspace(y_max, y_min, num=Y_STEPS):
        sphere_row: list[any] = list()
        for x in linspace(x_min, x_max, num=X_STEPS):
            discriminant: float = radius**2 - x**2 - y**2
            if not discriminant < 0:
                z_positive: float = sqrt(discriminant)
                z_negative: float = -z_positive

                for z in [z_negative, z_positive]:
                    point: Vector3d = Vector3d(x, y, z)

                    # if the point is perpendicular to the light source (scalar product is 0)
                    # add it to the list of perpendicular vectors
                    if point*light_source < 0.0:
                        t: float = (-(point.get_z() + radius)/light_source.get_z())
                        shadow_point: Vector3d = point + light_source*t
                        shadow.append(shadow_point)

    #generates the sphere and draws the shadow points with it.
    for y in linspace(y_max, y_min, num=Y_STEPS):
        sphere_row: list[float, str, None] = list()
        for x in linspace(x_min, x_max, num=X_STEPS):
            discriminant: float = radius**2 - x**2 - y**2
            if not discriminant < 0:
                z: float = sqrt(discriminant)
                point: Vector3d = Vector3d(x, y, z)
                light_level: float = get_light_level(point, light_source, radius)

                # if the point is perpendicular to the light source (scalar product is 0)
                # add it to the list of perpendicular vectors
            else:
                is_in_shadow: bool = False
                for shadow_point in shadow:
                    x_diff: float = x - shadow_point.get_x()
                    y_diff: float = y - shadow_point.get_y()

                    #squared to avoid extra computation time while calculating
                    distance_squared: float = x_diff**2 + y_diff**2
                    tolerance: float = shadow_tolerance*TOLERANCE_TUNING_NUMBER
                    if distance_squared <= tolerance:
                        is_in_shadow: bool = True
                        break
                    else:
                        continue

                if is_in_shadow:
                    light_level: str = "shadow"
                else:
                    light_level: None = None

            sphere_row.append(light_level)

        sphere.append(sphere_row)


    return sphere
