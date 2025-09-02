from potential_energy import calculate_potential_energy

def main():
    mass = float(input("Mass: "))
    height = float(input("Height: "))
    print(f"Lägesenergi: {calculate_potential_energy(mass, height)} J")

main()
