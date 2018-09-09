SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DIRNAME=$(basename "$SCRIPTPATH")
rm -rf "${SCRIPTPATH}/dist"
mkdir -p "${SCRIPTPATH}/dist"

cd ${SCRIPTPATH}
#Zipando os arquivos de resources sem o meta.xml
zip -r "./dist/${DIRNAME}.zip" "resources/" -x *meta.xml*
#Adicionado para o zip o código fonte
zip -ur "./dist/${DIRNAME}.zip" "src/"

#Copiando o meta.xml para modificar
mkdir -p ./tmp/
cp ./resources/meta.xml ./tmp/
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