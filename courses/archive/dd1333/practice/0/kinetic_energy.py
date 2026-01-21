def calculate_kinetic_energy(mass, velocity):
    return (mass * velocity ** 2) / 2

input_mass = float(input("Mass: "))
input_velocity = float(input("Velocity: "))

print(f"The kinetic energy is {str(calculate_kinetic_energy(input_mass, input_velocity))} J")
