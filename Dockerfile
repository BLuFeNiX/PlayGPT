FROM ubuntu:22.04

# ---------------------------------------------------
# Basic system requirements
# ---------------------------------------------------

RUN apt-get update && apt-get install -y --no-install-recommends \
	python3 \
	python-is-python3 \
	python3-pip \
 && rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------
# Transition from root to a user matching a host UID,
#  to avoid file ownership issues on the host
# ---------------------------------------------------

ARG HOST_UID=1000
RUN useradd -m -u ${HOST_UID} user
USER user

# ---------------------------------------------------
# Install pip packages
# ---------------------------------------------------

ENV PATH="$PATH:/home/user/.local/bin"
RUN pip3 install revChatGPT colorama --upgrade


# ---------------------------------------------------
# Default to a shell
# ---------------------------------------------------

ENTRYPOINT [ "bash", "-l" ]
