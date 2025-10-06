from math import sqrt, cos, acos, sin, pi
from colorama import Fore

if __name__ == "__main__":
    from errors import NotA3dVector
    from testing import success, failed
else:
    from lib.errors import NotA3dVector
    from lib.testing import success, failed


def deg2rad(theta):
    rads = (2 * pi)/(360) * theta
    return rads


class Vector3d:
    def __init__(self, x, y, z):
        try:
            self.x = float(x)
            self.y = float(y)
            self.z = float(z)
        except ValueError:
            raise ValueError


    # Get the norm 
    def norm(self) -> float:
        norm = sqrt(self.x**2 + self.y**2 + self.z**2)
        return norm

    
    def set(self, x, y, z):
        try:
            self.x = x
            self.y = y
            self.z = z
        except ValueError:
            raise ValueError


    # Construct a vector from spherical coordinates 
    # the angles should be in radians
    def from_spherical(self, **kwargs):
        try:
            phi = float(kwargs["rotation"])
            theta = float(kwargs["azimuth"])
            r = float(kwargs["radius"])
        except ValueError:
            raise ValueError 

        self.x = r * sin(theta) * cos(phi)
        self.y = r * sin(theta) * sin(phi)
        self.z = r * cos(phi)

   
    # modifying the add method (a + b) for Vector3d objects
    def __add__(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector 

        x, y, z = self.x + v.x, self.y + v.y, self.z + v.z

        return Vector3d(x, y, z)


    # modifying the subtract method (a - b) for Vector3d objects
    def __sub__(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector

        x, y, z = self.x - v.x, self.y - v.y, self.z - v.z

        return Vector3d(x, y, z)


    # modifying the multiplication operator (a * b) for Vector3d objects 
    # if a is a scalar, it just returns a scaled vector 
    # if a is a vector, it returns the scalar product as a float or int
    def __mul__(self, a):
        if type(a) == int or type(a) == float:
            x = a * self.x
            y = a * self.y
            z = a * self.z

            return Vector3d(x, y, z)
        
        elif a.__class__ == Vector3d:
            scalar_product = self.x * a.x + self.y * a.y + self.z * a.z
            return scalar_product 


    # cross product
    def cross(self, v):
        if v.__class__ != Vector3d:
            raise NotA3dVector 
        
        x = self.y * v.z - self.z * v.y 
        y = -1 * (self.x * v.z - self.z * v.x) 
        z = self.x * v.y - self.y * v.x

        return Vector3d(x, y, z)

        
    # Get the difference of angle between two angles
    def angle_diff(self, v) -> float:
        angle = acos((self*v)/(self.norm()*v.norm()))
        return angle

    
    # This method projects a vector onto a Plane or a Vector3d
    # Usage: v.project(a)
    # Where v is a Vector3d and a is a Plane or a Vector3d
    def project(self, a):
        if a.__class__ == Plane:
            n = a.normal()
            alpha = self.angle_diff(n)
            u_norm = (self.norm())*(cos(alpha))
            t = u_norm/(n.norm())
            u = Vector3d(t*(n.x), t*(n.y), t*(n.z)) 
            projected = (self - u) + a.origin

        elif a.__class__ == Vector3d:
            alpha = self.angle_diff(a)
            u_norm = self.norm() * cos(alpha)
            t = u_norm/(a.norm())
            projected = Vector3d(t*(a.x), t*(a.y), t*(a.z))

        else:
            raise MethodNotDefinedForClass(a.__class__)

        return projected


# A plane is just defined by a pair of basis vectors
class Plane:
    def __init__(self, i, j, origin):
        if i.__class__ == Vector3d and j.__class__ == Vector3d and origin.__class__ == Vector3d:
            self.i = i 
            self.j = j
            self.origin = origin
        else:
            raise NotA3dVector

    def normal(self):
        i = self.i 
        j = self.j
        return i.cross(j)




#===========TESTS===========#

FLOAT_OPERATION_ERROR = 0.0001


#tests if vector addition works
def test_vector_addition():
    v_x, v_y, v_z = 1, 1, 1 
    u_x, u_y, u_z = 1, 7.3, 1 


    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    sum_v = v + u

    if sum_v.x - (v_x + u_x) < FLOAT_OPERATION_ERROR and sum_v.y - (v_y + u_y) < FLOAT_OPERATION_ERROR and sum_v.z - (v_z + u_z) < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False

#tests if vector subtraction works
def test_vector_subtraction():
    v_x, v_y, v_z = 1, 1, 1 
    u_x, u_y, u_z = 1, 7.3, 1 


    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    diff_v = v - u

    if (diff_v.x  - (v_x - u_x)) < FLOAT_OPERATION_ERROR and (diff_v.y - (v_y - u_y)) < FLOAT_OPERATION_ERROR and (diff_v.z - (v_z - u_z)) < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False

#tests if vector dot product works
def test_dot_product():
    v_x, v_y, v_z = 1, 1, 1 
    u_x, u_y, u_z = 1, 7.3, 1 

    v, u = Vector3d(v_x, v_y, v_z), Vector3d(u_x, u_y, u_z)

    if (v*u - (v_x*u_x + v_y*u_y + v_z*u_z)) < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False

#tests if scalar multiplication works properly
def test_scalar_multiplication():
    v_x, v_y, v_z = 1, 2, 3 
    t = 3 
    
    v = Vector3d(v_x, v_y, v_z)
    diff_v = (v - Vector3d(t*v_x, t*v_y, t*v_z)) 

    if diff_v.x < FLOAT_OPERATION_ERROR and diff_v.y < FLOAT_OPERATION_ERROR and diff_v.z < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False

#test vector projection onto vector
def test_projection_on_vector():
    expected = Vector3d(1,1,0)
    v = Vector3d(1,1,1)
    u = Vector3d(1,1,0)
    proj = v.project(u)
    if proj.x - expected.x < FLOAT_OPERATION_ERROR and proj.y - expected.y < FLOAT_OPERATION_ERROR and proj.z - expected.z < FLOAT_OPERATION_ERROR:
        return True
    else:
        return False

#test vector projection onto plane
def test_projection_on_plane():
    expected = Vector3d(1,2,1)
    plane = Plane(Vector3d(0,1,0), Vector3d(0,0,1), Vector3d(1,0,0))
    v = Vector3d(-1,2,1)
    proj = v.project(plane)
    if proj.x - expected.x < FLOAT_OPERATION_ERROR and proj.y - expected.y < FLOAT_OPERATION_ERROR and proj.z - expected.z < FLOAT_OPERATION_ERROR:
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
