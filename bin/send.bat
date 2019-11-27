@echo off


usage: send address file
eg; send 123.123.123.123 myfile.bin


p2pfile.exe -m send -a %1 -p 28010 -s "%2"