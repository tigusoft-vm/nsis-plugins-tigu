#!/bin/bash -e

echo "This will build Shelllnk.dll for Cross-Compilation"
echo "It also first builds it's dependency, then library nsis_ansi.a"

function wget_by_hash() {
	the_hash="$1"
	the_url="$2"
	the_outfile="$3"
	wget "$the_url" -O "$the_outfile" || { echo "Download failed (URL: $the_url)" ;  exit 1 ; }
	current_hash=$( sha256sum "$the_outfile" | head -n 1 | cut -d' ' -f1 )

	if [[ "$the_hash" == "$current_hash" ]] ; then
		echo "The checksum matches (hash of downloaded file: $current_hash)"
	else
		echo "The checksum seems invalid! $current_hash was downloaded instead of $the_hash"
		exit 1
	fi
}

echo "Cleanup"
rm -rf ./build/

mkdir ./build
cd ./build
echo "Working in build dir"

echo "*** nsis_ansi library"
mkdir "nsis_ansi"
(
cd "nsis_ansi"
echo "Downloading from Internet:"
wget_by_hash "0da0280a33eea055315d10febcd6a0ce3af66804ba40ac243dae5b793e4b66ed" "http://nsis.sourceforge.net/mediawiki/images/f/f0/NsJSON.zip" NsJSON.zip

unzip NsJSON.zip

cd Contrib/nsJSON/

i686-w64-mingw32-g++ -c pluginapi.c
i686-w64-mingw32-ar rcs ansi.lib pluginapi.o

echo -e "\n\nAfter compilation we have:"
file ansi.lib || exit 1
echo -e "\n\n"

)


echo "*** The ShellLink itself"

echo "Downloading from Internet:"
mkdir -p v1.1
wget_by_hash "266bfcbd6d9b978eabf2ce9335270e4c3891a97a9773d3c21b51310b9c11d24c" "http://nsis.sourceforge.net/mediawiki/images/c/cb/Shelllnk.zip" "v1.1/Shelllnk.zip"

mkdir -p v1.2
wget_by_hash "789bc4610272f8b01de8e2889987d50c7dd401193a90350184e58cb4c26393b9" "http://nsis.sourceforge.net/mediawiki/images/6/6c/Shelllink.zip" "v1.2/Shelllnk.zip"

echo -e "\nDownloads done\n\n"

echo "Unpack"
(
cd v1.1/
unzip Shelllnk.zip
) || exit 1
(
cd v1.2/
unzip Shelllnk.zip
) || exit 1

echo "Copy old ConvFunc.h"
cp v1.1/Contrib/ShellLink/ConvFunc.h  v1.2/Contrib/ShellLink/

echo "Fix include path dir separator"
sed  -i -e 's/^\(.*\)#include\(.*\)\\\(.*\)$/\1#include\2\/\3/g' v1.2/Contrib/ShellLink/ShellLink.cpp 

echo "Compiling"
cd v1.1/Contrib/ShellLink/

i686-w64-mingw32-g++ -c ShellLink.cpp

set -x
echo "Linking"
cp ../../../nsis_ansi/Contrib/nsJSON/ansi.lib ./pluginapi_ansi.lib
i686-w64-mingw32-g++ -shared -o ShellLink.dll ShellLink.o -L ./ -lpluginapi_ansi -lole32 -luuid || { 
	echo "Compilation failed. Launching shell to investigate."
	echo "*** EXIT this shell when done. ***"
	bash
	echo "Debug shell closed, existing with error now."
	exit 1
}

file ShellLink.dll
sha256sum ShellLink.dll

echo "All seems done and OK"
