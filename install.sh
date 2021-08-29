#!/bin/bash
# Installs JCV's IntelliJ configs into your user configs.
echo "Installing JCV AndroidStudio code style..."
echo ""

LATEST_CODE_STYLE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/configs/codestyles/JcvAndroid.xml"
if [ "$1" != "" ]; then
  lastChar=${1: -1}
  if [[ $lastChar == '/' ]]; then
    TARGET_DIR=("$1.idea")
  else
    TARGET_DIR=("$1/.idea")
  fi
else
  TARGET_DIR=("$HOME/Library/Application Support/Google")
fi
echo $TARGET_DIR
for target in $(ls "$TARGET_DIR" | grep Android)
do
  t=$TARGET_DIR/$target
  # create codestyles dir and ...
  echo "create codestyles dir in $t"
  mkdir -p ${t}/codestyles
  # ... copy to latest style to ${TARGET_DIR}
  echo "Copying..."
  cp -frv ${LATEST_CODE_STYLE} "${t}/codestyles/"
  if [ "$1" != "" ]; then
    echo "Renaming JcvAndroid.xml to Project.xml"
    mv ${t}/codestyles/JcvAndroid.xml ${t}/codestyles/Project.xml
  fi
done

echo ""
echo "Done."
echo "Restart AndroidStudio. Go to Preferences->Editor->Code Style and apply Scheme 'JcvAndroid'."
