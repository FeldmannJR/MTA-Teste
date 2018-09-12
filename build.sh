SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DIRNAME=$(basename "$SCRIPTPATH")
rm -rf "${SCRIPTPATH}/dist"
mkdir -p "${SCRIPTPATH}/dist"

cd ${SCRIPTPATH}

#Zipando o mapa
zip -rj "./dist/Mapa.zip" "map/"
#Zipando os arquivos de resources sem o meta.xml
zip -r "./dist/${DIRNAME}.zip" "resources/" -x *meta.xml*
#Adicionado para o zip o código fonte
zip -ur "./dist/${DIRNAME}.zip" "src/"

#Copiando o meta.xml para modificar
mkdir -p ./tmp/
printf "<meta>\n" >> "./tmp/meta.xml"

cat ./resources/meta.xml >> "./tmp/meta.xml"

#Adicionado os scripts shared automaticamente
find ./src/shared/ -type f | while read fname; do
    name=${fname:2}
    printf "\n\t<script src=\"${name}\" type=\"shared\"/>" >> "./tmp/meta.xml"
done

#Adicionando os scripts do server automaticamente
find ./src/server/ -type f | while read fname; do
    name=${fname:2}
    printf "\n\t<script src=\"${name}\" type=\"server\"/>" >> "./tmp/meta.xml"
done

#Adicionado os scripts do client automaticamente
find ./src/client/ -type f | while read fname; do
    name=${fname:2}
    printf "\n\t<script src=\"${name}\" type=\"client\"/>" >> "./tmp/meta.xml"
done

#Adicionado os resources no meta.xml automaticamento CATCHAU
find ./resources/ -type f | while read fname; do
    name=${fname:2}
    if [ "$name" != "resources/meta.xml" ]; then
        printf "\n\t<file src=\"${name}\"/>" >> "./tmp/meta.xml"
    fi
done


printf "\n</meta>" >> "./tmp/meta.xml"
zip -uj "./dist/${DIRNAME}.zip" "./tmp/meta.xml"
rm -rf "${SCRIPTPATH}/tmp"