# dotbox

> Run a full-fledged dotfiles environment with a single command

## Features

- Based on Alpine Linux
- Zsh (+syntax-highlighting +autosuggestions)
- Vim 8 (+linters +git)
- Git
- fzf (+history-bindings)
- Docker CLI
- Awesome tools: autojump, bat, fd, ripgrep
- Lightweight: just under 200 MB!

## Usage

```bash
$ docker run \
	--rm -it \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v dotbox-data:/root/.local \
	mperezi/dotbox:latest
```

Please note that:

* You can run Docker commands _on the host_ by mounting the unix socket exposed by your Docker daemon and available through /var/run/docker.sock.
* As Docker containers are stateless by default, data generated in a session like shell history or the autojump database would be lost when you exit the shell and therefore the container ceases to exist. You can use a named volume (e.g. dotbox-data) to persist this data across sessions.