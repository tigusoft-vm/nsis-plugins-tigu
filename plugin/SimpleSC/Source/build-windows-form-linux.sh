
echo -e "\nIn case of problems - read instructions here in depend/ how to prepare dependencies including the cross compiler\n"

fpc -Pi386 -Twin32 -S2 -Sh   SimpleSC.dpr  

# -S2 is for default value of function argument
# -Sh http://forum.lazarus.freepascal.org/index.php?topic=6147.0

