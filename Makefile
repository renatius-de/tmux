ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

PLUGIN_DIRECTORY = plugins

clean:
	rm -f ${HOME}/.screenrc
	rm -f ${HOME}/.tmux.conf
	rm -fr $(PLUGIN_DIRECTORY)
	#
	gem uninstall --all --user-install tmuxinator || true

install: | install_repos ${HOME}/.tmux
	ln -snf ${ROOT_DIR}/screenrc ${HOME}/.screenrc
	ln -snf ${ROOT_DIR}/tmux.conf ${HOME}/.tmux.conf
	ln -snf ${ROOT_DIR}/tmuxinator ${HOME}/.tmuxinator
	#
	gem install --user-install tmuxinator

update: install_repos
	git --work-tree=$(PLUGIN_DIRECTORY)/tpm checkout -f
	git --work-tree=$(PLUGIN_DIRECTORY)/tpm pull
	gem update --user-install tmuxinator

install_repos: | $(PLUGIN_DIRECTORY)/tpm
	mkdir -p $(PLUGIN_DIRECTORY)

$(PLUGIN_DIRECTORY)/tpm:
	git clone https://github.com/tmux-plugins/tpm $(PLUGIN_DIRECTORY)/tpm

${HOME}/.tmux:
	ln -snf $(ROOT_DIR) ${HOME)/.tmux
