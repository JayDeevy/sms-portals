#!/bin/bash

set -e

function buildApp {
	local version=$1

	echo "# $version # :Changing package name on AndroidManifest.xml"
	sed -i -e s/million/$version/g AndroidManifest.xml

	echo "# $version # Changing the package name on SmsSyncPortal.java"
	sed -i -e s/million/$version/g src/com/smssync/portal/million/SmsSyncPortal.java

	echo "# $version # Making proper directory"
	mkdir src/com/smssync/portal/$version
	mv src/com/smssync/portal/million/SmsSyncPortal.java src/com/smssync/portal/$version/SmsSyncPortal.java

	echo "# $version # Removing old default directory"
	rm -r src/com/smssync/portal/million

	echo "# $version # Building the APP"
	ant clean
	ant debug
}

for version in one two
do
	buildApp $version
	cp bin/SmsSyncPortal-debug.apk ~/Desktop/SmsSyncPortal-$version-debug.apk
	git reset --hard && git clean -df
done

