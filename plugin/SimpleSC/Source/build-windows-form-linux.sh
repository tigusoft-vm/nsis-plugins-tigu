
echo "This build the NSIS Plugin from sources (cross-compiles it, for win32 target)"

echo -e "\nIn case of problems - read instructions here in depend/ how to prepare dependencies including the cross compiler\n"

fpc -Pi386 -Twin32 -Mdelphi  -Sh   SimpleSC.dpr  && echo "OK"

# -S2 is for default value of function argument
# -Sh http://forum.lazarus.freepascal.org/index.php?topic=6147.0

