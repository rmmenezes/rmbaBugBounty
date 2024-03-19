#!/bin/bash

sudo apt update
sudo apt install golang python3-pip -y


export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
source ~/.profile
go version

echo "Instalando Dirsearch"
sudo apt install dirsearch

echo "Instalando Subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo "Instalando Httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo "Instalando Meg..."
go install github.com/tomnomnom/meg@latest

echo "Instalando Nuclei..."
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo "Instalando Uro..."
sudo pip3 install uro

echo "Instalando Gau..."
go install github.com/lc/gau/v2/cmd/gau@latest

echo "Instalando Dalefox..."
go install github.com/hahwul/dalfox/v2@latest

echo "Instalando Cariddi..."
go install -v github.com/edoardottt/cariddi/cmd/cariddi@latest





