# nsis-plugins-tigu

Some NSIS plugins with our fixes or docs, especially regarding cross-compilation

This can includes some other misc tools not just NSIS plugins, e.g. FooService.exe
on example of CjdnsService.exe.

Used e.g. for cjdns windows installer:  http://h.forum.meshnet.pl/viewtopic.php?f=9&t=41

Start
=====

Host is Debian 8 (but should work on many other such OSes)

Start with installing:

aptitude install wine 

# for tests:
dpkg --add-architecture i386 && apt-get update && apt-get install wine32


