#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

echo 'local.zshenv'
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PIPENV_VENV_IN_PROJECT=true
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

## Rubyenv
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
## GO
if [ -z "${GOPATH:-}" ]; then
  export GOPATH=$HOME/go
  PATH=$GOPATH/bin:$PATH
fi
## Godmine
GODMINE_ENV='coore_sui46 coore_sud53'
PATH="$HOME/bin:$PATH"

echo $PATH

