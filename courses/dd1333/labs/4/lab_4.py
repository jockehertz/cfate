#preamble


COUNTRY_DATA_FILEPATH = "europa.txt"

class Country:
    def __init__(self, name, population, landlocked):
        self.name = name
        self.population = population
        self.landlocked = landlocked


class InvalidFormat(Exception):
    def __init__(self, value):
        self.value = value


#imports

from colorama import Fore
import sys


def print_error(message, solution):
    print("\n", Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible solution:", Fore.RESET, solution, "\n")


def read_country_data_to_list(file):
    country_data = list()
    lines = file.readlines()
    lines.pop(0)

    for line in lines:
        words = line.split(",")
        name = words[0].strip()
        try:
            pop = int(words[2].strip())
        except ValueError as error:
            raise error 

        landlocked = words[3].strip()

        if landlocked == "Y":
            landlocked = True

        elif landlocked == "N":
            landlocked = False

        else:
            raise InvalidFormat(f"\"landlocked\" incorrectly formatted for {name}")

        country_data.append(Country(name, pop, landlocked))

    return country_data



def filter_landlocked(country_list):
    landlocked_countries = list()

    for country in country_list:

        if country.landlocked:
            landlocked_countries.append(country)

    return landlocked_countries 


def sum_country_populations(country_list):
    total_population = 0
    for country in country_list:
        total_population += country.population

    return total_population 


def main():
    country_data_file = open(COUNTRY_DATA_FILEPATH, encoding="utf-8")
    try:
        country_data = read_country_data_to_list(country_data_file)
    except ValueError as error:
        print_error(
                f"Value {error} incorrectly formatted.",
                "Make sure that the format in the file is correct for all fields."
                )
        sys.exit(1)
    except InvalidFormat as error:
        print_error(
                error,
                "Make sure that the format in the file is correct for all fields."
                )
        sys.exit(1)


    landlocked_countries = filter_landlocked(country_data)

    if len(landlocked_countries) > 1:
        print("In Europe, the following countries have no access to ocean:")

        for country in landlocked_countries:
            print(country.name)

    elif len(landlocked_countries) == 1:
        print("In Europe, the following country has no access to ocean:")
        print(landlocked_countries[0])

    else:
        print("All countries in Europe have access to ocean.")

    total_population = sum_country_populations(landlocked_countries)

    print(f"There are in total {total_population} inhabitants in these {len(landlocked_countries)} countries.")

    

if __name__ == "__main__":
    main()
