HOME := $(shell echo $$HOME)
HOSTNAME := $(shell hostname)
DOTFILES_DIR := $(shell pwd)

# Find all dotfiles except .git, .gitignore, and .bash_profile
DOTFILES := $(filter-out .git .gitignore .bash_profile,$(wildcard .*))

# Determine the shell profile file based on OS
ifeq ($(shell uname),Darwin)
	PROFILE := $(HOME)/.bash_profile
else
	PROFILE := $(HOME)/.bashrc
endif

.PHONY: all install screen bash_profile link_dotfiles

all: install

install: screen bash_profile link_dotfiles

link_dotfiles:
	@for dotfile in $(DOTFILES); do \
		dest="$(HOME)/$$dotfile"; \
		if [ -e "$$dest" ]; then \
			echo "$$dest exists"; \
		else \
			echo "Linking $$dest"; \
			ln -s "$(DOTFILES_DIR)/$$dotfile" "$$dest"; \
		fi; \
	done

screen: .screen-profiles/logo
	@mkdir -p "$(HOME)/bin"
	@if [ -e "$(HOME)/bin/screen-profiles-status" ]; then \
		echo "$(HOME)/bin/screen-profiles-status exists"; \
	else \
		echo "Linking $(HOME)/bin/screen-profiles-status"; \
		ln -s "$(DOTFILES_DIR)/bin/screen-profiles-status" "$(HOME)/bin/screen-profiles-status"; \
	fi

.screen-profiles/logo:
	@echo "Creating a default $@"
	@printf '\005{= wr}$(HOSTNAME) @ ' > $@

bash_profile:
	@if [ -e "$(HOME)/bin/show-colors" ]; then \
		echo "$(HOME)/bin/show-colors exists"; \
	else \
		echo "Linking $(HOME)/bin/show-colors"; \
		ln -s "$(DOTFILES_DIR)/bin/show-colors" "$(HOME)/bin/show-colors"; \
	fi
	@if grep -q 'dotfiles/.bash_profile' "$(PROFILE)" 2>/dev/null; then \
		echo ".bash_profile already mentioned in $(PROFILE); not modifying"; \
	else \
		echo "Sourcing .bash_profile from $(PROFILE)"; \
		printf '\nsource $(DOTFILES_DIR)/.bash_profile\n\nexport PSCOLOR=$$COLOR_GREEN\nexport PSHOST="$(HOSTNAME)"\nexport PSBOLD=1\nexport PSUNDERLINE=\n' >> "$(PROFILE)"; \
	fi
