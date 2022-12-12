#!/usr/bin/env python3

import json
import textwrap
import shutil
from svglib.svglib import svg2rlg
from colorama import Fore
from colorama import Style

from itertools import islice
from random import randint
from time import sleep

from revChatGPT.revChatGPT import Chatbot

class CaptchaSolver:
    """
    Captcha solver
    """
    @staticmethod
    def solve_captcha(raw_svg):
        # Save the SVG
        with open("/root/game/captcha.png", "w", encoding="utf-8") as f:
            png = svg2rlg(raw_svg)
            f.write(png)
            print("Captcha saved to {f.name}")
        # Get input
        solution = input("Please solve the captcha: ")
        # Return the solution
        return solution


def get_input(prompt):
    # prompt for input
    lines = []
    print(prompt, end="")
    while True:
        line = input()
        if line == "":
            break
        lines.append(line)

    # Join the lines, separated by newlines, and print the result
    user_input = "\n".join(lines)
    # print(user_input)
    return user_input

class FakeChatbot:
    def __init__(*args, **kwargs):
        pass
    def get_chat_response(self, input, rmin=1, rmax=5, delay=0.01, output=None):
        reply = []
        it = iter(f"You told me this!\n\n{input}\n\nThanks for chatting!")
        while True:
            token = list(islice(it,randint(rmin,rmax)))
            if token:
                reply += token
                ret = dict()
                ret['message'] = ''.join(reply)
                sleep(delay)
                yield ret
            else:
                break

def main():
    try:
        term_cols,_ = shutil.get_terminal_size((80, 25))

        with open("config.json", encoding="utf-8") as f:
            config = json.load(f)

        print("Logging in...")
        chatbot = Chatbot(config, debug=False, captcha_solver=CaptchaSolver())
        print("Welcome to the game! Begin by entering an initial prompt for the AI.\nNOTE: You must press [enter] TWICE to submit messages.\n")

        while True:

            print(f"{Style.DIM}", end='');
            prompt = get_input("> ")
            print(f"{Style.RESET_ALL}", end='');
            
            try:
                lines_printed = 0
                formatted_parts = []
                for message in chatbot.get_chat_response(prompt, output="stream"):
                    # replace double newlines with a newline and a NULL
                    # this will let us swap them back to preserve paragraphs
                    msg = message["message"].replace('\n\n', '\n\0')
                    # Split the message by newlines
                    message_parts = msg.split("\n")
                    # restore extra newlines
                    message_parts = [x.replace('\0', '\n') for x in message_parts]

                    # Wrap each part separately
                    formatted_parts = []
                    for part in message_parts:
                        formatted_parts.extend(textwrap.wrap(part, width=term_cols, replace_whitespace=False, break_long_words=False))
                        for _ in formatted_parts:
                            if len(formatted_parts) > lines_printed + 1:
                                print(formatted_parts[lines_printed])
                                lines_printed += 1
                print(formatted_parts[lines_printed])
                print(f"{Style.RESET_ALL}")
            except Exception as e:
                print("Response not in correct format!")
                print(e)
                continue

    except Exception as exc:
        print("Something went wrong!")
        print(exc)
        exit(1)


if __name__ == "__main__":
    main()
