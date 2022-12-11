# chatgpt

Runs a sharable ChatGPT docker container using the [acheong08/ChatGPT](https://github.com/acheong08/ChatGPT) API and [elisescu/tty-share](https://github.com/elisescu/tty-share).

## Setup

1. Clone this repo.
2. Create a `config.json` within the `game` directory. The format of the JSON file must match the format [specified by the acheong08/ChatGPT API](https://github.com/acheong08/ChatGPT/wiki/Setup).

## Usage

```
./run.sh
```

You can also pass any arg that `tty-share` accepts to customize your setup.

Ex:
```
./run.sh --public --headless --headless-cols 160 --headless-rows 50
```

### Interacting with ChatGPT

You can directly use the terminal prompt to interact, as seen here:

```
================================================================
Starting docker container
args: --public
================================================================
public session: https://on.tty-share.com/s/REDACTED/
local session: http://172.17.0.2:8000/s/local/
Logging in...
Welcome to the game! Begin by entering an initial prompt for the AI.
NOTE: You must press [enter] TWICE to submit messages.
> This is a test.

Hello! I am Assistant, a large language model trained by OpenAI. I am here to help you with any
questions you may have. Is there anything specific you would like to know? I am here to assist you.

> 

```

You will also be given a URL (or two, if using `--public`) for others to connect to your session via a web browser (or via `tty-share` in a terminal).

> NOTE: Anyone joining a session will not see output history. The screen will be blank until something is typed or new text is printed.

