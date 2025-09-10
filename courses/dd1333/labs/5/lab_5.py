#preamble

class AminoAcid:
    def __init__(self, marker, name, property, weight):
        self.marker = marker 
        self.name = name 
        self.property = property 
        self.weight = weight

class Peptide:
    def __init__(self, sequence, weight):
        self.sequence = sequence 
        self.weight = weight

DATA_FILE_PATH = "aminosyror.txt"

MODES = {
        "list": "1",
        "save_sequence": "2",
        "list_sequences": "3",
        "exit": "4"
        }

INPUT_MODE_MESSAGE = """
Välj ett av följande:
1 - Lista alla aminosyror 
2 - Spara en sekvens av aminosyror (peptid)
3 - Lista alla sekvenser sorterade i viktordning
4 - Avsluta
Ditt val: """

INVALID_INPUT_MODE_MESSAGE = """
Inte ett alternativ!

Försök igen - Välj ett av följande:
1 - Lista alla aminosyror 
2 - Spara en sekvens av aminosyror (peptid)
3 - Lista alla sekvenser sorterade i viktordning
4 - Avsluta
Ditt val: """


#imports
from colorama import Fore 
import sys


def print_error(message, solution):
    print("\n", Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible Solution:", Fore.RESET, solution, "\n")

def construct_acid_dictionary(data_file):
    acid_dict = dict()
    lines = data_file.readlines()
    for line in lines:
        words = line.split()

        marker = words[0].strip()
        name = words[1].strip()
        property = words[2].strip()
        try:
            weight = float(words[3].strip())
        except ValueError as error:
            raise error

        acid_dict[marker] = AminoAcid(
                marker,
                name,
                property,
                weight
                )
    return acid_dict


def list_acids(acids):
    print("Markör\tNamn\tEgenskap\tVikt")
    for acid in acids:
        values = acids[acid]
        marker = values.marker
        name = values.name 
        property = values.property
        weight = values.weight 
        print(f"{marker}\t{name}\t{property}\t{weight}")


def construct_peptide(sequence, acids):
    weight = 0
    sequence = sequence.strip()

    for marker in sequence:
        try:
            weight += acids[marker].weight 
        except KeyError as error:
            raise error

    return Peptide(sequence, weight)


def print_list_of_peptides(peptides):
    print("Sekvens\tVikt")
    for peptide in peptides:
        print(f"{peptide.sequence}\t{peptide.weight}")



def main():
    print("reading aminoacids...")
    try:
        data_file = open(DATA_FILE_PATH)
    except FileNotFoundError as error:
        print_error(error, "make sure that aminosyror.txt exists in the same directory as the program")
        sys.exit(1)
        
    try:
        amino_acids = construct_acid_dictionary(data_file)
    except ValueError as error:
        print_error(error,
                    "Make sure that the file with acids has correct format for the weights")
        sys.exit(1)
    data_file.close()
    print("...done\n")


    
    peptides = list()

    while True:
        mode = input(INPUT_MODE_MESSAGE)

        while not mode in MODES.values():
            mode = input(INVALID_INPUT_MODE_MESSAGE)

        if mode == MODES["list"]:
            list_acids(amino_acids)

        elif mode == MODES["save_sequence"]:
            sequence = input("Sekvens: ")
            try:
                peptide = construct_peptide(sequence, amino_acids)
            except KeyError as error_value:
                print_error(f"Marker {error_value} does not exist",
                            "Only use amino acid markers that exist in the list of amino acids")
                continue

            peptides.append(peptide)

        elif mode == MODES["list_sequences"]:
            sorted_peptides = sorted(peptides, key=lambda x: x.weight, reverse=True)
            print_list_of_peptides(sorted_peptides)


        elif mode == MODES["exit"]:
            print("\nExiting\n")
            break


if __name__ == "__main__":
    main()
