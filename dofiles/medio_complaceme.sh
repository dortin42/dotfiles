#!/bin/bash
# -*- ENCODING: UTF-8 -*-
clear
cd

venezolanPride(){
    #Venezolan pride
    echo -e "\e[0;31mHecho en socialismo :v \e[7;33m\nnintF1link\e[7;34m\n   J44G   \e[7;31m\nЯ <3 Linux"
}

#Script version
#Nombres de versiones:
#Alpha( 0.1 ) Codename: 'Buena vista'
#Alpha( 1.0 ) Codename: 'Contacto'
#Beta( 0.1 ) Codename: 'Atracción'
__ScriptVersion="Beta( 0.5 ) Codename: 'Valentía y plática'"

# Usage info
usage() {
  cat << EOF
Para ejecutar la opción -i debe tener permisos de administrador: sudo ./medio_complaceme.sh
Usage: ./medio_complaceme.sh
-v  --version
-h  --help
-i  --install
-it --installTmux
-iz --installZsh
-in --installNvim
-im --installMedioComplaceme
-ut --updateTmux
-uz --updateZsh
-un --updateNvim
-um --updateMedioComplaceme
-ua --updateAll
EOF
}

# Print version
version() {
  echo "Version $__ScriptVersion"
  venezolanPride
}

#Installing dotfiles
nvimCfg(){
    #Install nvim config
    curl -fLso ~/.config/nvim/init.vim --create-dirs https://gitlab.com/nintF1link/dotfiles/raw/master/init.vim
    echo "Se actualizó init.vim"
}

ternCfg(){
    #Install tern config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/.tern-config -o .tern-config
    echo "Se actualizó .tern-config"
}

tmuxCfg(){
    #Install tmux config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/.tmux.conf -o .tmux.conf
    echo "Se actualizó .tmux.conf"
}

eslintrcCfg(){
    #Install eslintrc config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/.eslintrc -o .eslintrc
    echo "Se actualizó .eslintrc"
}

gemrcCfg(){
    #Install gem config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/.gemrc -o .gemrc
    echo "Se actualizó .gemrc"
}

zshCfg(){
    #Install zsh config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/.zshrc -o .zshrc
    #Install Oh-my-zsh and Antigen
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    curl -L git.io/antigen > antigen.zsh
    echo "Se actualizó .zshrc"
}

medioComplaceme(){
    #Install zsh config
    curl https://gitlab.com/nintF1link/dotfiles/raw/master/medio_complaceme.sh -o $PWD/medio_complaceme.sh
    echo "Se actualizó este script"
    venezolanPride
    exit 0
}

everyFile(){
    nvimCfg; ternCfg; tmuxCfg; zshCfg; medioComplaceme; gemrcCfg; eslintrcCfg
}

rebootPC(){
    #Do you wish reboot ur computer?
    echo -e "\e[7;32m\n~>¿Desea reiniciar el equipo?[\e[0;32ms\e[7;32m \ \e[0;31mn\e[7;32m]"
    read -n 1 tecla
    case $tecla in
        y|Y|s|S) echo -e "\e[0;31mHecho en socialismo :v \e[7;33m\nnintF1link\e[7;34m\n   J44G   \e[7;31m\nЯ <3 Linux" && init 6;;
        n|N) echo -e "\e[7;32mOk, pos bueno";;
        *) echo -e "\e[0;31mNo introdujo una opción valida, lo que me hace pensar que posee una cantidad considerable de retraso, pero da igual.\e[7;32m\nEl script se ejecutó correctamente.\e[7;31m\n(imbécil, las instrucciones fueron bien claras, y luego dicen que las \ncomputadoras somos las estúpidas, tengo mejor ortografía que ese sujeto...)\n>:v";;
    esac
}

instala(){
    #Get every needed things
    echo -e "\n"
    read -p "Email:" email
    read -p "Git username:" gitUser

    #Know the linux distro
    distro=$(lsb_release -si)
    paquetesComunes=$"git curl wget zsh neovim tmux at ctags global"
    if [ "$distro" = "Solus" ]; then
        sudo eopkg it -y global font-hack-ttf python-devel sqlite3-devel $paquetesComunes
        sudo eopkg it -c system.devel
    elif [ "$distro" = "Ubuntu" ]; then
        sudo apt install -y fonts-hack-ttf python3-venv $paquetesComunes
    else
        echo "Por favor asegurate de que puedes correr el comando: lsb_release -si"
    fi
    git config --global color.ui true
    git config --global user.name $gitUser
    git config --global user.email $email
    ssh-keygen -t rsa -b 4096 -C $email

    #Install NVM and RVM
    #RVM
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    #NVM
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

    #Install NERDFonts
    curl -fLso ~/.local/share/fonts/droid.otf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

    everyFile
    rebootPC
}

defaultMenu(){
    # Default menu
    cat << EOF
¿Qué deseas hacer? (selecciona un número):
0) -v mostrar la versión
1) -i instalar todo (incluye todos los paquetes necesarios para correr el entorno entero (zsh, tmux, tern, neovim))
2) -it instalar .tmux.conf
3) -iz instalar .zshrc
4) -ir instalar .tern-config
5) -in instalar init.vim
6) -um actualizar este script
7) -ua actualizar todos los dotfiles
EOF
    read -n 1 flag
    case "$flag" in
        0) version;;
        1) instala;;
        2) tmuxCfg && exit 0;;
        3) zshCfg && exit 0;;
        4) ternCfg && exit 0;;
        5) nvimCfg && exit 0;;
        6) medioComplaceme;;
        7) everyFile;;
        *) clear && echo -e "A ver, a ver, que tampoco es tan difícil,\nno me seas imbécil, escoje un número de la lista\n" && defaultMenu;;
    esac
}

#Si el usuario introdujo algún parametro extra, será leido acá, si no, o si no
#introdujo alguna de las opciones, se abrirá el menú
case "$1" in
    -h | --help) usage;;
    -v | --version) version;;
    -i | --install) instala;;
    -it | --installTmux | -ut |--updateTmux) tmuxCfg && exit 0;;
    -ir | --installTern | -ur |--updateTern) ternCfg && exit 0;;
    -iz | --installZsh | -uz |--updateZsh) zshCfg && exit 0;;
    -in | --installNvim | -un |--updateNvim) nvimCfg && exit 0;;
    -um | --updateMedioComplaceme) medioComplaceme;;
    -ua | --updateAll) everyFile;;
    *) defaultMenu;;
esac

venezolanPride
exit 0
