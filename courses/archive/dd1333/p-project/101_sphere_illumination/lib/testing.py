from colorama import Fore


# This module just has syntactic sugar for printing positive and negative
# # test case messages.
def success(message):
    print(Fore.GREEN, message, Fore.RESET)


def failed(message):
    print(Fore.RED, message, Fore.RESET)
