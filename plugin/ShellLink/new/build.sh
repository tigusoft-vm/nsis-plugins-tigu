#!/bin/bash -e

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

echo "Downloading from Internet:"

mkdir -p v1.1
wget_by_hash "266bfcbd6d9b978eabf2ce9335270e4c3891a97a9773d3c21b51310b9c11d24c" "http://nsis.sourceforge.net/mediawiki/images/c/cb/Shelllnk.zip" "v1.1/Shelllnk.zip"

mkdir -p v1.2
wget_by_hash "789bc4610272f8b01de8e2889987d50c7dd401193a90350184e58cb4c26393b9" "http://nsis.sourceforge.net/mediawiki/images/6/6c/Shelllink.zip" "v1.2/Shelllnk.zip"

echo -e "\nDownloads done\n\n"

echo "NOT done yet - follow instructions from README.txt"

