from math import acos, cos, pi, sin, sqrt
from typing import Any

from colorama import Fore

if __name__ == "__main__":
    from errors import MethodNotDefinedForClass, NotA3dVector
    from testing import failed, success
else:
    from lib.errors import MethodNotDefinedForClass, NotA3dVector
    from lib.testing import failed, success


def deg2rad(theta):
    rads = (2 * pi) / (360) * theta
    return rads


class Vector3d:
    # Inits a Vector3d object
    # inputs: x (float), y (float), z (float): the x, y, and z coordinates of the vector
    # outputs: no output
    def __init__(self, x: float, y: float, z: float):
        try:
            self.x = float(x)
            self.y = float(y)
            self.z = float(z)
        except ValueError:
            raise ValueError

    # Getter for the x attribute
    # inputs: no input
    # outputs: self.x (float)
    def get_x(self) -> float:
        return self.x

    # Getter for the y attribute
    # inputs: no input
    # outputs: self.y (float)
    def get_y(self) -> float:
        return self.y

    # Getter for the z attribute
    # inputs: no input
    # outputs: self.z (float)
    def get_z(self) -> float:
        return self.z

    # Setter for the x attribute
    # inputs: x (float): the value which the x-coordinate is to be set to
    # outputs: no output
    # might raise a ValueError if the API caller gave the setter a bad input (non-parseable to float)
    def set_x(self, x: float):
        try:
            self.x = float(x)
        except ValueError:
            raise ValueError

    # Setter for the y attribute
    # inputs: y (float): the value which the y-coordinate is to be set to
    # outputs: no output
    # might raise a ValueError if the API caller gave the setter a bad input (non-parseable to float)
    def set_y(self, y: float):
        try:
            self.y = float(y)
        except ValueError:
            raise ValueError

    # Setter for the z attribute
    # inputs: z (float): the value which the z-coordinate is to be set to
    # outputs: no output
    # might raise a ValueError if the API caller gave the setter a bad input (non-parseable to float)
    def set_z(self, z: float):
        try:
            self.z = float(z)
        except ValueError:
            raise ValueError

    # Get the norm
    # inputs: no input
    # outputs: norm (float): the norm of the vector which the method is called on
    def norm(self) -> float:
        norm: float = sqrt(self.x**2 + self.y**2 + self.z**2)
        return norm

    # Sets all coordinates of a Vector3d
    # inputs: x (float), y (float), z (float): the x, y, and z coordinates to be set
    # outputs: no output
    # might raise a ValueError if any of the coordinates is bad (non-parseable to float)
    def set(self, x: float, y: float, z: float):
        try:
            x, y, z = float(x), float(y), float(z)

        except ValueError:
            raise ValueError

        self.x = x
        self.y = y
        self.z = z

    # Construct a vector from spherical coordinates
    # the angles should be in radians
    # inputs: KWARGS:
    #           rotation (float): the rotation angle for the coordinate
    #           azimuth (float): the azimuth for the coordinate
    #           radius (float): the radius for the coordinate
    #
    # outputs: no output
    # might raise a ValueError if any of the arguments are bad (non-parseable to float)
    def from_spherical(self, **kwargs: Any):
        try:
            phi: float = float(kwargs["rotation"])
            theta: float = float(kwargs["azimuth"])
            r: float = float(kwargs["radius"])
        except ValueError:
            raise ValueError

        self.x = r * sin(theta) * cos(phi)
        self.y = r * sin(theta) * sin(phi)
        self.z = r * cos(phi)

    # modifying the add method (a + b) for Vector3d objects
    # inputs: v (Vector3d): the vector to be added to self
    # outputs: u (Vector3d): the resultant vector of the addition
    # might raise a NotA3dVector exception if v is not a Vector3d
    def __add__(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector

        x, y, z = self.x + v.x, self.y + v.y, self.z + v.z

        u = Vector3d(x, y, z)
        return u

    # modifying the subtract method (a - b) for Vector3d objects
    # inputs: v (Vector3d): the vector for self to be subtracted with
    # outputs: u (Vector3d): the resultant vector of the subtraction
    # might raise a NotA3dVector exception if v is not a Vector3d
    def __sub__(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector

        x, y, z = self.x - v.x, self.y - v.y, self.z - v.z

        u = Vector3d(x, y, z)
        return u

    # modifying the multiplication operator (a * b) for Vector3d objects
    # if a is a float or int, it just returns a scaled vector
    # if a is a Vector3d, it returns the scalar product as a float
    def __mul__(self, a):
        if type(a) is int or type(a) is float:
            x: float = a * self.x
            y: float = a * self.y
            z: float = a * self.z

            return Vector3d(x, y, z)

        elif a.__class__ == Vector3d:
            scalar_product: float = self.x * a.x + self.y * a.y + self.z * a.z
            return scalar_product

    # cross product
    # inputs: v (Vector3d): the vector which self is to be operated with
    # outputs: u (Vector3d): the resultant vector of the cross product
    def cross(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector

        x = self.y * v.z - self.z * v.y
        y = -1 * (self.x * v.z - self.z * v.x)
        z = self.x * v.y - self.y * v.x

        u = Vector3d(x, y, z)
        return u

    # Get the difference of angle between two test_vectors
    # inputs: v (Vector3d): the vector which v will be compared with for the angle difference
    # outputs: angle (float): the angle difference in radians
    def angle_diff(self, v) -> float:
        angle: float = acos((self * v) / (self.norm() * v.norm()))
        return angle

    # This method projects a vector onto a Plane or a Vector3d
    # inputs: a (Vector3d | Plane): the vector or plane which self is to be projected on
    # outputs: projected (Vector3d): the projected vector
    # might raise a MethodNotDefinedForClass exception
    def project(self, a):
        alpha: float
        u_norm: float
        t: float
        if a.__class__ == Plane:
            n = a.normal()  # Vector3d
            alpha = self.angle_diff(n)
            u_norm = (self.norm()) * (cos(alpha))
            t = u_norm / (n.norm())
            u = Vector3d(t * (n.x), t * (n.y), t * (n.z))
            projected = (self - u) + a.origin  # Vector3d

        elif a.__class__ == Vector3d:
            alpha = self.angle_diff(a)
            u_norm = self.norm() * cos(alpha)
            t = u_norm / (a.norm())
            projected = Vector3d(t * (a.x), t * (a.y), t * (a.z))

        else:
            raise MethodNotDefinedForClass(a.__class__)

        return projected


# A plane is just defined by a pair of basis vectors and a starting vector
class Plane:
    # Inits a Plane object
    # inputs: i (Vector3d), j (Vector3d): the two basis vectors for the plane,
    #         origin (Vector3d): the vector which points to the plane's origin in R3
    def __init__(self, i: Vector3d, j: Vector3d, origin: Vector3d):
        if (
            i.__class__ == Vector3d
            and j.__class__ == Vector3d
            and origin.__class__ == Vector3d
        ):
            self.i: Vector3d = i
            self.j: Vector3d = j
            self.origin: Vector3d = origin
        else:
            raise NotA3dVector

    # Gets the normal Vector of a plane by cross product
    # inputs: no inputs
    # outputs: normal (Vector3d): the vector that is normal to the plane
    def normal(self) -> Vector3d:
        i: Vector3d = self.i
        j: Vector3d = self.j
        normal = i.cross(j)
        return normal


# ===========TESTS===========#

FLOAT_OPERATION_ERROR = 0.0001


# tests if vector addition works
def test_vector_addition():
    v_x, v_y, v_z = 1, 1, 1
    u_x, u_y, u_z = 1, 7.3, 1

    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    sum_v = v + u

    if (
        sum_v.x - (v_x + u_x) < FLOAT_OPERATION_ERROR
        and sum_v.y - (v_y + u_y) < FLOAT_OPERATION_ERROR
        and sum_v.z - (v_z + u_z) < FLOAT_OPERATION_ERROR
    ):
        return True
    else:
        return False


# tests if vector subtraction works
def test_vector_subtraction():
    v_x, v_y, v_z = 1, 1, 1
    u_x, u_y, u_z = 1, 7.3, 1

    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    diff_v = v - u

    if (
        (diff_v.x - (v_x - u_x)) < FLOAT_OPERATION_ERROR
        and (diff_v.y - (v_y - u_y)) < FLOAT_OPERATION_ERROR
        and (diff_v.z - (v_z - u_z)) < FLOAT_OPERATION_ERROR
    ):
        return True
    else:
        return False


# tests if vector dot product works
def test_dot_product():
    v_x, v_y, v_z = 1, 1, 1
    u_x, u_y, u_z = 1, 7.3, 1

    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    if (v * u - (v_x * u_x + v_y * u_y + v_z * u_z)) < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False


# tests if scalar multiplication works properly
def test_scalar_multiplication():
    v_x, v_y, v_z = 1, 2, 3
    t = 3

    v = Vector3d(v_x, v_y, v_z)
    diff_v = v - Vector3d(t * v_x, t * v_y, t * v_z)

    if (
        diff_v.x < FLOAT_OPERATION_ERROR
        and diff_v.y < FLOAT_OPERATION_ERROR
        and diff_v.z < FLOAT_OPERATION_ERROR
    ):
        return True
    else:
        return False


# test vector projection onto vector
def test_projection_on_vector():
    expected = Vector3d(1, 1, 0)
    v = Vector3d(1, 1, 1)
    u = Vector3d(1, 1, 0)
    proj = v.project(u)
    if (
        proj.x - expected.x < FLOAT_OPERATION_ERROR
        and proj.y - expected.y < FLOAT_OPERATION_ERROR
        and proj.z - expected.z < FLOAT_OPERATION_ERROR
    ):
        return True
    else:
        return False


# test vector projection onto plane
def test_projection_on_plane():
    expected = Vector3d(1, 2, 1)
    plane = Plane(Vector3d(0, 1, 0), Vector3d(0, 0, 1), Vector3d(1, 0, 0))
    v = Vector3d(-1, 2, 1)
    proj = v.project(plane)
    if (
        proj.x - expected.x < FLOAT_OPERATION_ERROR
        and proj.y - expected.y < FLOAT_OPERATION_ERROR
        and proj.z - expected.z < FLOAT_OPERATION_ERROR
    ):
        return True
    else:
        return False


def main():
    if test_vector_addition():
        success("Vector addition test passed.")
    else:
        failed("Vector addition test not passed.")

    if test_vector_subtraction():
        success("Vector subtraction test passed.")
    else:
        failed("Vector subtraction test not passed.")

    if test_dot_product():
        success("Dot product test passed.")
    else:
        failed("Dot product test not passed.")

    if test_scalar_multiplication():
        success("Scalar multiplication test passed.")
    else:
        failed("Scalar product test not passed.")

    if test_projection_on_vector():
        success("Vector projection onto vector test passed")
    else:
        failed("Vector projection onto vector test not passed")

    if test_projection_on_plane():
        success("Vector projection onto plane test passed")
    else:
        failed("Vector projection onto plane test not passed")


if __name__ == "__main__":
    main()
