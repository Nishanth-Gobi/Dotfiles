#!/bin/bash

# Set the variable to 0 if it doesn't exist
if [[ ! -f script_execution_count.txt ]]; then
  echo "0" > script_execution_count.txt
fi

# Read the value from the file and increment it
SCRIPT_EXECUTION_COUNT=$(($(cat script_execution_count.txt)+1))

# Save the new value to the file
echo "${SCRIPT_EXECUTION_COUNT}" > script_execution_count.txt


if [[ ${SCRIPT_EXECUTION_COUNT} -eq 1 ]]; then

	# ------------------------------------------------
	# setup Time Machine
	# ------------------------------------------------

	while true; do

		read -p "Have you setup Time Machine? (y/n)" choice
		if [ $choice = "y" ]; then
			break
		else
			read -p "Are you sure you want to skip Time Machine setup? (y/n)" choice

			if [$choice = "y"]
				echo "Wohoo! I sense an adventure ahead!"
				break
			else
				echo "You can't have it both ways!"
			fi
		fi
	done
		

	# ------------------------------------------------
	# install homebrew
	# ------------------------------------------------

	count=0
	while true; do
		
		if command -v brew >/dev/null 2>&1; then
			echo "Homebrew is installed"
		else
			echo "Homebrew is not installed!"
			count=$((count+1))
			if [[ $count -ge 4 ]]; then
				echo "Failed to install Homebrew after 3 attemps!"
				exit 1
			fi
		fi

		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
	done


	# ------------------------------------------------
	# install GUI apps
	# ------------------------------------------------
	echo "Installing GUI apps..."
	xargs brew install --cask < gui_apps.txt
	echo "Installde GUI apps"


	# ------------------------------------------------
	# install Terminal apps
	# ------------------------------------------------
	echo "Installing Terminal apps..."
	xargs brew install < terminal_apps.txt
	echo "Installed Terminal apps..."


	# ------------------------------------------------
	# setup fish
	# ------------------------------------------------
	if command -v fish >/dev/null 2>&1; then
		echo "Fish shell is installed"
	else
		echo "Fish shell is not installed"
		exit 1
	fi

	fish_path=$(which fish) 

	# add it to the shells list

	sudo echo $fish_path >> /etc/shells
	echo "Added fish to shells list"
	echo "Restart terminal and re-run script..."


elif [[ ${SCRIPT_EXECUTION_COUNT} -eq 2 ]]; then

	fish_path=$(which fish) 

	# change default shell

	chsh -s $fish_path
	echo "Changed default shell"
	echo "Restart terminal and re-run script..."

elif [[ ${SCRIPT_EXECUTION_COUNT} -eq 3 ]]; then

	# ------------------------------------------------
	# setup git
	# ------------------------------------------------

	if command -v git >/dev/null 2>&1; then
		echo "Git is installed"
	else
		echo "Git is not installed"
  		exit 1
	fi

	echo "Setting up git..."

	git config --global user.name "Nishanth Gobi"
	git config --global user.email "nish.professional@gmail.com"
	git config --global init.defaultBranch main

	echo "Make sure to setup your GitHub SSH Key"
	
	echo -e "*** Good luck on your Mac journey :) \n This script is done! ***"
fi
