echo "Trying to cross-build. If it would fail then read the .md documentation text file above"

fpc -Pi386 -Twin32 windows_drives.pas || { echo "Damn it failed." ; exit 1 ; }

echo "Seems that it worked"

