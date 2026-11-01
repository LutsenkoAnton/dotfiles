# Setting xdg variables
if [[ -z ${XDG_CONFIG_HOME+x} ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -z ${XDG_CACHE_HOME+x} ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
if [[ -z ${XDG_DATA_HOME+x} ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [[ -z ${XDG_STATE_HOME+x} ]]; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi
if [[ -z ${XDG_DATA_DIRS+x} ]]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi
if [[ -z ${XDG_CONFIG_DIRS+x} ]]; then
    export XDG_CONFIG_DIRS="/etc/xdg"
fi

# Setting PATH
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi
if [[ -d "$HOME/perl5/bin" ]]; then
    export PATH="$PATH:$HOME/perl5/bin"
fi
if [[ -d "$HOME/.local/share/gem/ruby/3.0.0/bin" ]]; then
    export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
fi
if [[ -d "/usr/local/sbin" ]]; then
    export PATH="$PATH:/usr/local/sbin"
fi
if [[ -d "/usr/local/bin" ]]; then
    export PATH="$PATH:/usr/local/bin"
fi
if [[ -d "/usr/bin" ]]; then
    export PATH="$PATH:/usr/bin"
fi
if [[ -d "/usr/lib/jvm/default/bin" ]]; then
    export PATH="$PATH:/usr/lib/jvm/default/bin"
fi
if [[ -d "/usr/bin/site_perl" ]]; then
    export PATH="$PATH:/usr/bin/site_perl"
fi
if [[ -d "/usr/bin/vendor_perl" ]]; then
    export PATH="$PATH:/usr/bin/vendor_perl"
fi
if [[ -d "/usr/bin/core_perl" ]]; then
    export PATH="$PATH:/usr/bin/core_perl"
fi
if [[ -d "/home/anton/Documents/hse/curs/code/mapf-visualizer/bin" ]]; then
    export PATH="$PATH:/home/anton/Documents/hse/curs/code/mapf-visualizer/bin"
fi
if [[ -d "$(go env GOPATH)/bin" ]]; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi
if [[ -d "/home/anton/.config/foundry/bin" ]]; then
    export PATH="$PATH:/home/anton/.config/.foundry/bin"
fi

if [[ -d "/home/anton/.ghcup/bin" ]]; then
    export PATH="$PATH:/home/anton/.ghcup/bin"
fi

# Clippy
if [ -f '/home/anton/Documents/hse/concurrency/workspace/concurrency-course/client/activate' ]; then . '/home/anton/Documents/hse/concurrency/workspace/concurrency-course/client/activate'; fi

if [[ -d "/usr/share/gcc-14.2.1/python" ]]; then
    export PYTHONPATH="$PYTHONPATH:/usr/share/gcc-14.2.1/python"
fi

# Setting editor and browser
if [[ -x $(command -v neovide) ]]; then
    export EDITOR='neovide'
elif [[ -x $(command -v nvim) ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
if [[ -x $(command -v qutebrowser) ]]; then
    export BROWSER='qutebrowser'
elif [[ -x $(command -v lynx) ]]; then
    export BROWSER='lynx'
else
    export BROWSER='elinks'
fi


export PATH="$PATH:/home/anton/.config/.foundry/bin"

# The next line updates PATH for CLI.
if [ -f '/home/anton/yandex-cloud/path.bash.inc' ]; then source '/home/anton/yandex-cloud/path.bash.inc'; fi

