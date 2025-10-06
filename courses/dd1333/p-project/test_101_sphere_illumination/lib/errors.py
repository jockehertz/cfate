# If the user gives a radius of sphere that is smaller than the distance from
# the centerpoint to the light source, this error will be returned.
class RadiusSmallerThanDistance(Exception):
    def __init__(self, value):
        self.value = value 

# If a function recieves something which is not a vaslid 3d vector type, this 
# exception may be raised
class NotA3dVector(Exception):
    pass

class MethodNotDefinedForClass(Exception):
    def __init__(self, value):
        self.value = value
