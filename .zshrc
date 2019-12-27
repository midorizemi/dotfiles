#
###zprezto
source ~/.zplug/init.zsh
zplug "sorin-ionescu/prezto"

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zprezto
zplug "sorin-ionescu/prezto"
# ドラキュラテーマ
#zplug "dracula/zsh", as:theme
# theme (https://github.com/sindresorhus/pure#zplug)　好みのスキーマをいれてくだされ。
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

echo 'source zprezto init'
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
prompt paradox

source ~/.zshenv

eval "$(rbenv init -)"
eval "$(nodenv init -)"

# alias
alias fetchU1='rsync -ahv --progress --checksum u1_webadmin:coore_on_rails/ ~/Documents/workspace/coore_on_rails/'
alias viZrc='vim ~/.zshrc'
alias viZenv='vim ~/.zshenv'
#alias start_u1='ssh potvalley < ~/bin/start_dev_indv_ubuntu01.sh'
#alias start_c1='ssh potvalley < ~/bin/start_dev_indv_centos01.sh'
alias activateV='source ./venv/bin/activate'
alias rsync_checksome='rsync -ahvn --progress --checksum $1 $2'

alias reln='ln -nfs $1 $2'
alias lnls='ll |grep "^l"'

case ${OSTYPE} in
  darwin*)
    alias yesterday='date -v -1d "+%Y%m%d"'
    alias today='date "+%Y%m%d"'
    alias today/='date "+%Y/%m/%d"'
    ;;
  linux*)
    # ここに Linux 向けの設定
    ;;
esac

#GHQ
alias goto='cd `ghq list -p | fzf`'

#Git
alias g='git'

function chanGem(){
    echo $1,$2
    nn=$(grep -e $1 -n Gemfile |tail -n 1|sed -e 's/:.*//g')
    ee="$nn s#$1#$2#g"
    sed -i ".back" -e "$ee" Gemfile
 }

function whoisparent(){
    git show-branch | grep "*" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
}
alias gparent='whoisparent'

function loadu1(){ #廃止
    hoge=$(pwd)
    wrk=`basename $(dirname $hoge)`
    dir=`basename $hoge`
    case $wrk in
        akane) echo akane
            echo "$dir/ ==> u1_webadmin:$wrk/$dir/"
            rsync -auvzh --progress --checksum --delete --exclude='.bundle/' --exclude='tmp/' --exclude='vendor/bundle/' u1_webadmin:$wrk/$dir/ $hoge/
            :;;
        cobalt) echo v5
            echo "$dir/ ==> u1_webadmin:$wrk/$dir/"
            rsync -auvzh --progress --checksum --delete --exclude='.bundle/' --exclude='tmp/' --exclude='vendor/bundle/' u1_webadmin:$wrk/$dir/ $hoge/
            :;;
    esac
}

function deployu1(){ #廃止
    hoge=$(pwd)
    wrk=`basename $(dirname $hoge)`
    dir=`basename $hoge`
    echo "[DRY]"
    localdir=''
    remotedir=''
    echo "Application:[ $wrk ]"
    case $wrk in
        akane) 
            echo "$dir/ ==> u1_webadmin:$wrk/$dir/"
            localdir="$hoge/"
            remotedir="u1_webadmin:$wrk/$dir/";;
        cobalt) 
            echo "$dir/ ==> u1_webadmin:$wrk/$dir/"
            localdir="$hoge/"
            remotedir="u1_webadmin:$wrk/$dir/";;
    esac
    rsync -avn --exclude='tmp/' --exclude='.bundle/' --exclude='vendor/bundle/' --exclude='.DS_Store' $localdir $remotedir
    echo "deploy?(y/N): "
    if read -q; then
        rsync -auvzh --progress --checksum --exclude='.bundle/' --exclude='tmp/' --exclude='vendor/bundle/' --exclude='.DS_Store' $localdir $remotedir
    else
        echo "done"
    fi
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}


# sufics ailias
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N ghq-fzf
bindkey "^]" ghq-fzf

function print_date() {
  zle -U `date "+%y%m%d"`
}
zle -N print_date
bindkey "^Xd" print_date

# export environment
#GHQ
alias goto='cd `ghq list -p | fzf`'

### Rails
alias be='rbenv exec bundle exec'
alias be-t='RAILS_ENV=test rbenv exec bundle exec'
alias bconf='rbenv exec bundle config --local local.coore_on_rails $1'
alias bi='rbenv exec bundle install --path vendor/bundle'
alias brake='(){be bin/rake $1 $2}'
alias brails='(){be bin/rails $1 $2 $3 $4}'
alias brails-t='(){RAILS_ENV=test rbenv exec bundle exec bin/rails $1 $2 $3 $4}'
alias rsq='(){be bin/rails resque:work QUEUE="*"}'

function _appstart(){
    app=`dirname $(pwd)`
    echo $app
    wrk=`basename $app`
    case $wrk in
        akane) echo $wrk
            echo "start AKANE"
            rbenv exec bundle exec bin/rails s -b 127.0.0.1 -p 3030 $1 $2
            ;;
        cobalt) echo $wrk
            echo "start v5"
            rbenv exec bundle exec bin/rails s -b 127.0.0.1 $1 $2
            ;;
    esac
}
alias appstart='_appstart'


## Bundle
alias bi='rbenv exec bundle install --path vendor/bundle'
function use_local(){
    export BUNDLE_GEMFILE="Gemfile.local"
}

function unuse_local(){
    unset BUNDLE_GEMFILE
}

## Files
function _latest(){
    if [ $# -eq 1 ]; then
        ls -1t *.$1 | head -n 1
    else
        ls -1t * | head -n 1
    fi
}
alias latest='_latest'

alias new_dr='kyou="s#[0-9]\{4\}/[0-9]\{2\}/[0-9]\{2\}#$(today/)#g" ; cat $(latest md) | sed "$kyou" > dr_$(today).md'


#WP-CLI
#source ~/wp-completion.bash

#ZIPgetter
# output: xxx-yyyy
# xxx
# yyyy
function _load_zipcode_html() {
  domain=$(echo $1 | sed -E 's/^.*(http|https):\/\/([^/]+).*/\2/g')
  document=$(curl -s -L $1)
  add=$(echo $document\
    | grep -o -E "<span ((class='address__zipcode')|(class='address__item address__item--zipcode')|(itemprop='postalCode'))>〒*[0-9]{3}-[0-9]{4}</span>" \
    | tail -n 1 \
    | grep -o -E '[0-9]{4}|[0-9]{3}' \
    | xargs -L2 \
    | tr " " "/" \
    | xargs -IXXX echo "https://madefor.github.io/postal-code-api/api/v1/XXX.json" \
    | xargs curl -s \
    | jq -c -r ".data[] | .en | .prefecture, .address1" \
    | tr "\n" " " \
    | xargs -IXX echo 'JP XX')

  x=$(echo $document\
      | grep -o -E "<span itemprop='copyrightHolder'>(.+)</span>" \
      | sed -E "s/<[^>]*>//g")
  if [[ -n "$x" ]]; then
    #cobalの時
    echo "$add $x, $domain"
    return
  fi
  y=$(echo $document\
    | grep -o -E "<small>©[0-9]{4}.*&nbsp;All" \
    | sed -E 's/<[^>]*>|©[0-9]{4}|(&nbsp;)*All//g' \
    | sed -E 's/&nbsp;//g')
  if [[ -n "$y" ]]; then
    echo "$add $y, $domain"
    return
  fi
  echo "$add <失敗>, $domain"
}
alias csr_arguments='_load_zipcode_html'

alias load_redmine_auth_token="curl -b cookie.txt -c cookie.txt -s -L http://redmine2.s-rep.net:1080/login | xmllint --html --xpath '//input[@name=\"authenticity_token\"]/@value' -|grep -o -E '\"[0-9a-zA-Z=/]*\"' | sed 's/\"//g'"
alias login_redmine="load_redmine_auth_token && curl -b cookie.txt -c cookie.txt -d username=iwasaki -d password=xier7aeD -d authenticity_token=\$(load_redmine_auth_token) -s -L http://redmine2.s-rep.net:1080/login"
alias load_my_tickets="curl -b cookie.txt -c cookie.txt -s -L 'http://redmine2.s-rep.net:1080/issues?c%5B%5D=project&c%5B%5D=priority&c%5B%5D=subject&f%5B%5D=status_id&f%5B%5D=assigned_to_id&f%5B%5D=&group_by=&op%5Bassigned_to_id%5D=%3D&op%5Bstatus_id%5D=o&set_filter=1&sort=priority%3Adesc%2Cid%3Adesc&utf8=%E2%9C%93&v%5Bassigned_to_id%5D%5B%5D=me' | xmllint --html --xpath '//table/tbody/tr/td[@class=\"subject\"]' -"
alias load_list_my_tickets="load_my_tickets | sed 's#<td class=\"subject\">##g' |sed 's#</td>#@#g' | sed -e 's/&amp;/＆/g' -e 's/&quot;/\"/g' | tr '@' '\n'| xargs -IXXX echo XXX"
alias load_md_list_my_tickets="load_list_my_tickets | sed 's#</a>##g' | sed 's#<a href=/issues/#- [ ] \##g' | tr '>' ' '"

function _scp_validfile(){
    case $1 in
        c|cobalt)
            ssh cobalt "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/Downloads/$2 cobalt:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
        c2|cobalt2)
            ssh cobalt2 "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/Downloads/$2 cobalt2:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
        ind|indigo)
            ssh indigo "mkdir -p /home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/"
            scp ~/Downloads/$2 indigo:/home/indigo/apps/responsive_on_rails/current/public/.well-known/pki-validation/
            ;;
    esac
}
alias scp_validfile='_scp_validfile'

function _cp_crt2key(){
    domain=$(echo $1 | sed -E 's/^.*(http|https):\/\/([^/]+).*/\2/g')
    a=$(echo $domain | tr '.' '_')
    downloaded_dir=~/Downloads/$a
    if [ ! -e $downloaded_dir ]; then
        cd ~/Downloads/
        unzip $a.zip -d $downloaded_dir
    fi
    cp $downloaded_dir/$a.crt ~/Documents/workspace/chef/chef-repo/tools/ssl/key/$domain.key
    cd -
}
alias cp_crt2key='_cp_crt2key'

function _validate_auth_file(){
    domain=$(echo $1 | sed -E 's/^.*(http|https):\/\/([^/]+).*/\2/g' | sed 's/www.//g')
    if diff -s <(curl http://$domain/.well-known/pki-validation/$2) <(cat ~/Downloads/$2) > /dev/null 2>&1 ; then
        echo 'OK'
    else
        echo 'no'
    fi
}
alias validate_af='_validate_auth_file'
