
export PATH="/usr/local/opt/python/libexec/bin:/usr/local/sbin:$PATH"

export WORKON_HOME=$HOME/Repos/_virtualenvs

mkenv() {
    python -m venv "${WORKON_HOME}/${1}"
}

workon() {
	if [[ "$1" != "" ]]; then
    	source "${WORKON_HOME}/${1}/bin/activate"
    else
    	ls "${WORKON_HOME}"
    fi
}
