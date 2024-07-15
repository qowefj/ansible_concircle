#!/bin/bash

# Variables
nudgeLatestURL="https://github.com/macadmins/nudge/releases/latest/"
versionUrl=$(curl "${nudgeLatestURL}" -s -L -I -o /dev/null -w '%{url_effective}')
versionNumber=$(printf "%s" "${versionUrl[@]}" | sed 's@.*/@@' | sed 's/%20/-/g')
versionNumber=${versionNumber:1}
downloadUrl="https://github.com/macadmins/nudge/releases/download/v$versionNumber/Nudge-$versionNumber.pkg"
header="$(curl -sI "$downloadUrl" | tr -d '\r')"
pkgName=$(printf "%s" "${downloadUrl[@]}" | sed 's@.*/@@' | sed 's/%20/-/g')
pkgPath="/tmp/$pkgName"
downloadUrl2="https://github.com/macadmins/nudge/releases/download/v$versionNumber/Nudge_LaunchAgent-1.0.1.pkg"
pkgName2=$(printf "%s" "${downloadUrl2[@]}" | sed 's@.*/@@' | sed 's/%20/-/g')
pkgPath2="/tmp/$pkgName2"

# Check if Nudge is already installed and get the version.
# Assumes nudge is in Applications folder, if not, assumes its in Utilities.
nudgePath="/Applications/Nudge.app"
if [ ! -e "$nudgePath" ]; then
    nudgePath="/Applications/Utilities/Nudge.app"
fi

if [ -e "$nudgePath" ]; then
    installedVersion=$(defaults read "$nudgePath/Contents/Info.plist" CFBundleShortVersionString)
    if [ "$installedVersion" = "$versionNumber" ]; then
        echo "Nudge is already up to date (version $versionNumber)"
        exit 0
    else
        echo "Updating Nudge from version $installedVersion to version $versionNumber"
    fi
else
    echo "Nudge is not installed. Installing version $versionNumber"
fi


# Download files
/usr/bin/curl -L -o "$pkgPath" "$downloadUrl"
/usr/bin/curl -L -o "$pkgPath2" "$downloadUrl2"

# Install PKGs
sudo installer -pkg $pkgPath -target /
sudo installer -pkg $pkgPath2 -target /


# Delete PKGs
sudo /bin/rm "$pkgPath"
sudo /bin/rm "$pkgPath2"




exit 0
