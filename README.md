# MTA-Teste
Criando GM do mta em LUA, testando como funciona a estrutura de criação de scripts e aprendendo lua.

## Organização dos diretórios

> ./src -> Código dos scripts em lua  
> ./resources -> Outros arquivos necessários para o script rodar  
> ./dist -> O .zip com os arquivos do src e resources


## Build

O sistema de build foi feito em shell, só uma sequencia de comandos que zipa o conteudo da pasta src e resources em um arquivo.  
O conteudo da pasta ./src continua no mesmo caminho dentro do zip, dentro da pasta ./src  
Já o conteudo da pasta ./resources não preserva o caminho
  
Para construir o pacote simplesmente execute o comando `./build.sh` em um terminal.