# nsis-plugins-tigu

Some NSIS plugins with our fixes or docs, especially regarding cross-compilation

This can includes some other misc tools not just NSIS plugins, e.g. FooService.exe
on example of CjdnsService.exe.

Used e.g. for cjdns windows installer:  http://h.forum.meshnet.pl/viewtopic.php?f=9&t=41

Crossbuild the NSIS plugins and other tools - from source
=========================================================

As result you will get compiled binary NSIS plugins (and other tools) that can be used
for compiling NSIS installer.

Host is Debian 8 (but should work on many other Linux)
Target is Windows (32, testing on Windows 7 mostly).

Start with installing:
`aptitude install wine`
(and typical compilers etc)

For tests in Wine also:
`dpkg --add-architecture i386 && apt-get update && apt-get install wine32`

Then:

# Build the dependencies (e.g. crosscompiler) in depend/ and install in your host system

# Cross-build the plugins in plugin/ - and the resulting .dll and other binary files 

# Ready. Now take resulting binary tools to the place that will be building NSIS installer

