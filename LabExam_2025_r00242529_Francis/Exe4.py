

def check_sentence(sentence):
    print(sentence)
    word_list = sentence.split()
    number_of_words = len(word_list)

    # check if it has number, uppercase
    has_number = False
    has_uppercase = False
    it_has_number = ''
    it_has_uppercase = ''

    for word in word_list:
        # first we check if it is a number
        if word.isdigit():
            has_number = True
            it_has_number = word
        # checn if it is a uppercase
        elif word.isupper():
            has_uppercase = True
            it_has_uppercase = word

    # now we are going to check when contain both
    if has_number and not has_uppercase:
        print(f"Sentence contains {number_of_words} words")
        print(it_has_number)
    if has_uppercase and not has_number:
        print(f"Sentence contains {number_of_words} words")
        print(it_has_uppercase)


while True:
    # collecting the input
    user_input = input("Enter a sentence (write 'end me now' to quit)) >>>")

    # user_input = sys.argv[1]
    # sample = “Hello how are you doing there with you and hello how are we doing it
    # there again”
    if user_input.lower() == 'end me now':
        print("Goodbye my friend...")
        break

    # ensure the user word
    split_words = user_input.split()
    if len(split_words) <= 2:
        print("Please insert a sentence with more than two words...")
        continue

    check_sentence(user_input)
