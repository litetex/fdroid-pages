# Abort on failure
set -e

echo "Cleaning"
rm -rf /repo/*

mkdir -p /repo/repo

echo "Copying apks"
cp -a /apks/*.apk /repo/repo/
echo "Copying repobase"
cp -a /repobase/. /repo/

echo "SEDing config.yml REPO_KEYALIAS"
sed -i 's@$REPO_KEYALIAS@"'"$REPO_KEYALIAS"'"@g' /repo/config.yml
echo "SEDing config.yml KEYPASS (also used for KEYSTOREPASS)"
sed -i 's@$KEYPASS@"'"$KEYPASS"'"@g' /repo/config.yml
sed -i 's@$KEYSTOREPASS@"'"$KEYPASS"'"@g' /repo/config.yml
echo "SEDing config.yml KEYDNAME"
sed -i 's@$KEYDNAME@"'"$KEYDNAME"'"@g' /repo/config.yml

echo "Ensuring that permissions are correct"
chown root:root /repo/config.yml
chmod 600 /repo/config.yml

echo "Updating..."
fdroid update --use-date-from-apk 

echo "Deploying..."
fdroid deploy