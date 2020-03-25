export DISPLAY=localhost:0.0
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

bindkey "jj" vi-cmd-mode
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/taopypy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
export EDITOR=vim

alias ll='ls -l'
alias la='ls -la'
alias reload='exec $SHELL -l'

function gt (){
    case $1 in
        ws)
            cd ~/workspace
            ls
            :;;
        til|t)
            cd ~/workspace/TIL
            ls
            :;;
        akane|a)
            cd ~/workspace/akane;ls
            :;;
        "akane-app"|aapp)
            cd ~/workspace/akane;ls
            :;;
        "akane-engine"|aegn)
            cd ~/workspace/akane;ls
            :;;
        ec2|e)
            cd ~/workspace/ec2_manager;ls
            :;;
        WS)
            cd ~/winhome/workSpace/
            ls
            :;;
        wp)
            cd /home/taopypy/winhome/workSpace/wpProductions;ls
            :;;
        "cobalt-app"|capp)
            cd ~/winhome/workSpace/cobalt/responsive_on_rails;ls
            :;;
        "cobalt-engine"|cegn)
            cd ~/winhome/workSpace/cobalt/coore_on_rails;ls
            :;;
    esac
}


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
#にほんごを打ち込む

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
eval "$(anyenv init -)"

export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"

export PATH="/home/linuxbrew/.linuxbrew/opt/mysql@5.7/bin:$PATH"
export BUNDLEV=""

alias ls='ls --color=auto'
function bd(){
    rbenv exec bundle $BUNDLEV $@
}
alias bconf='bd config --local local.coore_on_rails $1'
alias bi='bd install --path vendor/bundle'
alias be='bd exec'
alias g='git'
function chanGem(){
    echo $1,$2
    nn=$(grep -e $1 -n Gemfile |tail -n 1|sed -e 's/:.*//g')
    ee="$nn s#$1#$2#g"
    sed -i ".back" -e "$ee" Gemfile
 }

alias load_redmine_auth_token="curl -b cookie.txt -c cookie.txt -s -L http://redmine2.s-rep.net:1080/login | xmllint --html --xpath '//input[@name=\"authenticity_token\"]/@value' -|grep -o -E '\"[0-9a-zA-Z=/]*\"' | sed 's/\"//g'"
alias login_redmine="load_redmine_auth_token && curl -b cookie.txt -c cookie.txt -d username=iwasaki -d password=xier7aeD -d authenticity_token=\$(load_redmine_auth_token) -s -L http://redmine2.s-rep.net:1080/login"
alias load_my_tickets="curl -b cookie.txt -c cookie.txt -s -L 'http://redmine2.s-rep.net:1080/issues?c%5B%5D=project&c%5B%5D=priority&c%5B%5D=subject&f%5B%5D=status_id&f%5B%5D=assigned_to_id&f%5B%5D=&group_by=&op%5Bassigned_to_id%5D=%3D&op%5Bstatus_id%5D=o&set_filter=1&sort=priority%3Adesc%2Cid%3Adesc&utf8=%E2%9C%93&v%5Bassigned_to_id%5D%5B%5D=me' | xmllint --html --xpath '//table/tbody/tr/td[@class=\"subject\"]' - 2>/dev/null"
alias load_list_my_tickets="load_my_tickets | sed 's#<td class=\"subject\">##g' |sed 's#</td>#@#g' | sed -e 's/&amp;/＆/g' -e 's/&quot;/\"/g' | tr '@' '\n'| xargs -IXXX echo XXX"
alias load_md_list_my_tickets="load_list_my_tickets | sed 's#</a>##g' | sed 's#<a href=/issues/#- [ ] \##g' | tr '>' ' '"

alias gsed='sed'

function _scp_validfile(){
    case $1 in
        c|cobalt)
            ssh cobalt "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/winhome/Downloads/$2 cobalt:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
        c2|cobalt2)
            ssh cobalt2 "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/winhome/Downloads/$2 cobalt2:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
        ind|indigo)
            ssh indigo "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/winhome/Downloads/$2 indigo:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
    esac
}
alias scp_validfile='_scp_validfile'

function _cp_crt2key(){
    domain=$(echo $1 | sed -E 's/^.*(http|https):\/\/([^/]+).*/\2/g')
    a=$(echo $domain | tr '.' '_')
    downloaded_dir=~/winhome/Downloads/$a
    if [ ! -e $downloaded_dir ]; then
        cd ~/winhome/Downloads/
        unzip $a.zip -d $downloaded_dir
    fi
    \cp -f $downloaded_dir/$a.crt ~/workspace/chef-repo/tools/ssl/key/$domain.key
    cd ~/workspace/chef-repo/tools/ssl/
}
alias cp_crt2key='_cp_crt2key'

function _validate_auth_file(){
    domain=$(echo $1 | sed -E 's/^.*(http|https):\/\/([^/]+).*/\2/g' | sed 's/www.//g')
    if diff -s <(curl http://$domain/.well-known/pki-validation/$2) <(cat ~/winhome/Downloads/$2) > /dev/null 2>&1 ; then
        echo 'OK'
    else
        echo 'no'
    fi
}
alias validate_af='_validate_auth_file'

alias npm='nodenv exec npm'
alias yarn='nodenv exec yarn'

umask 002

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
