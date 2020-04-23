service postgresql start
service rabbitmq-server start
service nginx start
sudo -i -u postgres psql -c "CREATE DATABASE onlyoffice;"
sudo -i -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';"
sudo -i -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"
PGPASSWORD='onlyoffice' psql -hlocalhost -Uonlyoffice -d onlyoffice -f /out/linux_64/onlyoffice/documentserver/server/schema/postgresql/createdb.sql
cd /out/linux_64/onlyoffice/documentserver/
mkdir fonts
LD_LIBRARY_PATH=${PWD}/server/FileConverter/bin server/tools/allfontsgen \
  --input="${PWD}/core-fonts" \
  --allfonts-web="${PWD}/sdkjs/common/AllFonts.js" \
  --allfonts="${PWD}/server/FileConverter/bin/AllFonts.js" \
  --images="${PWD}/sdkjs/common/Images" \
  --selection="${PWD}/server/FileConverter/bin/font_selection.bin" \
  --output-web='fonts' \
  --use-system="true"
cd /out/linux_64/onlyoffice/documentserver/
LD_LIBRARY_PATH=${PWD}/server/FileConverter/bin server/tools/allthemesgen \
  --converter-dir="${PWD}/server/FileConverter/bin"\
  --src="${PWD}/sdkjs/slide/themes"\
  --output="${PWD}/sdkjs/common/Images"
cd /out/linux_64/onlyoffice/documentserver/server/FileConverter
LD_LIBRARY_PATH=$PWD/bin NODE_ENV=development-linux NODE_CONFIG_DIR=$PWD/../Common/config ./converter &
cd /out/linux_64/onlyoffice/documentserver/server/SpellChecker
NODE_ENV=development-linux NODE_CONFIG_DIR=$PWD/../Common/config ./spellchecker &
cd /out/linux_64/onlyoffice/documentserver/server/DocService
NODE_ENV=development-linux NODE_CONFIG_DIR=$PWD/../Common/config ./docservice &
bash
