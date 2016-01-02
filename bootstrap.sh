
#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";	

rsync \
	--exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "bootstrap.sh" \
	--exclude "README.md" \
	--exclude "brew.sh" \
	--exclude "init.sh" \
	--exclude ".osx" \
	--exclude "config/" \
	--exclude ".idea/" \
	--exclude "LICENSE-MIT.txt" -avh --no-perms . ~;
