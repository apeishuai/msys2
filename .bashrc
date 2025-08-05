if [ "$(uname)" == "Linux" ]; then
    home=~
    source ~/.bashrc_comm
    source ~/.bashrc_linux
elif [ -n "$MSYSTEM" ] && { [ "$MSYSTEM" == "MSYS" ] || [ "$MSYSTEM" == "MINGW64" ] || [ "$MSYSTEM" == "MINGW32" ] || [ "$MSYSTEM" == "CYGWIN" ] || [ "$MSYSTEM" == "UCRT64" ] || [ "$MSYSTEM" == "CLANG64" ];}; then
    home=D:/msys64/home/apeishuai
    source ~/.bashrc_comm
    source ~/.bashrc_win
fi

[ -f "/d/softwares/haskell/ghcup/env" ] && . "/d/softwares/haskell/ghcup/env" # ghcup-env
