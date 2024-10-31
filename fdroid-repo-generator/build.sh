echo "(Re)Building repo"
rm -rf /repo/*

mkdir -p /repo/repo

cp -a /apks/*.apk /repo/repo/
cp -a /repobase/. /repo/

chown root:root /repo/config.yml
chmod 600 /repo/config.yml

fdroid update --use-date-from-apk 
fdroid deploy