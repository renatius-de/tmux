SOURCE = ${HOME}/.dotfiles/tmux

clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux.conf
	rm -fr plugins

install:
	ln -snf ${SOURCE}/screenrc ${HOME}/.screenrc
	ln -snf ${SOURCE}/tmux.conf ${HOME}/.tmux.conf
	ln -snf ${SOURCE}/tmuxinator ${HOME}/.tmuxinator
	mkdir -p plugins
	git clone https://github.com/tmux-plugins/tpm plugins/tpm
