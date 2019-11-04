
	'	p2pfile v3.01
	'	An example of multipart P2P file transfers over TCP/IP.
	'	this program can act as the server or the get/send client.
	
	'	to enable server:
	'	p2pfile.exe -m listen -l password -p port
	'	eg, 'p2pfile.exe'
	'	will activate server mode with default auth and port.
	'	eg, 'p2pfile.exe' -p 1923
	'	will activate server mode with default auth on port 1923.
	'	eg, 'p2pfile.exe -m listen -l gre_en -p 5432'
	'	will activate the server on port 5432 and gre_en as the password.
'
	'	to 'send' a file to an existing server:
	'	p2pfile.exe -m send -l password -a hostaddress -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c
	'	eg, 'p2pfile.exe -m send -l gre_en -a 123.1.2.3 -s "c:\my movie.mpg" -d "c:\your movie.mpg"'
	'	will upload the local file 'my movie.mpg' to the host which will be saved remotely as 'your movie.mpg'
	'	eg, 'p2pfile.exe -m send -a myhost.com -s "x:\file\my movie.mpg" -p 401
	'	will upload the local file 'my movie.mpg' to 'myhost.com' which will be saved remotely as 'my movie.mpg'
	'	in the directory from which the server was started.
	
	'	to 'get' a file from an existing server:
	'	p2pfile.exe -m get -l password -a address -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c
	'	eg, 'p2pfile.exe -m get -l gre_en -a host.address.com -p 28760 -s "c:\your movie.mpg" -d "c:\my movie.mpg" -o 10000000 -e 25000000 -c'
	'	will download 15meg of the remote file (beginning at the 10meg offset and ending at the 25meg offset) 'your movie.mpg' which will be saved localy as 'my movie.mpg'
	'	total downloaded filesize will be 25meg or more.
		
	'	-c enable CRC32 checks. checksum of data is performed before compression or encryption.
	'	-z enable zlib data compression. data compressed on a per block per socket transmit basis.
	'	-r enable encryption. data encrypted on a per block per socket transmit basis.
	'	-h display help.
	'	'Esc' key exits.
	
	'	some helpful infomation:
	'	data is transfered in blocks which is currently set to 1024k, use -b (megabyte unit) to adjust.
	'	adjust according to connection bandwidth and filesize, or if using compression
	'	enabling data verification or encryption can slow file transfers (more so on slower cpu's).
	'	the authenticating password is never transfered, why? view source.
	'	if no password is supplied the default password is assumed ($$FILE_DEFAULTAUTH).
	'	if no port is supplied then the default port is assumed ($$FILE_DEFAULTPORT).	
	'	filenames must begin and end with a quote, ie "
	'	an endoffset of '0' will 'get' or 'send' to the end of the file.
	
	
	'	by Michael McElligott
	'	Mapei_@hotmail.com
	'
	'	4'th of June 2006
	'


PROGRAM "p2pfile"
VERSION "301"  '3.01
CONSOLE

	IMPORT "xst_s.lib" 
	IMPORT "kernel32"
	IMPORT "wsock32"
	IMPORT "zlib"		' download from http://perso.wanadoo.fr/xblite/
	IMPORT "advapi32"
	'IMPORT "xio"
	IMPORT "msvcrt"
	IMPORT "p2pfiled.dec"


DECLARE FUNCTION Entry ()
DECLARE FUNCTION InitWSA ()

DECLARE FUNCTION sBind (socket,ipaddress$,port)
DECLARE FUNCTION sConnect (ipaddress$,port,socket)
DECLARE FUNCTION CreateBindSocket (ipaddress$,port,socket)

DECLARE FUNCTION SendBin (socket,lpbuffer,size)
DECLARE FUNCTION ListenBin (socket,size,ANY)
DECLARE FUNCTION ListenBin2 (socket,size,lpbuffer)

DECLARE FUNCTION GetIPName (numIPAddr$, @IPName$)
DECLARE FUNCTION GetIPAddr (IPName$, @numIPAddr$)

DECLARE FUNCTION open_file (pfilename, flags)
DECLARE FUNCTION write_file (hfile,ULONG buffer,nbytes)
DECLARE FUNCTION close_file (file)

DECLARE FUNCTION CreateCRC32Table ()
DECLARE FUNCTION GetAdler32 (lpbuffer,size)
DECLARE FUNCTION GetCRC32 (pbuffer,size)

DECLARE FUNCTION PrintHelp ()
DECLARE FUNCTION CPrint (STRING text)
DECLARE FUNCTION STRING GetLocalIpA ()
DECLARE FUNCTION GetCommandLineArguments (total, argv$[])
DECLARE FUNCTION GetCommandLine (mode$,auth$,addr$,port,srcfile$,desfile$,start,end,flags)
DECLARE FUNCTION GetDefaultCmdValues (STRING mode,STRING auth,STRING addr,port,srcfile$,desfile$,start,end,flags)
DECLARE FUNCTION DecomposePathname (pathname$, @path$, @parent$, @filename$, @file$, @extent$)
DECLARE FUNCTION getLastSlash(str$, stop)

DECLARE FUNCTION LOCATE (row, col)
DECLARE FUNCTION Inkey ()
DECLARE FUNCTION KeyCheck(key)

DECLARE FUNCTION ResetSendTotal()
DECLARE FUNCTION ResetListenTotal()
DECLARE FUNCTION GetSendTotal()
DECLARE FUNCTION GetRecvTotal()

DECLARE FUNCTION EndAuthTimeOut ()
DECLARE FUNCTION InvalidAuth()
DECLARE FUNCTION StartAuthTimeout (socket)

DECLARE FUNCTION FileGet (socket,TFILE file)
DECLARE FUNCTION FileSend (socket,TFILE file)

'EXPORT
DECLARE FUNCTION encrypt_buffer (buffer,size,STRING password)				' if pwd is empty a public key is created and return in 'passowrd'
DECLARE FUNCTION decrypt_buffer (buffer,size,STRING password, STRING key)	' provide a pwd or a key but not both.

DECLARE FUNCTION zlib_compress (source,ssize,dest,dsize,level)
DECLARE FUNCTION zlib_compress2 (source,ssize,STRING dbuffer)
DECLARE FUNCTION zlib_decompress (source,ssize,dest,dsize)

DECLARE FUNCTION FileListen (auth,port)
DECLARE FUNCTION FileDownload (auth,addr$,port,filename$,lfile$,start,end,flags)
DECLARE FUNCTION FileUpload (auth,addr$,port,filename$,lfile$,start,end,flags)

DECLARE FUNCTION P2PShutdown ()
'END EXPORT


FUNCTION Entry ()
	SHARED APPLSTATUS
	SHARED CONNECTED
	STRING auth
	SHARED thandle


	APPLSTATUS = $$TRUE
	CONNECTED = $$FALSE
	#blocks = $$MAX_FBUFFER
	
	thandle = _beginthreadex (NULL, 0, &KeyCheck(),27, 0, &tid)	' 27 = 'Esc' key
	IFZ thandle THEN RETURN P2PShutdown ()
	IFF InitWSA () THEN P2PShutdown ()
	'CreateCRC32Table ()
	GetCommandLine (@mode$,@auth,@addr$,@port,@srcfile$,@desfile$,@start,@end,@flags)

	SELECT CASE LCASE$(mode$)
		CASE "listen"	:FileListen (GetAdler32(&auth,SIZE(auth)),port)
		CASE "get"		:IFZ auth THEN P2PShutdown ()
						 IFZ addr$ THEN P2PShutdown ()
						 IFZ srcfile$ THEN P2PShutdown ()
						 IFZ desfile$ THEN DecomposePathname (@srcfile$, path$, parent$, @desfile$, file$, extent$)
						 FileDownload (GetAdler32(&auth,SIZE(auth)),addr$,port,srcfile$,desfile$,start,end,flags)
		CASE "send"		:IFZ auth THEN P2PShutdown ()
						 IFZ addr$ THEN P2PShutdown ()
						 IFZ srcfile$ THEN P2PShutdown ()
						 IFZ desfile$ THEN DecomposePathname (@srcfile$, path$, parent$, @desfile$, file$, extent$)
						 FileUpload (GetAdler32(&auth,SIZE(auth)),addr$,port,srcfile$,desfile$,start,end,flags)
		CASE ELSE		:
	END SELECT		

	'P2PShutdown ()
	CONNECTED = $$FALSE
	APPLSTATUS = $$FALSE
	WSACleanup ()
END FUNCTION

FUNCTION KeyCheck (key)
	SHARED APPLSTATUS
	SHARED CONNECTED
	SHARED thandle
	SHARED tAuth0

	DO
		k = Inkey()
		IF (k == key) THEN
			CPrint ("* Shutting down..")
			APPLSTATUS = $$FALSE
			CONNECTED = $$FALSE
			Sleep(1000)
			P2PShutdown()
		END IF
		
'		IF (k == 1067) THEN
'			XioHideConsole ()
'		END IF
		
		IF tAuth0 THEN
			IF ((GetTickCount()-tAuth0) > $$timeToAuth) THEN InvalidAuth()
		END IF

		Sleep (20)
	LOOP WHILE ((APPLSTATUS == $$TRUE) && thandle )

END FUNCTION

FUNCTION StartAuthTimeout(socket)
	SHARED tAuth0
	SHARED asocket
	
	asocket = socket
	tAuth0 = GetTickCount()
END FUNCTION

FUNCTION EndAuthTimeOut()
	SHARED tAuth0
	
	tAuth0 = 0
END FUNCTION

FUNCTION InvalidAuth()
	SHARED asocket
	SHARED CONNECTED
	

	EndAuthTimeOut()
	CONNECTED = $$FALSE
	CPrint ("* authentication failed\r\n* connection closed")
	closesocket (asocket)
		
END FUNCTION

FUNCTION GetDefaultCmdValues (STRING mode,STRING auth,STRING addr,port,srcfile$,desfile$,start,end,flags)

	
	mode = "listen"							' set default values
	auth = $$FILE_DEFAULTAUTH
	addr = ""
	port = $$FILE_DEFAULTPORT
	srcfile$ = ""
	desfile$ = ""
	start = 0
	end = 0
	flags = 0

	RETURN $$TRUE
END FUNCTION

FUNCTION GetCommandLine (mode$,auth$,addr$,port,srcfile$,desfile$,start,end,flags)


	GetDefaultCmdValues (@mode$,@auth$,@addr$,@port,@srcfile$,@desfile$,@start,@end,@flags)
	GetCommandLineArguments (@argc, @argv$[])

	IF (argc > 1) THEN
		FOR i = 1 TO argc-1												' for all command line arguments
			arg$ = TRIM$(argv$[i])										' get next argument
			IF (LEN (arg$) = 2) THEN									' if not empty
				IF (arg${0} = '-') THEN									' command line switch?
					SELECT CASE LCASE$(CHR$(arg${1}))					' which switch?
						CASE "m"	:mode$ = TRIM$(argv$[i+1])			' program mode
						CASE "l"	:auth$ = TRIM$(argv$[i+1])			' auth password
						CASE "a"	:addr$ = TRIM$(argv$[i+1])			' address
						CASE "p"	:port = XLONG (TRIM$(argv$[i+1]))	' port
									 IF (port < 1) THEN port = $$FILE_DEFAULTPORT
						CASE "s"	:srcfile$ = TRIM$(argv$[i+1])		' source filename
						CASE "d"	:desfile$ = TRIM$(argv$[i+1])		' destination filename
						CASE "o"	:start = XLONG (TRIM$(argv$[i+1]))	' start offset
									 IF (start < 1) THEN start = 0	
						CASE "e"	:end = XLONG (TRIM$(argv$[i+1]))	' end offset
									 IF (end < 1) THEN end = 0
						CASE "b"	:#blocks = (1024) * SINGLE(TRIM$(argv$[i+1])) ' data block length
						CASE "h"	:PrintHelp (): P2PShutdown (): QUIT(0)
						
						CASE "r"	:flags = flags | $$FILE_ENCRYPT		' data encryption
						CASE "c"	:flags = flags | $$FILE_CRC			' crc32 data
						CASE "z"	:flags = flags | $$FILE_COMPRESS	' compress data
					END SELECT
				END IF
			END IF
		NEXT i
	END IF

	RETURN $$TRUE
END FUNCTION

FUNCTION PrintHelp ()


	GetCommandLineArguments (argc, @argv$[])
	exefile$ = argv$[0]
	DecomposePathname (@exefile$, path$, parent$, @filename$, file$, extent$)
	
	CPrint ("\r\nUsage: "+filename$+" -m -l -a -p -s -d -o -e -c -b -z -r -h")
	CPrint (" -m mode  Operating mode. LISTEN, GET or SEND")
	CPrint (" -l pass  Authentication password")
	CPrint (" -a ip    Host IP Address")
	CPrint (" -p n     Client/Server Port")
	CPrint (" -s file  Source filename")
	CPrint (" -d file  Destination filename")
	CPrint (" -o n     Start Offset. Begin reading at this offset within file")
	CPrint (" -e n     End Offset. End reading at this offset")
	CPrint (" -c       Enable CRC32 verification on transfer")
	CPrint (" -r       Encrypt data, use with -l")
	CPrint (" -b mb    Block size per read->send, adjust to suit connection type")
	CPrint (" -z       Enable zlib compression per block")
	CPrint (" -h       Display this page")

END FUNCTION

FUNCTION FileListen (auth,port)
	SOCKADDR_IN  sockaddrin
	STATIC STRING buffer
	SHARED APPLSTATUS
	SHARED CONNECTED
	TFILE file
	XLONG cauth


	IFF CreateBindSocket (GetLocalIpA(), port,@fssocket) THEN
		CPrint ("\r\n* unable to create socket")
		RETURN $$FALSE
	END IF
	listen (fssocket, 1)
	length = SIZE(sockaddrin)

	CPrint ("\r\n* Press 'Esc' to Quit")
	DO 
		ResetSendTotal()
		ResetListenTotal()
		CPrint ("\r\n*** listening on "+GetLocalIpA()+" port "+STRING$(port)+" ***")
		
		fsclient = accept (fssocket, &sockaddrin, &length)
		IF fsclient && (APPLSTATUS == $$TRUE) THEN

			CONNECTED = $$TRUE
			cip$ = CSTRING$(inet_ntoa (sockaddrin.sin_addr))
			CPrint ("* accepted connection from: "+cip$)

			StartAuthTimeout (fsclient)
			IFF ListenBin2 (fsclient,SIZE(TFILE),&file) THEN
				EndAuthTimeOut()
				IFT CONNECTED THEN
					CONNECTED = $$FALSE
					CPrint ("* connection lost")
				END IF
				EXIT IF 2
			ELSE
				EndAuthTimeOut()
			END IF

			IF file.auth != auth THEN
				CONNECTED = $$FALSE
				InvalidAuth()
				EXIT IF 2
			END IF

			IF (file.ident == $$FILE_IDENT) THEN
				SELECT CASE file.fmode
					CASE $$FILE_SEND	:CPrint ("* sending file to "+cip$+": "+file.srcfile)
										 IFT FileSend (fsclient, file) THEN
											CPrint ("* transfer completed: "+file.srcfile)
										 ELSE
											CPrint ("* transfer failed: "+file.srcfile)
										 END IF
					CASE $$FILE_GET		:CPrint ("* receiving file from "+cip$+": "+file.desfile)
										 IFT FileGet (fsclient, file) THEN
											CPrint ("* transfer completed: "+file.desfile)
										 ELSE
											CPrint ("* transfer failed: "+file.desfile)
										 END IF
					CASE ELSE			:CONNECTED = $$FALSE
										 CPrint ("* invalid transfer header")
				END SELECT
			ELSE
				CONNECTED = $$FALSE
				CPrint ("* invalid header")
			END IF
		ELSE
			IFT APPLSTATUS THEN
				CONNECTED = $$FALSE
				CPrint ("* attempted connection failed")
			END IF
		END IF
		
	LOOP WHILE (APPLSTATUS == $$TRUE)

	CONNECTED = $$FALSE
	APPLSTATUS = $$FALSE
	closesocket (fsclient)
	closesocket (fssocket)	
		
END FUNCTION

FUNCTION FileSend (fsclient, TFILE file)
	UBYTE buffer[],dbuffer[]
	STRING auth
	SINGLE tt
	TCRC crc


	IF file.ident != $$FILE_IDENT THEN
		CPrint ("* invalid transfer request")
		RETURN $$FALSE
	END IF

	auth = STRING$(file.auth)
	t0 = GetTickCount ()
	file.error = 0
	file.size = 0

	IF file.end OR file.start THEN
		file.wmode = $$WR
	ELSE
		file.wmode = $$WRNEW
	END IF

	fp = open_file (&file.srcfile, 0)
	IF fp THEN
		fseek(fp, 0, 2)			'$$SEEK_END)
		file.size = ftell(fp)
			
		IFZ file.end THEN
			file.end = file.size
		ELSE
			IF file.end > file.size THEN file.end = file.size
		END IF
		
		IF (file.end - file.start) > file.blocks THEN
			fbsize = file.blocks
		ELSE
			fbsize = file.end - file.start
		END IF

		CPrint ("* file size: "+STRING$(file.size)+" bytes")
		CPrint ("* total bytes to send: "+STRING$(file.end - file.start))

		IFF SendBin (fsclient,&file,SIZE(TFILE)) THEN
			CPrint ("* transfer error")
			close_file (fp)
			RETURN $$FALSE
		END IF

		DIM buffer[fbsize]
		IF (file.flags & $$FILE_COMPRESS) THEN DIM dbuffer[fbsize+1024]
		
		FOR pos = file.start TO file.end STEP file.blocks
			
			IF (pos+fbsize) > file.end THEN fbsize = file.end - pos
			fsetpos (fp, &pos)
			fread (&buffer[],1,fbsize,fp)
			crc.filepos = pos
			crc.usize = fbsize
			
			IF (file.flags & $$FILE_CRC) THEN
				crc.crc32 = GetAdler32(&buffer[],crc.usize)
			ELSE
				crc.crc32 = 0
			END IF

			IF (file.flags & $$FILE_COMPRESS) THEN
				dsize = crc.usize + 1024
				zlib_compress(&buffer[],crc.usize,&dbuffer[],&dsize,5) ' $$Z_BEST_COMPRESSION)
				
				crc.size = dsize
				lpdata = &dbuffer[]
			ELSE
				crc.size = fbsize
				lpdata = &buffer[]
			END IF
			
			IF (file.flags & $$FILE_ENCRYPT) THEN
				encrypt_buffer(lpdata,crc.size,auth)
			END IF
			
			IFZ fsclient THEN
				close_file (fp)
				RETURN $$FALSE
			END IF

			IFT SendBin(fsclient,&crc,SIZE(TCRC)) THEN
			'	Sleep (1)
				IFF SendBin (fsclient,lpdata,crc.size) THEN
					CPrint ("* transfer error")
					close_file (fp)
					RETURN $$FALSE
				END IF
				'Sleep (50)		' remove this sleep if transfering across a LAN. try increasing if there are conn errors.
			ELSE
				CPrint ("* transfer error")
				close_file (fp)
				RETURN $$FALSE
			END IF

		NEXT pos
			
		tt = (GetTickCount()-t0) * 0.001
		PRINT "* transfer rate:";XLONG (((file.end-file.start))/tt);" bytes per second"
		CPrint ("* total data sent: "+STRING$(GetSendTotal()/1024)+"kb")

		close_file (fp)
		RETURN $$TRUE
	ELSE
		CPrint ("* access to file denied or file does not exist: "+file.srcfile)
		file.error = 1
		SendBin (fsclient,&file,SIZE(TFILE))
		RETURN $$FALSE
	END IF

	RETURN $$FALSE
END FUNCTION

FUNCTION FileGet (socket, TFILE file)
	UBYTE buffer[],dbuffer[]
	SINGLE tt
	STRING auth
	TCRC crc

	t0 = GetTickCount ()
	auth = STRING$(file.auth)
	ListenBin2 (socket,SIZE(TFILE),&file)

	IF file.ident != $$FILE_IDENT THEN
		CPrint ("* transfer header invalid")
		RETURN $$FALSE
	END IF

	IF file.error THEN
		CPrint ("* unable to open file or file does not exist")
		RETURN $$FALSE
	END IF

	IFZ file.end OR file.size THEN
		CPrint ("* no data to receive")
		RETURN $$FALSE
	END IF

	CPrint ("* file size: "+STRING$(file.size)+" bytes")
	CPrint ("* total bytes to write: "+STRING$(file.end - file.start))
	
	DecomposePathname (file.desfile, @path$, parent$, filename$, Fn$, fileExt$)
	IF path$ THEN CreateDirectoryA (&path$, 0)
	
	hfile = open_file (&file.desfile,&"wb")
	IFZ (hfile) THEN
		'CPrint ("* access denied on file: "+file.desfile)
		CPrint ("* transfer aborted *")
		RETURN $$FALSE
	ELSE
		FOR pos = file.start TO file.end STEP file.blocks
			ListenBin2 (socket,SIZE(TCRC),&crc)

			IF crc.size THEN
				IF (UBOUND(buffer[])!= crc.size) THEN DIM buffer[crc.size]
				ListenBin2 (socket,crc.size,&buffer[])

				IF (file.flags & $$FILE_ENCRYPT) THEN
					decrypt_buffer (&buffer[],crc.size,auth,"")
				END IF

				IF (file.flags & $$FILE_COMPRESS) THEN
					dsize = crc.usize
					IF (UBOUND(dbuffer[]) != dsize) THEN DIM dbuffer[dsize]
					zlib_decompress (&buffer[],crc.size,&dbuffer[],&dsize)
					
					IF dsize != crc.usize THEN
						CPrint ("* decompression error: source blk size different from destination blk size")
					END IF
					
					crc.size = dsize
					lpdata = &dbuffer[]
				ELSE
					lpdata = &buffer[]
				END IF

				IF (file.flags & $$FILE_CRC) THEN
					crc32 = GetAdler32 (lpdata,crc.size)
					IF crc32 != crc.crc32 THEN
						CPrint ("* crc error on transfer: "+file.desfile)
						CPrint ("*  offset: "+STRING$(crc.filepos)+" size: "+STRING$(crc.size))
						CPrint ("*  remote data crc:   " +HEXX$(crc.crc32))
						CPrint ("*  received data crc: " +HEXX$(crc32))
						close_file(hfile)
						RETURN $$FALSE
					END IF
				END IF
			
				fsetpos (hfile,&crc.filepos)
				write_file (hfile,lpdata,crc.size)
			ELSE
				CPrint ("* no data to receive on: "+file.desfile)
			END IF
		NEXT pos
		'tt = (GetTickCount()-t0) * SINGLE(0.001)
		'PRINT "* transfer rate: ";XLONG (((file.end-file.start)/1024)/SINGLE(tt));"kps"
		'CPrint ("* total bytes received: "+STRING$(GetRecvTotal()/1024)+"kb")
		CPrint ("* total bytes received: "+STRING$(GetRecvTotal())) ' includes p2p protocol header(s)
		close_file(hfile)
	END IF

	RETURN $$TRUE
END FUNCTION

FUNCTION FileUpload (auth,addr$,port,filename$,lfile$,start,end,flags)
	SHARED CONNECTED
	TFILE file
	
	
	IF (flags & $$FILE_COMPRESS) THEN CPrint ("*** compression enabled")
	IF (flags & $$FILE_ENCRYPT) THEN CPrint ("*** encryption enabled")
	IF (flags & $$FILE_CRC) THEN CPrint ("*** checksum verification enabled")

	CPrint ("\r\n* connecting...")
	IFT sConnect (addr$,port,@socket) THEN
		CPrint ("* connected to "+addr$+" on port "+STRING$(port)+"\r\n* transfering...")
		CONNECTED = $$TRUE
	ELSE
		CPrint ("* unable to connect")
		CONNECTED = $$FALSE
		closesocket (socket)
		RETURN $$FALSE
	END IF
	
	file.auth = auth
	file.ident = $$FILE_IDENT
	file.fmode = $$FILE_GET
	file.srcfile = filename$
	file.desfile = lfile$
	'file.fileid = 1
	file.start = start
	file.end = end
	file.error = 0
	file.size = 0
	file.flags = flags
	file.blocks = #blocks

	ret = $$FALSE
	IFT SendBin (socket, &file, SIZE(TFILE)) THEN
		'Sleep (1)
		IFT FileSend (socket, file) THEN ret = $$TRUE
	END IF

	CONNECTED = $$FALSE
	IF socket THEN closesocket (socket)
	IFT ret THEN
		CPrint ("* transfer completed: "+filename$)
	ELSE
		CPrint ("* connection to host lost")
		CPrint ("* transfer failed: "+filename$)
	END IF
		
	RETURN ret
	
END FUNCTION

FUNCTION FileDownload (auth,addr$,port,filename$,lfile$,start,end,flags)
	SHARED CONNECTED
	TFILE file

	
	IF (flags & $$FILE_COMPRESS) THEN CPrint ("*** compression enabled")
	IF (flags & $$FILE_ENCRYPT) THEN CPrint ("*** encryption enabled")
	IF (flags & $$FILE_CRC) THEN CPrint ("*** checksum verification enabled")
	
	CPrint ("\r\n* connecting...")
	IFT sConnect (addr$,port,@socket) THEN
		CPrint ("* connected to "+addr$+" on port "+STRING$(port)+"\r\n* transfering...")
		CPrint ("* file: "+filename$)
		CONNECTED = $$TRUE
	ELSE
		CPrint ("* unable to connect")
		IF socket THEN closesocket (socket)
		CONNECTED = $$FALSE
		RETURN $$FALSE
	END IF
	
	file.auth = auth
	file.ident = $$FILE_IDENT
	file.fmode = $$FILE_SEND
	file.srcfile = filename$
	file.desfile = lfile$
	'file.fileid = 1
	file.start = start
	file.end = end
	file.error = 0
	file.size = 0
	file.flags = flags
	file.blocks = #blocks
	
	ret = $$FALSE
	IFT SendBin(socket, &file, SIZE(TFILE)) THEN
'		Sleep (1)
		IFT FileGet(socket,file) THEN ret = $$TRUE
	END IF

	CONNECTED = $$FALSE
	IF socket THEN closesocket (socket)
	IFT ret THEN
		CPrint ("* transfer completed: "+lfile$)
	ELSE
		CPrint ("* connection to host lost")
		CPrint ("* transfer failed: "+filename$)
	END IF
	
	RETURN ret
END FUNCTION

FUNCTION STRING GetLocalIpA ()


	name$ = NULL$(256)
	gethostname (&name$,255)
	GetIPAddr (@name$, @ip$)	
	RETURN ip$
	
END FUNCTION

FUNCTION CreateCRC32Table ()
	SHARED ULONG table[]
	ULONG sum, n, a, b, magic
	UBYTE i, j, c


	DIM table[255]
	magic = 0xEDB88320

	FOR j = 0 TO 255
		sum = j
		FOR i = 0 TO 7
			IF (sum AND 1) THEN
				rum = sum
				sum = (sum >> 1) XOR magic
				bum = (rum >> 1) XOR 0xEDB88320
				'IF (sum != bum) THEN PRINT "sum : bum = "; HEX$(sum,8); " : "; HEX$(bum,8)
			ELSE
				sum = (sum >> 1)
			END IF
		NEXT i
		table[j] = sum
		'PRINT "table[" j "]=" HEXX$(sum)
	NEXT j
	
	RETURN $$TRUE
END FUNCTION

FUNCTION GetAdler32 (pbuffer,tbytes)

	adler = adler32(0, $$Z_NULL, 0)
	RETURN adler32(adler,pbuffer,tbytes)
END FUNCTION

FUNCTION GetCRC32 (pbuffer,size)
	SHARED ULONG table[]


	DEC size
	IFZ size THEN RETURN 0
	
	crc32 = 0xFFFFFFFF
	FOR n = pbuffer TO (pbuffer + size)
		crc32 = table[(crc32 XOR UBYTEAT (n)) AND 0xFF] XOR (crc32 >> 8)
	NEXT n

	RETURN (crc32 XOR 0xFFFFFFFF)
END FUNCTION

FUNCTION write_file (hfile,ULONG buffer,nbytes)

	'_write (hfile, buffer, nbytes)
	foffset = 0
	fgetpos (hfile,&foffset)
	
	IF (fwrite (buffer, 1, nbytes, hfile) < nbytes) THEN
		printf(&"error writing buffer to file\n",NULL)
		RETURN -1
	ELSE
		RETURN foffset
	END IF
END FUNCTION

FUNCTION open_file (lpfilename, flags)


	IFZ lpfilename THEN RETURN $$FALSE
	IFZ flags THEN
		type = &"rb"
	ELSE
		type = flags
	END IF
	
	hfile = fopen (lpfilename, type)
	IFZ hfile THEN
		printf(&"unable to open file '%s'\n",lpfilename)
		RETURN 0
	ELSE
		RETURN hfile
	END IF

END FUNCTION

FUNCTION close_file (file)

	IF file THEN
		fclose (file)
		RETURN $$TRUE
	ELSE
		printf(&"\nunable to close file",NULL)
		RETURN $$FALSE
	END IF

END FUNCTION

FUNCTION GetIPAddr (IPName$, @numIPAddr$)
	WSADATA wsadata
	HOSTENT	host


	host = gethostbyname (&IPName$)
	IF (host.h_addr_list != 0) THEN
		addr = 0
		RtlMoveMemory (&addr, host.h_addr_list, 4)
		RtlMoveMemory (&addr, addr, 4)
		addr2 = inet_ntoa (addr)
'		length = strlen (addr2)
		numIPAddr$ = NULL$ (512)
		RtlMoveMemory (&numIPAddr$, addr2, LEN(numIPAddr$))
		numIPAddr$ = CSIZE$ (numIPAddr$)
	END IF
	
	RETURN $$TRUE
END FUNCTION

FUNCTION GetIPName (numIPAddr$, @IPName$)
	WSADATA wsadata
	HOSTENT	host
	

	addr = inet_addr (&numIPAddr$)
	host = gethostbyaddr (&addr, 4, $$AF_INET)

	IF host.h_name <> 0 THEN
		IPName$ = NULL$ (512)
		RtlMoveMemory (&IPName$, host.h_name, LEN(IPName$))
		IPName$ = CSIZE$ (IPName$)
	END IF

	RETURN $$TRUE
END FUNCTION

FUNCTION sBind (socket,ipaddress$,port)
	SOCKADDR_IN udtSocket

	
	udtSocket.sin_family = $$AF_INET
	udtSocket.sin_port = htons (port)
	udtSocket.sin_addr = inet_addr (&ipaddress$)

	IF (udtSocket.sin_addr == $$INADDR_NONE) THEN
		GetIPAddr (ipaddress$, @numIPAddr$)
		udtSocket.sin_addr = inet_addr (&numIPAddr$)
	END IF
	IF (bind (socket, &udtSocket, SIZE (udtSocket)) == $$SOCKET_ERROR) THEN
		'CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
		RETURN $$FALSE
	ELSE
		RETURN $$TRUE
	END IF
	
END FUNCTION

FUNCTION CreateBindSocket (addy$,port,socket)
	SHARED APPLSTATUS
	

	socket = socket ($$AF_INET, $$SOCK_STREAM, 0)
	IFZ socket THEN RETURN $$FALSE
	
	erroronce = $$FALSE
	ret = $$FALSE
	DO
		ret = sBind (socket,addy$,port)
		IFF ret THEN
			IFF erroronce THEN 			' wait until port is free 
				erroronce = $$TRUE
				CPrint ("* port "+STRING$(port)+" in use, waiting... (wsa error "+ STRING$(WSAGetLastError ())+")")
			END IF
			Sleep(50)
		END IF
	LOOP WHILE ((ret == $$FALSE) AND (APPLSTATUS == $$TRUE))
	
	RETURN $$TRUE
	
END FUNCTION 

FUNCTION sConnect (ipaddress$,port,socket)
	SOCKADDR_IN udtSocket

	
	udtSocket.sin_family = $$AF_INET
	udtSocket.sin_port = htons (port)
	udtSocket.sin_addr = inet_addr (&ipaddress$)

	IF udtSocket.sin_addr = $$INADDR_NONE THEN
		GetIPAddr (ipaddress$, @numIPAddr$)
		udtSocket.sin_addr = inet_addr (&numIPAddr$)
	END IF
	
	socket = socket (udtSocket.sin_family, $$SOCK_STREAM, 0)
	IF (connect (socket, &udtSocket, SIZE(udtSocket)) == $$SOCKET_ERROR) THEN
		CPrint ("* wsa error "+ STRING$(WSAGetLastError ()))
		IF socket THEN closesocket (socket)
		RETURN $$FALSE
	ELSE
		RETURN $$TRUE
	END IF

END FUNCTION

FUNCTION SendBin (socket,pbuffer,size)
	SHARED ULONG tBytesSent
	SHARED APPLSTATUS
	SHARED CONNECTED


	IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
		RETURN $$FALSE
	END IF

	DO
		size = size-sent
		sent = send (socket, pbuffer+sent, size, 0)
		IF (sent == $$SOCKET_ERROR) THEN
			CPrint ("* wsa error "+ STRING$(WSAGetLastError ()))
			RETURN $$FALSE
		ELSE
			tBytesSent = tBytesSent + sent
		END IF
	LOOP WHILE (sent < size)

	RETURN $$TRUE
END FUNCTION


FUNCTION ListenBin (socket,size,UBYTE buffer[])
	SHARED ULONG tBytesRecvB
	SHARED APPLSTATUS
	SHARED CONNECTED


	IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
		RETURN $$FALSE
	END IF	
	
	IFZ size THEN RETURN $$FALSE
	DIM buffer[size-1]
	rover = &buffer[]
	read = 0
		
	DO WHILE (read < size)
		thisRead = recv (socket, rover, size-read, 0)
	
		IF (thisRead == $$SOCKET_ERROR || thisRead == 0) THEN
			IF thisRead == $$SOCKET_ERROR THEN
				CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
				RETURN $$FALSE
			END IF
			EXIT DO
		ELSE
			tBytesRecvB = tBytesRecvB + thisRead
			read = read + thisRead
			rover = rover + thisRead
		END IF
	LOOP
	
	RETURN $$TRUE
END FUNCTION

FUNCTION ListenBin2 (socket,size,lpbuffer)
	SHARED ULONG tBytesRecvB
	SHARED APPLSTATUS
	SHARED CONNECTED


	IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
		RETURN $$FALSE
	END IF	
	
	IFZ size THEN RETURN $$FALSE
	rover = lpbuffer
	read = 0
		
	DO WHILE (read < size)
		thisRead = recv (socket, rover, size-read, 0)
	
		IF (thisRead == $$SOCKET_ERROR || thisRead == 0) THEN
			IF thisRead == $$SOCKET_ERROR THEN
				CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
				RETURN $$FALSE
			END IF
			EXIT DO
		ELSE
			tBytesRecvB = tBytesRecvB + thisRead
			read = read + thisRead
			rover = rover + thisRead
		END IF
	LOOP
	
	RETURN $$TRUE
END FUNCTION

FUNCTION ResetSendTotal()
	SHARED ULONG tBytesSent	
	
	tBytesSent = 0
END FUNCTION

FUNCTION ResetListenTotal()
	SHARED ULONG tBytesRecvB
	
	tBytesRecvB = 0
END FUNCTION

FUNCTION GetSendTotal()
	SHARED ULONG tBytesSent
	
	RETURN tBytesSent
END FUNCTION

FUNCTION GetRecvTotal()
	SHARED ULONG tBytesRecvB
	
	RETURN tBytesRecvB
END FUNCTION

FUNCTION P2PShutdown ()
	SHARED APPLSTATUS
	SHARED CONNECTED
	SHARED thandle
	STATIC once


	IF once THEN RETURN ELSE once = 1
	
	CONNECTED = $$FALSE
	APPLSTATUS = $$FALSE
	WSACleanup ()
	Sleep (100)
	IF thandle THEN CloseHandle (thandle): thandle = 0
'	QUIT (0)
END FUNCTION

FUNCTION CPrint (message$)

	PRINT message$
	RETURN $$TRUE
END FUNCTION

FUNCTION getLastSlash(str$, stop)
	$PathSlash$   = "\\" 


	IF stop < 0 THEN
		slash1 = RINSTR(str$, "/")
		slash2 = RINSTR(str$, $PathSlash$)
	ELSE
		slash1 = RINSTR(str$, "/", stop)
		slash2 = RINSTR(str$, $PathSlash$, stop)
	END IF
	IFZ slash1 THEN
		RETURN slash2
	ELSE
		RETURN MAX(slash1, slash2)
	END IF
	
END FUNCTION

FUNCTION DecomposePathname (pathname$, @path$, @parent$, @filename$, @file$, @extent$)
'
	path$ = ""
	file$ = ""
	extent$ = ""
	parent$ = ""
	filename$ = ""
	name$ = TRIM$ (pathname$)
	dot = RINSTR (name$, ".")
	slash = getLastSlash(name$, -1)
	
	IF slash THEN preslash = getLastSlash(name$, slash-1)
	IF (dot < slash) THEN dot = 0
'
	filename$ = MID$ (name$, slash+1)							' filename = "name.ext"
	IFZ dot THEN
		file$ = filename$										' file = filename (filename has no extent)
	ELSE
		file$ = MID$ (name$, slash+1, dot-slash-1)	' file = "name" (without extent)
		extent$ = MID$ (name$, dot)					' extent = ".ext"
	END IF
'
	IF slash THEN
		path$ = LEFT$ (name$, slash-1)							' path = full pathname to left of "/file.ext"
		IF preslash THEN
			parent$ = MID$ (name$, preslash+1, slash-preslash-1)
		ELSE
			parent$ = LEFT$ (name$, slash-1)
		END IF
	END IF
	
END FUNCTION

FUNCTION GetCommandLineArguments (argc, argv$[]) ' taken from the Xst lib
	SHARED  setarg
	SHARED  setargc
	SHARED  setargv$[]


	DIM argv$[]
	inc = argc
	argc = 0
'
' return already set argc and argv$[]
'
	IF (inc >= 0) THEN
		IF setarg THEN
			argc = setargc
			upper = UBOUND (setargv$[])
			ucount = upper + 1
			IF (argc > ucount) THEN argc = ucount
			IF argc THEN
				DIM argv$[upper]
				FOR i = 0 TO upper
					argv$[i] = setargv$[i]
				NEXT i
			END IF
			RETURN ($$FALSE)
		END IF
	END IF
'
' get original command line arguments from system
'
	argc = 0
	index = 0
	DIM argv$[]
	addr = GetCommandLineA()			' address of full command line
	line$ = CSTRING$(addr)
	
'	PRINT "cmd line",line$
'
	done = 0
	IF addr THEN
		DIM argv$[1023]
		quote = $$FALSE
		argc = 0
		empty = $$FALSE
		I = 0
		DO
			cha = UBYTEAT(addr, I)
			IF (cha < ' ') THEN EXIT DO

			IF (cha = ' ') AND NOT quote THEN
				IF NOT empty THEN
					INC argc
					argv$[argc] = ""
					empty = $$TRUE
				END IF
			ELSE
				IF (cha = '"') THEN
					quote = NOT quote
				ELSE
					argv$[argc] = argv$[argc] + CHR$(cha)
					empty = $$FALSE
				END IF
			END IF
			INC I
		LOOP
		IF NOT empty THEN
			argc = argc + 1
		END IF
		REDIM argv$[argc-1]

	END IF
'
' if input argc < 0 THEN don't overwrite current values
'
	IF ((setarg = $$FALSE) OR (inc >= 0)) THEN
		setarg = $$TRUE
		setargc = argc
		DIM setargv$[]
		IF (argc > 0) THEN
			DIM setargv$[argc-1]
			FOR i = 0 TO argc-1
				setargv$[i] = argv$[i]
			NEXT i
		END IF
	END IF
	
END FUNCTION

FUNCTION LOCATE (row, col)
	STATIC hConsole, entry


	IFZ entry THEN
		hConsole = GetStdHandle ($$STD_OUTPUT_HANDLE)
		entry = $$TRUE
	END IF

	DEC row: DEC col
	pos = (row << 16) + col
	SetConsoleCursorPosition (hConsole,pos)

END FUNCTION

FUNCTION Inkey ()
	INPUT_RECORD inputRecord
	STATIC u$, l$
	STATIC entry

	IFZ entry THEN GOSUB Initialize
	count = 0
	ch = 0

	hStdIn = GetStdHandle ($$STD_INPUT_HANDLE)
	oldConsoleMode = 0
	GetConsoleMode (hStdIn, &oldConsoleMode)
	SetConsoleMode (hStdIn, 0)
	PeekConsoleInputA (hStdIn, &inputRecord, 1, &count)
  	IF ((count > 0) && (inputRecord.EventType == $$KEY_EVENT)) THEN
  	ReadConsoleInputA (hStdIn, &inputRecord, 1, &count)
  	SetConsoleMode (hStdIn, oldConsoleMode)
  	IF (count) && (inputRecord.EventType == $$KEY_EVENT) && (inputRecord.KeyEvent.bKeyDown) THEN
			vkc = inputRecord.KeyEvent.wVirtualKeyCode
			vsc = inputRecord.KeyEvent.wVirtualScanCode
			ch  = inputRecord.KeyEvent.AsciiChar
			cks = inputRecord.KeyEvent.dwControlKeyState
		'	PRINT vkc, vsc, ch, cks
			FlushConsoleInputBuffer (hStdIn)

			IF (!ch) && (vsc > 58) THEN
				IF (cks & 3) THEN RETURN (1000 + vsc) * (-1)
				IF (cks & 12) THEN RETURN (2000 + vsc) * (-1)
				RETURN vsc * (-1)
			END IF

			IF (ch && (cks & 3)) THEN RETURN vkc + 1000
			IF ((vsc == 15) && (cks & 16)) THEN RETURN 15
			IF (vkc == 27) THEN RETURN 27

			IF (ch && (cks & 128)) THEN
				upper = LEN (u$) - 1
				FOR i = 0 TO upper
					IF u${i} == ch THEN
						ch = l${i}
						RETURN ch
					END IF
				NEXT i
			END IF

			IF ch THEN RETURN ch
		END IF
	END IF

	FlushConsoleInputBuffer (hStdIn)
	SetConsoleMode (hStdIn, oldConsoleMode)
  RETURN ch


' ***** Initialize *****
SUB Initialize
'
	entry = $$TRUE
'
	u$ = "\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x7C\x7B\x7D\x3A\x22\x3C\x3E\x3F\x60\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x2D\x3D\x5C\x5B\x5D\x3B\x27\x2C\x2E\x2F\x00"
	l$ = "\x60\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x2D\x3D\x5C\x5B\x5D\x3B\x27\x2C\x2E\x2F\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x7C\x7B\x7D\x3A\x22\x3C\x3E\x3F\x00"
'
END SUB
END FUNCTION


FUNCTION decrypt_buffer (sbuffer, ssize, STRING password, STRING key)
	FUNCADDR Decrypt (HCRYPTKEY, HCRYPTHASH, XLONG, ULONG, XLONG, XLONG)
	HCRYPTKEY hKey
	HCRYPTHASH hHash
	HCRYPTPROV hProv


	$KEYLENGTH = 0x00800000
	$ENCRYPT_ALGORITHM = $$CALG_RC4		' stream encryption cipher, block size is 1 byte

	'load advapi32.dll library
	hAdvapi = LoadLibraryA (&"advapi32.dll")
	IFZ hAdvapi THEN
		error$ = "LoadLibraryA : advapi32.dll not found"
		GOSUB HandleError
	END IF

	'get function address for CryptDecrypt
	Decrypt = GetProcAddress (hAdvapi, &"CryptDecrypt")
	IFZ Decrypt THEN
		error$ = "GetProcAddress(): CryptDecrypt Not Found"
		GOSUB HandleError
	END IF

	' Get the handle to the default provider
	IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, 0)) THEN
		IF (GetLastError () == $$NTE_BAD_KEYSET) THEN
			IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, $$CRYPT_NEWKEYSET)) THEN
				error$ = "CryptAcquireContext()"
				GOSUB HandleError
			END IF
		ELSE
			error$ = "CryptAcquireContext()"
			GOSUB HandleError
		END IF
	END IF

	'Check for the existence of a password.
	IFZ password THEN
		IFZ key THEN
			error$ = "a password or key required for decryption"
			GOSUB HandleError
		END IF
		
		' Decrypt the file with the saved session key.
		dwKeyBlobLen = SIZE(key)
		IF (!dwKeyBlobLen) THEN
			error$ = "Key BLOB length error"
			GOSUB HandleError
		END IF

		' Import key BLOB into CSP.
		IF (!CryptImportKey (hProv, &key, dwKeyBlobLen, 0, 0, &hKey)) THEN
			error$ = "CryptImportKey()"
			GOSUB HandleError
		END IF

	ELSE

		' Decrypt the file with a session key derived from a password.
		' Create a hash object.
		IF (!CryptCreateHash (hProv, $$CALG_MD5, 0, 0, &hHash)) THEN
			error$ = "CryptCreateHash()"
			GOSUB HandleError
		END IF

		' Hash in the password data.
		IF (!CryptHashData (hHash, &password, LEN (password), 0)) THEN
			error$ = "CryptHashData()"
			GOSUB HandleError
		END IF

		' Derive a session key from the hash object.
		IF (!CryptDeriveKey (hProv, $ENCRYPT_ALGORITHM, hHash, $KEYLENGTH, &hKey)) THEN
			error$ = "CryptDeriveKey()"
			GOSUB HandleError
		END IF

		' Destroy the hash object.
		IF (!CryptDestroyHash (hHash)) THEN
			error$ = "CryptDeriveKey()"
			GOSUB HandleError
		END IF

	END IF

	' The decryption key is now available
	' for stream ciphers, buffer size can be equal to the block length
	dwBlockLen = 8192
	lpBuffer = sbuffer
	count = dwBlockLen
	final = 0

	DO
		IF (lpBuffer+count) >= (sbuffer+ssize) THEN
			final = 1
			count = (sbuffer+ssize) - lpBuffer
		END IF

		IF (!@Decrypt (hKey, 0, final, 0, lpBuffer, &count)) THEN
			error$ = "CryptDecrypt()"
			GOSUB HandleError
		END IF
		lpBuffer = lpBuffer + dwBlockLen

	LOOP UNTIL final

	' Destroy the session key.
	IF (hKey) THEN
		IF (!CryptDestroyKey (hKey)) THEN
			error$ = "CryptDestroyKey error"
			GOSUB HandleError
		END IF
	END IF

	' Release the provider handle.
	IF (hProv) THEN
		IF (!CryptReleaseContext (hProv, 0)) THEN
			error$ = "CryptReleaseContext error"
			GOSUB HandleError
		END IF
	END IF

	RETURN 1

SUB HandleError

	IF error$ THEN
		printf (&"error: decrypt_buffer() %s\n",&error$)
	ELSE
		printf (&"unknown error during decrypt_buffer()\n",0)
	END IF

	IF hKey THEN CryptDestroyKey(hKey)
	IF hHash THEN CryptDestroyHash (hHash)
	IF hProv THEN CryptReleaseContext (hProv, 0)
	IF hAdvapi THEN FreeLibrary (hAdvapi)

	RETURN 0
END SUB

END FUNCTION

FUNCTION encrypt_buffer (sbuffer,ssize,STRING password)
	FUNCADDR Encrypt (HCRYPTKEY, HCRYPTHASH, XLONG, ULONG, XLONG, XLONG, ULONG)
	HCRYPTKEY hKey, hXchgKey
	HCRYPTHASH hHash
	HCRYPTPROV hProv


	$KEYLENGTH = 0x00800000
	$ENCRYPT_ALGORITHM = $$CALG_RC4		' stream encryption cipher, block size is 1 byte

	hAdvapi = LoadLibraryA (&"advapi32.dll")
	IFZ hAdvapi THEN
		error$ = "LoadLibraryA(): advapi32.dll not found"
		GOSUB HandleError
	END IF

	Encrypt = GetProcAddress (hAdvapi, &"CryptEncrypt")
	IFZ Encrypt THEN
		error$ = "GetProcAddress(): CryptEncrypt() Not Found"
		GOSUB HandleError
	END IF

	' Get the handle to the default provider.
	IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, 0)) THEN
		IF (GetLastError () == $$NTE_BAD_KEYSET) THEN
			IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, $$CRYPT_NEWKEYSET)) THEN
				error$ = "CryptAcquireContext()"
				GOSUB HandleError
			END IF
		ELSE
			error$ = "CryptAcquireContext()"
			GOSUB HandleError
		END IF
	END IF

	' Create the session key.
	IFZ password THEN
		' No password was passed.
		' Encrypt the file with a random session key,
		' and write the key to dest buffer
		' create a random session key.
		IF (!CryptGenKey (hProv, $ENCRYPT_ALGORITHM, $KEYLENGTH | $$CRYPT_EXPORTABLE, &hKey)) THEN
			error$ = "CryptGenKey error"
			GOSUB HandleError
		END IF

		' Get the handle to the encrypter's exchange public key.
		IF (!CryptGetUserKey (hProv, $$AT_KEYEXCHANGE, &hXchgKey)) THEN
			IF (GetLastError () == $$NTE_NO_KEY) THEN
				IF (!CryptGenKey (hProv, $$AT_KEYEXCHANGE, 0, &hXchgKey)) THEN
					error$ = "CryptGenKey(): \nunable to create exchange public key"
					GOSUB HandleError
				END IF
			ELSE
				error$ = "CryptGetUserKey(): \nuser public key is not available and may not exist"
				GOSUB HandleError
			END IF
		END IF

		' Determine size of the key BLOB, and allocate memory.
		IF (!CryptExportKey (hKey, hXchgKey, $$SIMPLEBLOB, 0, NULL, &dwKeyBlobLen)) THEN
			error$ = "CryptExportKey(): \nError computing BLOB length"
			GOSUB HandleError
		END IF

		IFZ dwKeyBlobLen THEN
			error$ = "CryptExportKey(): BLOB length zero"
			GOSUB HandleError
		END IF
		
		password = NULL$(dwKeyBlobLen)

		' Encrypt and export the session key into a simple key BLOB.
		IF (!CryptExportKey (hKey, hXchgKey, $$SIMPLEBLOB, 0, &password, &dwKeyBlobLen)) THEN
			error$ = "CryptExportKey() error"
			GOSUB HandleError
		END IF

		' Release the key exchange key handle.
		IF (hXchgKey) THEN
			IF (!CryptDestroyKey (hXchgKey)) THEN
				error$ = "CryptDestroyKey error"
				GOSUB HandleError
			END IF
			hXchgKey = 0
		END IF

	ELSE
		' the file will be encrypted with a session key derived from a password.
		' the session key will be recreated when the file is decrypted
		' only if the password used to create the key is available.

		' create a hash object.
		IF (!CryptCreateHash (hProv, $$CALG_MD5, 0, 0, &hHash)) THEN
			error$ = "CryptCreateHash() error"
			GOSUB HandleError
		END IF

		' Hash the password.
		IF (!CryptHashData (hHash, &password, LEN(password), 0)) THEN
			error$ = "CryptHashData() error"
			GOSUB HandleError
		END IF

		' Derive a session key from the password hash object.
		IF (!CryptDeriveKey (hProv, $ENCRYPT_ALGORITHM, hHash, $KEYLENGTH, &hKey)) THEN
			error$ = "CryptDeriveKey() error"
			GOSUB HandleError
		END IF

		' Destroy hash object.
		IF (hHash) THEN
			IF (!CryptDestroyHash (hHash)) THEN
				error$ = "CryptDestroyHash() error"
				GOSUB HandleError
			END IF
		END IF
		hHash = 0

	END IF

	' The session key is now ready
	' for stream ciphers, buffer size can be equal to the block length
	dwBlockLen = 8192
	lpBuffer = sbuffer
	count = dwBlockLen
	final = 0

	DO
		IF (lpBuffer+count) >= (sbuffer+ssize) THEN
			final = 1
			count = (sbuffer+ssize) - lpBuffer
		END IF

		ret = @Encrypt (hKey, 0, final, 0, lpBuffer, &count, dwBlockLen)
		IFZ ret THEN error$ = "CryptEncrypt()": GOSUB HandleError
		lpBuffer = lpBuffer + dwBlockLen

	LOOP UNTIL final
	
	' Destroy the session key.
	IF (hKey) THEN
		IF (!CryptDestroyKey (hKey)) THEN
			error$ = "CryptDestroyKey error"
			GOSUB HandleError
		END IF
	END IF

	' Release the provider handle.
	IF (hProv) THEN
		IF (!CryptReleaseContext (hProv, 0)) THEN
			error$ = "CryptReleaseContext error"
			GOSUB HandleError
		END IF
	END IF

	'free the dll
	IF hAdvapi THEN FreeLibrary (hAdvapi)
	RETURN $$TRUE
	
SUB HandleError

	IF error$ THEN
		printf (&"error: encrypt_buffer() %s\n",&error$)
	ELSE
		printf (&"unknown error during encrypt_buffer()\n",0)
	END IF

	IF hKey THEN CryptDestroyKey(hKey)
	IF hXchgKey THEN CryptDestroyKey (hXchgKey)
	IF hHash THEN CryptDestroyHash (hHash)
	IF hProv THEN CryptReleaseContext (hProv, 0)
	IF hAdvapi THEN FreeLibrary (hAdvapi)

	RETURN $$FALSE
END SUB

END FUNCTION

FUNCTION zlib_decompress (source,ssize,dest,dsize)

	IF (uncompress (dest,dsize,source,ssize) == $$Z_OK) THEN
		RETURN $$TRUE
	ELSE
		printf(&"zlib_decompress(): unable to decompress buffer\n",$$NULL)
		RETURN $$FALSE
	END IF
END FUNCTION

FUNCTION zlib_compress (source,ssize,dest,dsize,level)


	IF (compress2 (dest,dsize,source,ssize,level) < 0) THEN
		printf(&"zlib_compress(): unable to compress buffer\n",$$NULL)
		RETURN $$FALSE
	ELSE
		RETURN $$TRUE
	END IF
END FUNCTION

FUNCTION zlib_compress2 (sbuffer,ssize,STRING dbuffer)

	
	dsize = ssize+75
	dbuffer = NULL$(dsize)
	IFT zlib_compress (sbuffer,ssize,&dbuffer,&dsize,$$Z_BEST_COMPRESSION) THEN
		RETURN dsize
	ELSE
		dbuffer = ""
		RETURN 0
	END IF
END FUNCTION

FUNCTION InitWSA ()
	WSADATA wsadata
	
	
	version = 2 OR (2 << 8)
	IF WSAStartup (version, &wsadata) THEN RETURN $$FALSE
	IF wsadata.wVersion != version THEN RETURN $$FALSE

	ResetSendTotal()
	ResetListenTotal()
	RETURN $$TRUE
END FUNCTION
END PROGRAM
