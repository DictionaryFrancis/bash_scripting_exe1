# import libs:
import random
import os
import shutil
import zipfile
import sys

# handling file '.txt'
# if len(sys.argv) != 2:
#     print("Please provide the sentence aas an argument...")
#     # if not exit
#     sys.exit()
# else:
#     print("okay going")

# user_input = sys.argv[1]

def counting_words(sentence):
    # separate/split the sentence into a list
    word_list = sentence.split()
    number_of_words = {}

    for word in word_list:
        # for how and are we are create a if
        if word == 'how' or word == 'are':
            if word not in number_of_words:
                # if it is the list we do not add anymore
                number_of_words[word] = 1

        else:
            if word in number_of_words:
                number_of_words[word] += 1
            else:
                number_of_words[word] = 1

    return number_of_words

while True:
    # collecting the input
    user_input = input("Enter a sentence (write 'finish' to quit)) >>>")

    # user_input = sys.argv[1]
    # sample = “Hello how are you doing there with you and hello how are we doing it
    # there again”
    if user_input.lower() == 'finish':
        print("Goodbye my friend...")
        break

    resultt = counting_words(user_input)
    print(resultt)

