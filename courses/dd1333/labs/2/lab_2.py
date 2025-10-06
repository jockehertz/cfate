#preamble

MODES = {
        "input": "1",
        "fetch_results": "2",
        "exit": "3"
        }

INPUT_MESSAGE = """
Modes for the program:
1 - Input the results of the participants
2 - See statistics for the participants 
3 - Exit
"""

INVALID_MODE_MESSAGE = """
Valid modes for the program:
1 - Input the results of the participants
2 - See statistics for the participants 
3 - Exit
"""

#imports
import statistics
from colorama import Fore

#functions


#this function gets user input
def input_participants():
    try:
        participant_count = int(input("Input the number of participants: ").strip())
    except:
        print(Fore.RED, "Error:", Fore.RESET, "Error taking input.")
        return None

    if participant_count < 2:
        print("\n", Fore.RED, "Error:", Fore.RESET, "Participant count must be at least 2\n")
        return None

    participant_data = []

    for i in range(0, participant_count):
        try:
            result = float(input(f"Enter the result for participant {i + 1}: "))
        except:
            print(Fore.RED, "Error:", Fore.RESET, "Error taking input.")
            return None

        participant_data.append(result)

    return participant_data


#this function fetches the results
#data should be a list of floats
def fetch_results(data):
    results = dict()
    results["mean"] = statistics.mean(data)
    results["stdev"] = statistics.stdev(data)
    results["maximum"] = max(data)
    results["minimum"] = min(data)

    return results


#main program

def main():
    data = []

    while True:
        print(INPUT_MESSAGE)

        #mode selection at the start of each loop.
        mode = input("Choose mode: ").strip()
        
        #if the mode in the input is not a valid input for the modes, try getting the input again.
        while not mode in MODES.values():
            print("\n", Fore.RED, "Error:", Fore.RESET, "Invalid mode\n", INVALID_MODE_MESSAGE)
            mode = input("Choose mode again: ").strip()

        #input mode
        if mode == MODES["input"]:
            data = input_participants()

            if data == None:
                print("\n", Fore.RED, "Error:", Fore.RESET, "Invalid data input, must be a decimal number (float)")
                data = []


        #result display mode
        elif mode == MODES["fetch_results"]:

            #statistics.mean() only works with at least 2 data points.
            data_len = len(data)
            if data_len > 1:
                results = fetch_results(data)
                print(f"\nThe mean is {results["mean"]} with a standard deviation of {results["stdev"]}. The highest result was {results["maximum"]} and the lowest was {results["minimum"]}")
            elif data_len == 1:
                print("\n", Fore.RED, "Error:", Fore.RESET, "The program requires more than 1 data point to work.")
            else:
                print("\n", Fore.RED, "Error:", Fore.RESET, "There is no data. Please use the data input mode to give the program data.")

        #break out of the loop if the user wants to exit.
        elif mode == MODES["exit"]:
            break

    print("\nExiting\n")


#execute the main program
if __name__ == "__main__":
    main()
