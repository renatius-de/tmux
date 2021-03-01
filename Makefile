ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

PLUGIN_DIRECTORY = plugins
TPM              = ${PLUGIN_DIRECTORY}/tpm

clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux.conf
	rm -fr $(PLUGIN_DIRECTORY)
	rm -fr ${HOME}/.rvm
	#
	gem uninstall --all --user-install tmuxinator || true

install: | plugin ${HOME}/.tmux ${HOME}/.tmuxinator
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf

${HOME}/.tmux:
	ln -snf ${ROOT_DIR} ${HOME}/.tmux

${HOME}/.tmuxinator: | ${HOME}/.rvm
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator
	#
	gem install --user-install tmuxinator

${HOME}/.rvm:
	gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable -- --ignore-dotfiles
	#
	${HOME}/.rvm/bin/rvm get stable
	source ${HOME}/.rvm/scripts/rvm

plugin: | ${TPM}
	mkdir -p $(PLUGIN_DIRECTORY)

${TPM}:
	git clone --quiet https://github.com/tmux-plugins/tpm ${TPM}
