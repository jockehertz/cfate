def calculate_interest(initial_amount, time, interest):
    change_factor = 1 + (interest/100)
    return initial_amount*(change_factor**time)

initial_amount = float(input("Initial amount: "))
time = float(input("The time for which the money grows (years): "))
interest = float(input("The interest (percent/year): "))

print(f"The amount after {time} years at {interest} interest is: {str(calculate_interest(initial_amount, time, interest))}")
