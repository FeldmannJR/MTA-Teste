SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DIRNAME=$(basename "$SCRIPTPATH")
rm -rf "${SCRIPTPATH}/dist"
mkdir -p "${SCRIPTPATH}/dist"
cd $SCRIPTPATH
zip -r -j "dist/${DIRNAME}.zip" "resources/"
zip -ur "dist/${DIRNAME}.zip" "src/"
