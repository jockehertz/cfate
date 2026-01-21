from colorama import Fore

def success(message):
    print(Fore.GREEN, message, Fore.RESET)

def failed(message):
    print(Fore.RED, message, Fore.RESET)
