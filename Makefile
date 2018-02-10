ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux.conf
	rm -fr plugins

install:
	ln -snf ${ROOT_DIR}/screenrc ${HOME}/.screenrc
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator
	mkdir -p plugins
	git clone https://github.com/tmux-plugins/tpm plugins/tpm
