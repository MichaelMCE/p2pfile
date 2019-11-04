
Multipart Peer To Peer file transfers over TCP/IP, supporting both encryption and compression.
P2Pfile may act as either the server or the send/get client.
	
To enable server:
file.exe -m listen -l password -p port
file.exe with no arguments will activate server mode with default auth and port.
'file.exe -p 1923' will activate server mode with default auth on port 1923.
'file.exe -m listen -l gre_en -p 5432' will activate the server on port 5432 and gre_en as the password.

To send a file to an existing server:
file.exe -m send -l password -a hostaddress -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c

file.exe -m send -l gre_en -a 123.1.2.3 -s "c:\my movie.mpg" -d "c:\your movie.mpg"
Will upload the local file 'my movie.mpg' to the host which will be saved remotely as 'your movie.mpg'

file.exe -m send -a myhost.com -s "x:\file\my movie.mpg" -p 401
Will upload the local file 'my movie.mpg' to 'myhost.com' which will be saved remotely as 'my movie.mpg' in the directory from which the server was started.
	
To pull (get) a file from an existing server:
file.exe -m get -l password -a address -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c
'file.exe -m get -l gre_en -a host.address.com -p 28760 -s "c:\your movie.mpg" -d "c:\my movie.mpg" -o 10000000 -e 25000000 -c'
Will download 15meg of the remote file (beginning at the 10meg offset and ending at the 25meg offset) 'your movie.mpg' which will be saved localy as 'my movie.mpg'.
Total downloaded filesize will be 25meg or more.
		
If no password is supplied the default password is assumed ($$FILE_DEFAULTAUTH).
If no port is supplied then the default port is assumed ($$FILE_DEFAULTPORT).	
Filenames must begin and end with a quote, ie "
Nn endoffset of '0' will 'get' or 'send' to the end of the file.
	
-c enable CRC32 checks. data checksum is performed before compression or encryption.
-z enable zlib data compression. data compressed on a per block per socket transmit basis.
-r enable encryption. data encrypted on a per block per socket transmit basis.
-h display help.
'Esc' key exits.
	
Data is transfered in blocks which is currently set to 1024k, use -b (megabyte unit) to adjust.
Adjust according to connection bandwidth and filesize, or if using compression
Enabling data verification or encryption can slow file transfers (more so on slower cpu's).
Authenticating password is never transmitted.
	

by Michael McElligott
4'th of June 2006


XBlite can be downloaded from: https://xblite.soft32.com/
