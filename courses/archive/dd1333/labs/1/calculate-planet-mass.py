from math import pi

def calculate_planet_mass(t, r):
    G = 6.67 * (10**(-11))
    planet_mass = (4*(pi**2)*(r**3))/(G*(t**2))
    return planet_mass

time = float(input("The time it takes for the satellite to orbit (hours): "))*(60**2)
radius = float(input("The distance from the planet to (1000km): "))*(10**6)

print(f"The planet weighs {str(calculate_planet_mass(time, radius))} Kg.")
