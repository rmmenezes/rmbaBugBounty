#!/bin/bash

echo "Bem-vindo ao Menu do Projeto!"
echo "Escolha uma opção:"
echo "1. Instalar dependências"
echo "2. Executar ferramenta"
echo "3. Sair"

read -p "Opção: " option

case $option in
    1)
        echo "Instalando dependências..."
        sudo apt update
        sudo apt install golang python3-pip -y

        echo "Instalando Subfinder..."
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

        echo "Instalando Airixss..."
        go install github.com/ferreiraklet/airixss@latest

        echo "Instalando Httpx..."
        go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

        echo "Instalando Meg..."
        go install github.com/tomnomnom/meg@latest

        echo "Instalando Nuclei..."
        go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

        echo "Instalando Waybackurls..."
        go install github.com/tomnomnom/waybackurls@latest

        echo "Instalando Uro..."
        sudo pip3 install uro

        echo "Instalando Gau..."
        go install github.com/lc/gau/v2/cmd/gau@latest

        echo "Instalando Dalefox..."
        go install github.com/hahwul/dalfox/v2@latest

        echo "Dependências instaladas com sucesso!"
        ;;
    2)
        echo "Executando a ferramenta..."
        # Coloque os comandos da ferramenta aqui
        echo "Iniciando o script..."

        echo "Executando o comando 'subfinder':"
        subfinder -all -silent -dL escope.txt -o subfinder-output.txt &>/dev/null
        echo "Comando 'subfinder' concluído."

        echo "Executando o comando 'gau':"
        cat subfinder-output.txt | gau --blacklist png,jpg,gif --from 202201 --providers wayback --o gau-output.txt
        echo "Comando 'gau' concluído."

        echo "Executando o comando 'uro':"
        cat gau-output.txt | uro -o uro-output.txt
        echo "Comando 'uro' concluído."

        echo "Executando o comando 'httpx':"
        cat uro-output.txt | httpx -silent -o httpx-output.txt &>/dev/null
        echo "Comando 'httpx' concluído."

        echo "Executando o comando 'dalfox':"
        cat httpx-output.txt | dalfox pipe --only-poc='g,r,v' |& tee dalfox-output.txt
        echo "Comando 'dalfox' concluído."

        echo "Executando o comando 'nuclei':"
        cat httpx-output.txt | nuclei --severity low,medium,high,critical |& tee nuclei-output.txt
        echo "Comando 'nuclei' concluído."

        echo "Fim do script."
        ;;
    3)
        echo "Saindo do menu."
        exit 0
        ;;
    *)
        echo "Opção inválida. Saindo do menu."
        exit 1
        ;;
esac
