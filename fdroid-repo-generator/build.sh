echo "(Re)Building repo"
rm -rf /repo/*

mkdir -p /repo/repo

cp -a /apks/. /repo/repo/
cp -a /repobase/. /repo/

fdroid update --use-date-from-apk 
fdroid deploy