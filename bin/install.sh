#! /bin/bash
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)
    ./bin/install-ubuntu.sh
    ;;
  Darwin*)
    ./bin/install-macos.sh
    ;;
esac
