Build instructions:
From http://h.forum.meshnet.pl/viewtopic.php?f=9&t=41#p126

Crossbuild ShellLink from source:


--- done by build.sh ---
1) Download ShellLink form http://nsis.sourceforge.net/ShellLink_plug-in (version 1.1 and 1.2) 


--- do this yourself ---
2) Unzip
3) Copy file ConvFunc.h from v1.1/Contrib/ShellLink to v1.2/Contrib/ShellLink
4) cd 1.2/Contrib/ShellLink/
5) Open ShellLink.cpp file and switch '\' to '/' in includes paths
6) i686-w64-mingw32-g++ -c ShellLink.cpp
7) i686-w64-mingw32-g++ -shared -o ShellLink.dll ShellLink.o -L nsis_ansi -lpluginapi -lole32 -luuid


