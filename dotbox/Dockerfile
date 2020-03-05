FROM alpine:3.10

LABEL maintainer="Miguel Pérez <https://github.com/mperezi>"

ENV TERM xterm-256color

RUN apk add --no-cache \
		git curl less bash zsh vim python3 \
		zsh-vcs fzf docker-cli && \
	rm -rf /usr/share/vim/vim*/doc && \
	find /usr/lib/python3* -type d -name __pycache__ | xargs rm -rf
RUN ln -sf /usr/bin/python3 /usr/bin/python

COPY install_custom.sh /usr/bin/install_custom.sh
RUN /usr/bin/install_custom.sh

RUN bash -c "$(curl -sL https://raw.githubusercontent.com/mperezi/dotfiles/master/install.sh)" && \
	find $HOME/.dotfiles -type d -name .git | xargs rm -rf && \
	rm -rf $HOME/.dotfiles/macos

CMD ["/bin/zsh"]
