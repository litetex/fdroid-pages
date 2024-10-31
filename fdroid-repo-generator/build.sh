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
echo "SEDing config.yml KEYSTOREPASS"
sed -i 's@$KEYSTOREPASS@"'"$KEYSTOREPASS"'"@g' /repo/config.yml
echo "SEDing config.yml KEYPASS"
sed -i 's@$KEYPASS@"'"$KEYPASS"'"@g' /repo/config.yml
echo "SEDing config.yml KEYDNAME"
sed -i 's@$KEYDNAME@"'"$KEYDNAME"'"@g' /repo/config.yml

echo "Ensuring that permissions are correct"
chown root:root /repo/config.yml
chmod 600 /repo/config.yml
chown root:root /repo/keystore.p12
chmod 600 /repo/keystore.p12

echo "Updating..."
fdroid update -v --use-date-from-apk 

echo "Deploying..."
fdroid deploy