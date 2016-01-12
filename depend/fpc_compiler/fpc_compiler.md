
To crosscompile some NSIS plugins for Windows from Linux, we will need the Coimpiler FPC (Free Pascal Compiler).

To install it:

aptitude install fpc # we do need the packaged existing fpc compiler to build the new fpc compiler
aptitude install fpc-src # we need the sources of fpc to compiler our version of fpc, this time in crosscompilation mode

Then take the directory with source of fpc that are unpacked from this Debian package,
and copy it somewhere where root will build them.

E.g. as root:

```
mkdir ~/fpc-build
cd ~/fpc-build
cp -ar /usr/share/fpcsrc/ .
```

and there run:

```
make all OS_TARGET=win32 CPU_TARGET=i386
make crossinstall OS_TARGET=win32 CPU_TARGET=i386 
ln -sf /usr/local/lib/fpc/2.7.1/ppcross386 /usr/bin/ppcross386
```

we did it without the `INSTALL_PREFIX=/usr` because we want to install it in /usr/local/
and not overwrite the system's packaged fpc version.


After this steps are done, try cross-building example programs provided here in 
directory `depend/fpc_compiler/example/`


See also:
http://forum.lazarus.freepascal.org/index.php/topic,31060.0.html

