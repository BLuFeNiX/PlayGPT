# chatgpt

Runs a sharable ChatGPT docker container using the [acheong08/ChatGPT](https://github.com/acheong08/ChatGPT) API and [elisescu/tty-share](https://github.com/elisescu/tty-share).

## Setup

1. Clone this repo.
2. Create a `config.json` within the `game` directory. The format of the JSON file must match the format [specified by the acheong08/ChatGPT API](https://github.com/acheong08/ChatGPT/wiki/Setup).

## Usage

```
./run.sh [--public]
```

This will build and run the docker container.
