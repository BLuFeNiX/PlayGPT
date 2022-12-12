FROM ubuntu:22.04

# ---------------------------------------------------
# Basic system requirements
# ---------------------------------------------------

RUN apt-get update && apt-get install -y --no-install-recommends \
	python3 \
	python-is-python3 \
	python3-pip \
	golang-go \
	go-bindata \
	git \
	tmux \
 && rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------
# Install tty-share
# ---------------------------------------------------

WORKDIR /root
ENV GOPATH=/go
ENV GOBIN=/go/bin
RUN git clone https://github.com/elisescu/tty-share.git \
&& cd tty-share \
&& go-bindata --prefix server/frontend/static -o gobindata.go server/frontend/static/* \
&& go build \
&& cp tty-share /usr/bin/ \
&& rm -r $GOPATH


# ---------------------------------------------------
# Transition from root to a user matching a host UID,
#  to avoid file ownership issues on the host
# ---------------------------------------------------

ARG HOST_UID=1000
RUN useradd -m -u ${HOST_UID} user
USER user
ENV USER=user
ENV HOME=/home/user
WORKDIR /home/user

# ---------------------------------------------------
# Install pip packages
# ---------------------------------------------------

ENV PATH="$PATH:/home/user/.local/bin"
RUN pip3 install revChatGPT colorama svglib --upgrade


# ---------------------------------------------------
# Default to a shell
# ---------------------------------------------------

ENTRYPOINT [ "bash", "-l" ]
