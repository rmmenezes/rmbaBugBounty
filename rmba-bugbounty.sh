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
        echo "Iniciando o script..."

        echo "Executando o comando 'subfinder':"
        subfinder -all -silent -dL escope.txt -o subfinder-output.txt &>/dev/null
        echo "Comando 'subfinder' concluído."

        echo "Executando o comando 'gau':"
        cat subfinder-output.txt | gau --blacklist md,jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico --from 202201 --providers wayback --o gau-output.txt
        echo "Comando 'gau' concluído."

        echo "Executando o comando 'uro':"
        cat gau-output.txt | uro -o uro-output.txt
        echo "Comando 'uro' concluído."

        echo "Executando o comando 'httpx':"
        cat uro-output.txt | httpx -silent -p 80,443,81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672 -o httpx-output.txt &>/dev/null
        echo "Comando 'httpx' concluído."

        echo "Executando o comando 'dalfox':"
        cat httpx-output.txt | dalfox pipe --silence --format json -o dalfox-output.json
        echo "Comando 'dalfox' concluído. Verificar o arquivo 'dalfox-output.json'"

        echo "Executando o comando 'nuclei':"
        cat uro-output.txt | ~/go/bin/nuclei -silent --severity low,medium,high,critical |& tee nuclei-output.txt
        echo "Comando 'nuclei' concluído. Verificaro o arquivo nuclei-output.txt "

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
