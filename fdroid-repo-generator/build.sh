echo "Cleaning"
rm -rf /repo/*

mkdir -p /repo/repo

echo "Copying apks"
cp -a /apks/*.apk /repo/repo/
echo "Copying repobase"
cp -a /repobase/. /repo/

echo "SEDing config.yml REPO_KEYALIAS"
sed -i -e 's/$REPO_KEYALIAS/'\""$REPO_KEYALIAS"\"'/' /repo/config.yml
echo "SEDing config.yml KEYSTOREPASS"
sed -i -e 's/$KEYSTOREPASS/'\""$KEYSTOREPASS"\"'/' /repo/config.yml
echo "SEDing config.yml KEYPASS"
sed -i -e 's/$KEYPASS/'\""$KEYPASS"\"'/' /repo/config.yml
echo "SEDing config.yml KEYDNAME"
sed -i -e 's/$KEYDNAME/'\""$KEYDNAME"\"'/' /repo/config.yml

echo "Ensuring that permissions are correct"
chown root:root /repo/config.yml
chmod 600 /repo/config.yml
chown root:root /repo/keystore.p12
chmod 600 /repo/keystore.p12

echo "Updating..."
fdroid update -v --use-date-from-apk 

echo "Deploying..."
fdroid deploy