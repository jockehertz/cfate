from colorama import Fore

def print_error(message, solution):
    print("\n", Fore.RED, "Error:", Fore.RESET, message)
    print(Fore.GREEN, "Possible solution: ", Fore.RESET, solution, "\n")

# returns a dict of structure {word (str): count (int)}
def read_word_counts_from_file(file):
    word_dict = dict()
    lines = file.readlines()

    for line in lines:
        words = line.split()

        for word in words:
            lower_word = word.lower()

            if lower_word in word_dict and lower_word.isalpha():
                word_dict[lower_word] += 1

            elif not lower_word in word_dict and lower_word.isalpha():
                word_dict[lower_word] = 1

    return word_dict


#kwargs: main, compare
def get_dict_diff(**kwargs):
    main = kwargs["main"]
    compare = kwargs["compare"]
    diff_dict = dict()

    for word in main:
        if not word in compare:
            diff_dict[word] = main[word]

    return diff_dict


def main():
    filepath = input("What file should be analysed? ").strip()

    try: 
        file = open(filepath, encoding="utf-8", errors="ignore")
    except FileNotFoundError as error:
        print_error(error, "Check that the file path is correct, contains no misspellings, and that the file exists")
        print("Exiting since an error was encountered")
        return

    all_words = read_word_counts_from_file(file)
    file.close()

    common_words_file = open("vanligaord.txt", encoding="utf-8", errors="ignore")
    common_words = read_word_counts_from_file(common_words_file)
    common_words_file.close()

    uncommon_words = get_dict_diff(main=all_words, compare=common_words)
    
    for word in uncommon_words:
        if uncommon_words[word] > 1:
            print(f"{word} occured {uncommon_words[word]} times.")
        else:
            print(f"{word} occured {uncommon_words[word]} time.")


if __name__ == "__main__":
    main()
