echo "(Re)Building repo"
rm -rf /repo/*

mkdir -p /repo/repo

cp -a /apks/*.apk /repo/repo/
cp -a /repobase/. /repo/

chown root:root /repo/config.yml
chmod 600 /repo/config.yml
chown root:root /repo/keystore.p12
chmod 600 /repo/keystore.p12

fdroid update -v --use-date-from-apk 
fdroid deploy