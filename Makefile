ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

PLUGIN_DIRECTORY = plugins
TPM              = ${PLUGIN_DIRECTORY}/tpm

clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux.conf
	rm -fr $(PLUGIN_DIRECTORY)
	#
	gem uninstall --all --user-install tmuxinator || true

install: | plugin ${HOME}/.tmux
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator
	#
	gem install --user-install tmuxinator

${HOME}/.tmux:
	ln -snf ${ROOT_DIR} ${HOME}/.tmux

plugin: | ${TPM}
	mkdir -p $(PLUGIN_DIRECTORY)

${TPM}:
	git clone --quiet https://github.com/tmux-plugins/tpm ${TPM}
