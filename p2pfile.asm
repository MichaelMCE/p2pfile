;
; [2] '	p2pfile v3.01
;
; [3] '	An example of multipart P2P file transfers over TCP/IP.
;
; [4] '	this program can act as the server or the get/send client.
;
; [6] '	to enable server:
;
; [7] '	p2pfile.exe -m listen -l password -p port
;
; [8] '	eg, 'p2pfile.exe'
;
; [9] '	will activate server mode with default auth and port.
;
; [10] '	eg, 'p2pfile.exe' -p 1923
;
; [11] '	will activate server mode with default auth on port 1923.
;
; [12] '	eg, 'p2pfile.exe -m listen -l gre_en -p 5432'
;
; [13] '	will activate the server on port 5432 and gre_en as the password.
;
; [14] '
;
; [15] '	to 'send' a file to an existing server:
;
; [16] '	p2pfile.exe -m send -l password -a hostaddress -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c
;
; [17] '	eg, 'p2pfile.exe -m send -l gre_en -a 123.1.2.3 -s "c:\my movie.mpg" -d "c:\your movie.mpg"'
;
; [18] '	will upload the local file 'my movie.mpg' to the host which will be saved remotely as 'your movie.mpg'
;
; [19] '	eg, 'p2pfile.exe -m send -a myhost.com -s "x:\file\my movie.mpg" -p 401
;
; [20] '	will upload the local file 'my movie.mpg' to 'myhost.com' which will be saved remotely as 'my movie.mpg'
;
; [21] '	in the directory from which the server was started.
;
; [23] '	to 'get' a file from an existing server:
;
; [24] '	p2pfile.exe -m get -l password -a address -p port -s "sourcefilename" -d "destinationfilename" -o startoffset -e endoffset -c
;
; [25] '	eg, 'p2pfile.exe -m get -l gre_en -a host.address.com -p 28760 -s "c:\your movie.mpg" -d "c:\my movie.mpg" -o 10000000 -e 25000000 -c'
;
; [26] '	will download 15meg of the remote file (beginning at the 10meg offset and ending at the 25meg offset) 'your movie.mpg' which will be saved localy as 'my movie.mpg'
;
; [27] '	total downloaded filesize will be 25meg or more.
;
; [29] '	-c enable CRC32 checks. checksum of data is performed before compression or encryption.
;
; [30] '	-z enable zlib data compression. data compressed on a per block per socket transmit basis.
;
; [31] '	-r enable encryption. data encrypted on a per block per socket transmit basis.
;
; [32] '	-h display help.
;
; [33] '	'Esc' key exits.
;
; [35] '	some helpful infomation:
;
; [36] '	data is transfered in blocks which is currently set to 1024k, use -b (megabyte unit) to adjust.
;
; [37] '	adjust according to connection bandwidth and filesize, or if using compression
;
; [38] '	enabling data verification or encryption can slow file transfers (more so on slower cpu's).
;
; [39] '	the authenticating password is never transfered, why? view source.
;
; [40] '	if no password is supplied the default password is assumed ($$FILE_DEFAULTAUTH).
;
; [41] '	if no port is supplied then the default port is assumed ($$FILE_DEFAULTPORT).
;
; [42] '	filenames must begin and end with a quote, ie "
;
; [43] '	an endoffset of '0' will 'get' or 'send' to the end of the file.
;
; [46] '	by Michael McElligott
;
; [47] '	Mapei_@hotmail.com
;
; [48] '
;
; [49] '	4'th of June 2006
;
; [50] '
;
; [53] PROGRAM "p2pfile"
;
; [54] VERSION "301"'3.01
;
; [55] CONSOLE
;
; [57] IMPORT "xst_s.lib"
.code
	jmp	%_StartApplication			;;; i37a
PrologCode.p2pfile:
	push	ebp			;;; i38
	mov	ebp,esp			;;; i39
	sub	esp,256			;;; i40
;
; [58] IMPORT "kernel32"
	mov	eax,addr @_string.002C.p2pfile			;;; i663
	push	eax
	call	_XxxXstLoadLibrary@4
	test	eax,eax
	jz	> A.2			;;; i40a
	push	eax
	mov	ebx,addr @_string.002C.p2pfile			;;; i663
	push	addr @_string.StartLibrary.p2pfile			;;; i41
	push	ebx			;;; i41a
	push	0			;;; i41b
	call	main.concat			;;; i41c
	add	esp,12			;;; i41d
	pop	ebx
	push	eax
	push	eax
	push	ebx
	call	_GetProcAddress@8
	test	eax,eax
	jz	> A.1
	call	eax
A.1:
	pop	esi
	call	%____free
A.2:
;
; [59] IMPORT "wsock32"
	mov	eax,addr @_string.002D.p2pfile			;;; i663
	push	eax
	call	_XxxXstLoadLibrary@4
	test	eax,eax
	jz	> A.4			;;; i40a
	push	eax
	mov	ebx,addr @_string.002D.p2pfile			;;; i663
	push	addr @_string.StartLibrary.p2pfile			;;; i41
	push	ebx			;;; i41a
	push	0			;;; i41b
	call	main.concat			;;; i41c
	add	esp,12			;;; i41d
	pop	ebx
	push	eax
	push	eax
	push	ebx
	call	_GetProcAddress@8
	test	eax,eax
	jz	> A.3
	call	eax
A.3:
	pop	esi
	call	%____free
A.4:
;
; [60] IMPORT "zlib"' download from http://perso.wanadoo.fr/xblite/
	mov	eax,addr @_string.002E.p2pfile			;;; i663
	push	eax
	call	_XxxXstLoadLibrary@4
	test	eax,eax
	jz	> A.6			;;; i40a
	push	eax
	mov	ebx,addr @_string.002E.p2pfile			;;; i663
	push	addr @_string.StartLibrary.p2pfile			;;; i41
	push	ebx			;;; i41a
	push	0			;;; i41b
	call	main.concat			;;; i41c
	add	esp,12			;;; i41d
	pop	ebx
	push	eax
	push	eax
	push	ebx
	call	_GetProcAddress@8
	test	eax,eax
	jz	> A.5
	call	eax
A.5:
	pop	esi
	call	%____free
A.6:
;
; [61] IMPORT "advapi32"
	mov	eax,addr @_string.002F.p2pfile			;;; i663
	push	eax
	call	_XxxXstLoadLibrary@4
	test	eax,eax
	jz	> A.8			;;; i40a
	push	eax
	mov	ebx,addr @_string.002F.p2pfile			;;; i663
	push	addr @_string.StartLibrary.p2pfile			;;; i41
	push	ebx			;;; i41a
	push	0			;;; i41b
	call	main.concat			;;; i41c
	add	esp,12			;;; i41d
	pop	ebx
	push	eax
	push	eax
	push	ebx
	call	_GetProcAddress@8
	test	eax,eax
	jz	> A.7
	call	eax
A.7:
	pop	esi
	call	%____free
A.8:
;
; [62] 'IMPORT "xio"
;
; [63] IMPORT "msvcrt"
	mov	eax,addr @_string.0030.p2pfile			;;; i663
	push	eax
	call	_XxxXstLoadLibrary@4
	test	eax,eax
	jz	> A.10			;;; i40a
	push	eax
	mov	ebx,addr @_string.0030.p2pfile			;;; i663
	push	addr @_string.StartLibrary.p2pfile			;;; i41
	push	ebx			;;; i41a
	push	0			;;; i41b
	call	main.concat			;;; i41c
	add	esp,12			;;; i41d
	pop	ebx
	push	eax
	push	eax
	push	ebx
	call	_GetProcAddress@8
	test	eax,eax
	jz	> A.9
	call	eax
A.9:
	pop	esi
	call	%____free
A.10:
;
; [64] IMPORT "p2pfiled.dec"
;
; [67] DECLARE FUNCTION Entry ()
;
; [68] DECLARE FUNCTION InitWSA ()
;
; [70] DECLARE FUNCTION sBind (socket,ipaddress$,port)
;
; [71] DECLARE FUNCTION sConnect (ipaddress$,port,socket)
;
; [72] DECLARE FUNCTION CreateBindSocket (ipaddress$,port,socket)
;
; [74] DECLARE FUNCTION SendBin (socket,lpbuffer,size)
;
; [75] DECLARE FUNCTION ListenBin (socket,size,ANY)
;
; [76] DECLARE FUNCTION ListenBin2 (socket,size,lpbuffer)
;
; [78] DECLARE FUNCTION GetIPName (numIPAddr$, @IPName$)
;
; [79] DECLARE FUNCTION GetIPAddr (IPName$, @numIPAddr$)
;
; [81] DECLARE FUNCTION open_file (pfilename, flags)
;
; [82] DECLARE FUNCTION write_file (hfile,ULONG buffer,nbytes)
;
; [83] DECLARE FUNCTION close_file (file)
;
; [85] DECLARE FUNCTION CreateCRC32Table ()
;
; [86] DECLARE FUNCTION GetAdler32 (lpbuffer,size)
;
; [87] DECLARE FUNCTION GetCRC32 (pbuffer,size)
;
; [89] DECLARE FUNCTION PrintHelp ()
;
; [90] DECLARE FUNCTION CPrint (STRING text)
;
; [91] DECLARE FUNCTION STRING GetLocalIpA ()
;
; [92] DECLARE FUNCTION GetCommandLineArguments (total, argv$[])
;
; [93] DECLARE FUNCTION GetCommandLine (mode$,auth$,addr$,port,srcfile$,desfile$,start,end,flags)
;
; [94] DECLARE FUNCTION GetDefaultCmdValues (STRING mode,STRING auth,STRING addr,port,srcfile$,desfile$,start,end,flags)
;
; [95] DECLARE FUNCTION DecomposePathname (pathname$, @path$, @parent$, @filename$, @file$, @extent$)
;
; [96] DECLARE FUNCTION getLastSlash(str$, stop)
;
; [98] DECLARE FUNCTION LOCATE (row, col)
;
; [99] DECLARE FUNCTION Inkey ()
;
; [100] DECLARE FUNCTION KeyCheck(key)
;
; [102] DECLARE FUNCTION ResetSendTotal()
;
; [103] DECLARE FUNCTION ResetListenTotal()
;
; [104] DECLARE FUNCTION GetSendTotal()
;
; [105] DECLARE FUNCTION GetRecvTotal()
;
; [107] DECLARE FUNCTION EndAuthTimeOut ()
;
; [108] DECLARE FUNCTION InvalidAuth()
;
; [109] DECLARE FUNCTION StartAuthTimeout (socket)
;
; [111] DECLARE FUNCTION FileGet (socket,TFILE file)
;
; [112] DECLARE FUNCTION FileSend (socket,TFILE file)
;
; [114] 'EXPORT
;
; [115] DECLARE FUNCTION encrypt_buffer (buffer,size,STRING password)' if pwd is empty a public key is created and return in 'passowrd'
;
; [116] DECLARE FUNCTION decrypt_buffer (buffer,size,STRING password, STRING key)' provide a pwd or a key but not both.
;
; [118] DECLARE FUNCTION zlib_compress (source,ssize,dest,dsize,level)
;
; [119] DECLARE FUNCTION zlib_compress2 (source,ssize,STRING dbuffer)
;
; [120] DECLARE FUNCTION zlib_decompress (source,ssize,dest,dsize)
;
; [122] DECLARE FUNCTION FileListen (auth,port)
;
; [123] DECLARE FUNCTION FileDownload (auth,addr$,port,filename$,lfile$,start,end,flags)
;
; [124] DECLARE FUNCTION FileUpload (auth,addr$,port,filename$,lfile$,start,end,flags)
;
; [126] DECLARE FUNCTION P2PShutdown ()
;
; [127] 'END EXPORT
;
; [130] FUNCTION Entry ()
.code
	leave	;;; i160a
	ret				;;; i161 ;;; end prolog code
%_StartApplication:
	call	func1.p2pfile			;;; i162c
	ret	0			;;; i162d
align 16
_Entry.p2pfile@0:
;  *****
;  *****  FUNCTION  Entry ()  *****
;  *****
func1.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func1.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
	call	%%%%initOnce.p2pfile
;
;	#### Begin Local Initialization Code ####
	mov	ecx,3				;;; ..
	xor	eax,eax			;;; ...
A.24:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.24			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,108			;;; i114a
;
funcBody1.p2pfile:
;
; [131] SHARED APPLSTATUS
data section 'globals$shared'
align	4
%APPLSTATUS.p2pfile:	db 4 dup ?
.code
;
; [132] SHARED CONNECTED
data section 'globals$shared'
align	4
%CONNECTED.p2pfile:	db 4 dup ?
.code
;
; [133] STRING auth
#ifdef Entry.auth
#undef Entry.auth
#endif
#define Entry.auth ebp-40	; exposes local variable 'auth'
;
;
; [134] SHARED thandle
data section 'globals$shared'
align	4
%thandle.p2pfile:	db 4 dup ?
.code
;
; [137] APPLSTATUS = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%APPLSTATUS.p2pfile],eax			;;; i668
;
; [138] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [139] #blocks = $$MAX_FBUFFER
data section 'globals$shared'
align	4
%#blocks.p2pfile:	db 4 dup ?
.code
	mov	eax,1048576			;;; i657
	mov	d[%#blocks.p2pfile],eax			;;; i668
;
; [141] thandle = _beginthreadex (NULL, 0, &KeyCheck(),27, 0, &tid)' 27 = 'Esc' key
;
; [0] EXTERNAL CFUNCTION  _beginthreadex (lpThreadAttributes, dwStackSize, Startess, lpParameter, dwCreationFlags, lpThreadId)
#ifdef Entry.NULL
#undef Entry.NULL
#endif
#define Entry.NULL ebp-44	; exposes local variable 'NULL'
;
	mov	eax,addr _KeyCheck.p2pfile@4			;;; i599
; .xstk1.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
#ifdef Entry.tid
#undef Entry.tid
#endif
#define Entry.tid ebp-56	; exposes local variable 'tid'
;
	lea	eax,[ebp-56]			;;; i642
	push	eax			;;; i667a
	push	0			;;; i656a
	push	27			;;; i656a
	push	[ebp-52]			;;; i674a
	push	0			;;; i656a
	push	[ebp-44]			;;; i674a
	call	__beginthreadex			;;; i619
	add	esp,24			;;; i633
	mov	d[%thandle.p2pfile],eax			;;; i668
;
; [142] IFZ thandle THEN RETURN P2PShutdown ()
	mov	eax,d[%thandle.p2pfile]			;;; i663a
	test	eax,eax			;;; i194
	jnz	>> else.0001.p2pfile			;;; i195
	call	func2D.p2pfile			;;; i619
	jmp	end.func1.p2pfile			;;; i258
else.0001.p2pfile:
end.if.0001.p2pfile:
;
; [143] IFF InitWSA () THEN P2PShutdown ()
	call	func2.p2pfile			;;; i619
	test	eax,eax			;;; i194
	jnz	>> else.0002.p2pfile			;;; i195
	call	func2D.p2pfile			;;; i619
else.0002.p2pfile:
end.if.0002.p2pfile:
;
; [144] 'CreateCRC32Table ()
;
; [145] GetCommandLine (@mode$,@auth,@addr$,@port,@srcfile$,@desfile$,@start,@end,@flags)
#ifdef Entry.mode$
#undef Entry.mode$
#endif
#define Entry.mode$ ebp-60	; exposes local variable 'mode$'
;
#ifdef Entry.addr$
#undef Entry.addr$
#endif
#define Entry.addr$ ebp-64	; exposes local variable 'addr$'
;
#ifdef Entry.port
#undef Entry.port
#endif
#define Entry.port ebp-68	; exposes local variable 'port'
;
#ifdef Entry.srcfile$
#undef Entry.srcfile$
#endif
#define Entry.srcfile$ ebp-72	; exposes local variable 'srcfile$'
;
#ifdef Entry.desfile$
#undef Entry.desfile$
#endif
#define Entry.desfile$ ebp-76	; exposes local variable 'desfile$'
;
#ifdef Entry.start
#undef Entry.start
#endif
#define Entry.start ebp-80	; exposes local variable 'start'
;
#ifdef Entry.end
#undef Entry.end
#endif
#define Entry.end ebp-84	; exposes local variable 'end'
;
#ifdef Entry.flags
#undef Entry.flags
#endif
#define Entry.flags ebp-88	; exposes local variable 'flags'
;
	push	[ebp-88]			;;; i674a
	push	[ebp-84]			;;; i674a
	push	[ebp-80]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-68]			;;; i674a
	push	[ebp-64]			;;; i674a
	push	[ebp-40]			;;; i674a
	push	[ebp-60]			;;; i674a
	call	func15.p2pfile			;;; i619
	mov	ecx,d[esp-36]			;;; i877a
	mov	ebx,d[esp-32]			;;; i877b
	mov	edi,d[esp-28]			;;; i877c
	mov	esi,d[esp-24]			;;; i877d
	mov	[ebp-60],ecx			;;; i670
	mov	[ebp-40],ebx			;;; i670
	mov	[ebp-64],edi			;;; i670
	mov	d[ebp-68],esi			;;; i670
	mov	ecx,d[esp-20]			;;; i877a
	mov	ebx,d[esp-16]			;;; i877b
	mov	edi,d[esp-12]			;;; i877c
	mov	esi,d[esp-8]			;;; i877d
	mov	[ebp-72],ecx			;;; i670
	mov	[ebp-76],ebx			;;; i670
	mov	d[ebp-80],edi			;;; i670
	mov	d[ebp-84],esi			;;; i670
	mov	ecx,d[esp-4]			;;; i877a
	mov	d[ebp-88],ecx			;;; i670
;
; [147] SELECT CASE LCASE$(mode$)
	sub	esp,64			;;; i487
	mov	eax,[ebp-60]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_lcase.d.v			;;; i583
	add	esp,64			;;; i600
; .select1.0003 = ebp-92	; internal variable
	mov	esi,[ebp-92]			;;; i665
	mov	[ebp-92],eax			;;; i670
	call	%____free			;;; i260
;
; [148] CASE "listen"	:FileListen (GetAdler32(&auth,SIZE(auth)),port)
	mov	eax,addr @_string.0072.p2pfile			;;; i663
	mov	ebx,[ebp-92]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0003.0001.p2pfile			;;; i71
	mov	eax,d[ebp-40]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.11			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.11:
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	call	funcF.p2pfile			;;; i619
	mov	d[ebp-52],eax			;;; i670
	push	[ebp-68]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	func2A.p2pfile			;;; i619
;
; [149] CASE "get"		:IFZ auth THEN P2PShutdown ()
	jmp	end.select.0003.p2pfile			;;; i69
case.0003.0001.p2pfile:
	mov	eax,addr @_string.0073.p2pfile			;;; i663
	mov	ebx,[ebp-92]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0003.0002.p2pfile			;;; i71
	mov	eax,[ebp-40]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.12			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0004.p2pfile			;;; i192
A.12:
	call	func2D.p2pfile			;;; i619
else.0004.p2pfile:
end.if.0004.p2pfile:
;
; [150] IFZ addr$ THEN P2PShutdown ()
	mov	eax,[ebp-64]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.13			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0005.p2pfile			;;; i192
A.13:
	call	func2D.p2pfile			;;; i619
else.0005.p2pfile:
end.if.0005.p2pfile:
;
; [151] IFZ srcfile$ THEN P2PShutdown ()
	mov	eax,[ebp-72]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.14			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0006.p2pfile			;;; i192
A.14:
	call	func2D.p2pfile			;;; i619
else.0006.p2pfile:
end.if.0006.p2pfile:
;
; [152] IFZ desfile$ THEN DecomposePathname (@srcfile$, path$, parent$, @desfile$, file$, extent$)
	mov	eax,[ebp-76]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.15			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0007.p2pfile			;;; i192
A.15:
#ifdef Entry.path$
#undef Entry.path$
#endif
#define Entry.path$ ebp-96	; exposes local variable 'path$'
;
	mov	eax,d[ebp-96]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-52],eax			;;; i670
#ifdef Entry.parent$
#undef Entry.parent$
#endif
#define Entry.parent$ ebp-100	; exposes local variable 'parent$'
;
	mov	eax,d[ebp-100]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk1.0001 = ebp-108	; internal variable
	mov	d[ebp-108],eax			;;; i670
#ifdef Entry.file$
#undef Entry.file$
#endif
#define Entry.file$ ebp-112	; exposes local variable 'file$'
;
	mov	eax,d[ebp-112]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk1.0002 = ebp-120	; internal variable
	mov	d[ebp-120],eax			;;; i670
#ifdef Entry.extent$
#undef Entry.extent$
#endif
#define Entry.extent$ ebp-124	; exposes local variable 'extent$'
;
	mov	eax,d[ebp-124]			;;; i665
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	push	[ebp-120]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-108]			;;; i674a
	push	[ebp-52]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	func17.p2pfile			;;; i619
	sub	esp,24			;;; xnt1i
	mov	ecx,d[esp]			;;; i877a
	mov	[ebp-72],ecx			;;; i670
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+12]			;;; i877a
	mov	[ebp-76],ecx			;;; i670
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+20]			;;; i871
	call	%____free			;;; i872
	add	esp,24			;;; i633
else.0007.p2pfile:
end.if.0007.p2pfile:
;
; [153] FileDownload (GetAdler32(&auth,SIZE(auth)),addr$,port,srcfile$,desfile$,start,end,flags)
	mov	eax,d[ebp-40]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.16			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.16:
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	call	funcF.p2pfile			;;; i619
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-64]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-108],eax			;;; i670
	mov	eax,d[ebp-72]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-120],eax			;;; i670
	mov	eax,d[ebp-76]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk1.0003 = ebp-132	; internal variable
	mov	d[ebp-132],eax			;;; i670
	push	[ebp-88]			;;; i674a
	push	[ebp-84]			;;; i674a
	push	[ebp-80]			;;; i674a
	push	[ebp-132]			;;; i674a
	push	[ebp-120]			;;; i674a
	push	[ebp-68]			;;; i674a
	push	[ebp-108]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	func2B.p2pfile			;;; i619
	sub	esp,32			;;; xnt1i
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+12]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	add	esp,32			;;; i633
;
; [154] CASE "send"		:IFZ auth THEN P2PShutdown ()
	jmp	end.select.0003.p2pfile			;;; i69
case.0003.0002.p2pfile:
	mov	eax,addr @_string.0078.p2pfile			;;; i663
	mov	ebx,[ebp-92]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0003.0003.p2pfile			;;; i71
	mov	eax,[ebp-40]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.17			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0008.p2pfile			;;; i192
A.17:
	call	func2D.p2pfile			;;; i619
else.0008.p2pfile:
end.if.0008.p2pfile:
;
; [155] IFZ addr$ THEN P2PShutdown ()
	mov	eax,[ebp-64]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.18			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.0009.p2pfile			;;; i192
A.18:
	call	func2D.p2pfile			;;; i619
else.0009.p2pfile:
end.if.0009.p2pfile:
;
; [156] IFZ srcfile$ THEN P2PShutdown ()
	mov	eax,[ebp-72]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.19			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.000A.p2pfile			;;; i192
A.19:
	call	func2D.p2pfile			;;; i619
else.000A.p2pfile:
end.if.000A.p2pfile:
;
; [157] IFZ desfile$ THEN DecomposePathname (@srcfile$, path$, parent$, @desfile$, file$, extent$)
	mov	eax,[ebp-76]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.20			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.000B.p2pfile			;;; i192
A.20:
	mov	eax,d[ebp-96]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-100]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-108],eax			;;; i670
	mov	eax,d[ebp-112]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-120],eax			;;; i670
	mov	eax,d[ebp-124]			;;; i665
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	push	[ebp-120]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-108]			;;; i674a
	push	[ebp-52]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	func17.p2pfile			;;; i619
	sub	esp,24			;;; xnt1i
	mov	ecx,d[esp]			;;; i877a
	mov	[ebp-72],ecx			;;; i670
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+12]			;;; i877a
	mov	[ebp-76],ecx			;;; i670
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+20]			;;; i871
	call	%____free			;;; i872
	add	esp,24			;;; i633
else.000B.p2pfile:
end.if.000B.p2pfile:
;
; [158] FileUpload (GetAdler32(&auth,SIZE(auth)),addr$,port,srcfile$,desfile$,start,end,flags)
	mov	eax,d[ebp-40]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.21			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.21:
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	call	funcF.p2pfile			;;; i619
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-64]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-108],eax			;;; i670
	mov	eax,d[ebp-72]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-120],eax			;;; i670
	mov	eax,d[ebp-76]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-132],eax			;;; i670
	push	[ebp-88]			;;; i674a
	push	[ebp-84]			;;; i674a
	push	[ebp-80]			;;; i674a
	push	[ebp-132]			;;; i674a
	push	[ebp-120]			;;; i674a
	push	[ebp-68]			;;; i674a
	push	[ebp-108]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	func2C.p2pfile			;;; i619
	sub	esp,32			;;; xnt1i
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+12]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	add	esp,32			;;; i633
;
; [159] CASE ELSE		:
	jmp	end.select.0003.p2pfile			;;; i69
case.0003.0003.p2pfile:
;
; [160] END SELECT
end.select.0003.p2pfile:
;
; [162] 'P2PShutdown ()
;
; [163] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [164] APPLSTATUS = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%APPLSTATUS.p2pfile],eax			;;; i668
;
; [165] WSACleanup ()
;
; [0] EXTERNAL SFUNCTION  WSACleanup       ()
	call	_WSACleanup@0			;;; i619
;
; [166] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.Entry.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func1.p2pfile
	call	end_program.p2pfile			;;; i108
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
free.func1.p2pfile:
	mov	esi,[ebp-64]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-72]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-92]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-60]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-76]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-100]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-40]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-124]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-96]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-112]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  Entry ()  *****
;  *****
%%%%initOnce.p2pfile:
	cmp d[%%%entered.p2pfile],-1		;;; i117
	jne > A.25	;;; i117a
	ret			;;; i117b
A.25:
	call	PrologCode.p2pfile			;;; i118a
	mov esi,addr %_begin_external_data_p2pfile
	mov edi,addr %_end_external_data_p2pfile
	call %_ZeroMemory
	call	InitSharedComposites.p2pfile			;;; i119
	mov	d[%%%entered.p2pfile],-1
	ret				;;; i120
data section 'p2pfile$internals'
align 4
%%%entered.p2pfile:
db 4 dup ?
.code
;
; [168] FUNCTION KeyCheck (key)
.code
;
#ifdef KeyCheck.key
#undef KeyCheck.key
#endif
#define KeyCheck.key ebp+8	; exposes function argument 'key'
;
align 16
_KeyCheck.p2pfile@4:
;  *****
;  *****  FUNCTION  KeyCheck ()  *****
;  *****
func1B.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,200			;;; i114a
;
funcBody1B.p2pfile:
;
; [169] SHARED APPLSTATUS
;
; [170] SHARED CONNECTED
;
; [171] SHARED thandle
;
; [172] SHARED tAuth0
data section 'globals$shared'
align	4
%tAuth0.p2pfile:	db 4 dup ?
.code
;
; [174] DO
align 8
do.000C.p2pfile:
;
; [175] k = Inkey()
#ifdef KeyCheck.k
#undef KeyCheck.k
#endif
#define KeyCheck.k ebp-40	; exposes local variable 'k'
;
	call	func1A.p2pfile			;;; i619
	mov	d[ebp-40],eax			;;; i670
;
; [176] IF (k == key) THEN
	mov	eax,d[ebp-40]			;;; i665
	mov	ebx,d[ebp+8]			;;; i665
	cmp	eax,ebx			;;; i684a
	jne	>> else.000D.p2pfile			;;; i219
;
; [177] CPrint ("* Shutting down..")
	mov	eax,addr @_string.007F.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [178] APPLSTATUS = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%APPLSTATUS.p2pfile],eax			;;; i668
;
; [179] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [180] Sleep(1000)
;
; [0] EXTERNAL FUNCTION Sleep (dwMilliseconds)
	push	1000			;;; i656a
	call	_Sleep@4			;;; i619
;
; [181] P2PShutdown()
	call	func2D.p2pfile			;;; i619
;
; [182] END IF
else.000D.p2pfile:
end.if.000D.p2pfile:
;
; [184] '		IF (k == 1067) THEN
;
; [185] '			XioHideConsole ()
;
; [186] '		END IF
;
; [188] IF tAuth0 THEN
	mov	eax,d[%tAuth0.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.000E.p2pfile			;;; i221
;
; [189] IF ((GetTickCount()-tAuth0) > $$timeToAuth) THEN InvalidAuth()
;
; [0] EXTERNAL FUNCTION GetTickCount ()
	call	_GetTickCount@0			;;; i619
	mov	ebx,d[%tAuth0.p2pfile]			;;; i663a
	sub	eax,ebx			;;; i791
	cmp	eax,3000			;;; i684a
	jle	>> else.000F.p2pfile			;;; i219
	call	func21.p2pfile			;;; i619
else.000F.p2pfile:
end.if.000F.p2pfile:
;
; [190] END IF
else.000E.p2pfile:
end.if.000E.p2pfile:
;
; [192] Sleep (20)
	push	20			;;; i656a
	call	_Sleep@4			;;; i619
;
; [193] LOOP WHILE ((APPLSTATUS == $$TRUE) && thandle )
do.loop.000C.p2pfile:
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,-1			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.26			;;; i467
	not	eax			;;; i468
A.26:
;+peep
	mov	ebx,d[%thandle.p2pfile]			;;; i663a
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i194
	jnz	< do.000C.p2pfile			;;; i195
end.do.000C.p2pfile:
;
; [195] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.KeyCheck.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1B.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	4			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  KeyCheck ()  *****
;  *****
;
; [197] FUNCTION StartAuthTimeout(socket)
.code
;
#ifdef StartAuthTimeout.socket
#undef StartAuthTimeout.socket
#endif
#define StartAuthTimeout.socket ebp+8	; exposes function argument 'socket'
;
align 16
_StartAuthTimeout.p2pfile@4:
;  *****
;  *****  FUNCTION  StartAuthTimeout ()  *****
;  *****
func22.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody22.p2pfile:
;
; [198] SHARED tAuth0
;
; [199] SHARED asocket
data section 'globals$shared'
align	4
%asocket.p2pfile:	db 4 dup ?
.code
;
; [201] asocket = socket
	mov	eax,d[ebp+8]			;;; i665
	mov	d[%asocket.p2pfile],eax			;;; i668
;
; [202] tAuth0 = GetTickCount()
	call	_GetTickCount@0			;;; i619
	mov	d[%tAuth0.p2pfile],eax			;;; i668
;
; [203] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.StartAuthTimeout.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func22.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	4			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  StartAuthTimeout ()  *****
;  *****
;
; [205] FUNCTION EndAuthTimeOut()
.code
align 16
_EndAuthTimeOut.p2pfile@0:
;  *****
;  *****  FUNCTION  EndAuthTimeOut ()  *****
;  *****
func20.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody20.p2pfile:
;
; [206] SHARED tAuth0
;
; [208] tAuth0 = 0
	mov	eax,0			;;; i659
	mov	d[%tAuth0.p2pfile],eax			;;; i668
;
; [209] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.EndAuthTimeOut.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func20.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  EndAuthTimeOut ()  *****
;  *****
;
; [211] FUNCTION InvalidAuth()
.code
align 16
_InvalidAuth.p2pfile@0:
;  *****
;  *****  FUNCTION  InvalidAuth ()  *****
;  *****
func21.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody21.p2pfile:
;
; [212] SHARED asocket
;
; [213] SHARED CONNECTED
;
; [216] EndAuthTimeOut()
	call	func20.p2pfile			;;; i619
;
; [217] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [218] CPrint ("* authentication failed\r\n* connection closed")
	mov	eax,addr @_string.0089.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [219] closesocket (asocket)
;
; [0] EXTERNAL SFUNCTION  closesocket      (socket)
	push	[%asocket.p2pfile]			;;; i672a
	call	_closesocket@4			;;; i619
;
; [221] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.InvalidAuth.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func21.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  InvalidAuth ()  *****
;  *****
;
; [223] FUNCTION GetDefaultCmdValues (STRING mode,STRING auth,STRING addr,port,srcfile$,desfile$,start,end,flags)
.code
;
#ifdef GetDefaultCmdValues.mode
#undef GetDefaultCmdValues.mode
#endif
#define GetDefaultCmdValues.mode ebp+8	; exposes function argument 'mode'
;
;
#ifdef GetDefaultCmdValues.auth
#undef GetDefaultCmdValues.auth
#endif
#define GetDefaultCmdValues.auth ebp+12	; exposes function argument 'auth'
;
;
#ifdef GetDefaultCmdValues.addr
#undef GetDefaultCmdValues.addr
#endif
#define GetDefaultCmdValues.addr ebp+16	; exposes function argument 'addr'
;
;
#ifdef GetDefaultCmdValues.port
#undef GetDefaultCmdValues.port
#endif
#define GetDefaultCmdValues.port ebp+20	; exposes function argument 'port'
;
;
#ifdef GetDefaultCmdValues.srcfile$
#undef GetDefaultCmdValues.srcfile$
#endif
#define GetDefaultCmdValues.srcfile$ ebp+24	; exposes function argument 'srcfile$'
;
;
#ifdef GetDefaultCmdValues.desfile$
#undef GetDefaultCmdValues.desfile$
#endif
#define GetDefaultCmdValues.desfile$ ebp+28	; exposes function argument 'desfile$'
;
;
#ifdef GetDefaultCmdValues.start
#undef GetDefaultCmdValues.start
#endif
#define GetDefaultCmdValues.start ebp+32	; exposes function argument 'start'
;
;
#ifdef GetDefaultCmdValues.end
#undef GetDefaultCmdValues.end
#endif
#define GetDefaultCmdValues.end ebp+36	; exposes function argument 'end'
;
;
#ifdef GetDefaultCmdValues.flags
#undef GetDefaultCmdValues.flags
#endif
#define GetDefaultCmdValues.flags ebp+40	; exposes function argument 'flags'
;
align 16
_GetDefaultCmdValues.p2pfile@36:
;  *****
;  *****  FUNCTION  GetDefaultCmdValues ()  *****
;  *****
func16.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody16.p2pfile:
;
; [226] mode = "listen"' set default values
	mov	eax,addr @_string.0072.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp+8]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [227] auth = $$FILE_DEFAULTAUTH
	mov	eax,addr @_string.112E.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [228] addr = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [229] port = $$FILE_DEFAULTPORT
	mov	eax,28010			;;; i659
	mov	d[ebp+20],eax			;;; i670
;
; [230] srcfile$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+24]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [231] desfile$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+28]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [232] start = 0
	mov	eax,0			;;; i659
	mov	d[ebp+32],eax			;;; i670
;
; [233] end = 0
	mov	eax,0			;;; i659
	mov	d[ebp+36],eax			;;; i670
;
; [234] flags = 0
	mov	eax,0			;;; i659
	mov	d[ebp+40],eax			;;; i670
;
; [236] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func16.p2pfile			;;; i258
;
; [237] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetDefaultCmdValues.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func16.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	36			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  GetDefaultCmdValues ()  *****
;  *****
;
; [239] FUNCTION GetCommandLine (mode$,auth$,addr$,port,srcfile$,desfile$,start,end,flags)
.code
;
#ifdef GetCommandLine.mode$
#undef GetCommandLine.mode$
#endif
#define GetCommandLine.mode$ ebp+8	; exposes function argument 'mode$'
;
;
#ifdef GetCommandLine.auth$
#undef GetCommandLine.auth$
#endif
#define GetCommandLine.auth$ ebp+12	; exposes function argument 'auth$'
;
;
#ifdef GetCommandLine.addr$
#undef GetCommandLine.addr$
#endif
#define GetCommandLine.addr$ ebp+16	; exposes function argument 'addr$'
;
;
#ifdef GetCommandLine.port
#undef GetCommandLine.port
#endif
#define GetCommandLine.port ebp+20	; exposes function argument 'port'
;
;
#ifdef GetCommandLine.srcfile$
#undef GetCommandLine.srcfile$
#endif
#define GetCommandLine.srcfile$ ebp+24	; exposes function argument 'srcfile$'
;
;
#ifdef GetCommandLine.desfile$
#undef GetCommandLine.desfile$
#endif
#define GetCommandLine.desfile$ ebp+28	; exposes function argument 'desfile$'
;
;
#ifdef GetCommandLine.start
#undef GetCommandLine.start
#endif
#define GetCommandLine.start ebp+32	; exposes function argument 'start'
;
;
#ifdef GetCommandLine.end
#undef GetCommandLine.end
#endif
#define GetCommandLine.end ebp+36	; exposes function argument 'end'
;
;
#ifdef GetCommandLine.flags
#undef GetCommandLine.flags
#endif
#define GetCommandLine.flags ebp+40	; exposes function argument 'flags'
;
align 16
_GetCommandLine.p2pfile@36:
;  *****
;  *****  FUNCTION  GetCommandLine ()  *****
;  *****
func15.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func15.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.42:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.42			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,180			;;; i114a
;
funcBody15.p2pfile:
;
; [242] GetDefaultCmdValues (@mode$,@auth$,@addr$,@port,@srcfile$,@desfile$,@start,@end,@flags)
	push	[ebp+40]			;;; i674a
	push	[ebp+36]			;;; i674a
	push	[ebp+32]			;;; i674a
	push	[ebp+28]			;;; i674a
	push	[ebp+24]			;;; i674a
	push	[ebp+20]			;;; i674a
	push	[ebp+16]			;;; i674a
	push	[ebp+12]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func16.p2pfile			;;; i619
	mov	ecx,d[esp-36]			;;; i877a
	mov	ebx,d[esp-32]			;;; i877b
	mov	edi,d[esp-28]			;;; i877c
	mov	esi,d[esp-24]			;;; i877d
	mov	[ebp+8],ecx			;;; i670
	mov	[ebp+12],ebx			;;; i670
	mov	[ebp+16],edi			;;; i670
	mov	d[ebp+20],esi			;;; i670
	mov	ecx,d[esp-20]			;;; i877a
	mov	ebx,d[esp-16]			;;; i877b
	mov	edi,d[esp-12]			;;; i877c
	mov	esi,d[esp-8]			;;; i877d
	mov	[ebp+24],ecx			;;; i670
	mov	[ebp+28],ebx			;;; i670
	mov	d[ebp+32],edi			;;; i670
	mov	d[ebp+36],esi			;;; i670
	mov	ecx,d[esp-4]			;;; i877a
	mov	d[ebp+40],ecx			;;; i670
;
; [243] GetCommandLineArguments (@argc, @argv$[])
#ifdef GetCommandLine.argc
#undef GetCommandLine.argc
#endif
#define GetCommandLine.argc ebp-40	; exposes local variable 'argc'
;
#ifdef GetCommandLine.argv$
#undef GetCommandLine.argv$
#endif
#define GetCommandLine.argv$ ebp-44	; exposes local variable 'argv$'
;
	push	[ebp-44]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	func14.p2pfile			;;; i619
	mov	ecx,d[esp-8]			;;; i877a
	mov	ebx,d[esp-4]			;;; i877b
	mov	d[ebp-40],ecx			;;; i670
	mov	d[ebp-44],ebx			;;; i670
;
; [245] IF (argc > 1) THEN
	mov	eax,d[ebp-40]			;;; i665
	cmp	eax,1			;;; i684a
	jle	>> else.0010.p2pfile			;;; i219
;
; [246] FOR i = 1 TO argc-1' for all command line arguments
#ifdef GetCommandLine.i
#undef GetCommandLine.i
#endif
#define GetCommandLine.i ebp-48	; exposes local variable 'i'
;
	mov	eax,1			;;; i659
	mov	d[ebp-48],eax			;;; i670
	mov	eax,d[ebp-40]			;;; i665
	sub	eax,1			;;; i791
; .forlimit15.0011 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
align 8
for.0011.p2pfile:
	mov	eax,d[ebp-48]			;;; i665
	mov	ebx,d[ebp-52]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0011.p2pfile			;;; i154
;
; [247] arg$ = TRIM$(argv$[i])' get next argument
#ifdef GetCommandLine.arg$
#undef GetCommandLine.arg$
#endif
#define GetCommandLine.arg$ ebp-56	; exposes local variable 'arg$'
;
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp-56]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [248] IF (LEN (arg$) = 2) THEN' if not empty
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.38			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.38:
	cmp	eax,2			;;; i684a
	jne	>> else.0012.p2pfile			;;; i219
;
; [249] IF (arg${0} = '-') THEN' command line switch?
	mov	edx,d[ebp-56]			;;; i665
	movzx	eax,b[edx]			;;; i464
	cmp	eax,45			;;; i684a
	jne	>> else.0013.p2pfile			;;; i219
;
; [250] SELECT CASE LCASE$(CHR$(arg${1}))' which switch?
	sub	esp,64			;;; i487
	sub	esp,64			;;; i487
	mov	edx,d[ebp-56]			;;; i665
	movzx	eax,b[edx+1]			;;; i464
	mov	d[esp],eax			;;; i887
	mov	d[esp+4],1
	call	%_chr.d			;;; i575
	add	esp,64			;;; i600
	mov	d[esp],eax			;;; i887
	call	%_lcase.d.s			;;; i583
	add	esp,64			;;; i600
; .select15.0014 = ebp-60	; internal variable
	mov	esi,[ebp-60]			;;; i665
	mov	[ebp-60],eax			;;; i670
	call	%____free			;;; i260
;
; [251] CASE "m"	:mode$ = TRIM$(argv$[i+1])' program mode
	mov	eax,addr @_string.00A5.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0001.p2pfile			;;; i71
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+8]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [252] CASE "l"	:auth$ = TRIM$(argv$[i+1])' auth password
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0001.p2pfile:
	mov	eax,addr @_string.00A6.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0002.p2pfile			;;; i71
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [253] CASE "a"	:addr$ = TRIM$(argv$[i+1])' address
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0002.p2pfile:
	mov	eax,addr @_string.00A7.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0003.p2pfile			;;; i71
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [254] CASE "p"	:port = XLONG (TRIM$(argv$[i+1]))' port
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0003.p2pfile:
	mov	eax,addr @_string.00A8.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0004.p2pfile			;;; i71
	sub	esp,64			;;; i487
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	mov	d[esp],eax			;;; i887
	call	%_cv.string.to.xlong.s			;;; i492a
	add	esp,64			;;; i600
	mov	d[ebp+20],eax			;;; i670
;
; [255] IF (port < 1) THEN port = $$FILE_DEFAULTPORT
	mov	eax,d[ebp+20]			;;; i665
	cmp	eax,1			;;; i684a
	jge	>> else.0015.p2pfile			;;; i219
	mov	eax,28010			;;; i659
	mov	d[ebp+20],eax			;;; i670
else.0015.p2pfile:
end.if.0015.p2pfile:
;
; [256] CASE "s"	:srcfile$ = TRIM$(argv$[i+1])' source filename
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0004.p2pfile:
	mov	eax,addr @_string.00A9.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0005.p2pfile			;;; i71
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+24]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [257] CASE "d"	:desfile$ = TRIM$(argv$[i+1])' destination filename
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0005.p2pfile:
	mov	eax,addr @_string.00AA.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0006.p2pfile			;;; i71
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+28]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [258] CASE "o"	:start = XLONG (TRIM$(argv$[i+1]))' start offset
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0006.p2pfile:
	mov	eax,addr @_string.00AB.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0007.p2pfile			;;; i71
	sub	esp,64			;;; i487
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	mov	d[esp],eax			;;; i887
	call	%_cv.string.to.xlong.s			;;; i492a
	add	esp,64			;;; i600
	mov	d[ebp+32],eax			;;; i670
;
; [259] IF (start < 1) THEN start = 0
	mov	eax,d[ebp+32]			;;; i665
	cmp	eax,1			;;; i684a
	jge	>> else.0016.p2pfile			;;; i219
	mov	eax,0			;;; i659
	mov	d[ebp+32],eax			;;; i670
else.0016.p2pfile:
end.if.0016.p2pfile:
;
; [260] CASE "e"	:end = XLONG (TRIM$(argv$[i+1]))' end offset
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0007.p2pfile:
	mov	eax,addr @_string.00AC.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0008.p2pfile			;;; i71
	sub	esp,64			;;; i487
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	mov	d[esp],eax			;;; i887
	call	%_cv.string.to.xlong.s			;;; i492a
	add	esp,64			;;; i600
	mov	d[ebp+36],eax			;;; i670
;
; [261] IF (end < 1) THEN end = 0
	mov	eax,d[ebp+36]			;;; i665
	cmp	eax,1			;;; i684a
	jge	>> else.0017.p2pfile			;;; i219
	mov	eax,0			;;; i659
	mov	d[ebp+36],eax			;;; i670
else.0017.p2pfile:
end.if.0017.p2pfile:
;
; [262] CASE "b"	:#blocks = (1024) * SINGLE(TRIM$(argv$[i+1]))' data block length
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0008.p2pfile:
	mov	eax,addr @_string.00AD.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.0009.p2pfile			;;; i71
	sub	esp,64			;;; i487
	sub	esp,64			;;; i487
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	mov	d[esp],eax			;;; i887
	call	%_cv.string.to.single.s			;;; i492a
	add	esp,64			;;; i600
	push	1083179008			;;; i650
	push	0			;;; i651
	fld	q[esp]			;;; i652
	add	esp,8			;;; i653
	fmul				;;; i841
	fistp	d[%#blocks.p2pfile]			;;; i646
;
; [263] CASE "h"	:PrintHelp (): P2PShutdown (): QUIT(0)
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.0009.p2pfile:
	mov	eax,addr @_string.00B0.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.000A.p2pfile			;;; i71
	call	func11.p2pfile			;;; i619
	call	func2D.p2pfile			;;; i619
	sub	esp,64			;;; i487
	mov	d[esp],0
	call	%_quit
	add	esp,64			;;; i600
;
; [265] CASE "r"	:flags = flags | $$FILE_ENCRYPT' data encryption
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.000A.p2pfile:
	mov	eax,addr @_string.00B1.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.000B.p2pfile			;;; i71
	mov	eax,d[ebp+40]			;;; i665
	or	eax,2			;;; i763
	mov	d[ebp+40],eax			;;; i670
;
; [266] CASE "c"	:flags = flags | $$FILE_CRC' crc32 data
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.000B.p2pfile:
	mov	eax,addr @_string.00B3.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.000C.p2pfile			;;; i71
	mov	eax,d[ebp+40]			;;; i665
	or	eax,1			;;; i763
	mov	d[ebp+40],eax			;;; i670
;
; [267] CASE "z"	:flags = flags | $$FILE_COMPRESS' compress data
	jmp	end.select.0014.p2pfile			;;; i69
case.0014.000C.p2pfile:
	mov	eax,addr @_string.00B5.p2pfile			;;; i663
	mov	ebx,[ebp-60]			;;; i665
	call	%_string.compare.vv			;;; i690
	jne	>> case.0014.000D.p2pfile			;;; i71
	mov	eax,d[ebp+40]			;;; i665
	or	eax,4			;;; i763
	mov	d[ebp+40],eax			;;; i670
;
; [268] END SELECT
case.0014.000D.p2pfile:
end.select.0014.p2pfile:
;
; [269] END IF
else.0013.p2pfile:
end.if.0013.p2pfile:
;
; [270] END IF
else.0012.p2pfile:
end.if.0012.p2pfile:
;
; [271] NEXT i
do.next.0011.p2pfile:
	inc	d[ebp-48]			;;; i229
	jmp	for.0011.p2pfile			;;; i231
end.for.0011.p2pfile:
;
; [272] END IF
else.0010.p2pfile:
end.if.0010.p2pfile:
;
; [274] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func15.p2pfile			;;; i258
;
; [275] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetCommandLine.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func15.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func15.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	36			;;; i111a
free.func15.p2pfile:
	mov	esi,d[ebp-44]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,[ebp-56]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-60]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  GetCommandLine ()  *****
;  *****
;
; [277] FUNCTION PrintHelp ()
.code
align 16
_PrintHelp.p2pfile@0:
;  *****
;  *****  FUNCTION  PrintHelp ()  *****
;  *****
func11.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func11.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.45:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.45			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,148			;;; i114a
;
funcBody11.p2pfile:
;
; [280] GetCommandLineArguments (argc, @argv$[])
#ifdef PrintHelp.argc
#undef PrintHelp.argc
#endif
#define PrintHelp.argc ebp-40	; exposes local variable 'argc'
;
#ifdef PrintHelp.argv$
#undef PrintHelp.argv$
#endif
#define PrintHelp.argv$ ebp-44	; exposes local variable 'argv$'
;
	push	[ebp-44]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	func14.p2pfile			;;; i619
	mov	ecx,d[esp-4]			;;; i877a
	mov	d[ebp-44],ecx			;;; i670
;
; [281] exefile$ = argv$[0]
#ifdef PrintHelp.exefile$
#undef PrintHelp.exefile$
#endif
#define PrintHelp.exefile$ ebp-48	; exposes local variable 'exefile$'
;
	mov	edx,d[ebp-44]			;;; i665
	mov	eax,[edx]			;;; i464
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-48]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [282] DecomposePathname (@exefile$, path$, parent$, @filename$, file$, extent$)
#ifdef PrintHelp.path$
#undef PrintHelp.path$
#endif
#define PrintHelp.path$ ebp-52	; exposes local variable 'path$'
;
	mov	eax,d[ebp-52]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk11.0000 = ebp-60	; internal variable
	mov	d[ebp-60],eax			;;; i670
#ifdef PrintHelp.parent$
#undef PrintHelp.parent$
#endif
#define PrintHelp.parent$ ebp-64	; exposes local variable 'parent$'
;
	mov	eax,d[ebp-64]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk11.0001 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
#ifdef PrintHelp.filename$
#undef PrintHelp.filename$
#endif
#define PrintHelp.filename$ ebp-76	; exposes local variable 'filename$'
;
#ifdef PrintHelp.file$
#undef PrintHelp.file$
#endif
#define PrintHelp.file$ ebp-80	; exposes local variable 'file$'
;
	mov	eax,d[ebp-80]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk11.0002 = ebp-88	; internal variable
	mov	d[ebp-88],eax			;;; i670
#ifdef PrintHelp.extent$
#undef PrintHelp.extent$
#endif
#define PrintHelp.extent$ ebp-92	; exposes local variable 'extent$'
;
	mov	eax,d[ebp-92]			;;; i665
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	push	[ebp-88]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-60]			;;; i674a
	push	[ebp-48]			;;; i674a
	call	func17.p2pfile			;;; i619
	sub	esp,24			;;; xnt1i
	mov	ecx,d[esp]			;;; i877a
	mov	[ebp-48],ecx			;;; i670
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+12]			;;; i877a
	mov	[ebp-76],ecx			;;; i670
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+20]			;;; i871
	call	%____free			;;; i872
	add	esp,24			;;; i633
;
; [284] CPrint ("\r\nUsage: "+filename$+" -m -l -a -p -s -d -o -e -c -b -z -r -h")
	mov	eax,addr @_string.00BF.p2pfile			;;; i663
	mov	ebx,[ebp-76]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.00C0.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [285] CPrint (" -m mode  Operating mode. LISTEN, GET or SEND")
	mov	eax,addr @_string.00C1.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [286] CPrint (" -l pass  Authentication password")
	mov	eax,addr @_string.00C2.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [287] CPrint (" -a ip    Host IP Address")
	mov	eax,addr @_string.00C3.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [288] CPrint (" -p n     Client/Server Port")
	mov	eax,addr @_string.00C4.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [289] CPrint (" -s file  Source filename")
	mov	eax,addr @_string.00C5.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [290] CPrint (" -d file  Destination filename")
	mov	eax,addr @_string.00C6.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [291] CPrint (" -o n     Start Offset. Begin reading at this offset within file")
	mov	eax,addr @_string.00C7.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [292] CPrint (" -e n     End Offset. End reading at this offset")
	mov	eax,addr @_string.00C8.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [293] CPrint (" -c       Enable CRC32 verification on transfer")
	mov	eax,addr @_string.00C9.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [294] CPrint (" -r       Encrypt data, use with -l")
	mov	eax,addr @_string.00CA.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [295] CPrint (" -b mb    Block size per read->send, adjust to suit connection type")
	mov	eax,addr @_string.00CB.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [296] CPrint (" -z       Enable zlib compression per block")
	mov	eax,addr @_string.00CC.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [297] CPrint (" -h       Display this page")
	mov	eax,addr @_string.00CD.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [299] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.PrintHelp.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func11.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func11.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
free.func11.p2pfile:
	mov	esi,[ebp-76]			;;; i665
	call	%____free			;;; i423
	mov	esi,d[ebp-44]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,[ebp-64]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-48]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-92]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-52]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-80]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  PrintHelp ()  *****
;  *****
;
; [301] FUNCTION FileListen (auth,port)
.code
;
#ifdef FileListen.auth
#undef FileListen.auth
#endif
#define FileListen.auth ebp+8	; exposes function argument 'auth'
;
;
#ifdef FileListen.port
#undef FileListen.port
#endif
#define FileListen.port ebp+12	; exposes function argument 'port'
;
align 16
_FileListen.p2pfile@8:
;  *****
;  *****  FUNCTION  FileListen ()  *****
;  *****
func2A.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func2A.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.49:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.49			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,152			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,51				;;; ..
	xor	eax,eax			;;; ...
A.50:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.50			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	lea	ebx,[esp+16]			;;; i125a
	lea	ecx,[esp+560]			;;; i125b
	lea	edx,[esp+1104]			;;; i125c
	mov	d[ebp-44],eax			;;; i670
	mov	d[ebp-48],ebx			;;; i670
	mov	d[ebp-84],ecx			;;; i670
	mov	d[ebp-88],edx			;;; i670
funcBody2A.p2pfile:
;
; [302] SOCKADDR_IN  sockaddrin
; .composites = ebp-40	; internal variable
#ifdef FileListen.sockaddrin
#undef FileListen.sockaddrin
#endif
#define FileListen.sockaddrin ebp-44	; exposes local variable 'sockaddrin'
;
;
; [303] STATIC STRING buffer
data section 'globals$statics'
align	4
%2A%buffer.p2pfile:	db 4 dup ?
.code
;
; [304] SHARED APPLSTATUS
;
; [305] SHARED CONNECTED
;
; [306] TFILE file
#ifdef FileListen.file
#undef FileListen.file
#endif
#define FileListen.file ebp-48	; exposes local variable 'file'
;
;
; [307] XLONG cauth
#ifdef FileListen.cauth
#undef FileListen.cauth
#endif
#define FileListen.cauth ebp-52	; exposes local variable 'cauth'
;
;
; [310] IFF CreateBindSocket (GetLocalIpA(), port,@fssocket) THEN
	call	func13.p2pfile			;;; i619
; .xstk2A.0000 = ebp-60	; internal variable
	mov	[ebp-60],eax			;;; i670
#ifdef FileListen.fssocket
#undef FileListen.fssocket
#endif
#define FileListen.fssocket ebp-64	; exposes local variable 'fssocket'
;
	push	[ebp-64]			;;; i674a
	push	[ebp+12]			;;; i674a
	push	[ebp-60]			;;; i674a
	call	func5.p2pfile			;;; i619
	sub	esp,12			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+8]			;;; i877a
	mov	d[ebp-64],ecx			;;; i670
	add	esp,12			;;; i633
	test	eax,eax			;;; i194
	jnz	>> else.0018.p2pfile			;;; i195
;
; [311] CPrint ("\r\n* unable to create socket")
	mov	eax,addr @_string.00D7.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [312] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func2A.p2pfile			;;; i258
;
; [313] END IF
else.0018.p2pfile:
end.if.0018.p2pfile:
;
; [314] listen (fssocket, 1)
;
; [0] EXTERNAL SFUNCTION  listen           (socket, backlog)
	push	1			;;; i656a
	push	[ebp-64]			;;; i674a
	call	_listen@8			;;; i619
;
; [315] length = SIZE(sockaddrin)
#ifdef FileListen.length
#undef FileListen.length
#endif
#define FileListen.length ebp-68	; exposes local variable 'length'
;
	mov	eax,16			;;; i584
	mov	d[ebp-68],eax			;;; i670
;
; [317] CPrint ("\r\n* Press 'Esc' to Quit")
	mov	eax,addr @_string.00D9.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [318] DO
align 8
do.0019.p2pfile:
;
; [319] ResetSendTotal()
	call	func1C.p2pfile			;;; i619
;
; [320] ResetListenTotal()
	call	func1D.p2pfile			;;; i619
;
; [321] CPrint ("\r\n*** listening on "+GetLocalIpA()+" port "+STRING$(port)+" ***")
	call	func13.p2pfile			;;; i619
	mov	ebx,addr @_string.00DA.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.00DB.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	[ebp-60],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,[ebp-60]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.00DC.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [323] fsclient = accept (fssocket, &sockaddrin, &length)
#ifdef FileListen.fsclient
#undef FileListen.fsclient
#endif
#define FileListen.fsclient ebp-72	; exposes local variable 'fsclient'
;
;
; [0] EXTERNAL SFUNCTION  accept           (socket, addrSOCKADDR, addrLength)
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-60],eax			;;; i670
	lea	eax,[ebp-68]			;;; i642
	push	eax			;;; i667a
	push	[ebp-60]			;;; i674a
	push	[ebp-64]			;;; i674a
	call	_accept@12			;;; i619
	mov	d[ebp-72],eax			;;; i670
;
; [324] IF fsclient && (APPLSTATUS == $$TRUE) THEN
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,-1			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.46			;;; i467
	not	eax			;;; i468
A.46:
;+peep
	mov	ebx,d[ebp-72]			;;; i665
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.001A.p2pfile			;;; i221
;
; [326] CONNECTED = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [327] cip$ = CSTRING$(inet_ntoa (sockaddrin.sin_addr))
#ifdef FileListen.cip$
#undef FileListen.cip$
#endif
#define FileListen.cip$ ebp-76	; exposes local variable 'cip$'
;
	sub	esp,64			;;; i487
;
; [0] EXTERNAL SFUNCTION  inet_ntoa        (in_addr)
	mov	eax,d[ebp-44]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	push	eax			;;; i667a
	call	_inet_ntoa@4			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_cstring.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp-76]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [328] CPrint ("* accepted connection from: "+cip$)
	mov	eax,addr @_string.00E0.p2pfile			;;; i663
	mov	ebx,[ebp-76]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [330] StartAuthTimeout (fsclient)
	push	[ebp-72]			;;; i674a
	call	func22.p2pfile			;;; i619
;
; [331] IFF ListenBin2 (fsclient,SIZE(TFILE),&file) THEN
	mov	eax,544			;;; i584
	mov	d[ebp-60],eax			;;; i670
	mov	eax,d[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	[ebp-60]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	func8.p2pfile			;;; i619
	test	eax,eax			;;; i194
	jnz	>> else.001B.p2pfile			;;; i195
;
; [332] EndAuthTimeOut()
	call	func20.p2pfile			;;; i619
;
; [333] IFT CONNECTED THEN
	mov	eax,d[%CONNECTED.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.001C.p2pfile			;;; i221
;
; [334] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [335] CPrint ("* connection lost")
	mov	eax,addr @_string.00E1.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [336] END IF
else.001C.p2pfile:
end.if.001C.p2pfile:
;
; [337] EXIT IF 2
	jmp	end.if.001A.p2pfile			;;; i146
;
; [338] ELSE
	jmp	end.if.001B.p2pfile			;;; i107
else.001B.p2pfile:
;
; [339] EndAuthTimeOut()
	call	func20.p2pfile			;;; i619
;
; [340] END IF
end.if.001B.p2pfile:
;
; [342] IF file.auth != auth THEN
	mov	eax,d[ebp-48]			;;; i665
	mov	eax,d[eax+3]			;;; i313b
	mov	ebx,d[ebp+8]			;;; i665
	cmp	eax,ebx			;;; i684a
	je	>> else.001D.p2pfile			;;; i219
;
; [343] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [344] InvalidAuth()
	call	func21.p2pfile			;;; i619
;
; [345] EXIT IF 2
	jmp	end.if.001A.p2pfile			;;; i146
;
; [346] END IF
else.001D.p2pfile:
end.if.001D.p2pfile:
;
; [348] IF (file.ident == $$FILE_IDENT) THEN
	mov	eax,d[ebp-48]			;;; i665
	lea	esi,[eax]			;;; i308
	mov	edi,3			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.1132.p2pfile			;;; i663
	call	%_string.compare.sv			;;; i690
	jne	>> else.001E.p2pfile			;;; i219
;
; [349] SELECT CASE file.fmode
	mov	eax,d[ebp-48]			;;; i665
	movzx	eax,b[eax+541]			;;; i313b
; .select2A.001F = ebp-80	; internal variable
	mov	d[ebp-80],eax			;;; i670
;
; [350] CASE $$FILE_SEND	:CPrint ("* sending file to "+cip$+": "+file.srcfile)
	mov	eax,1			;;; i659
	mov	ebx,d[ebp-80]			;;; i665
	cmp	eax,ebx			;;; i684a
	jne	>> case.001F.0001.p2pfile			;;; i71
	mov	eax,addr @_string.00E7.p2pfile			;;; i663
	mov	ebx,[ebp-76]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.00E8.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,d[ebp-48]			;;; i665
	lea	esi,[ebx+7]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	ebx,esi			;;; i312
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [351] IFT FileSend (fsclient, file) THEN
	mov	eax,d[ebp-48]			;;; i665
; .compositeArg.0 = ebp-84	; internal variable
	mov	edi,d[ebp-84]			;;; i665
	mov	esi,eax			;;; i660
	mov	ecx,544			;;; i606a
	mov	eax,edi			;;; i606b
	call	%_assignComposite			;;; i607
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	call	func24.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.0020.p2pfile			;;; i221
;
; [352] CPrint ("* transfer completed: "+file.srcfile)
	mov	eax,d[ebp-48]			;;; i665
	lea	esi,[eax+7]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.00EA.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [353] ELSE
	jmp	end.if.0020.p2pfile			;;; i107
else.0020.p2pfile:
;
; [354] CPrint ("* transfer failed: "+file.srcfile)
	mov	eax,d[ebp-48]			;;; i665
	lea	esi,[eax+7]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.00EB.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [355] END IF
end.if.0020.p2pfile:
;
; [356] CASE $$FILE_GET		:CPrint ("* receiving file from "+cip$+": "+file.desfile)
	jmp	end.select.001F.p2pfile			;;; i69
case.001F.0001.p2pfile:
	mov	eax,2			;;; i659
	mov	ebx,d[ebp-80]			;;; i665
	cmp	eax,ebx			;;; i684a
	jne	>> case.001F.0002.p2pfile			;;; i71
	mov	eax,addr @_string.00ED.p2pfile			;;; i663
	mov	ebx,[ebp-76]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.00E8.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,d[ebp-48]			;;; i665
	lea	esi,[ebx+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	ebx,esi			;;; i312
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [357] IFT FileGet (fsclient, file) THEN
	mov	eax,d[ebp-48]			;;; i665
; .compositeArg.1 = ebp-88	; internal variable
	mov	edi,d[ebp-88]			;;; i665
	mov	esi,eax			;;; i660
	mov	ecx,544			;;; i606a
	mov	eax,edi			;;; i606b
	call	%_assignComposite			;;; i607
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	call	func23.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.0021.p2pfile			;;; i221
;
; [358] CPrint ("* transfer completed: "+file.desfile)
	mov	eax,d[ebp-48]			;;; i665
	lea	esi,[eax+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.00EA.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [359] ELSE
	jmp	end.if.0021.p2pfile			;;; i107
else.0021.p2pfile:
;
; [360] CPrint ("* transfer failed: "+file.desfile)
	mov	eax,d[ebp-48]			;;; i665
	lea	esi,[eax+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.00EB.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [361] END IF
end.if.0021.p2pfile:
;
; [362] CASE ELSE			:CONNECTED = $$FALSE
	jmp	end.select.001F.p2pfile			;;; i69
case.001F.0002.p2pfile:
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [363] CPrint ("* invalid transfer header")
	mov	eax,addr @_string.00EF.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [364] END SELECT
end.select.001F.p2pfile:
;
; [365] ELSE
	jmp	end.if.001E.p2pfile			;;; i107
else.001E.p2pfile:
;
; [366] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [367] CPrint ("* invalid header")
	mov	eax,addr @_string.00F0.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [368] END IF
end.if.001E.p2pfile:
;
; [369] ELSE
	jmp	end.if.001A.p2pfile			;;; i107
else.001A.p2pfile:
;
; [370] IFT APPLSTATUS THEN
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.0022.p2pfile			;;; i221
;
; [371] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [372] CPrint ("* attempted connection failed")
	mov	eax,addr @_string.00F1.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [373] END IF
else.0022.p2pfile:
end.if.0022.p2pfile:
;
; [374] END IF
end.if.001A.p2pfile:
;
; [376] LOOP WHILE (APPLSTATUS == $$TRUE)
do.loop.0019.p2pfile:
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,-1			;;; i684a
	je	< do.0019.p2pfile			;;; i193
end.do.0019.p2pfile:
;
; [378] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [379] APPLSTATUS = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%APPLSTATUS.p2pfile],eax			;;; i668
;
; [380] closesocket (fsclient)
	push	[ebp-72]			;;; i674a
	call	_closesocket@4			;;; i619
;
; [381] closesocket (fssocket)
	push	[ebp-64]			;;; i674a
	call	_closesocket@4			;;; i619
;
; [383] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.FileListen.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func2A.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func2A.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
free.func2A.p2pfile:
	mov	esi,[ebp-76]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  FileListen ()  *****
;  *****
;
; [385] FUNCTION FileSend (fsclient, TFILE file)
.code
;
#ifdef FileSend.fsclient
#undef FileSend.fsclient
#endif
#define FileSend.fsclient ebp+8	; exposes function argument 'fsclient'
;
;
#ifdef FileSend.file
#undef FileSend.file
#endif
#define FileSend.file ebp+12	; exposes function argument 'file'
;
align 16
_FileSend.p2pfile@8:
;  *****
;  *****  FUNCTION  FileSend ()  *****
;  *****
func24.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func24.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.57:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.57			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,128			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-60],eax			;;; i670
funcBody24.p2pfile:
;
; [386] UBYTE buffer[],dbuffer[]
#ifdef FileSend.buffer
#undef FileSend.buffer
#endif
#define FileSend.buffer ebp-40	; exposes local variable 'buffer'
;
#ifdef FileSend.dbuffer
#undef FileSend.dbuffer
#endif
#define FileSend.dbuffer ebp-44	; exposes local variable 'dbuffer'
;
;
; [387] STRING auth
#ifdef FileSend.auth
#undef FileSend.auth
#endif
#define FileSend.auth ebp-48	; exposes local variable 'auth'
;
;
; [388] SINGLE tt
#ifdef FileSend.tt
#undef FileSend.tt
#endif
#define FileSend.tt ebp-52	; exposes local variable 'tt'
;
;
; [389] TCRC crc
; .composites = ebp-56	; internal variable
#ifdef FileSend.crc
#undef FileSend.crc
#endif
#define FileSend.crc ebp-60	; exposes local variable 'crc'
;
;
; [392] IF file.ident != $$FILE_IDENT THEN
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax]			;;; i308
	mov	edi,3			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.1132.p2pfile			;;; i663
	call	%_string.compare.sv			;;; i690
	je	>> else.0023.p2pfile			;;; i219
;
; [393] CPrint ("* invalid transfer request")
	mov	eax,addr @_string.00F9.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [394] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [395] END IF
else.0023.p2pfile:
end.if.0023.p2pfile:
;
; [397] auth = STRING$(file.auth)
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+3]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.ulong			;;; i576
	add	esp,64			;;; i600
	lea	ebx,[ebp-48]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [398] t0 = GetTickCount ()
#ifdef FileSend.t0
#undef FileSend.t0
#endif
#define FileSend.t0 ebp-64	; exposes local variable 't0'
;
	call	_GetTickCount@0			;;; i619
	mov	d[ebp-64],eax			;;; i670
;
; [399] file.error = 0
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,0			;;; i659
	mov	b[eax+543],bl			;;; i13b
;
; [400] file.size = 0
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,0			;;; i659
	mov	d[eax+529],ebx			;;; i13b
;
; [402] IF file.end OR file.start THEN
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i220
	jz	>> else.0024.p2pfile			;;; i221
;
; [403] file.wmode = $$WR
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,1			;;; i659
	mov	d[eax+533],ebx			;;; i13b
;
; [404] ELSE
	jmp	end.if.0024.p2pfile			;;; i107
else.0024.p2pfile:
;
; [405] file.wmode = $$WRNEW
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,3			;;; i659
	mov	d[eax+533],ebx			;;; i13b
;
; [406] END IF
end.if.0024.p2pfile:
;
; [408] fp = open_file (&file.srcfile, 0)
#ifdef FileSend.fp
#undef FileSend.fp
#endif
#define FileSend.fp ebp-68	; exposes local variable 'fp'
;
	mov	eax,d[ebp+12]			;;; i665
	lea	eax,[eax+7]			;;; i636
; .xstk24.0000 = ebp-76	; internal variable
	mov	d[ebp-76],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-76]			;;; i674a
	call	funcB.p2pfile			;;; i619
	mov	d[ebp-68],eax			;;; i670
;
; [409] IF fp THEN
	mov	eax,d[ebp-68]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0025.p2pfile			;;; i221
;
; [410] fseek(fp, 0, 2)'$$SEEK_END)
;
; [0] EXTERNAL CFUNCTION  fseek (fpAddr, offset, where)			' changes the read/write position of the file specified by fp
	push	2			;;; i656a
	push	0			;;; i656a
	push	[ebp-68]			;;; i674a
	call	_fseek			;;; i619
	add	esp,12			;;; i633
;
; [411] file.size = ftell(fp)
;
; [0] EXTERNAL CFUNCTION  ftell (fpAddr)										' returns the current read/write position of the file specified by fp
	push	[ebp-68]			;;; i674a
	call	_ftell			;;; i619
	add	esp,4			;;; i633
	mov	ebx,d[ebp+12]			;;; i665
	mov	d[ebx+529],eax			;;; i13b
;
; [413] IFZ file.end THEN
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	test	eax,eax			;;; i194
	jnz	>> else.0026.p2pfile			;;; i195
;
; [414] file.end = file.size
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+529]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	d[ebx+525],eax			;;; i13b
;
; [415] ELSE
	jmp	end.if.0026.p2pfile			;;; i107
else.0026.p2pfile:
;
; [416] IF file.end > file.size THEN file.end = file.size
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+529]			;;; i313b
	cmp	eax,ebx			;;; i684a
	jle	>> else.0027.p2pfile			;;; i219
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+529]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	d[ebx+525],eax			;;; i13b
else.0027.p2pfile:
end.if.0027.p2pfile:
;
; [417] END IF
end.if.0026.p2pfile:
;
; [419] IF (file.end - file.start) > file.blocks THEN
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	sub	eax,ebx			;;; i791
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+537]			;;; i313b
	cmp	eax,ebx			;;; i684a
	jle	>> else.0028.p2pfile			;;; i219
;
; [420] fbsize = file.blocks
#ifdef FileSend.fbsize
#undef FileSend.fbsize
#endif
#define FileSend.fbsize ebp-80	; exposes local variable 'fbsize'
;
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+537]			;;; i313b
	mov	d[ebp-80],eax			;;; i670
;
; [421] ELSE
	jmp	end.if.0028.p2pfile			;;; i107
else.0028.p2pfile:
;
; [422] fbsize = file.end - file.start
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	sub	eax,ebx			;;; i791
	mov	d[ebp-80],eax			;;; i670
;
; [423] END IF
end.if.0028.p2pfile:
;
; [425] CPrint ("* file size: "+STRING$(file.size)+" bytes")
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+529]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0105.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0106.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [426] CPrint ("* total bytes to send: "+STRING$(file.end - file.start))
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	sub	eax,ebx			;;; i791
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0107.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [428] IFF SendBin (fsclient,&file,SIZE(TFILE)) THEN
	mov	eax,d[ebp+12]			;;; i642
	mov	d[ebp-76],eax			;;; i670
	mov	eax,544			;;; i584
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func6.p2pfile			;;; i619
	test	eax,eax			;;; i194
	jnz	>> else.0029.p2pfile			;;; i195
;
; [429] CPrint ("* transfer error")
	mov	eax,addr @_string.0108.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [430] close_file (fp)
	push	[ebp-68]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [431] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [432] END IF
else.0029.p2pfile:
end.if.0029.p2pfile:
;
; [434] DIM buffer[fbsize]
	sub	esp,64			;;; i430
	mov	eax,d[ebp-80]			;;; i665
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp-40]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073545215			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp-40],eax			;;; i670
;
; [435] IF (file.flags & $$FILE_COMPRESS) THEN DIM dbuffer[fbsize+1024]
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,4			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.002A.p2pfile			;;; i221
	sub	esp,64			;;; i430
	mov	eax,d[ebp-80]			;;; i665
	add	eax,1024			;;; i775
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp-44]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073545215			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp-44],eax			;;; i670
else.002A.p2pfile:
end.if.002A.p2pfile:
;
; [437] FOR pos = file.start TO file.end STEP file.blocks
#ifdef FileSend.pos
#undef FileSend.pos
#endif
#define FileSend.pos ebp-84	; exposes local variable 'pos'
;
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+521]			;;; i313b
	mov	d[ebp-84],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
; .forlimit24.002B = ebp-88	; internal variable
	mov	d[ebp-88],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+537]			;;; i313b
; .forstep24.002B = ebp-92	; internal variable
	mov	d[ebp-92],eax			;;; i670
align 8
for.002B.p2pfile:
	mov	eax,d[ebp-84]			;;; i665
	mov	ebx,d[ebp-88]			;;; i665
	mov	esi,d[ebp-92]			;;; i665
	or	esi,esi
	jns	> A.51
	xchg	eax,ebx
A.51:
	cmp	eax,ebx			;;; i153
	jg	>> end.for.002B.p2pfile			;;; i154
;
; [439] IF (pos+fbsize) > file.end THEN fbsize = file.end - pos
	mov	eax,d[ebp-84]			;;; i665
	mov	ebx,d[ebp-80]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+525]			;;; i313b
	cmp	eax,ebx			;;; i684a
	jle	>> else.002C.p2pfile			;;; i219
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp-84]			;;; i665
	sub	eax,ebx			;;; i791
	mov	d[ebp-80],eax			;;; i670
else.002C.p2pfile:
end.if.002C.p2pfile:
;
; [440] fsetpos (fp, &pos)
;
; [0] EXTERNAL CFUNCTION  fsetpos (fpAddr, posAddr)					' positions the file fp according to the value of the object pointed to by pos
	lea	eax,[ebp-84]			;;; i642
	push	eax			;;; i667a
	push	[ebp-68]			;;; i674a
	call	_fsetpos			;;; i619
	add	esp,8			;;; i633
;
; [441] fread (&buffer[],1,fbsize,fp)
;
; [0] EXTERNAL CFUNCTION  fread (bufAddr, elsize, nelem, fpAddr)		' reads nelem elements of elsize bytes each from the file specified by fp into the buffer specified by buf
	push	[ebp-68]			;;; i674a
	push	[ebp-80]			;;; i674a
	push	1			;;; i656a
	push	[ebp-40]			;;; i674a
	call	_fread			;;; i619
	add	esp,16			;;; i633
;
; [442] crc.filepos = pos
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-84]			;;; i665
	mov	d[eax],ebx			;;; i13b
;
; [443] crc.usize = fbsize
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-80]			;;; i665
	mov	d[eax+8],ebx			;;; i13b
;
; [445] IF (file.flags & $$FILE_CRC) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,1			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.002D.p2pfile			;;; i221
;
; [446] crc.crc32 = GetAdler32(&buffer[],crc.usize)
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+8]			;;; i313b
	push	eax			;;; i667a
	push	[ebp-40]			;;; i674a
	call	funcF.p2pfile			;;; i619
	mov	ebx,d[ebp-60]			;;; i665
	mov	d[ebx+12],eax			;;; i13b
;
; [447] ELSE
	jmp	end.if.002D.p2pfile			;;; i107
else.002D.p2pfile:
;
; [448] crc.crc32 = 0
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,0			;;; i659
	mov	d[eax+12],ebx			;;; i13b
;
; [449] END IF
end.if.002D.p2pfile:
;
; [451] IF (file.flags & $$FILE_COMPRESS) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,4			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.002E.p2pfile			;;; i221
;
; [452] dsize = crc.usize + 1024
#ifdef FileSend.dsize
#undef FileSend.dsize
#endif
#define FileSend.dsize ebp-96	; exposes local variable 'dsize'
;
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+8]			;;; i313b
	mov	ebx,1024			;;; i659
	or	ebx,ebx			;;; i366
	jns	> A.52			;;; i367
	call	%_eeeOverflow			;;; i368
A.52:
	add	eax,ebx			;;; i772
	jnc	> A.53			;;; i773
	call	%_eeeOverflow			;;; i774
A.53:
	mov	d[ebp-96],eax			;;; i670
;
; [453] zlib_compress(&buffer[],crc.usize,&dbuffer[],&dsize,5)' $$Z_BEST_COMPRESSION)
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+8]			;;; i313b
	mov	d[ebp-76],eax			;;; i670
	lea	eax,[ebp-96]			;;; i642
; .xstk24.0001 = ebp-104	; internal variable
	mov	d[ebp-104],eax			;;; i670
	push	5			;;; i656a
	push	[ebp-104]			;;; i674a
	push	[ebp-44]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	func27.p2pfile			;;; i619
;
; [455] crc.size = dsize
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-96]			;;; i665
	mov	d[eax+4],ebx			;;; i13b
;
; [456] lpdata = &dbuffer[]
#ifdef FileSend.lpdata
#undef FileSend.lpdata
#endif
#define FileSend.lpdata ebp-108	; exposes local variable 'lpdata'
;
	mov	eax,d[ebp-44]			;;; i665
	mov	d[ebp-108],eax			;;; i670
;
; [457] ELSE
	jmp	end.if.002E.p2pfile			;;; i107
else.002E.p2pfile:
;
; [458] crc.size = fbsize
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-80]			;;; i665
	mov	d[eax+4],ebx			;;; i13b
;
; [459] lpdata = &buffer[]
	mov	eax,d[ebp-40]			;;; i665
	mov	d[ebp-108],eax			;;; i670
;
; [460] END IF
end.if.002E.p2pfile:
;
; [462] IF (file.flags & $$FILE_ENCRYPT) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,2			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.002F.p2pfile			;;; i221
;
; [463] encrypt_buffer(lpdata,crc.size,auth)
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[ebp-76],eax			;;; i670
	mov	eax,d[ebp-48]			;;; i665
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	[ebp-108]			;;; i674a
	call	func25.p2pfile			;;; i619
	sub	esp,12			;;; xnt1i
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	add	esp,12			;;; i633
;
; [464] END IF
else.002F.p2pfile:
end.if.002F.p2pfile:
;
; [466] IFZ fsclient THEN
	mov	eax,d[ebp+8]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0030.p2pfile			;;; i195
;
; [467] close_file (fp)
	push	[ebp-68]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [468] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [469] END IF
else.0030.p2pfile:
end.if.0030.p2pfile:
;
; [471] IFT SendBin(fsclient,&crc,SIZE(TCRC)) THEN
	mov	eax,d[ebp-60]			;;; i642
	mov	d[ebp-76],eax			;;; i670
	mov	eax,16			;;; i584
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func6.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.0031.p2pfile			;;; i221
;
; [472] '	Sleep (1)
;
; [473] IFF SendBin (fsclient,lpdata,crc.size) THEN
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	push	eax			;;; i667a
	push	[ebp-108]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func6.p2pfile			;;; i619
	test	eax,eax			;;; i194
	jnz	>> else.0032.p2pfile			;;; i195
;
; [474] CPrint ("* transfer error")
	mov	eax,addr @_string.0108.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [475] close_file (fp)
	push	[ebp-68]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [476] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [477] END IF
else.0032.p2pfile:
end.if.0032.p2pfile:
;
; [478] 'Sleep (50)		' remove this sleep if transfering across a LAN. try increasing if there are conn errors.
;
; [479] ELSE
	jmp	end.if.0031.p2pfile			;;; i107
else.0031.p2pfile:
;
; [480] CPrint ("* transfer error")
	mov	eax,addr @_string.0108.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [481] close_file (fp)
	push	[ebp-68]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [482] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [483] END IF
end.if.0031.p2pfile:
;
; [485] NEXT pos
do.next.002B.p2pfile:
	mov	eax,d[ebp-84]			;;; i665
	mov	ebx,d[ebp-92]			;;; i665
	add	eax,ebx			;;; i238a
	mov	d[ebp-84],eax			;;; i670
	jmp	for.002B.p2pfile			;;; i238b
end.for.002B.p2pfile:
;
; [487] tt = (GetTickCount()-t0) * 0.001
	call	_GetTickCount@0			;;; i619
	mov	ebx,d[ebp-64]			;;; i665
	sub	eax,ebx			;;; i791
	mov	d[ebp-8],eax			;;; i397
	fild	d[ebp-8]			;;; i398
	push	1062232653			;;; i650
	push	-755914244			;;; i651
	fld	q[esp]			;;; i652
	add	esp,8			;;; i653
	fmul				;;; i841
	fstp	d[ebp-52]			;;; i669
;
; [488] PRINT "* transfer rate:";XLONG (((file.end-file.start))/tt);" bytes per second"
; .filenumber = ebp-112	; internal variable
	push	1			;;; i844
	sub	esp,64			;;; i845
	mov	eax,addr @_string.0112.p2pfile			;;; i663
	call	%_clone.a0			;;; i429
	mov	[ebp-76],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	sub	eax,ebx			;;; i791
	mov	d[ebp-8],eax			;;; i389
	fild	d[ebp-8]			;;; i390
	fld	d[ebp-52]			;;; i643a
	fdiv				;;; i841
	fstp	d[esp]
	call	%_cv.single.to.xlong			;;; i492b
	add	esp,64			;;; i600
	mov	ebx,[ebp-76]			;;; i665
	push	ebx
	sub	esp,64
	mov	d[esp],eax			;;; i848
	call	%_str.d.xlong			;;; i849a
	add	esp,64			;;; i849b
	pop	ebx			;;; i849d
	push ebx
	push eax
	push 6
	call main.concat	;;; i291
	add esp,12
	mov	ebx,addr @_string.0113.p2pfile			;;; i663
	call	%_clone.a1			;;; i429
	push eax
	push ebx
	push 6
	call main.concat	;;; i291a
	add esp,12
	add	esp,64
	call	%_PrintWithNewlineThenFree			;;; i859
	add	esp,4
;
; [489] CPrint ("* total data sent: "+STRING$(GetSendTotal()/1024)+"kb")
	sub	esp,64			;;; i487
	call	func1E.p2pfile			;;; i619
	mov	esi,1024
	cdq	
	idiv	esi
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0114.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0115.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [491] close_file (fp)
	push	[ebp-68]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [492] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [493] ELSE
	jmp	end.if.0025.p2pfile			;;; i107
else.0025.p2pfile:
;
; [494] CPrint ("* access to file denied or file does not exist: "+file.srcfile)
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax+7]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.0116.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [495] file.error = 1
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,1			;;; i659
	mov	b[eax+543],bl			;;; i13b
;
; [496] SendBin (fsclient,&file,SIZE(TFILE))
	mov	eax,d[ebp+12]			;;; i642
	mov	d[ebp-76],eax			;;; i670
	mov	eax,544			;;; i584
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func6.p2pfile			;;; i619
;
; [497] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [498] END IF
end.if.0025.p2pfile:
;
; [500] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func24.p2pfile			;;; i258
;
; [501] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.FileSend.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func24.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func24.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
free.func24.p2pfile:
	mov	esi,d[ebp-44]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,d[ebp-40]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,[ebp-48]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  FileSend ()  *****
;  *****
;
; [503] FUNCTION FileGet (socket, TFILE file)
.code
;
#ifdef FileGet.socket
#undef FileGet.socket
#endif
#define FileGet.socket ebp+8	; exposes function argument 'socket'
;
;
#ifdef FileGet.file
#undef FileGet.file
#endif
#define FileGet.file ebp+12	; exposes function argument 'file'
;
align 16
_FileGet.p2pfile@8:
;  *****
;  *****  FUNCTION  FileGet ()  *****
;  *****
func23.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func23.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,3				;;; ..
	xor	eax,eax			;;; ...
A.65:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.65			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,96			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-60],eax			;;; i670
funcBody23.p2pfile:
;
; [504] UBYTE buffer[],dbuffer[]
#ifdef FileGet.buffer
#undef FileGet.buffer
#endif
#define FileGet.buffer ebp-40	; exposes local variable 'buffer'
;
#ifdef FileGet.dbuffer
#undef FileGet.dbuffer
#endif
#define FileGet.dbuffer ebp-44	; exposes local variable 'dbuffer'
;
;
; [505] SINGLE tt
#ifdef FileGet.tt
#undef FileGet.tt
#endif
#define FileGet.tt ebp-48	; exposes local variable 'tt'
;
;
; [506] STRING auth
#ifdef FileGet.auth
#undef FileGet.auth
#endif
#define FileGet.auth ebp-52	; exposes local variable 'auth'
;
;
; [507] TCRC crc
; .composites = ebp-56	; internal variable
#ifdef FileGet.crc
#undef FileGet.crc
#endif
#define FileGet.crc ebp-60	; exposes local variable 'crc'
;
;
; [509] t0 = GetTickCount ()
#ifdef FileGet.t0
#undef FileGet.t0
#endif
#define FileGet.t0 ebp-64	; exposes local variable 't0'
;
	call	_GetTickCount@0			;;; i619
	mov	d[ebp-64],eax			;;; i670
;
; [510] auth = STRING$(file.auth)
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+3]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.ulong			;;; i576
	add	esp,64			;;; i600
	lea	ebx,[ebp-52]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [511] ListenBin2 (socket,SIZE(TFILE),&file)
	mov	eax,544			;;; i584
; .xstk23.0000 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i642
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func8.p2pfile			;;; i619
;
; [513] IF file.ident != $$FILE_IDENT THEN
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax]			;;; i308
	mov	edi,3			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.1132.p2pfile			;;; i663
	call	%_string.compare.sv			;;; i690
	je	>> else.0033.p2pfile			;;; i219
;
; [514] CPrint ("* transfer header invalid")
	mov	eax,addr @_string.011F.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [515] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [516] END IF
else.0033.p2pfile:
end.if.0033.p2pfile:
;
; [518] IF file.error THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+543]			;;; i313b
	test	eax,eax			;;; i220
	jz	>> else.0034.p2pfile			;;; i221
;
; [519] CPrint ("* unable to open file or file does not exist")
	mov	eax,addr @_string.0120.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [520] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [521] END IF
else.0034.p2pfile:
end.if.0034.p2pfile:
;
; [523] IFZ file.end OR file.size THEN
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+529]			;;; i313b
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i194
	jnz	>> else.0035.p2pfile			;;; i195
;
; [524] CPrint ("* no data to receive")
	mov	eax,addr @_string.0121.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [525] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [526] END IF
else.0035.p2pfile:
end.if.0035.p2pfile:
;
; [528] CPrint ("* file size: "+STRING$(file.size)+" bytes")
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+529]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0105.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0106.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [529] CPrint ("* total bytes to write: "+STRING$(file.end - file.start))
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
	mov	ebx,d[ebp+12]			;;; i665
	mov	ebx,d[ebx+521]			;;; i313b
	sub	eax,ebx			;;; i791
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0122.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [531] DecomposePathname (file.desfile, @path$, parent$, filename$, Fn$, fileExt$)
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	[ebp-72],eax			;;; i670
#ifdef FileGet.path$
#undef FileGet.path$
#endif
#define FileGet.path$ ebp-76	; exposes local variable 'path$'
;
#ifdef FileGet.parent$
#undef FileGet.parent$
#endif
#define FileGet.parent$ ebp-80	; exposes local variable 'parent$'
;
	mov	eax,d[ebp-80]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk23.0001 = ebp-88	; internal variable
	mov	d[ebp-88],eax			;;; i670
#ifdef FileGet.filename$
#undef FileGet.filename$
#endif
#define FileGet.filename$ ebp-92	; exposes local variable 'filename$'
;
	mov	eax,d[ebp-92]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk23.0002 = ebp-100	; internal variable
	mov	d[ebp-100],eax			;;; i670
#ifdef FileGet.Fn$
#undef FileGet.Fn$
#endif
#define FileGet.Fn$ ebp-104	; exposes local variable 'Fn$'
;
	mov	eax,d[ebp-104]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk23.0003 = ebp-112	; internal variable
	mov	d[ebp-112],eax			;;; i670
#ifdef FileGet.fileExt$
#undef FileGet.fileExt$
#endif
#define FileGet.fileExt$ ebp-116	; exposes local variable 'fileExt$'
;
	mov	eax,d[ebp-116]			;;; i665
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	push	[ebp-112]			;;; i674a
	push	[ebp-100]			;;; i674a
	push	[ebp-88]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	func17.p2pfile			;;; i619
	sub	esp,24			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+4]			;;; i877a
	mov	[ebp-76],ecx			;;; i670
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+12]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+16]			;;; i871
	call	%____free			;;; i872
	mov	esi,d[esp+20]			;;; i871
	call	%____free			;;; i872
	add	esp,24			;;; i633
;
; [532] IF path$ THEN CreateDirectoryA (&path$, 0)
	mov	eax,[ebp-76]			;;; i665
	test	eax,eax			;;; i214
	jz	>> else.0036.p2pfile			;;; i215
	mov	eax,d[eax-8]			;;; i216
	test	eax,eax			;;; i217
	jz	>> else.0036.p2pfile			;;; i218
;
; [0] EXTERNAL FUNCTION CreateDirectoryA (lpPathName, lpSecurityAttributes)
	mov	eax,d[ebp-76]			;;; i642
	mov	d[ebp-72],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-72]			;;; i674a
	call	_CreateDirectoryA@8			;;; i619
else.0036.p2pfile:
end.if.0036.p2pfile:
;
; [534] hfile = open_file (&file.desfile,&"wb")
#ifdef FileGet.hfile
#undef FileGet.hfile
#endif
#define FileGet.hfile ebp-120	; exposes local variable 'hfile'
;
	mov	eax,d[ebp+12]			;;; i665
	lea	eax,[eax+262]			;;; i636
	mov	d[ebp-72],eax			;;; i670
	mov	eax,addr @_string.0129.p2pfile			;;; i642
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	call	funcB.p2pfile			;;; i619
	mov	d[ebp-120],eax			;;; i670
;
; [535] IFZ (hfile) THEN
	mov	eax,d[ebp-120]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0037.p2pfile			;;; i195
;
; [536] 'CPrint ("* access denied on file: "+file.desfile)
;
; [537] CPrint ("* transfer aborted *")
	mov	eax,addr @_string.012A.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [538] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [539] ELSE
	jmp	end.if.0037.p2pfile			;;; i107
else.0037.p2pfile:
;
; [540] FOR pos = file.start TO file.end STEP file.blocks
#ifdef FileGet.pos
#undef FileGet.pos
#endif
#define FileGet.pos ebp-124	; exposes local variable 'pos'
;
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+521]			;;; i313b
	mov	d[ebp-124],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+525]			;;; i313b
; .forlimit23.0038 = ebp-128	; internal variable
	mov	d[ebp-128],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	mov	eax,d[eax+537]			;;; i313b
; .forstep23.0038 = ebp-132	; internal variable
	mov	d[ebp-132],eax			;;; i670
align 8
for.0038.p2pfile:
	mov	eax,d[ebp-124]			;;; i665
	mov	ebx,d[ebp-128]			;;; i665
	mov	esi,d[ebp-132]			;;; i665
	or	esi,esi
	jns	> A.59
	xchg	eax,ebx
A.59:
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0038.p2pfile			;;; i154
;
; [541] ListenBin2 (socket,SIZE(TCRC),&crc)
	mov	eax,16			;;; i584
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp-60]			;;; i642
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func8.p2pfile			;;; i619
;
; [543] IF crc.size THEN
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	test	eax,eax			;;; i220
	jz	>> else.0039.p2pfile			;;; i221
;
; [544] IF (UBOUND(buffer[])!= crc.size) THEN DIM buffer[crc.size]
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.60			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.60:
	dec	eax			;;; i596
	mov	ebx,d[ebp-60]			;;; i665
	mov	ebx,d[ebx+4]			;;; i313b
	cmp	eax,ebx			;;; i684a
	je	>> else.003A.p2pfile			;;; i219
	sub	esp,64			;;; i430
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp-40]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073545215			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp-40],eax			;;; i670
else.003A.p2pfile:
end.if.003A.p2pfile:
;
; [545] ListenBin2 (socket,crc.size,&buffer[])
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[ebp-72],eax			;;; i670
	push	[ebp-40]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func8.p2pfile			;;; i619
;
; [547] IF (file.flags & $$FILE_ENCRYPT) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,2			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.003B.p2pfile			;;; i221
;
; [548] decrypt_buffer (&buffer[],crc.size,auth,"")
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp-52]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-88],eax			;;; i670
	push	0			;;; i665a
	push	[ebp-88]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	func26.p2pfile			;;; i619
	sub	esp,16			;;; xnt1i
	mov	esi,d[esp+8]			;;; i871
	call	%____free			;;; i872
	add	esp,16			;;; i633
;
; [549] END IF
else.003B.p2pfile:
end.if.003B.p2pfile:
;
; [551] IF (file.flags & $$FILE_COMPRESS) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,4			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.003C.p2pfile			;;; i221
;
; [552] dsize = crc.usize
#ifdef FileGet.dsize
#undef FileGet.dsize
#endif
#define FileGet.dsize ebp-136	; exposes local variable 'dsize'
;
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+8]			;;; i313b
	mov	d[ebp-136],eax			;;; i670
;
; [553] IF (UBOUND(dbuffer[]) != dsize) THEN DIM dbuffer[dsize]
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.61			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.61:
	dec	eax			;;; i596
	mov	ebx,d[ebp-136]			;;; i665
	cmp	eax,ebx			;;; i684a
	je	>> else.003D.p2pfile			;;; i219
	sub	esp,64			;;; i430
	mov	eax,d[ebp-136]			;;; i665
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp-44]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073545215			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp-44],eax			;;; i670
else.003D.p2pfile:
end.if.003D.p2pfile:
;
; [554] zlib_decompress (&buffer[],crc.size,&dbuffer[],&dsize)
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[ebp-72],eax			;;; i670
	lea	eax,[ebp-136]			;;; i642
	push	eax			;;; i667a
	push	[ebp-44]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	func29.p2pfile			;;; i619
;
; [556] IF dsize != crc.usize THEN
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+8]			;;; i313b
	mov	ebx,d[ebp-136]			;;; i665
	cmp	eax,ebx			;;; i684a
	je	>> else.003E.p2pfile			;;; i219
;
; [557] CPrint ("* decompression error: source blk size different from destination blk size")
	mov	eax,addr @_string.012D.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [558] END IF
else.003E.p2pfile:
end.if.003E.p2pfile:
;
; [560] crc.size = dsize
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-136]			;;; i665
	mov	d[eax+4],ebx			;;; i13b
;
; [561] lpdata = &dbuffer[]
#ifdef FileGet.lpdata
#undef FileGet.lpdata
#endif
#define FileGet.lpdata ebp-140	; exposes local variable 'lpdata'
;
	mov	eax,d[ebp-44]			;;; i665
	mov	d[ebp-140],eax			;;; i670
;
; [562] ELSE
	jmp	end.if.003C.p2pfile			;;; i107
else.003C.p2pfile:
;
; [563] lpdata = &buffer[]
	mov	eax,d[ebp-40]			;;; i665
	mov	d[ebp-140],eax			;;; i670
;
; [564] END IF
end.if.003C.p2pfile:
;
; [566] IF (file.flags & $$FILE_CRC) THEN
	mov	eax,d[ebp+12]			;;; i665
	movzx	eax,b[eax+542]			;;; i313b
	and	eax,1			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.003F.p2pfile			;;; i221
;
; [567] crc32 = GetAdler32 (lpdata,crc.size)
#ifdef FileGet.crc32
#undef FileGet.crc32
#endif
#define FileGet.crc32 ebp-144	; exposes local variable 'crc32'
;
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	push	eax			;;; i667a
	push	[ebp-140]			;;; i674a
	call	funcF.p2pfile			;;; i619
	mov	d[ebp-144],eax			;;; i670
;
; [568] IF crc32 != crc.crc32 THEN
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+12]			;;; i313b
	mov	ebx,d[ebp-144]			;;; i665
	cmp	eax,ebx			;;; i684a
	je	>> else.0040.p2pfile			;;; i219
;
; [569] CPrint ("* crc error on transfer: "+file.desfile)
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.0130.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [570] CPrint ("*  offset: "+STRING$(crc.filepos)+" size: "+STRING$(crc.size))
	sub	esp,64			;;; i487
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.ulong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0131.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0132.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	[ebp-72],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	mov	d[esp],eax			;;; i887
	call	%_string.ulong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,[ebp-72]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [571] CPrint ("*  remote data crc:   " +HEXX$(crc.crc32))
	sub	esp,64			;;; i487
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+12]			;;; i313b
	mov	d[esp],eax			;;; i887
	mov	d[esp+4],0
	call	%_hexx.d			;;; i574
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0133.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [572] CPrint ("*  received data crc: " +HEXX$(crc32))
	sub	esp,64			;;; i487
	mov	eax,d[ebp-144]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	d[esp+4],0
	call	%_hexx.d			;;; i574
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0134.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [573] close_file(hfile)
	push	[ebp-120]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [574] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [575] END IF
else.0040.p2pfile:
end.if.0040.p2pfile:
;
; [576] END IF
else.003F.p2pfile:
end.if.003F.p2pfile:
;
; [578] fsetpos (hfile,&crc.filepos)
	mov	eax,d[ebp-60]			;;; i665
	push	eax			;;; i667a
	push	[ebp-120]			;;; i674a
	call	_fsetpos			;;; i619
	add	esp,8			;;; i633
;
; [579] write_file (hfile,lpdata,crc.size)
	mov	eax,d[ebp-60]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	push	eax			;;; i667a
	push	[ebp-140]			;;; i674a
	push	[ebp-120]			;;; i674a
	call	funcC.p2pfile			;;; i619
;
; [580] ELSE
	jmp	end.if.0039.p2pfile			;;; i107
else.0039.p2pfile:
;
; [581] CPrint ("* no data to receive on: "+file.desfile)
	mov	eax,d[ebp+12]			;;; i665
	lea	esi,[eax+262]			;;; i308
	mov	edi,255			;;; i310
	call	%_CompositeStringToString			;;; i311
	mov	eax,esi			;;; i312
	mov	ebx,addr @_string.0135.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [582] END IF
end.if.0039.p2pfile:
;
; [583] NEXT pos
do.next.0038.p2pfile:
	mov	eax,d[ebp-124]			;;; i665
	mov	ebx,d[ebp-132]			;;; i665
	add	eax,ebx			;;; i238a
	mov	d[ebp-124],eax			;;; i670
	jmp	for.0038.p2pfile			;;; i238b
end.for.0038.p2pfile:
;
; [584] 'tt = (GetTickCount()-t0) * SINGLE(0.001)
;
; [585] 'PRINT "* transfer rate: ";XLONG (((file.end-file.start)/1024)/SINGLE(tt));"kps"
;
; [586] 'CPrint ("* total bytes received: "+STRING$(GetRecvTotal()/1024)+"kb")
;
; [587] CPrint ("* total bytes received: "+STRING$(GetRecvTotal()))' includes p2p protocol header(s)
	sub	esp,64			;;; i487
	call	func1F.p2pfile			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.0136.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [588] close_file(hfile)
	push	[ebp-120]			;;; i674a
	call	funcD.p2pfile			;;; i619
;
; [589] END IF
end.if.0037.p2pfile:
;
; [591] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func23.p2pfile			;;; i258
;
; [592] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.FileGet.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func23.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func23.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
free.func23.p2pfile:
	mov	esi,[ebp-92]			;;; i665
	call	%____free			;;; i423
	mov	esi,d[ebp-44]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,[ebp-80]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-104]			;;; i665
	call	%____free			;;; i423
	mov	esi,d[ebp-40]			;;; i665
	call	%_FreeArray			;;; i424
	mov	esi,[ebp-52]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-116]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-76]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  FileGet ()  *****
;  *****
;
; [594] FUNCTION FileUpload (auth,addr$,port,filename$,lfile$,start,end,flags)
.code
;
#ifdef FileUpload.auth
#undef FileUpload.auth
#endif
#define FileUpload.auth ebp+8	; exposes function argument 'auth'
;
;
#ifdef FileUpload.addr$
#undef FileUpload.addr$
#endif
#define FileUpload.addr$ ebp+12	; exposes function argument 'addr$'
;
;
#ifdef FileUpload.port
#undef FileUpload.port
#endif
#define FileUpload.port ebp+16	; exposes function argument 'port'
;
;
#ifdef FileUpload.filename$
#undef FileUpload.filename$
#endif
#define FileUpload.filename$ ebp+20	; exposes function argument 'filename$'
;
;
#ifdef FileUpload.lfile$
#undef FileUpload.lfile$
#endif
#define FileUpload.lfile$ ebp+24	; exposes function argument 'lfile$'
;
;
#ifdef FileUpload.start
#undef FileUpload.start
#endif
#define FileUpload.start ebp+28	; exposes function argument 'start'
;
;
#ifdef FileUpload.end
#undef FileUpload.end
#endif
#define FileUpload.end ebp+32	; exposes function argument 'end'
;
;
#ifdef FileUpload.flags
#undef FileUpload.flags
#endif
#define FileUpload.flags ebp+36	; exposes function argument 'flags'
;
align 16
_FileUpload.p2pfile@32:
;  *****
;  *****  FUNCTION  FileUpload ()  *****
;  *****
func2C.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.69:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.69			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,176			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,34				;;; ..
	xor	eax,eax			;;; ...
A.70:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.70			;;; .....
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	lea	ebx,[esp+544]			;;; i125a
	mov	d[ebp-44],eax			;;; i670
	mov	d[ebp-64],ebx			;;; i670
funcBody2C.p2pfile:
;
; [595] SHARED CONNECTED
;
; [596] TFILE file
; .composites = ebp-40	; internal variable
#ifdef FileUpload.file
#undef FileUpload.file
#endif
#define FileUpload.file ebp-44	; exposes local variable 'file'
;
;
; [599] IF (flags & $$FILE_COMPRESS) THEN CPrint ("*** compression enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,4			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0041.p2pfile			;;; i221
	mov	eax,addr @_string.0141.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.0041.p2pfile:
end.if.0041.p2pfile:
;
; [600] IF (flags & $$FILE_ENCRYPT) THEN CPrint ("*** encryption enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,2			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0042.p2pfile			;;; i221
	mov	eax,addr @_string.0142.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.0042.p2pfile:
end.if.0042.p2pfile:
;
; [601] IF (flags & $$FILE_CRC) THEN CPrint ("*** checksum verification enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,1			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0043.p2pfile			;;; i221
	mov	eax,addr @_string.0143.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.0043.p2pfile:
end.if.0043.p2pfile:
;
; [603] CPrint ("\r\n* connecting...")
	mov	eax,addr @_string.0144.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [604] IFT sConnect (addr$,port,@socket) THEN
	mov	eax,d[ebp+12]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk2C.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
#ifdef FileUpload.socket
#undef FileUpload.socket
#endif
#define FileUpload.socket ebp-56	; exposes local variable 'socket'
;
	push	[ebp-56]			;;; i674a
	push	[ebp+16]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	func4.p2pfile			;;; i619
	sub	esp,12			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+8]			;;; i877a
	mov	d[ebp-56],ecx			;;; i670
	add	esp,12			;;; i633
	test	eax,eax			;;; i220
	jz	>> else.0044.p2pfile			;;; i221
;
; [605] CPrint ("* connected to "+addr$+" on port "+STRING$(port)+"\r\n* transfering...")
	mov	eax,addr @_string.0146.p2pfile			;;; i663
	mov	ebx,[ebp+12]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0147.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	[ebp-52],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp+16]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,[ebp-52]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0148.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [606] CONNECTED = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [607] ELSE
	jmp	end.if.0044.p2pfile			;;; i107
else.0044.p2pfile:
;
; [608] CPrint ("* unable to connect")
	mov	eax,addr @_string.0149.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [609] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [610] closesocket (socket)
	push	[ebp-56]			;;; i674a
	call	_closesocket@4			;;; i619
;
; [611] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func2C.p2pfile			;;; i258
;
; [612] END IF
end.if.0044.p2pfile:
;
; [614] file.auth = auth
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+8]			;;; i665
	mov	d[eax+3],ebx			;;; i13b
;
; [615] file.ident = $$FILE_IDENT
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,addr @_string.1132.p2pfile			;;; i663
	mov	edi,eax			;;; i9a
	mov	esi,ebx			;;; i10
	mov	ecx,3			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [616] file.fmode = $$FILE_GET
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,2			;;; i659
	mov	b[eax+541],bl			;;; i13b
;
; [617] file.srcfile = filename$
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,[ebp+20]			;;; i665
	lea	edi,[eax+7]			;;; i9b
	mov	esi,ebx			;;; i10
	mov	ecx,255			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [618] file.desfile = lfile$
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,[ebp+24]			;;; i665
	lea	edi,[eax+262]			;;; i9b
	mov	esi,ebx			;;; i10
	mov	ecx,255			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [619] 'file.fileid = 1
;
; [620] file.start = start
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+28]			;;; i665
	mov	d[eax+521],ebx			;;; i13b
;
; [621] file.end = end
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+32]			;;; i665
	mov	d[eax+525],ebx			;;; i13b
;
; [622] file.error = 0
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,0			;;; i659
	mov	b[eax+543],bl			;;; i13b
;
; [623] file.size = 0
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,0			;;; i659
	mov	d[eax+529],ebx			;;; i13b
;
; [624] file.flags = flags
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+36]			;;; i665
	mov	b[eax+542],bl			;;; i13b
;
; [625] file.blocks = #blocks
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[%#blocks.p2pfile]			;;; i663a
	mov	d[eax+537],ebx			;;; i13b
;
; [627] ret = $$FALSE
#ifdef FileUpload.ret
#undef FileUpload.ret
#endif
#define FileUpload.ret ebp-60	; exposes local variable 'ret'
;
	mov	eax,0			;;; i659
	mov	d[ebp-60],eax			;;; i670
;
; [628] IFT SendBin (socket, &file, SIZE(TFILE)) THEN
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,544			;;; i584
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	func6.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.0045.p2pfile			;;; i221
;
; [629] 'Sleep (1)
;
; [630] IFT FileSend (socket, file) THEN ret = $$TRUE
	mov	eax,d[ebp-44]			;;; i665
; .compositeArg.0 = ebp-64	; internal variable
	mov	edi,d[ebp-64]			;;; i665
	mov	esi,eax			;;; i660
	mov	ecx,544			;;; i606a
	mov	eax,edi			;;; i606b
	call	%_assignComposite			;;; i607
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	func24.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.0046.p2pfile			;;; i221
	mov	eax,-1			;;; i659
	mov	d[ebp-60],eax			;;; i670
else.0046.p2pfile:
end.if.0046.p2pfile:
;
; [631] END IF
else.0045.p2pfile:
end.if.0045.p2pfile:
;
; [633] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [634] IF socket THEN closesocket (socket)
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0047.p2pfile			;;; i221
	push	[ebp-56]			;;; i674a
	call	_closesocket@4			;;; i619
else.0047.p2pfile:
end.if.0047.p2pfile:
;
; [635] IFT ret THEN
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0048.p2pfile			;;; i221
;
; [636] CPrint ("* transfer completed: "+filename$)
	mov	eax,addr @_string.00EA.p2pfile			;;; i663
	mov	ebx,[ebp+20]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [637] ELSE
	jmp	end.if.0048.p2pfile			;;; i107
else.0048.p2pfile:
;
; [638] CPrint ("* connection to host lost")
	mov	eax,addr @_string.014C.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [639] CPrint ("* transfer failed: "+filename$)
	mov	eax,addr @_string.00EB.p2pfile			;;; i663
	mov	ebx,[ebp+20]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [640] END IF
end.if.0048.p2pfile:
;
; [642] RETURN ret
	mov	eax,d[ebp-60]			;;; i665
	jmp	end.func2C.p2pfile			;;; i258
;
; [644] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.FileUpload.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func2C.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	32			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  FileUpload ()  *****
;  *****
;
; [646] FUNCTION FileDownload (auth,addr$,port,filename$,lfile$,start,end,flags)
.code
;
#ifdef FileDownload.auth
#undef FileDownload.auth
#endif
#define FileDownload.auth ebp+8	; exposes function argument 'auth'
;
;
#ifdef FileDownload.addr$
#undef FileDownload.addr$
#endif
#define FileDownload.addr$ ebp+12	; exposes function argument 'addr$'
;
;
#ifdef FileDownload.port
#undef FileDownload.port
#endif
#define FileDownload.port ebp+16	; exposes function argument 'port'
;
;
#ifdef FileDownload.filename$
#undef FileDownload.filename$
#endif
#define FileDownload.filename$ ebp+20	; exposes function argument 'filename$'
;
;
#ifdef FileDownload.lfile$
#undef FileDownload.lfile$
#endif
#define FileDownload.lfile$ ebp+24	; exposes function argument 'lfile$'
;
;
#ifdef FileDownload.start
#undef FileDownload.start
#endif
#define FileDownload.start ebp+28	; exposes function argument 'start'
;
;
#ifdef FileDownload.end
#undef FileDownload.end
#endif
#define FileDownload.end ebp+32	; exposes function argument 'end'
;
;
#ifdef FileDownload.flags
#undef FileDownload.flags
#endif
#define FileDownload.flags ebp+36	; exposes function argument 'flags'
;
align 16
_FileDownload.p2pfile@32:
;  *****
;  *****  FUNCTION  FileDownload ()  *****
;  *****
func2B.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.73:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.73			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,176			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,34				;;; ..
	xor	eax,eax			;;; ...
A.74:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.74			;;; .....
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	lea	ebx,[esp+544]			;;; i125a
	mov	d[ebp-44],eax			;;; i670
	mov	d[ebp-64],ebx			;;; i670
funcBody2B.p2pfile:
;
; [647] SHARED CONNECTED
;
; [648] TFILE file
; .composites = ebp-40	; internal variable
#ifdef FileDownload.file
#undef FileDownload.file
#endif
#define FileDownload.file ebp-44	; exposes local variable 'file'
;
;
; [651] IF (flags & $$FILE_COMPRESS) THEN CPrint ("*** compression enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,4			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0049.p2pfile			;;; i221
	mov	eax,addr @_string.0141.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.0049.p2pfile:
end.if.0049.p2pfile:
;
; [652] IF (flags & $$FILE_ENCRYPT) THEN CPrint ("*** encryption enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,2			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.004A.p2pfile			;;; i221
	mov	eax,addr @_string.0142.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.004A.p2pfile:
end.if.004A.p2pfile:
;
; [653] IF (flags & $$FILE_CRC) THEN CPrint ("*** checksum verification enabled")
	mov	eax,d[ebp+36]			;;; i665
	and	eax,1			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.004B.p2pfile			;;; i221
	mov	eax,addr @_string.0143.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
else.004B.p2pfile:
end.if.004B.p2pfile:
;
; [655] CPrint ("\r\n* connecting...")
	mov	eax,addr @_string.0144.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [656] IFT sConnect (addr$,port,@socket) THEN
	mov	eax,d[ebp+12]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk2B.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
#ifdef FileDownload.socket
#undef FileDownload.socket
#endif
#define FileDownload.socket ebp-56	; exposes local variable 'socket'
;
	push	[ebp-56]			;;; i674a
	push	[ebp+16]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	func4.p2pfile			;;; i619
	sub	esp,12			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+8]			;;; i877a
	mov	d[ebp-56],ecx			;;; i670
	add	esp,12			;;; i633
	test	eax,eax			;;; i220
	jz	>> else.004C.p2pfile			;;; i221
;
; [657] CPrint ("* connected to "+addr$+" on port "+STRING$(port)+"\r\n* transfering...")
	mov	eax,addr @_string.0146.p2pfile			;;; i663
	mov	ebx,[ebp+12]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0147.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	[ebp-52],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp+16]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,[ebp-52]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.0148.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [658] CPrint ("* file: "+filename$)
	mov	eax,addr @_string.0158.p2pfile			;;; i663
	mov	ebx,[ebp+20]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [659] CONNECTED = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [660] ELSE
	jmp	end.if.004C.p2pfile			;;; i107
else.004C.p2pfile:
;
; [661] CPrint ("* unable to connect")
	mov	eax,addr @_string.0149.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [662] IF socket THEN closesocket (socket)
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.004D.p2pfile			;;; i221
	push	[ebp-56]			;;; i674a
	call	_closesocket@4			;;; i619
else.004D.p2pfile:
end.if.004D.p2pfile:
;
; [663] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [664] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func2B.p2pfile			;;; i258
;
; [665] END IF
end.if.004C.p2pfile:
;
; [667] file.auth = auth
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+8]			;;; i665
	mov	d[eax+3],ebx			;;; i13b
;
; [668] file.ident = $$FILE_IDENT
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,addr @_string.1132.p2pfile			;;; i663
	mov	edi,eax			;;; i9a
	mov	esi,ebx			;;; i10
	mov	ecx,3			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [669] file.fmode = $$FILE_SEND
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,1			;;; i659
	mov	b[eax+541],bl			;;; i13b
;
; [670] file.srcfile = filename$
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,[ebp+20]			;;; i665
	lea	edi,[eax+7]			;;; i9b
	mov	esi,ebx			;;; i10
	mov	ecx,255			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [671] file.desfile = lfile$
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,[ebp+24]			;;; i665
	lea	edi,[eax+262]			;;; i9b
	mov	esi,ebx			;;; i10
	mov	ecx,255			;;; i11
	call	%_assignCompositeStringlet.v			;;; i12
;
; [672] 'file.fileid = 1
;
; [673] file.start = start
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+28]			;;; i665
	mov	d[eax+521],ebx			;;; i13b
;
; [674] file.end = end
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+32]			;;; i665
	mov	d[eax+525],ebx			;;; i13b
;
; [675] file.error = 0
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,0			;;; i659
	mov	b[eax+543],bl			;;; i13b
;
; [676] file.size = 0
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,0			;;; i659
	mov	d[eax+529],ebx			;;; i13b
;
; [677] file.flags = flags
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+36]			;;; i665
	mov	b[eax+542],bl			;;; i13b
;
; [678] file.blocks = #blocks
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[%#blocks.p2pfile]			;;; i663a
	mov	d[eax+537],ebx			;;; i13b
;
; [680] ret = $$FALSE
#ifdef FileDownload.ret
#undef FileDownload.ret
#endif
#define FileDownload.ret ebp-60	; exposes local variable 'ret'
;
	mov	eax,0			;;; i659
	mov	d[ebp-60],eax			;;; i670
;
; [681] IFT SendBin(socket, &file, SIZE(TFILE)) THEN
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,544			;;; i584
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	func6.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.004E.p2pfile			;;; i221
;
; [682] '		Sleep (1)
;
; [683] IFT FileGet(socket,file) THEN ret = $$TRUE
	mov	eax,d[ebp-44]			;;; i665
; .compositeArg.0 = ebp-64	; internal variable
	mov	edi,d[ebp-64]			;;; i665
	mov	esi,eax			;;; i660
	mov	ecx,544			;;; i606a
	mov	eax,edi			;;; i606b
	call	%_assignComposite			;;; i607
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	func23.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.004F.p2pfile			;;; i221
	mov	eax,-1			;;; i659
	mov	d[ebp-60],eax			;;; i670
else.004F.p2pfile:
end.if.004F.p2pfile:
;
; [684] END IF
else.004E.p2pfile:
end.if.004E.p2pfile:
;
; [686] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [687] IF socket THEN closesocket (socket)
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0050.p2pfile			;;; i221
	push	[ebp-56]			;;; i674a
	call	_closesocket@4			;;; i619
else.0050.p2pfile:
end.if.0050.p2pfile:
;
; [688] IFT ret THEN
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0051.p2pfile			;;; i221
;
; [689] CPrint ("* transfer completed: "+lfile$)
	mov	eax,addr @_string.00EA.p2pfile			;;; i663
	mov	ebx,[ebp+24]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [690] ELSE
	jmp	end.if.0051.p2pfile			;;; i107
else.0051.p2pfile:
;
; [691] CPrint ("* connection to host lost")
	mov	eax,addr @_string.014C.p2pfile			;;; i663
	call	%_clone.a0			;;; i634
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [692] CPrint ("* transfer failed: "+filename$)
	mov	eax,addr @_string.00EB.p2pfile			;;; i663
	mov	ebx,[ebp+20]			;;; i665
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	0			;;; i781d
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [693] END IF
end.if.0051.p2pfile:
;
; [695] RETURN ret
	mov	eax,d[ebp-60]			;;; i665
	jmp	end.func2B.p2pfile			;;; i258
;
; [696] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.FileDownload.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func2B.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	32			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  FileDownload ()  *****
;  *****
;
; [698] FUNCTION STRING GetLocalIpA ()
.code
align 16
_GetLocalIpA.p2pfile@0:
;  *****
;  *****  FUNCTION  GetLocalIpA ()  *****
;  *****
func13.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func13.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,188			;;; i114a
;
funcBody13.p2pfile:
;
; [701] name$ = NULL$(256)
#ifdef GetLocalIpA.name$
#undef GetLocalIpA.name$
#endif
#define GetLocalIpA.name$ ebp-40	; exposes local variable 'name$'
;
	sub	esp,64			;;; i487
	mov	d[esp],256
	call	%_null.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp-40]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [702] gethostname (&name$,255)
;
; [0] EXTERNAL SFUNCTION  					gethostname      (addrSTRING, length)
	mov	eax,d[ebp-40]			;;; i642
; .xstk13.0000 = ebp-48	; internal variable
	mov	d[ebp-48],eax			;;; i670
	push	255			;;; i656a
	push	[ebp-48]			;;; i674a
	call	_gethostname@8			;;; i619
;
; [703] GetIPAddr (@name$, @ip$)
#ifdef GetLocalIpA.ip$
#undef GetLocalIpA.ip$
#endif
#define GetLocalIpA.ip$ ebp-52	; exposes local variable 'ip$'
;
	push	[ebp-52]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	funcA.p2pfile			;;; i619
	mov	ecx,d[esp-8]			;;; i877a
	mov	ebx,d[esp-4]			;;; i877b
	mov	[ebp-40],ecx			;;; i670
	mov	[ebp-52],ebx			;;; i670
;
; [704] RETURN ip$
	mov	eax,[ebp-52]			;;; i665
	call	%_clone.a0			;;; i870
	jmp	end.func13.p2pfile			;;; i258
;
; [706] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetLocalIpA.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func13.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func13.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
free.func13.p2pfile:
	mov	esi,[ebp-40]			;;; i665
	call	%____free			;;; i423
	mov	esi,[ebp-52]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  GetLocalIpA ()  *****
;  *****
;
; [708] FUNCTION CreateCRC32Table ()
.code
align 16
_CreateCRC32Table.p2pfile@0:
;  *****
;  *****  FUNCTION  CreateCRC32Table ()  *****
;  *****
funcE.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,4				;;; ..
	xor	eax,eax			;;; ...
A.83:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.83			;;; .....
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,156			;;; i114a
;
funcBodyE.p2pfile:
;
; [709] SHARED ULONG table[]
data section 'globals$shared'
align	4
%%%table.p2pfile:	db 4 dup ?
.code
;
; [710] ULONG sum, n, a, b, magic
#ifdef CreateCRC32Table.sum
#undef CreateCRC32Table.sum
#endif
#define CreateCRC32Table.sum ebp-40	; exposes local variable 'sum'
;
#ifdef CreateCRC32Table.n
#undef CreateCRC32Table.n
#endif
#define CreateCRC32Table.n ebp-44	; exposes local variable 'n'
;
#ifdef CreateCRC32Table.a
#undef CreateCRC32Table.a
#endif
#define CreateCRC32Table.a ebp-48	; exposes local variable 'a'
;
#ifdef CreateCRC32Table.b
#undef CreateCRC32Table.b
#endif
#define CreateCRC32Table.b ebp-52	; exposes local variable 'b'
;
#ifdef CreateCRC32Table.magic
#undef CreateCRC32Table.magic
#endif
#define CreateCRC32Table.magic ebp-56	; exposes local variable 'magic'
;
;
; [711] UBYTE i, j, c
#ifdef CreateCRC32Table.i
#undef CreateCRC32Table.i
#endif
#define CreateCRC32Table.i ebp-60	; exposes local variable 'i'
;
#ifdef CreateCRC32Table.j
#undef CreateCRC32Table.j
#endif
#define CreateCRC32Table.j ebp-64	; exposes local variable 'j'
;
#ifdef CreateCRC32Table.c
#undef CreateCRC32Table.c
#endif
#define CreateCRC32Table.c ebp-68	; exposes local variable 'c'
;
;
; [714] DIM table[255]
	sub	esp,64			;;; i430
	mov	eax,255			;;; i659
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[%%%table.p2pfile]			;;; i663a
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073283068			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[%%%table.p2pfile],eax			;;; i668
;
; [715] magic = 0xEDB88320
	mov	eax,-306674912			;;; i657
	mov	d[ebp-56],eax			;;; i670
;
; [717] FOR j = 0 TO 255
	mov	eax,0			;;; i659
	mov	d[ebp-64],eax			;;; i670
	mov	eax,255			;;; i659
; .forlimitE.0052 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
align 8
for.0052.p2pfile:
	mov	eax,d[ebp-64]			;;; i665
	mov	ebx,d[ebp-72]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0052.p2pfile			;;; i154
;
; [718] sum = j
	mov	eax,d[ebp-64]			;;; i665
	or	eax,eax			;;; i366
	jns	> A.78			;;; i367
	call	%_eeeOverflow			;;; i368
A.78:
	mov	d[ebp-40],eax			;;; i670
;
; [719] FOR i = 0 TO 7
	mov	eax,0			;;; i659
	mov	d[ebp-60],eax			;;; i670
	mov	eax,7			;;; i659
; .forlimitE.0053 = ebp-76	; internal variable
	mov	d[ebp-76],eax			;;; i670
align 8
for.0053.p2pfile:
	mov	eax,d[ebp-60]			;;; i665
	mov	ebx,d[ebp-76]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0053.p2pfile			;;; i154
;
; [720] IF (sum AND 1) THEN
	mov	eax,d[ebp-40]			;;; i665
	and	eax,1			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0054.p2pfile			;;; i221
;
; [721] rum = sum
#ifdef CreateCRC32Table.rum
#undef CreateCRC32Table.rum
#endif
#define CreateCRC32Table.rum ebp-80	; exposes local variable 'rum'
;
	mov	eax,d[ebp-40]			;;; i665
	mov	d[ebp-80],eax			;;; i670
;
; [722] sum = (sum >> 1) XOR magic
	mov	eax,d[ebp-40]			;;; i665
	shr	eax,1			;;; i835
	mov	ebx,d[ebp-56]			;;; i665
	xor	eax,ebx			;;; i766
	mov	d[ebp-40],eax			;;; i670
;
; [723] bum = (rum >> 1) XOR 0xEDB88320
#ifdef CreateCRC32Table.bum
#undef CreateCRC32Table.bum
#endif
#define CreateCRC32Table.bum ebp-84	; exposes local variable 'bum'
;
	mov	eax,d[ebp-80]			;;; i665
	shr	eax,1			;;; i835
	xor	eax,-306674912			;;; i766
	mov	d[ebp-84],eax			;;; i670
;
; [724] 'IF (sum != bum) THEN PRINT "sum : bum = "; HEX$(sum,8); " : "; HEX$(bum,8)
;
; [725] ELSE
	jmp	end.if.0054.p2pfile			;;; i107
else.0054.p2pfile:
;
; [726] sum = (sum >> 1)
	mov	eax,d[ebp-40]			;;; i665
	shr	eax,1			;;; i835
	mov	d[ebp-40],eax			;;; i670
;
; [727] END IF
end.if.0054.p2pfile:
;
; [728] NEXT i
do.next.0053.p2pfile:
	inc	d[ebp-60]			;;; i229
	jmp	for.0053.p2pfile			;;; i231
end.for.0053.p2pfile:
;
; [729] table[j] = sum
	mov	eax,d[ebp-40]			;;; i665
	mov	ebx,d[ebp-64]			;;; i665
	mov	ecx,d[%%%table.p2pfile]			;;; i663a
	lea	ebx,[ecx+ebx*4]			;;; i464
	mov	d[ebx],eax			;;; i30
;
; [730] 'PRINT "table[" j "]=" HEXX$(sum)
;
; [731] NEXT j
do.next.0052.p2pfile:
	inc	d[ebp-64]			;;; i229
	jmp	for.0052.p2pfile			;;; i231
end.for.0052.p2pfile:
;
; [733] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.funcE.p2pfile			;;; i258
;
; [734] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.CreateCRC32Table.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcE.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  CreateCRC32Table ()  *****
;  *****
;
; [736] FUNCTION GetAdler32 (pbuffer,tbytes)
.code
;
#ifdef GetAdler32.pbuffer
#undef GetAdler32.pbuffer
#endif
#define GetAdler32.pbuffer ebp+8	; exposes function argument 'pbuffer'
;
;
#ifdef GetAdler32.tbytes
#undef GetAdler32.tbytes
#endif
#define GetAdler32.tbytes ebp+12	; exposes function argument 'tbytes'
;
align 16
_GetAdler32.p2pfile@8:
;  *****
;  *****  FUNCTION  GetAdler32 ()  *****
;  *****
funcF.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,200			;;; i114a
;
funcBodyF.p2pfile:
;
; [738] adler = adler32(0, $$Z_NULL, 0)
#ifdef GetAdler32.adler
#undef GetAdler32.adler
#endif
#define GetAdler32.adler ebp-40	; exposes local variable 'adler'
;
;
; [0] EXTERNAL CFUNCTION adler32 (adler, lpbuffer, length)
	push	0			;;; i656a
	push	0			;;; i656a
	push	0			;;; i656a
	call	_adler32			;;; i619
	add	esp,12			;;; i633
	mov	d[ebp-40],eax			;;; i670
;
; [739] RETURN adler32(adler,pbuffer,tbytes)
	push	[ebp+12]			;;; i674a
	push	[ebp+8]			;;; i674a
	push	[ebp-40]			;;; i674a
	call	_adler32			;;; i619
	add	esp,12			;;; i633
	jmp	end.funcF.p2pfile			;;; i258
;
; [740] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetAdler32.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcF.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  GetAdler32 ()  *****
;  *****
;
; [742] FUNCTION GetCRC32 (pbuffer,size)
.code
;
#ifdef GetCRC32.pbuffer
#undef GetCRC32.pbuffer
#endif
#define GetCRC32.pbuffer ebp+8	; exposes function argument 'pbuffer'
;
;
#ifdef GetCRC32.size
#undef GetCRC32.size
#endif
#define GetCRC32.size ebp+12	; exposes function argument 'size'
;
align 16
_GetCRC32.p2pfile@8:
;  *****
;  *****  FUNCTION  GetCRC32 ()  *****
;  *****
func10.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,192			;;; i114a
;
funcBody10.p2pfile:
;
; [743] SHARED ULONG table[]
;
; [746] DEC size
	dec	d[ebp+12]			;;; i84
;
; [747] IFZ size THEN RETURN 0
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0055.p2pfile			;;; i195
	mov	eax,0			;;; i659
	jmp	end.func10.p2pfile			;;; i258
else.0055.p2pfile:
end.if.0055.p2pfile:
;
; [749] crc32 = 0xFFFFFFFF
#ifdef GetCRC32.crc32
#undef GetCRC32.crc32
#endif
#define GetCRC32.crc32 ebp-40	; exposes local variable 'crc32'
;
	mov	eax,-1			;;; i659
	mov	d[ebp-40],eax			;;; i670
;
; [750] FOR n = pbuffer TO (pbuffer + size)
#ifdef GetCRC32.n
#undef GetCRC32.n
#endif
#define GetCRC32.n ebp-44	; exposes local variable 'n'
;
	mov	eax,d[ebp+8]			;;; i665
	mov	d[ebp-44],eax			;;; i670
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
; .forlimit10.0056 = ebp-48	; internal variable
	mov	d[ebp-48],eax			;;; i670
align 8
for.0056.p2pfile:
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0056.p2pfile			;;; i154
;
; [751] crc32 = table[(crc32 XOR UBYTEAT (n)) AND 0xFF] XOR (crc32 >> 8)
	mov	esi,d[ebp-44]			;;; i665
	movzx	eax,b[esi]			;;; i491
	mov	ebx,d[ebp-40]			;;; i665
	xor	eax,ebx			;;; i766
	and	eax,255			;;; i769
	mov	edx,d[%%%table.p2pfile]			;;; i663a
	mov	eax,d[edx+eax*4]			;;; i464
	mov	ebx,d[ebp-40]			;;; i665
	shr	ebx,8			;;; i835
	xor	eax,ebx			;;; i766
	mov	d[ebp-40],eax			;;; i670
;
; [752] NEXT n
do.next.0056.p2pfile:
	inc	d[ebp-44]			;;; i229
	jmp	for.0056.p2pfile			;;; i231
end.for.0056.p2pfile:
;
; [754] RETURN (crc32 XOR 0xFFFFFFFF)
	mov	eax,d[ebp-40]			;;; i665
	xor	eax,-1			;;; i766
	jmp	end.func10.p2pfile			;;; i258
;
; [755] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetCRC32.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func10.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  GetCRC32 ()  *****
;  *****
;
; [757] FUNCTION write_file (hfile,ULONG buffer,nbytes)
.code
;
#ifdef write_file.hfile
#undef write_file.hfile
#endif
#define write_file.hfile ebp+8	; exposes function argument 'hfile'
;
;
#ifdef write_file.buffer
#undef write_file.buffer
#endif
#define write_file.buffer ebp+12	; exposes function argument 'buffer'
;
;
#ifdef write_file.nbytes
#undef write_file.nbytes
#endif
#define write_file.nbytes ebp+16	; exposes function argument 'nbytes'
;
align 16
_write_file.p2pfile@12:
;  *****
;  *****  FUNCTION  write_file ()  *****
;  *****
funcC.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,188			;;; i114a
;
funcBodyC.p2pfile:
;
; [759] '_write (hfile, buffer, nbytes)
;
; [760] foffset = 0
#ifdef write_file.foffset
#undef write_file.foffset
#endif
#define write_file.foffset ebp-40	; exposes local variable 'foffset'
;
	mov	eax,0			;;; i659
	mov	d[ebp-40],eax			;;; i670
;
; [761] fgetpos (hfile,&foffset)
;
; [0] EXTERNAL CFUNCTION  fgetpos (fpAddr, posAddr)					' stores the current position of the file fp in the object pointed to by pos
	lea	eax,[ebp-40]			;;; i642
	push	eax			;;; i667a
	push	[ebp+8]			;;; i674a
	call	_fgetpos			;;; i619
	add	esp,8			;;; i633
;
; [763] IF (fwrite (buffer, 1, nbytes, hfile) < nbytes) THEN
;
; [0] EXTERNAL CFUNCTION  fwrite (bufAddr, elsize, nelem, fpAddr)	' writes nelem elements of elsize bytes each to the file specified by fp
	push	[ebp+8]			;;; i674a
	push	[ebp+16]			;;; i674a
	push	1			;;; i656a
	push	[ebp+12]			;;; i674a
	call	_fwrite			;;; i619
	add	esp,16			;;; i633
	mov	ebx,d[ebp+16]			;;; i665
	cmp	eax,ebx			;;; i684a
	jge	>> else.0057.p2pfile			;;; i219
;
; [764] printf(&"error writing buffer to file\n",NULL)
;
; [0] EXTERNAL CFUNCTION  printf (formatAddr, ...)				' places formatted output to stdout
	mov	eax,addr @_string.017C.p2pfile			;;; i642
; .xstkC.0000 = ebp-48	; internal variable
	mov	d[ebp-48],eax			;;; i670
#ifdef write_file.NULL
#undef write_file.NULL
#endif
#define write_file.NULL ebp-52	; exposes local variable 'NULL'
;
	push	[ebp-52]			;;; i674a
	push	[ebp-48]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [765] RETURN -1
	mov	eax,1			;;; i659
	neg	eax			;;; i916
	jmp	end.funcC.p2pfile			;;; i258
;
; [766] ELSE
	jmp	end.if.0057.p2pfile			;;; i107
else.0057.p2pfile:
;
; [767] RETURN foffset
	mov	eax,d[ebp-40]			;;; i665
	jmp	end.funcC.p2pfile			;;; i258
;
; [768] END IF
end.if.0057.p2pfile:
;
; [769] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.write_file.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcC.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  write_file ()  *****
;  *****
;
; [771] FUNCTION open_file (lpfilename, flags)
.code
;
#ifdef open_file.lpfilename
#undef open_file.lpfilename
#endif
#define open_file.lpfilename ebp+8	; exposes function argument 'lpfilename'
;
;
#ifdef open_file.flags
#undef open_file.flags
#endif
#define open_file.flags ebp+12	; exposes function argument 'flags'
;
align 16
_open_file.p2pfile@8:
;  *****
;  *****  FUNCTION  open_file ()  *****
;  *****
funcB.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,188			;;; i114a
;
funcBodyB.p2pfile:
;
; [774] IFZ lpfilename THEN RETURN $$FALSE
	mov	eax,d[ebp+8]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0058.p2pfile			;;; i195
	mov	eax,0			;;; i659
	jmp	end.funcB.p2pfile			;;; i258
else.0058.p2pfile:
end.if.0058.p2pfile:
;
; [775] IFZ flags THEN
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0059.p2pfile			;;; i195
;
; [776] type = &"rb"
#ifdef open_file.type
#undef open_file.type
#endif
#define open_file.type ebp-40	; exposes local variable 'type'
;
	mov	eax,addr @_string.0181.p2pfile			;;; i642
	mov	d[ebp-40],eax			;;; i670
;
; [777] ELSE
	jmp	end.if.0059.p2pfile			;;; i107
else.0059.p2pfile:
;
; [778] type = flags
	mov	eax,d[ebp+12]			;;; i665
	mov	d[ebp-40],eax			;;; i670
;
; [779] END IF
end.if.0059.p2pfile:
;
; [781] hfile = fopen (lpfilename, type)
#ifdef open_file.hfile
#undef open_file.hfile
#endif
#define open_file.hfile ebp-44	; exposes local variable 'hfile'
;
;
; [0] EXTERNAL CFUNCTION  fopen (filenameAddr, modeAddr)		' open a file whose name is the string pointed to by filename.
	push	[ebp-40]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	_fopen			;;; i619
	add	esp,8			;;; i633
	mov	d[ebp-44],eax			;;; i670
;
; [782] IFZ hfile THEN
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.005A.p2pfile			;;; i195
;
; [783] printf(&"unable to open file '%s'\n",lpfilename)
	mov	eax,addr @_string.0183.p2pfile			;;; i642
; .xstkB.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
	push	[ebp+8]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [784] RETURN 0
	mov	eax,0			;;; i659
	jmp	end.funcB.p2pfile			;;; i258
;
; [785] ELSE
	jmp	end.if.005A.p2pfile			;;; i107
else.005A.p2pfile:
;
; [786] RETURN hfile
	mov	eax,d[ebp-44]			;;; i665
	jmp	end.funcB.p2pfile			;;; i258
;
; [787] END IF
end.if.005A.p2pfile:
;
; [789] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.open_file.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcB.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  open_file ()  *****
;  *****
;
; [791] FUNCTION close_file (file)
.code
;
#ifdef close_file.file
#undef close_file.file
#endif
#define close_file.file ebp+8	; exposes function argument 'file'
;
align 16
_close_file.p2pfile@4:
;  *****
;  *****  FUNCTION  close_file ()  *****
;  *****
funcD.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,192			;;; i114a
;
funcBodyD.p2pfile:
;
; [793] IF file THEN
	mov	eax,d[ebp+8]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.005B.p2pfile			;;; i221
;
; [794] fclose (file)
;
; [0] EXTERNAL CFUNCTION  fclose (fpAddr)										' close the file fp
	push	[ebp+8]			;;; i674a
	call	_fclose			;;; i619
	add	esp,4			;;; i633
;
; [795] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.funcD.p2pfile			;;; i258
;
; [796] ELSE
	jmp	end.if.005B.p2pfile			;;; i107
else.005B.p2pfile:
;
; [797] printf(&"\nunable to close file",NULL)
	mov	eax,addr @_string.0185.p2pfile			;;; i642
; .xstkD.0000 = ebp-44	; internal variable
	mov	d[ebp-44],eax			;;; i670
#ifdef close_file.NULL
#undef close_file.NULL
#endif
#define close_file.NULL ebp-48	; exposes local variable 'NULL'
;
	push	[ebp-48]			;;; i674a
	push	[ebp-44]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [798] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.funcD.p2pfile			;;; i258
;
; [799] END IF
end.if.005B.p2pfile:
;
; [801] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.close_file.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcD.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	4			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  close_file ()  *****
;  *****
;
; [803] FUNCTION GetIPAddr (IPName$, @numIPAddr$)
.code
;
#ifdef GetIPAddr.IPName$
#undef GetIPAddr.IPName$
#endif
#define GetIPAddr.IPName$ ebp+8	; exposes function argument 'IPName$'
;
;
#ifdef GetIPAddr.numIPAddr$
#undef GetIPAddr.numIPAddr$
#endif
#define GetIPAddr.numIPAddr$ ebp+12	; exposes function argument 'numIPAddr$'
;
align 16
_GetIPAddr.p2pfile@8:
;  *****
;  *****  FUNCTION  GetIPAddr ()  *****
;  *****
funcA.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,3				;;; ..
	xor	eax,eax			;;; ...
A.103:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.103			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,164			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,13				;;; ..
	xor	eax,eax			;;; ...
A.104:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.104			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	lea	ebx,[esp+400]			;;; i125a
	lea	ecx,[esp+416]			;;; i125b
	mov	d[ebp-44],eax			;;; i670
	mov	d[ebp-48],ebx			;;; i670
	mov	d[ebp-52],ecx			;;; i670
funcBodyA.p2pfile:
;
; [804] WSADATA wsadata
; .composites = ebp-40	; internal variable
#ifdef GetIPAddr.wsadata
#undef GetIPAddr.wsadata
#endif
#define GetIPAddr.wsadata ebp-44	; exposes local variable 'wsadata'
;
;
; [805] HOSTENT	host
#ifdef GetIPAddr.host
#undef GetIPAddr.host
#endif
#define GetIPAddr.host ebp-48	; exposes local variable 'host'
;
;
; [808] host = gethostbyname (&IPName$)
;
; [0] EXTERNAL SFUNCTION  HOSTENT   gethostbyname    (addrSTRING)
; .compositeReturnAddr.0 = ebp-52	; internal variable
	mov	eax,d[ebp+8]			;;; i642
	push	eax			;;; i667a
	mov	ebx,d[ebp-52]			;;; i665
	call	_gethostbyname@4			;;; i619
	mov	ebx,d[ebp-48]			;;; i665
	mov	edi,ebx			;;; i14a
	mov	esi,eax			;;; i7
	mov	ecx,16			;;; i1
	call	%_AssignComposite			;;; i2
;
; [809] IF (host.h_addr_list != 0) THEN
	mov	eax,d[ebp-48]			;;; i665
	mov	eax,d[eax+12]			;;; i313b
	cmp	eax,0			;;; i684a
	je	>> else.005C.p2pfile			;;; i219
;
; [810] addr = 0
#ifdef GetIPAddr.addr
#undef GetIPAddr.addr
#endif
#define GetIPAddr.addr ebp-56	; exposes local variable 'addr'
;
	mov	eax,0			;;; i659
	mov	d[ebp-56],eax			;;; i670
;
; [811] RtlMoveMemory (&addr, host.h_addr_list, 4)
;
; [0] EXTERNAL FUNCTION RtlMoveMemory (pDestination, pSource, cbLength)
	lea	eax,[ebp-56]			;;; i642
; .xstkA.0000 = ebp-64	; internal variable
	mov	d[ebp-64],eax			;;; i670
	mov	eax,d[ebp-48]			;;; i665
	mov	eax,d[eax+12]			;;; i313b
; .xstkA.0001 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
	push	4			;;; i656a
	push	[ebp-72]			;;; i674a
	push	[ebp-64]			;;; i674a
	call	_RtlMoveMemory@12			;;; i619
;
; [812] RtlMoveMemory (&addr, addr, 4)
	lea	eax,[ebp-56]			;;; i642
	mov	d[ebp-64],eax			;;; i670
	push	4			;;; i656a
	push	[ebp-56]			;;; i674a
	push	[ebp-64]			;;; i674a
	call	_RtlMoveMemory@12			;;; i619
;
; [813] addr2 = inet_ntoa (addr)
#ifdef GetIPAddr.addr2
#undef GetIPAddr.addr2
#endif
#define GetIPAddr.addr2 ebp-76	; exposes local variable 'addr2'
;
	push	[ebp-56]			;;; i674a
	call	_inet_ntoa@4			;;; i619
	mov	d[ebp-76],eax			;;; i670
;
; [814] '		length = strlen (addr2)
;
; [815] numIPAddr$ = NULL$ (512)
	sub	esp,64			;;; i487
	mov	d[esp],512
	call	%_null.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [816] RtlMoveMemory (&numIPAddr$, addr2, LEN(numIPAddr$))
	mov	eax,d[ebp+12]			;;; i642
	mov	d[ebp-64],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.100			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.100:
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	[ebp-64]			;;; i674a
	call	_RtlMoveMemory@12			;;; i619
;
; [817] numIPAddr$ = CSIZE$ (numIPAddr$)
	sub	esp,64			;;; i487
	mov	eax,[ebp+12]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_csize.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [818] END IF
else.005C.p2pfile:
end.if.005C.p2pfile:
;
; [820] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.funcA.p2pfile			;;; i258
;
; [821] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetIPAddr.p2pfile:  ;;; Function end label for Assembly Programmers.
end.funcA.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  GetIPAddr ()  *****
;  *****
;
; [823] FUNCTION GetIPName (numIPAddr$, @IPName$)
.code
;
#ifdef GetIPName.numIPAddr$
#undef GetIPName.numIPAddr$
#endif
#define GetIPName.numIPAddr$ ebp+8	; exposes function argument 'numIPAddr$'
;
;
#ifdef GetIPName.IPName$
#undef GetIPName.IPName$
#endif
#define GetIPName.IPName$ ebp+12	; exposes function argument 'IPName$'
;
align 16
_GetIPName.p2pfile@8:
;  *****
;  *****  FUNCTION  GetIPName ()  *****
;  *****
func9.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,3				;;; ..
	xor	eax,eax			;;; ...
A.108:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.108			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,168			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,13				;;; ..
	xor	eax,eax			;;; ...
A.109:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.109			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	lea	ebx,[esp+400]			;;; i125a
	lea	ecx,[esp+416]			;;; i125b
	mov	d[ebp-44],eax			;;; i670
	mov	d[ebp-48],ebx			;;; i670
	mov	d[ebp-56],ecx			;;; i670
funcBody9.p2pfile:
;
; [824] WSADATA wsadata
; .composites = ebp-40	; internal variable
#ifdef GetIPName.wsadata
#undef GetIPName.wsadata
#endif
#define GetIPName.wsadata ebp-44	; exposes local variable 'wsadata'
;
;
; [825] HOSTENT	host
#ifdef GetIPName.host
#undef GetIPName.host
#endif
#define GetIPName.host ebp-48	; exposes local variable 'host'
;
;
; [828] addr = inet_addr (&numIPAddr$)
#ifdef GetIPName.addr
#undef GetIPName.addr
#endif
#define GetIPName.addr ebp-52	; exposes local variable 'addr'
;
;
; [0] EXTERNAL SFUNCTION  inet_addr        (addrSTRING)
	mov	eax,d[ebp+8]			;;; i642
	push	eax			;;; i667a
	call	_inet_addr@4			;;; i619
	mov	d[ebp-52],eax			;;; i670
;
; [829] host = gethostbyaddr (&addr, 4, $$AF_INET)
;
; [0] EXTERNAL SFUNCTION  HOSTENT   gethostbyaddr    (addrSTRING, length, type)
; .compositeReturnAddr.0 = ebp-56	; internal variable
	lea	eax,[ebp-52]			;;; i642
; .xstk9.0000 = ebp-64	; internal variable
	mov	d[ebp-64],eax			;;; i670
	push	2			;;; i656a
	push	4			;;; i656a
	push	[ebp-64]			;;; i674a
	mov	ebx,d[ebp-56]			;;; i665
	call	_gethostbyaddr@12			;;; i619
	mov	ebx,d[ebp-48]			;;; i665
	mov	edi,ebx			;;; i14a
	mov	esi,eax			;;; i7
	mov	ecx,16			;;; i1
	call	%_AssignComposite			;;; i2
;
; [831] IF host.h_name <> 0 THEN
	mov	eax,d[ebp-48]			;;; i665
	mov	eax,d[eax]			;;; i313b
	cmp	eax,0			;;; i684a
	je	>> else.005D.p2pfile			;;; i219
;
; [832] IPName$ = NULL$ (512)
	sub	esp,64			;;; i487
	mov	d[esp],512
	call	%_null.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [833] RtlMoveMemory (&IPName$, host.h_name, LEN(IPName$))
	mov	eax,d[ebp+12]			;;; i642
	mov	d[ebp-64],eax			;;; i670
	mov	eax,d[ebp-48]			;;; i665
	mov	eax,d[eax]			;;; i313b
; .xstk9.0001 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.105			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.105:
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	push	[ebp-64]			;;; i674a
	call	_RtlMoveMemory@12			;;; i619
;
; [834] IPName$ = CSIZE$ (IPName$)
	sub	esp,64			;;; i487
	mov	eax,[ebp+12]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_csize.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [835] END IF
else.005D.p2pfile:
end.if.005D.p2pfile:
;
; [837] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func9.p2pfile			;;; i258
;
; [838] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetIPName.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func9.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  GetIPName ()  *****
;  *****
;
; [840] FUNCTION sBind (socket,ipaddress$,port)
.code
;
#ifdef sBind.socket
#undef sBind.socket
#endif
#define sBind.socket ebp+8	; exposes function argument 'socket'
;
;
#ifdef sBind.ipaddress$
#undef sBind.ipaddress$
#endif
#define sBind.ipaddress$ ebp+12	; exposes function argument 'ipaddress$'
;
;
#ifdef sBind.port
#undef sBind.port
#endif
#define sBind.port ebp+16	; exposes function argument 'port'
;
align 16
_sBind.p2pfile@12:
;  *****
;  *****  FUNCTION  sBind ()  *****
;  *****
func3.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func3.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.112:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.112			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,184			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-44],eax			;;; i670
funcBody3.p2pfile:
;
; [841] SOCKADDR_IN udtSocket
; .composites = ebp-40	; internal variable
#ifdef sBind.udtSocket
#undef sBind.udtSocket
#endif
#define sBind.udtSocket ebp-44	; exposes local variable 'udtSocket'
;
;
; [844] udtSocket.sin_family = $$AF_INET
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,2			;;; i659
	mov	w[eax],bx			;;; i13b
;
; [845] udtSocket.sin_port = htons (port)
;
; [0] EXTERNAL SFUNCTION  htons            (hostshort)
	push	[ebp+16]			;;; i674a
	call	_htons@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	w[ebx+2],ax			;;; i13b
;
; [846] udtSocket.sin_addr = inet_addr (&ipaddress$)
	mov	eax,d[ebp+12]			;;; i642
	push	eax			;;; i667a
	call	_inet_addr@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	d[ebx+4],eax			;;; i13b
;
; [848] IF (udtSocket.sin_addr == $$INADDR_NONE) THEN
	mov	eax,d[ebp-44]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	cmp	eax,-1			;;; i684a
	jne	>> else.005E.p2pfile			;;; i219
;
; [849] GetIPAddr (ipaddress$, @numIPAddr$)
	mov	eax,d[ebp+12]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk3.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
#ifdef sBind.numIPAddr$
#undef sBind.numIPAddr$
#endif
#define sBind.numIPAddr$ ebp-56	; exposes local variable 'numIPAddr$'
;
	push	[ebp-56]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	funcA.p2pfile			;;; i619
	sub	esp,8			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+4]			;;; i877a
	mov	[ebp-56],ecx			;;; i670
	add	esp,8			;;; i633
;
; [850] udtSocket.sin_addr = inet_addr (&numIPAddr$)
	mov	eax,d[ebp-56]			;;; i642
	push	eax			;;; i667a
	call	_inet_addr@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	d[ebx+4],eax			;;; i13b
;
; [851] END IF
else.005E.p2pfile:
end.if.005E.p2pfile:
;
; [852] IF (bind (socket, &udtSocket, SIZE (udtSocket)) == $$SOCKET_ERROR) THEN
;
; [0] EXTERNAL SFUNCTION  bind             (socket, addrSOCKADDR, length)
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,16			;;; i584
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	_bind@12			;;; i619
	cmp	eax,-1			;;; i684a
	jne	>> else.005F.p2pfile			;;; i219
;
; [853] 'CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
;
; [854] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func3.p2pfile			;;; i258
;
; [855] ELSE
	jmp	end.if.005F.p2pfile			;;; i107
else.005F.p2pfile:
;
; [856] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func3.p2pfile			;;; i258
;
; [857] END IF
end.if.005F.p2pfile:
;
; [859] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.sBind.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func3.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func3.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
free.func3.p2pfile:
	mov	esi,[ebp-56]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  sBind ()  *****
;  *****
;
; [861] FUNCTION CreateBindSocket (addy$,port,socket)
.code
;
#ifdef CreateBindSocket.addy$
#undef CreateBindSocket.addy$
#endif
#define CreateBindSocket.addy$ ebp+8	; exposes function argument 'addy$'
;
;
#ifdef CreateBindSocket.port
#undef CreateBindSocket.port
#endif
#define CreateBindSocket.port ebp+12	; exposes function argument 'port'
;
;
#ifdef CreateBindSocket.socket
#undef CreateBindSocket.socket
#endif
#define CreateBindSocket.socket ebp+16	; exposes function argument 'socket'
;
align 16
_CreateBindSocket.p2pfile@12:
;  *****
;  *****  FUNCTION  CreateBindSocket ()  *****
;  *****
func5.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,188			;;; i114a
;
funcBody5.p2pfile:
;
; [862] SHARED APPLSTATUS
;
; [865] socket = socket ($$AF_INET, $$SOCK_STREAM, 0)
;
; [0] EXTERNAL SFUNCTION  socket           (domain, type, protocol)
	push	0			;;; i656a
	push	1			;;; i656a
	push	2			;;; i656a
	call	_socket@12			;;; i619
	mov	d[ebp+16],eax			;;; i670
;
; [866] IFZ socket THEN RETURN $$FALSE
	mov	eax,d[ebp+16]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0060.p2pfile			;;; i195
	mov	eax,0			;;; i659
	jmp	end.func5.p2pfile			;;; i258
else.0060.p2pfile:
end.if.0060.p2pfile:
;
; [868] erroronce = $$FALSE
#ifdef CreateBindSocket.erroronce
#undef CreateBindSocket.erroronce
#endif
#define CreateBindSocket.erroronce ebp-40	; exposes local variable 'erroronce'
;
	mov	eax,0			;;; i659
	mov	d[ebp-40],eax			;;; i670
;
; [869] ret = $$FALSE
#ifdef CreateBindSocket.ret
#undef CreateBindSocket.ret
#endif
#define CreateBindSocket.ret ebp-44	; exposes local variable 'ret'
;
	mov	eax,0			;;; i659
	mov	d[ebp-44],eax			;;; i670
;
; [870] DO
align 8
do.0061.p2pfile:
;
; [871] ret = sBind (socket,addy$,port)
	mov	eax,d[ebp+8]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk5.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
	push	[ebp+12]			;;; i674a
	push	[ebp-52]			;;; i674a
	push	[ebp+16]			;;; i674a
	call	func3.p2pfile			;;; i619
	sub	esp,12			;;; xnt1i
	mov	esi,d[esp+4]			;;; i871
	call	%____free			;;; i872
	add	esp,12			;;; i633
	mov	d[ebp-44],eax			;;; i670
;
; [872] IFF ret THEN
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0062.p2pfile			;;; i195
;
; [873] IFF erroronce THEN' wait until port is free
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0063.p2pfile			;;; i195
;
; [874] erroronce = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[ebp-40],eax			;;; i670
;
; [875] CPrint ("* port "+STRING$(port)+" in use, waiting... (wsa error "+ STRING$(WSAGetLastError ())+")")
	sub	esp,64			;;; i487
	mov	eax,d[ebp+12]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.01A7.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.01A8.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	[ebp-52],eax			;;; i670
	sub	esp,64			;;; i487
;
; [0] EXTERNAL SFUNCTION  WSAGetLastError  ()
	call	_WSAGetLastError@0			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,[ebp-52]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	6			;;; i781g
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,addr @_string.01A9.p2pfile			;;; i663
	push	eax			;;; i781b
	push	ebx			;;; i781c
	push	4			;;; i781f
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [876] END IF
else.0063.p2pfile:
end.if.0063.p2pfile:
;
; [877] Sleep(50)
	push	50			;;; i656a
	call	_Sleep@4			;;; i619
;
; [878] END IF
else.0062.p2pfile:
end.if.0062.p2pfile:
;
; [879] LOOP WHILE ((ret == $$FALSE) AND (APPLSTATUS == $$TRUE))
do.loop.0061.p2pfile:
	mov	eax,d[ebp-44]			;;; i665
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.114			;;; i467
	not	eax			;;; i468
A.114:
;+peep
	mov	ebx,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	ebx,-1			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.115			;;; i467
	not	ebx			;;; i468
A.115:
;+peep
	and	eax,ebx			;;; i769
	test	eax,eax			;;; i194
	jnz	< do.0061.p2pfile			;;; i195
end.do.0061.p2pfile:
;
; [881] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func5.p2pfile			;;; i258
;
; [883] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.CreateBindSocket.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func5.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  CreateBindSocket ()  *****
;  *****
;
; [885] FUNCTION sConnect (ipaddress$,port,socket)
.code
;
#ifdef sConnect.ipaddress$
#undef sConnect.ipaddress$
#endif
#define sConnect.ipaddress$ ebp+8	; exposes function argument 'ipaddress$'
;
;
#ifdef sConnect.port
#undef sConnect.port
#endif
#define sConnect.port ebp+12	; exposes function argument 'port'
;
;
#ifdef sConnect.socket
#undef sConnect.socket
#endif
#define sConnect.socket ebp+16	; exposes function argument 'socket'
;
align 16
_sConnect.p2pfile@12:
;  *****
;  *****  FUNCTION  sConnect ()  *****
;  *****
func4.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func4.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.121:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.121			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,184			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-44],eax			;;; i670
funcBody4.p2pfile:
;
; [886] SOCKADDR_IN udtSocket
; .composites = ebp-40	; internal variable
#ifdef sConnect.udtSocket
#undef sConnect.udtSocket
#endif
#define sConnect.udtSocket ebp-44	; exposes local variable 'udtSocket'
;
;
; [889] udtSocket.sin_family = $$AF_INET
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,2			;;; i659
	mov	w[eax],bx			;;; i13b
;
; [890] udtSocket.sin_port = htons (port)
	push	[ebp+12]			;;; i674a
	call	_htons@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	w[ebx+2],ax			;;; i13b
;
; [891] udtSocket.sin_addr = inet_addr (&ipaddress$)
	mov	eax,d[ebp+8]			;;; i642
	push	eax			;;; i667a
	call	_inet_addr@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	d[ebx+4],eax			;;; i13b
;
; [893] IF udtSocket.sin_addr = $$INADDR_NONE THEN
	mov	eax,d[ebp-44]			;;; i665
	mov	eax,d[eax+4]			;;; i313b
	cmp	eax,-1			;;; i684a
	jne	>> else.0064.p2pfile			;;; i219
;
; [894] GetIPAddr (ipaddress$, @numIPAddr$)
	mov	eax,d[ebp+8]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk4.0000 = ebp-52	; internal variable
	mov	d[ebp-52],eax			;;; i670
#ifdef sConnect.numIPAddr$
#undef sConnect.numIPAddr$
#endif
#define sConnect.numIPAddr$ ebp-56	; exposes local variable 'numIPAddr$'
;
	push	[ebp-56]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	funcA.p2pfile			;;; i619
	sub	esp,8			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	mov	ecx,d[esp+4]			;;; i877a
	mov	[ebp-56],ecx			;;; i670
	add	esp,8			;;; i633
;
; [895] udtSocket.sin_addr = inet_addr (&numIPAddr$)
	mov	eax,d[ebp-56]			;;; i642
	push	eax			;;; i667a
	call	_inet_addr@4			;;; i619
	mov	ebx,d[ebp-44]			;;; i665
	mov	d[ebx+4],eax			;;; i13b
;
; [896] END IF
else.0064.p2pfile:
end.if.0064.p2pfile:
;
; [898] socket = socket (udtSocket.sin_family, $$SOCK_STREAM, 0)
	mov	eax,d[ebp-44]			;;; i665
	movsx	eax,w[eax]			;;; i313b
	mov	d[ebp-52],eax			;;; i670
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-52]			;;; i674a
	call	_socket@12			;;; i619
	mov	d[ebp+16],eax			;;; i670
;
; [899] IF (connect (socket, &udtSocket, SIZE(udtSocket)) == $$SOCKET_ERROR) THEN
;
; [0] EXTERNAL SFUNCTION  connect          (socket, addrSOCKADDR, length)
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-52],eax			;;; i670
	mov	eax,16			;;; i584
	push	eax			;;; i667a
	push	[ebp-52]			;;; i674a
	push	[ebp+16]			;;; i674a
	call	_connect@12			;;; i619
	cmp	eax,-1			;;; i684a
	jne	>> else.0065.p2pfile			;;; i219
;
; [900] CPrint ("* wsa error "+ STRING$(WSAGetLastError ()))
	sub	esp,64			;;; i487
	call	_WSAGetLastError@0			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.01B0.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [901] IF socket THEN closesocket (socket)
	mov	eax,d[ebp+16]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0066.p2pfile			;;; i221
	push	[ebp+16]			;;; i674a
	call	_closesocket@4			;;; i619
else.0066.p2pfile:
end.if.0066.p2pfile:
;
; [902] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func4.p2pfile			;;; i258
;
; [903] ELSE
	jmp	end.if.0065.p2pfile			;;; i107
else.0065.p2pfile:
;
; [904] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func4.p2pfile			;;; i258
;
; [905] END IF
end.if.0065.p2pfile:
;
; [907] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.sConnect.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func4.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func4.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
free.func4.p2pfile:
	mov	esi,[ebp-56]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  sConnect ()  *****
;  *****
;
; [909] FUNCTION SendBin (socket,pbuffer,size)
.code
;
#ifdef SendBin.socket
#undef SendBin.socket
#endif
#define SendBin.socket ebp+8	; exposes function argument 'socket'
;
;
#ifdef SendBin.pbuffer
#undef SendBin.pbuffer
#endif
#define SendBin.pbuffer ebp+12	; exposes function argument 'pbuffer'
;
;
#ifdef SendBin.size
#undef SendBin.size
#endif
#define SendBin.size ebp+16	; exposes function argument 'size'
;
align 16
_SendBin.p2pfile@12:
;  *****
;  *****  FUNCTION  SendBin ()  *****
;  *****
func6.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,192			;;; i114a
;
funcBody6.p2pfile:
;
; [910] SHARED ULONG tBytesSent
data section 'globals$shared'
align	4
%tBytesSent.p2pfile:	db 4 dup ?
.code
;
; [911] SHARED APPLSTATUS
;
; [912] SHARED CONNECTED
;
; [915] IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.123			;;; i467
	not	eax			;;; i468
A.123:
;+peep
	mov	ebx,d[%CONNECTED.p2pfile]			;;; i663a
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.124			;;; i467
	not	ebx			;;; i468
A.124:
;+peep
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i220
	jz	>> else.0067.p2pfile			;;; i221
;
; [916] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func6.p2pfile			;;; i258
;
; [917] END IF
else.0067.p2pfile:
end.if.0067.p2pfile:
;
; [919] DO
align 8
do.0068.p2pfile:
;
; [920] size = size-sent
#ifdef SendBin.sent
#undef SendBin.sent
#endif
#define SendBin.sent ebp-40	; exposes local variable 'sent'
;
	mov	eax,d[ebp+16]			;;; i665
	mov	ebx,d[ebp-40]			;;; i665
	sub	eax,ebx			;;; i791
	mov	d[ebp+16],eax			;;; i670
;
; [921] sent = send (socket, pbuffer+sent, size, 0)
;
; [0] EXTERNAL SFUNCTION  send             (socket, addrMessage, length, flags)
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,d[ebp-40]			;;; i665
	add	eax,ebx			;;; i775
; .xstk6.0000 = ebp-48	; internal variable
	mov	d[ebp-48],eax			;;; i670
	push	0			;;; i656a
	push	[ebp+16]			;;; i674a
	push	[ebp-48]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	_send@16			;;; i619
	mov	d[ebp-40],eax			;;; i670
;
; [922] IF (sent == $$SOCKET_ERROR) THEN
	mov	eax,d[ebp-40]			;;; i665
	cmp	eax,-1			;;; i684a
	jne	>> else.0069.p2pfile			;;; i219
;
; [923] CPrint ("* wsa error "+ STRING$(WSAGetLastError ()))
	sub	esp,64			;;; i487
	call	_WSAGetLastError@0			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.01B0.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [924] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func6.p2pfile			;;; i258
;
; [925] ELSE
	jmp	end.if.0069.p2pfile			;;; i107
else.0069.p2pfile:
;
; [926] tBytesSent = tBytesSent + sent
	mov	eax,d[%tBytesSent.p2pfile]			;;; i663a
	mov	ebx,d[ebp-40]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[%tBytesSent.p2pfile],eax			;;; i668
;
; [927] END IF
end.if.0069.p2pfile:
;
; [928] LOOP WHILE (sent < size)
do.loop.0068.p2pfile:
	mov	eax,d[ebp-40]			;;; i665
	mov	ebx,d[ebp+16]			;;; i665
	cmp	eax,ebx			;;; i684a
	jl	< do.0068.p2pfile			;;; i193
end.do.0068.p2pfile:
;
; [930] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func6.p2pfile			;;; i258
;
; [931] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.SendBin.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func6.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  SendBin ()  *****
;  *****
;
; [934] FUNCTION ListenBin (socket,size,UBYTE buffer[])
.code
;
#ifdef ListenBin.socket
#undef ListenBin.socket
#endif
#define ListenBin.socket ebp+8	; exposes function argument 'socket'
;
;
#ifdef ListenBin.size
#undef ListenBin.size
#endif
#define ListenBin.size ebp+12	; exposes function argument 'size'
;
;
#ifdef ListenBin.buffer
#undef ListenBin.buffer
#endif
#define ListenBin.buffer ebp+16	; exposes function argument 'buffer'
;
align 16
_ListenBin.p2pfile@12:
;  *****
;  *****  FUNCTION  ListenBin ()  *****
;  *****
func7.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.134:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.134			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,184			;;; i114a
;
funcBody7.p2pfile:
;
; [935] SHARED ULONG tBytesRecvB
data section 'globals$shared'
align	4
%tBytesRecvB.p2pfile:	db 4 dup ?
.code
;
; [936] SHARED APPLSTATUS
;
; [937] SHARED CONNECTED
;
; [940] IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.128			;;; i467
	not	eax			;;; i468
A.128:
;+peep
	mov	ebx,d[%CONNECTED.p2pfile]			;;; i663a
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.129			;;; i467
	not	ebx			;;; i468
A.129:
;+peep
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i220
	jz	>> else.006A.p2pfile			;;; i221
;
; [941] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func7.p2pfile			;;; i258
;
; [942] END IF
else.006A.p2pfile:
end.if.006A.p2pfile:
;
; [944] IFZ size THEN RETURN $$FALSE
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.006B.p2pfile			;;; i195
	mov	eax,0			;;; i659
	jmp	end.func7.p2pfile			;;; i258
else.006B.p2pfile:
end.if.006B.p2pfile:
;
; [945] DIM buffer[size-1]
	sub	esp,64			;;; i430
	mov	eax,d[ebp+12]			;;; i665
	sub	eax,1			;;; i791
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp+16]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1073545215			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp+16],eax			;;; i670
;
; [946] rover = &buffer[]
#ifdef ListenBin.rover
#undef ListenBin.rover
#endif
#define ListenBin.rover ebp-40	; exposes local variable 'rover'
;
	mov	eax,d[ebp+16]			;;; i665
	mov	d[ebp-40],eax			;;; i670
;
; [947] read = 0
#ifdef ListenBin.read
#undef ListenBin.read
#endif
#define ListenBin.read ebp-44	; exposes local variable 'read'
;
	mov	eax,0			;;; i659
	mov	d[ebp-44],eax			;;; i670
;
; [949] DO WHILE (read < size)
align 8
do.006C.p2pfile:
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	cmp	eax,ebx			;;; i684a
	jge	>> end.do.006C.p2pfile			;;; i219
;
; [950] thisRead = recv (socket, rover, size-read, 0)
#ifdef ListenBin.thisRead
#undef ListenBin.thisRead
#endif
#define ListenBin.thisRead ebp-48	; exposes local variable 'thisRead'
;
;
; [0] EXTERNAL SFUNCTION  recv             (socket, addrBuffer, length, flags)
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,d[ebp-44]			;;; i665
	sub	eax,ebx			;;; i791
; .xstk7.0000 = ebp-56	; internal variable
	mov	d[ebp-56],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-56]			;;; i674a
	push	[ebp-40]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	_recv@16			;;; i619
	mov	d[ebp-48],eax			;;; i670
;
; [952] IF (thisRead == $$SOCKET_ERROR || thisRead == 0) THEN
	mov	eax,d[ebp-48]			;;; i665
	cmp	eax,-1			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.130			;;; i467
	not	eax			;;; i468
A.130:
;+peep
	mov	ebx,d[ebp-48]			;;; i665
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.131			;;; i467
	not	ebx			;;; i468
A.131:
;+peep
	or	eax,ebx			;;; i732
	neg	eax			;;; i736
	rcr	eax,1			;;; i737
	sar	eax,31			;;; i738
	test	eax,eax			;;; i220
	jz	>> else.006D.p2pfile			;;; i221
;
; [953] IF thisRead == $$SOCKET_ERROR THEN
	mov	eax,d[ebp-48]			;;; i665
	cmp	eax,-1			;;; i684a
	jne	>> else.006E.p2pfile			;;; i219
;
; [954] CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
	sub	esp,64			;;; i487
	call	_WSAGetLastError@0			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.01C1.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [955] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func7.p2pfile			;;; i258
;
; [956] END IF
else.006E.p2pfile:
end.if.006E.p2pfile:
;
; [957] EXIT DO
	jmp	end.do.006C.p2pfile			;;; i144
;
; [958] ELSE
	jmp	end.if.006D.p2pfile			;;; i107
else.006D.p2pfile:
;
; [959] tBytesRecvB = tBytesRecvB + thisRead
	mov	eax,d[%tBytesRecvB.p2pfile]			;;; i663a
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[%tBytesRecvB.p2pfile],eax			;;; i668
;
; [960] read = read + thisRead
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-44],eax			;;; i670
;
; [961] rover = rover + thisRead
	mov	eax,d[ebp-40]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-40],eax			;;; i670
;
; [962] END IF
end.if.006D.p2pfile:
;
; [963] LOOP
do.loop.006C.p2pfile:
	jmp	do.006C.p2pfile			;;; i222
end.do.006C.p2pfile:
;
; [965] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func7.p2pfile			;;; i258
;
; [966] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.ListenBin.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func7.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  ListenBin ()  *****
;  *****
;
; [968] FUNCTION ListenBin2 (socket,size,lpbuffer)
.code
;
#ifdef ListenBin2.socket
#undef ListenBin2.socket
#endif
#define ListenBin2.socket ebp+8	; exposes function argument 'socket'
;
;
#ifdef ListenBin2.size
#undef ListenBin2.size
#endif
#define ListenBin2.size ebp+12	; exposes function argument 'size'
;
;
#ifdef ListenBin2.lpbuffer
#undef ListenBin2.lpbuffer
#endif
#define ListenBin2.lpbuffer ebp+16	; exposes function argument 'lpbuffer'
;
align 16
_ListenBin2.p2pfile@12:
;  *****
;  *****  FUNCTION  ListenBin2 ()  *****
;  *****
func8.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.141:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.141			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,184			;;; i114a
;
funcBody8.p2pfile:
;
; [969] SHARED ULONG tBytesRecvB
;
; [970] SHARED APPLSTATUS
;
; [971] SHARED CONNECTED
;
; [974] IF ((APPLSTATUS == $$FALSE) OR (CONNECTED == $$FALSE)) THEN
	mov	eax,d[%APPLSTATUS.p2pfile]			;;; i663a
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.135			;;; i467
	not	eax			;;; i468
A.135:
;+peep
	mov	ebx,d[%CONNECTED.p2pfile]			;;; i663a
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.136			;;; i467
	not	ebx			;;; i468
A.136:
;+peep
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i220
	jz	>> else.006F.p2pfile			;;; i221
;
; [975] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func8.p2pfile			;;; i258
;
; [976] END IF
else.006F.p2pfile:
end.if.006F.p2pfile:
;
; [978] IFZ size THEN RETURN $$FALSE
	mov	eax,d[ebp+12]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0070.p2pfile			;;; i195
	mov	eax,0			;;; i659
	jmp	end.func8.p2pfile			;;; i258
else.0070.p2pfile:
end.if.0070.p2pfile:
;
; [979] rover = lpbuffer
#ifdef ListenBin2.rover
#undef ListenBin2.rover
#endif
#define ListenBin2.rover ebp-40	; exposes local variable 'rover'
;
	mov	eax,d[ebp+16]			;;; i665
	mov	d[ebp-40],eax			;;; i670
;
; [980] read = 0
#ifdef ListenBin2.read
#undef ListenBin2.read
#endif
#define ListenBin2.read ebp-44	; exposes local variable 'read'
;
	mov	eax,0			;;; i659
	mov	d[ebp-44],eax			;;; i670
;
; [982] DO WHILE (read < size)
align 8
do.0071.p2pfile:
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	cmp	eax,ebx			;;; i684a
	jge	>> end.do.0071.p2pfile			;;; i219
;
; [983] thisRead = recv (socket, rover, size-read, 0)
#ifdef ListenBin2.thisRead
#undef ListenBin2.thisRead
#endif
#define ListenBin2.thisRead ebp-48	; exposes local variable 'thisRead'
;
	mov	eax,d[ebp+12]			;;; i665
	mov	ebx,d[ebp-44]			;;; i665
	sub	eax,ebx			;;; i791
; .xstk8.0000 = ebp-56	; internal variable
	mov	d[ebp-56],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-56]			;;; i674a
	push	[ebp-40]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	_recv@16			;;; i619
	mov	d[ebp-48],eax			;;; i670
;
; [985] IF (thisRead == $$SOCKET_ERROR || thisRead == 0) THEN
	mov	eax,d[ebp-48]			;;; i665
	cmp	eax,-1			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.137			;;; i467
	not	eax			;;; i468
A.137:
;+peep
	mov	ebx,d[ebp-48]			;;; i665
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.138			;;; i467
	not	ebx			;;; i468
A.138:
;+peep
	or	eax,ebx			;;; i732
	neg	eax			;;; i736
	rcr	eax,1			;;; i737
	sar	eax,31			;;; i738
	test	eax,eax			;;; i220
	jz	>> else.0072.p2pfile			;;; i221
;
; [986] IF thisRead == $$SOCKET_ERROR THEN
	mov	eax,d[ebp-48]			;;; i665
	cmp	eax,-1			;;; i684a
	jne	>> else.0073.p2pfile			;;; i219
;
; [987] CPrint ("* wsa error: "+ STRING$(WSAGetLastError ()))
	sub	esp,64			;;; i487
	call	_WSAGetLastError@0			;;; i619
	mov	d[esp],eax			;;; i887
	call	%_string.xlong			;;; i576
	add	esp,64			;;; i600
	mov	ebx,addr @_string.01C1.p2pfile			;;; i663
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	push	eax			;;; i667a
	call	func12.p2pfile			;;; i619
	sub	esp,4			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,4			;;; i633
;
; [988] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func8.p2pfile			;;; i258
;
; [989] END IF
else.0073.p2pfile:
end.if.0073.p2pfile:
;
; [990] EXIT DO
	jmp	end.do.0071.p2pfile			;;; i144
;
; [991] ELSE
	jmp	end.if.0072.p2pfile			;;; i107
else.0072.p2pfile:
;
; [992] tBytesRecvB = tBytesRecvB + thisRead
	mov	eax,d[%tBytesRecvB.p2pfile]			;;; i663a
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[%tBytesRecvB.p2pfile],eax			;;; i668
;
; [993] read = read + thisRead
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-44],eax			;;; i670
;
; [994] rover = rover + thisRead
	mov	eax,d[ebp-40]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-40],eax			;;; i670
;
; [995] END IF
end.if.0072.p2pfile:
;
; [996] LOOP
do.loop.0071.p2pfile:
	jmp	do.0071.p2pfile			;;; i222
end.do.0071.p2pfile:
;
; [998] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func8.p2pfile			;;; i258
;
; [999] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.ListenBin2.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func8.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  ListenBin2 ()  *****
;  *****
;
; [1001] FUNCTION ResetSendTotal()
.code
align 16
_ResetSendTotal.p2pfile@0:
;  *****
;  *****  FUNCTION  ResetSendTotal ()  *****
;  *****
func1C.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody1C.p2pfile:
;
; [1002] SHARED ULONG tBytesSent
;
; [1004] tBytesSent = 0
	mov	eax,0			;;; i659
	or	eax,eax			;;; i366
	jns	> A.142			;;; i367
	call	%_eeeOverflow			;;; i368
A.142:
	mov	d[%tBytesSent.p2pfile],eax			;;; i668
;
; [1005] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.ResetSendTotal.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1C.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  ResetSendTotal ()  *****
;  *****
;
; [1007] FUNCTION ResetListenTotal()
.code
align 16
_ResetListenTotal.p2pfile@0:
;  *****
;  *****  FUNCTION  ResetListenTotal ()  *****
;  *****
func1D.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody1D.p2pfile:
;
; [1008] SHARED ULONG tBytesRecvB
;
; [1010] tBytesRecvB = 0
	mov	eax,0			;;; i659
	or	eax,eax			;;; i366
	jns	> A.145			;;; i367
	call	%_eeeOverflow			;;; i368
A.145:
	mov	d[%tBytesRecvB.p2pfile],eax			;;; i668
;
; [1011] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.ResetListenTotal.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1D.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  ResetListenTotal ()  *****
;  *****
;
; [1013] FUNCTION GetSendTotal()
.code
align 16
_GetSendTotal.p2pfile@0:
;  *****
;  *****  FUNCTION  GetSendTotal ()  *****
;  *****
func1E.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody1E.p2pfile:
;
; [1014] SHARED ULONG tBytesSent
;
; [1016] RETURN tBytesSent
	mov	eax,d[%tBytesSent.p2pfile]			;;; i663a
	jmp	end.func1E.p2pfile			;;; i258
;
; [1017] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetSendTotal.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1E.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  GetSendTotal ()  *****
;  *****
;
; [1019] FUNCTION GetRecvTotal()
.code
align 16
_GetRecvTotal.p2pfile@0:
;  *****
;  *****  FUNCTION  GetRecvTotal ()  *****
;  *****
func1F.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody1F.p2pfile:
;
; [1020] SHARED ULONG tBytesRecvB
;
; [1022] RETURN tBytesRecvB
	mov	eax,d[%tBytesRecvB.p2pfile]			;;; i663a
	jmp	end.func1F.p2pfile			;;; i258
;
; [1023] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetRecvTotal.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1F.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  GetRecvTotal ()  *****
;  *****
;
; [1025] FUNCTION P2PShutdown ()
.code
align 16
_P2PShutdown.p2pfile@0:
;  *****
;  *****  FUNCTION  P2PShutdown ()  *****
;  *****
func2D.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody2D.p2pfile:
;
; [1026] SHARED APPLSTATUS
;
; [1027] SHARED CONNECTED
;
; [1028] SHARED thandle
;
; [1029] STATIC once
data section 'globals$statics'
align	4
%2D%once.p2pfile:	db 4 dup ?
.code
;
; [1032] IF once THEN RETURN ELSE once = 1
	mov	eax,d[%2D%once.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.0074.p2pfile			;;; i221
	xor	eax,eax			;;; i862
	jmp	end.func2D.p2pfile			;;; i258
	jmp	end.if.0074.p2pfile			;;; i107
else.0074.p2pfile:
	mov	eax,1			;;; i659
	mov	d[%2D%once.p2pfile],eax			;;; i668
end.if.0074.p2pfile:
;
; [1034] CONNECTED = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%CONNECTED.p2pfile],eax			;;; i668
;
; [1035] APPLSTATUS = $$FALSE
	mov	eax,0			;;; i659
	mov	d[%APPLSTATUS.p2pfile],eax			;;; i668
;
; [1036] WSACleanup ()
	call	_WSACleanup@0			;;; i619
;
; [1037] Sleep (100)
	push	100			;;; i656a
	call	_Sleep@4			;;; i619
;
; [1038] IF thandle THEN CloseHandle (thandle): thandle = 0
	mov	eax,d[%thandle.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.0075.p2pfile			;;; i221
;
; [0] EXTERNAL FUNCTION CloseHandle (hObject)
	push	[%thandle.p2pfile]			;;; i672a
	call	_CloseHandle@4			;;; i619
	mov	eax,0			;;; i659
	mov	d[%thandle.p2pfile],eax			;;; i668
else.0075.p2pfile:
end.if.0075.p2pfile:
;
; [1039] '	QUIT (0)
;
; [1040] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.P2PShutdown.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func2D.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  P2PShutdown ()  *****
;  *****
;
; [1042] FUNCTION CPrint (message$)
.code
;
#ifdef CPrint.message$
#undef CPrint.message$
#endif
#define CPrint.message$ ebp+8	; exposes function argument 'message$'
;
align 16
_CPrint.p2pfile@4:
;  *****
;  *****  FUNCTION  CPrint ()  *****
;  *****
func12.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
	sub	esp,220			;;; i114a
;
funcBody12.p2pfile:
;
; [1044] PRINT message$
	push	1			;;; i844
	sub	esp,64			;;; i845
	mov	eax,[ebp+8]			;;; i665
	call	%_clone.a0			;;; i429
	add	esp,64
	call	%_PrintWithNewlineThenFree			;;; i859
	add	esp,4
;
; [1045] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func12.p2pfile			;;; i258
;
; [1046] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.CPrint.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func12.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	4			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  CPrint ()  *****
;  *****
;
; [1048] FUNCTION getLastSlash(str$, stop)
.code
;
#ifdef getLastSlash.str$
#undef getLastSlash.str$
#endif
#define getLastSlash.str$ ebp+8	; exposes function argument 'str$'
;
;
#ifdef getLastSlash.stop
#undef getLastSlash.stop
#endif
#define getLastSlash.stop ebp+12	; exposes function argument 'stop'
;
align 16
_getLastSlash.p2pfile@8:
;  *****
;  *****  FUNCTION  getLastSlash ()  *****
;  *****
func18.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,196			;;; i114a
;
funcBody18.p2pfile:
;
; [1049] $PathSlash$   = "\\"
;
; [1052] IF stop < 0 THEN
	mov	eax,d[ebp+12]			;;; i665
	cmp	eax,0			;;; i684a
	jge	>> else.0076.p2pfile			;;; i219
;
; [1053] slash1 = RINSTR(str$, "/")
#ifdef getLastSlash.slash1
#undef getLastSlash.slash1
#endif
#define getLastSlash.slash1 ebp-40	; exposes local variable 'slash1'
;
	sub	esp,64			;;; i487
	mov	eax,[ebp+8]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,addr @_string.01DA.p2pfile			;;; i663
	mov	d[esp+4],eax			;;; i887
	mov	d[esp+8],0			;;; i571
	call	%_rinstr.vv			;;; i572
	add	esp,64			;;; i600
	mov	d[ebp-40],eax			;;; i670
;
; [1054] slash2 = RINSTR(str$, $PathSlash$)
#ifdef getLastSlash.slash2
#undef getLastSlash.slash2
#endif
#define getLastSlash.slash2 ebp-44	; exposes local variable 'slash2'
;
	sub	esp,64			;;; i487
	mov	eax,[ebp+8]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,addr @_string.01D8.p2pfile			;;; i663
	mov	d[esp+4],eax			;;; i887
	mov	d[esp+8],0			;;; i571
	call	%_rinstr.vv			;;; i572
	add	esp,64			;;; i600
	mov	d[ebp-44],eax			;;; i670
;
; [1055] ELSE
	jmp	end.if.0076.p2pfile			;;; i107
else.0076.p2pfile:
;
; [1056] slash1 = RINSTR(str$, "/", stop)
	sub	esp,64			;;; i487
	mov	eax,[ebp+8]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,addr @_string.01DA.p2pfile			;;; i663
	mov	d[esp+4],eax			;;; i887
	mov	eax,d[ebp+12]			;;; i665
	mov	d[esp+8],eax			;;; i887
	call	%_rinstr.vv			;;; i572
	add	esp,64			;;; i600
	mov	d[ebp-40],eax			;;; i670
;
; [1057] slash2 = RINSTR(str$, $PathSlash$, stop)
	sub	esp,64			;;; i487
	mov	eax,[ebp+8]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,addr @_string.01D8.p2pfile			;;; i663
	mov	d[esp+4],eax			;;; i887
	mov	eax,d[ebp+12]			;;; i665
	mov	d[esp+8],eax			;;; i887
	call	%_rinstr.vv			;;; i572
	add	esp,64			;;; i600
	mov	d[ebp-44],eax			;;; i670
;
; [1058] END IF
end.if.0076.p2pfile:
;
; [1059] IFZ slash1 THEN
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.0077.p2pfile			;;; i195
;
; [1060] RETURN slash2
	mov	eax,d[ebp-44]			;;; i665
	jmp	end.func18.p2pfile			;;; i258
;
; [1061] ELSE
	jmp	end.if.0077.p2pfile			;;; i107
else.0077.p2pfile:
;
; [1062] RETURN MAX(slash1, slash2)
	sub	esp,64			;;; i487
	mov	eax,d[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-44]			;;; i665
	mov	d[esp+4],eax			;;; i887
	call	%_MAX.xlong
	add	esp,64			;;; i600
	jmp	end.func18.p2pfile			;;; i258
;
; [1063] END IF
end.if.0077.p2pfile:
;
; [1065] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.getLastSlash.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func18.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  getLastSlash ()  *****
;  *****
;
; [1067] FUNCTION DecomposePathname (pathname$, @path$, @parent$, @filename$, @file$, @extent$)
.code
;
#ifdef DecomposePathname.pathname$
#undef DecomposePathname.pathname$
#endif
#define DecomposePathname.pathname$ ebp+8	; exposes function argument 'pathname$'
;
;
#ifdef DecomposePathname.path$
#undef DecomposePathname.path$
#endif
#define DecomposePathname.path$ ebp+12	; exposes function argument 'path$'
;
;
#ifdef DecomposePathname.parent$
#undef DecomposePathname.parent$
#endif
#define DecomposePathname.parent$ ebp+16	; exposes function argument 'parent$'
;
;
#ifdef DecomposePathname.filename$
#undef DecomposePathname.filename$
#endif
#define DecomposePathname.filename$ ebp+20	; exposes function argument 'filename$'
;
;
#ifdef DecomposePathname.file$
#undef DecomposePathname.file$
#endif
#define DecomposePathname.file$ ebp+24	; exposes function argument 'file$'
;
;
#ifdef DecomposePathname.extent$
#undef DecomposePathname.extent$
#endif
#define DecomposePathname.extent$ ebp+28	; exposes function argument 'extent$'
;
align 16
_DecomposePathname.p2pfile@24:
;  *****
;  *****  FUNCTION  DecomposePathname ()  *****
;  *****
func17.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func17.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.161:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.161			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,180			;;; i114a
;
funcBody17.p2pfile:
;
; [1068] '
;
; [1069] path$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1070] file$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+24]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1071] extent$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+28]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1072] parent$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1073] filename$ = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+20]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1074] name$ = TRIM$ (pathname$)
#ifdef DecomposePathname.name$
#undef DecomposePathname.name$
#endif
#define DecomposePathname.name$ ebp-40	; exposes local variable 'name$'
;
	sub	esp,64			;;; i487
	mov	eax,[ebp+8]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_trim.d.v			;;; i583
	add	esp,64			;;; i600
	lea	ebx,[ebp-40]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1075] dot = RINSTR (name$, ".")
#ifdef DecomposePathname.dot
#undef DecomposePathname.dot
#endif
#define DecomposePathname.dot ebp-44	; exposes local variable 'dot'
;
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,addr @_string.01E4.p2pfile			;;; i663
	mov	d[esp+4],eax			;;; i887
	mov	d[esp+8],0			;;; i571
	call	%_rinstr.vv			;;; i572
	add	esp,64			;;; i600
	mov	d[ebp-44],eax			;;; i670
;
; [1076] slash = getLastSlash(name$, -1)
#ifdef DecomposePathname.slash
#undef DecomposePathname.slash
#endif
#define DecomposePathname.slash ebp-48	; exposes local variable 'slash'
;
	mov	eax,d[ebp-40]			;;; i665
	call	%_clone.a0			;;; i634
; .xstk17.0000 = ebp-56	; internal variable
	mov	d[ebp-56],eax			;;; i670
	mov	eax,1			;;; i659
	neg	eax			;;; i916
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	func18.p2pfile			;;; i619
	sub	esp,8			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,8			;;; i633
	mov	d[ebp-48],eax			;;; i670
;
; [1078] IF slash THEN preslash = getLastSlash(name$, slash-1)
	mov	eax,d[ebp-48]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0078.p2pfile			;;; i221
#ifdef DecomposePathname.preslash
#undef DecomposePathname.preslash
#endif
#define DecomposePathname.preslash ebp-60	; exposes local variable 'preslash'
;
	mov	eax,d[ebp-40]			;;; i665
	call	%_clone.a0			;;; i634
	mov	d[ebp-56],eax			;;; i670
	mov	eax,d[ebp-48]			;;; i665
	sub	eax,1			;;; i791
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	func18.p2pfile			;;; i619
	sub	esp,8			;;; xnt1i
	mov	esi,d[esp]			;;; i871
	call	%____free			;;; i872
	add	esp,8			;;; i633
	mov	d[ebp-60],eax			;;; i670
else.0078.p2pfile:
end.if.0078.p2pfile:
;
; [1079] IF (dot < slash) THEN dot = 0
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	cmp	eax,ebx			;;; i684a
	jge	>> else.0079.p2pfile			;;; i219
	mov	eax,0			;;; i659
	mov	d[ebp-44],eax			;;; i670
else.0079.p2pfile:
end.if.0079.p2pfile:
;
; [1080] '
;
; [1081] filename$ = MID$ (name$, slash+1)' filename = "name.ext"
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	d[esp+4],eax			;;; i887
	mov	d[esp+8],2147483647			;;; i579
	call	%_mid.d.v			;;; i580
	add	esp,64			;;; i600
	lea	ebx,[ebp+20]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1082] IFZ dot THEN
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.007A.p2pfile			;;; i195
;
; [1083] file$ = filename$' file = filename (filename has no extent)
	mov	eax,[ebp+20]			;;; i665
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp+24]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1084] ELSE
	jmp	end.if.007A.p2pfile			;;; i107
else.007A.p2pfile:
;
; [1085] file$ = MID$ (name$, slash+1, dot-slash-1)' file = "name" (without extent)
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-48]			;;; i665
	add	eax,1			;;; i775
	mov	d[esp+4],eax			;;; i887
	mov	eax,d[ebp-44]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	sub	eax,ebx			;;; i791
	sub	eax,1			;;; i791
	mov	d[esp+8],eax			;;; i887
	call	%_mid.d.v			;;; i580
	add	esp,64			;;; i600
	lea	ebx,[ebp+24]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1086] extent$ = MID$ (name$, dot)' extent = ".ext"
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-44]			;;; i665
	mov	d[esp+4],eax			;;; i887
	mov	d[esp+8],2147483647			;;; i579
	call	%_mid.d.v			;;; i580
	add	esp,64			;;; i600
	lea	ebx,[ebp+28]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1087] END IF
end.if.007A.p2pfile:
;
; [1088] '
;
; [1089] IF slash THEN
	mov	eax,d[ebp-48]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.007B.p2pfile			;;; i221
;
; [1090] path$ = LEFT$ (name$, slash-1)' path = full pathname to left of "/file.ext"
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-48]			;;; i665
	sub	eax,1			;;; i791
	mov	d[esp+4],eax			;;; i887
	call	%_left.d.v			;;; i578
	add	esp,64			;;; i600
	lea	ebx,[ebp+12]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1091] IF preslash THEN
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.007C.p2pfile			;;; i221
;
; [1092] parent$ = MID$ (name$, preslash+1, slash-preslash-1)
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-60]			;;; i665
	add	eax,1			;;; i775
	mov	d[esp+4],eax			;;; i887
	mov	eax,d[ebp-48]			;;; i665
	mov	ebx,d[ebp-60]			;;; i665
	sub	eax,ebx			;;; i791
	sub	eax,1			;;; i791
	mov	d[esp+8],eax			;;; i887
	call	%_mid.d.v			;;; i580
	add	esp,64			;;; i600
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1093] ELSE
	jmp	end.if.007C.p2pfile			;;; i107
else.007C.p2pfile:
;
; [1094] parent$ = LEFT$ (name$, slash-1)
	sub	esp,64			;;; i487
	mov	eax,[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	eax,d[ebp-48]			;;; i665
	sub	eax,1			;;; i791
	mov	d[esp+4],eax			;;; i887
	call	%_left.d.v			;;; i578
	add	esp,64			;;; i600
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1095] END IF
end.if.007C.p2pfile:
;
; [1096] END IF
else.007B.p2pfile:
end.if.007B.p2pfile:
;
; [1098] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.DecomposePathname.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func17.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func17.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	24			;;; i111a
free.func17.p2pfile:
	mov	esi,[ebp-40]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  DecomposePathname ()  *****
;  *****
;
; [1100] FUNCTION GetCommandLineArguments (argc, argv$[])' taken from the Xst lib
.code
;
#ifdef GetCommandLineArguments.argc
#undef GetCommandLineArguments.argc
#endif
#define GetCommandLineArguments.argc ebp+8	; exposes function argument 'argc'
;
;
#ifdef GetCommandLineArguments.argv$
#undef GetCommandLineArguments.argv$
#endif
#define GetCommandLineArguments.argv$ ebp+12	; exposes function argument 'argv$'
;
align 16
_GetCommandLineArguments.p2pfile@8:
;  *****
;  *****  FUNCTION  GetCommandLineArguments ()  *****
;  *****
func14.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func14.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.170:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.170			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,140			;;; i114a
;
funcBody14.p2pfile:
;
; [1101] SHARED  setarg
data section 'globals$shared'
align	4
%setarg.p2pfile:	db 4 dup ?
.code
;
; [1102] SHARED  setargc
data section 'globals$shared'
align	4
%setargc.p2pfile:	db 4 dup ?
.code
;
; [1103] SHARED  setargv$[]
data section 'globals$shared'
align	4
%%%setargv$.p2pfile:	db 4 dup ?
.code
;
; [1106] DIM argv$[]
	sub	esp,64			;;; i430
	mov	esi,d[ebp+12]			;;; i665
	call	%_FreeArray			;;; i431
	mov	esi,0			;;; i666
	mov	d[ebp+12],esi			;;; i670
	add	esp,64
;
; [1107] inc = argc
#ifdef GetCommandLineArguments.inc
#undef GetCommandLineArguments.inc
#endif
#define GetCommandLineArguments.inc ebp-40	; exposes local variable 'inc'
;
	mov	eax,d[ebp+8]			;;; i665
	mov	d[ebp-40],eax			;;; i670
;
; [1108] argc = 0
	mov	eax,0			;;; i659
	mov	d[ebp+8],eax			;;; i670
;
; [1109] '
;
; [1110] ' return already set argc and argv$[]
;
; [1111] '
;
; [1112] IF (inc >= 0) THEN
	mov	eax,d[ebp-40]			;;; i665
	cmp	eax,0			;;; i684a
	jl	>> else.007D.p2pfile			;;; i219
;
; [1113] IF setarg THEN
	mov	eax,d[%setarg.p2pfile]			;;; i663a
	test	eax,eax			;;; i220
	jz	>> else.007E.p2pfile			;;; i221
;
; [1114] argc = setargc
	mov	eax,d[%setargc.p2pfile]			;;; i663a
	mov	d[ebp+8],eax			;;; i670
;
; [1115] upper = UBOUND (setargv$[])
#ifdef GetCommandLineArguments.upper
#undef GetCommandLineArguments.upper
#endif
#define GetCommandLineArguments.upper ebp-44	; exposes local variable 'upper'
;
	mov	eax,d[%%%setargv$.p2pfile]			;;; i663a
	test	eax,eax			;;; i593
	jz	> A.162			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.162:
	dec	eax			;;; i596
	mov	d[ebp-44],eax			;;; i670
;
; [1116] ucount = upper + 1
#ifdef GetCommandLineArguments.ucount
#undef GetCommandLineArguments.ucount
#endif
#define GetCommandLineArguments.ucount ebp-48	; exposes local variable 'ucount'
;
	mov	eax,d[ebp-44]			;;; i665
	add	eax,1			;;; i775
	mov	d[ebp-48],eax			;;; i670
;
; [1117] IF (argc > ucount) THEN argc = ucount
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp-48]			;;; i665
	cmp	eax,ebx			;;; i684a
	jle	>> else.007F.p2pfile			;;; i219
	mov	eax,d[ebp-48]			;;; i665
	mov	d[ebp+8],eax			;;; i670
else.007F.p2pfile:
end.if.007F.p2pfile:
;
; [1118] IF argc THEN
	mov	eax,d[ebp+8]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0080.p2pfile			;;; i221
;
; [1119] DIM argv$[upper]
	sub	esp,64			;;; i430
	mov	eax,d[ebp-44]			;;; i665
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp+12]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1072496636			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp+12],eax			;;; i670
;
; [1120] FOR i = 0 TO upper
#ifdef GetCommandLineArguments.i
#undef GetCommandLineArguments.i
#endif
#define GetCommandLineArguments.i ebp-52	; exposes local variable 'i'
;
	mov	eax,0			;;; i659
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp-44]			;;; i665
; .forlimit14.0081 = ebp-56	; internal variable
	mov	d[ebp-56],eax			;;; i670
align 8
for.0081.p2pfile:
	mov	eax,d[ebp-52]			;;; i665
	mov	ebx,d[ebp-56]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0081.p2pfile			;;; i154
;
; [1121] argv$[i] = setargv$[i]
	mov	eax,d[ebp-52]			;;; i665
	mov	edx,d[%%%setargv$.p2pfile]			;;; i663a
	mov	eax,[edx+eax*4]			;;; i464
	call	%_clone.a0			;;; i21
	mov	ebx,d[ebp-52]			;;; i665
	mov	ecx,d[ebp+12]			;;; i665
	lea	ebx,[ecx+ebx*4]			;;; i464
	mov	esi,d[ebx]			;;; i26
	mov	d[ebx],eax			;;; i27
	call	%____free			;;; i28
;
; [1122] NEXT i
do.next.0081.p2pfile:
	inc	d[ebp-52]			;;; i229
	jmp	for.0081.p2pfile			;;; i231
end.for.0081.p2pfile:
;
; [1123] END IF
else.0080.p2pfile:
end.if.0080.p2pfile:
;
; [1124] RETURN ($$FALSE)
	mov	eax,0			;;; i659
	jmp	end.func14.p2pfile			;;; i258
;
; [1125] END IF
else.007E.p2pfile:
end.if.007E.p2pfile:
;
; [1126] END IF
else.007D.p2pfile:
end.if.007D.p2pfile:
;
; [1127] '
;
; [1128] ' get original command line arguments from system
;
; [1129] '
;
; [1130] argc = 0
	mov	eax,0			;;; i659
	mov	d[ebp+8],eax			;;; i670
;
; [1131] index = 0
#ifdef GetCommandLineArguments.index
#undef GetCommandLineArguments.index
#endif
#define GetCommandLineArguments.index ebp-60	; exposes local variable 'index'
;
	mov	eax,0			;;; i659
	mov	d[ebp-60],eax			;;; i670
;
; [1132] DIM argv$[]
	sub	esp,64			;;; i430
	mov	esi,d[ebp+12]			;;; i665
	call	%_FreeArray			;;; i431
	mov	esi,0			;;; i666
	mov	d[ebp+12],esi			;;; i670
	add	esp,64
;
; [1133] addr = GetCommandLineA()' address of full command line
#ifdef GetCommandLineArguments.addr
#undef GetCommandLineArguments.addr
#endif
#define GetCommandLineArguments.addr ebp-64	; exposes local variable 'addr'
;
;
; [0] EXTERNAL FUNCTION GetCommandLineA ()
	call	_GetCommandLineA@0			;;; i619
	mov	d[ebp-64],eax			;;; i670
;
; [1134] line$ = CSTRING$(addr)
#ifdef GetCommandLineArguments.line$
#undef GetCommandLineArguments.line$
#endif
#define GetCommandLineArguments.line$ ebp-68	; exposes local variable 'line$'
;
	sub	esp,64			;;; i487
	mov	eax,d[ebp-64]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_cstring.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp-68]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1136] '	PRINT "cmd line",line$
;
; [1137] '
;
; [1138] done = 0
#ifdef GetCommandLineArguments.done
#undef GetCommandLineArguments.done
#endif
#define GetCommandLineArguments.done ebp-72	; exposes local variable 'done'
;
	mov	eax,0			;;; i659
	mov	d[ebp-72],eax			;;; i670
;
; [1139] IF addr THEN
	mov	eax,d[ebp-64]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0082.p2pfile			;;; i221
;
; [1140] DIM argv$[1023]
	sub	esp,64			;;; i430
	mov	eax,1023			;;; i659
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp+12]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1072496636			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp+12],eax			;;; i670
;
; [1141] quote = $$FALSE
#ifdef GetCommandLineArguments.quote
#undef GetCommandLineArguments.quote
#endif
#define GetCommandLineArguments.quote ebp-76	; exposes local variable 'quote'
;
	mov	eax,0			;;; i659
	mov	d[ebp-76],eax			;;; i670
;
; [1142] argc = 0
	mov	eax,0			;;; i659
	mov	d[ebp+8],eax			;;; i670
;
; [1143] empty = $$FALSE
#ifdef GetCommandLineArguments.empty
#undef GetCommandLineArguments.empty
#endif
#define GetCommandLineArguments.empty ebp-80	; exposes local variable 'empty'
;
	mov	eax,0			;;; i659
	mov	d[ebp-80],eax			;;; i670
;
; [1144] I = 0
#ifdef GetCommandLineArguments.I
#undef GetCommandLineArguments.I
#endif
#define GetCommandLineArguments.I ebp-84	; exposes local variable 'I'
;
	mov	eax,0			;;; i659
	mov	d[ebp-84],eax			;;; i670
;
; [1145] DO
align 8
do.0083.p2pfile:
;
; [1146] cha = UBYTEAT(addr, I)
#ifdef GetCommandLineArguments.cha
#undef GetCommandLineArguments.cha
#endif
#define GetCommandLineArguments.cha ebp-88	; exposes local variable 'cha'
;
	mov	edi,d[ebp-84]			;;; i665
	mov	esi,d[ebp-64]			;;; i665
	movzx	eax,b[esi+edi]			;;; i491
	mov	d[ebp-88],eax			;;; i670
;
; [1147] IF (cha < ' ') THEN EXIT DO
	mov	eax,d[ebp-88]			;;; i665
	cmp	eax,32			;;; i684a
	jge	>> else.0084.p2pfile			;;; i219
	jmp	end.do.0083.p2pfile			;;; i144
else.0084.p2pfile:
end.if.0084.p2pfile:
;
; [1149] IF (cha = ' ') AND NOT quote THEN
	mov	eax,d[ebp-88]			;;; i665
	cmp	eax,32			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.164			;;; i467
	not	eax			;;; i468
A.164:
;+peep
	mov	ebx,d[ebp-76]			;;; i665
	not	ebx			;;; i923
	and	eax,ebx			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0085.p2pfile			;;; i221
;
; [1150] IF NOT empty THEN
	mov	eax,d[ebp-80]			;;; i665
	not	eax			;;; i923
	test	eax,eax			;;; i220
	jz	>> else.0086.p2pfile			;;; i221
;
; [1151] INC argc
	inc	d[ebp+8]			;;; i84
;
; [1152] argv$[argc] = ""
	xor	eax,eax			;;; i658
	call	%_clone.a0			;;; i21
	mov	ebx,d[ebp+8]			;;; i665
	mov	ecx,d[ebp+12]			;;; i665
	lea	ebx,[ecx+ebx*4]			;;; i464
	mov	esi,d[ebx]			;;; i26
	mov	d[ebx],eax			;;; i27
	call	%____free			;;; i28
;
; [1153] empty = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[ebp-80],eax			;;; i670
;
; [1154] END IF
else.0086.p2pfile:
end.if.0086.p2pfile:
;
; [1155] ELSE
	jmp	end.if.0085.p2pfile			;;; i107
else.0085.p2pfile:
;
; [1156] IF (cha = '"') THEN
	mov	eax,d[ebp-88]			;;; i665
	cmp	eax,34			;;; i684a
	jne	>> else.0087.p2pfile			;;; i219
;
; [1157] quote = NOT quote
	mov	eax,d[ebp-76]			;;; i665
	not	eax			;;; i923
	mov	d[ebp-76],eax			;;; i670
;
; [1158] ELSE
	jmp	end.if.0087.p2pfile			;;; i107
else.0087.p2pfile:
;
; [1159] argv$[argc] = argv$[argc] + CHR$(cha)
	mov	eax,d[ebp+8]			;;; i665
	mov	edx,d[ebp+12]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
; .xstk14.0000 = ebp-96	; internal variable
	mov	[ebp-96],eax			;;; i670
	sub	esp,64			;;; i487
	mov	eax,d[ebp-88]			;;; i665
	mov	d[esp],eax			;;; i887
	mov	d[esp+4],1
	call	%_chr.d			;;; i575
	add	esp,64			;;; i600
	mov	ebx,[ebp-96]			;;; i665
	push	ebx			;;; i781
	push	eax			;;; i781a
	push	2			;;; i781e
	call	main.concat			;;; i782
	add	esp,12			;;; i782a
	mov	ebx,d[ebp+8]			;;; i665
	mov	ecx,d[ebp+12]			;;; i665
	lea	ebx,[ecx+ebx*4]			;;; i464
	mov	esi,d[ebx]			;;; i26
	mov	d[ebx],eax			;;; i27
	call	%____free			;;; i28
;
; [1160] empty = $$FALSE
	mov	eax,0			;;; i659
	mov	d[ebp-80],eax			;;; i670
;
; [1161] END IF
end.if.0087.p2pfile:
;
; [1162] END IF
end.if.0085.p2pfile:
;
; [1163] INC I
	inc	d[ebp-84]			;;; i84
;
; [1164] LOOP
do.loop.0083.p2pfile:
	jmp	do.0083.p2pfile			;;; i222
end.do.0083.p2pfile:
;
; [1165] IF NOT empty THEN
	mov	eax,d[ebp-80]			;;; i665
	not	eax			;;; i923
	test	eax,eax			;;; i220
	jz	>> else.0088.p2pfile			;;; i221
;
; [1166] argc = argc + 1
	mov	eax,d[ebp+8]			;;; i665
	add	eax,1			;;; i775
	mov	d[ebp+8],eax			;;; i670
;
; [1167] END IF
else.0088.p2pfile:
end.if.0088.p2pfile:
;
; [1168] REDIM argv$[argc-1]
	sub	esp,64			;;; i430
	mov	eax,d[ebp+8]			;;; i665
	sub	eax,1			;;; i791
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[ebp+12]			;;; i665
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1072496636			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_RedimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[ebp+12],eax			;;; i670
;
; [1170] END IF
else.0082.p2pfile:
end.if.0082.p2pfile:
;
; [1171] '
;
; [1172] ' if input argc < 0 THEN don't overwrite current values
;
; [1173] '
;
; [1174] IF ((setarg = $$FALSE) OR (inc >= 0)) THEN
	mov	eax,d[%setarg.p2pfile]			;;; i663a
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.165			;;; i467
	not	eax			;;; i468
A.165:
;+peep
	mov	ebx,d[ebp-40]			;;; i665
	cmp	ebx,0			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jl	> A.166			;;; i467
	not	ebx			;;; i468
A.166:
;+peep
	or	eax,ebx			;;; i763
	test	eax,eax			;;; i220
	jz	>> else.0089.p2pfile			;;; i221
;
; [1175] setarg = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%setarg.p2pfile],eax			;;; i668
;
; [1176] setargc = argc
	mov	eax,d[ebp+8]			;;; i665
	mov	d[%setargc.p2pfile],eax			;;; i668
;
; [1177] DIM setargv$[]
	sub	esp,64			;;; i430
	mov	esi,d[%%%setargv$.p2pfile]			;;; i663a
	call	%_FreeArray			;;; i431
	mov	esi,0			;;; i666
	mov	d[%%%setargv$.p2pfile],esi			;;; i668
	add	esp,64
;
; [1178] IF (argc > 0) THEN
	mov	eax,d[ebp+8]			;;; i665
	cmp	eax,0			;;; i684a
	jle	>> else.008A.p2pfile			;;; i219
;
; [1179] DIM setargv$[argc-1]
	sub	esp,64			;;; i430
	mov	eax,d[ebp+8]			;;; i665
	sub	eax,1			;;; i791
	mov	d[esp+16],eax			;;; i432
	mov	esi,d[%%%setargv$.p2pfile]			;;; i663a
	mov	d[esp],esi			;;; i433
	mov	d[esp+4],1			;;; i434
	mov	d[esp+8],-1072496636			;;; i435
	mov	d[esp+12],0			;;; i436
	call	%_DimArray			;;; i437
	add	esp,64			;;; i438
	mov	d[%%%setargv$.p2pfile],eax			;;; i668
;
; [1180] FOR i = 0 TO argc-1
	mov	eax,0			;;; i659
	mov	d[ebp-52],eax			;;; i670
	mov	eax,d[ebp+8]			;;; i665
	sub	eax,1			;;; i791
; .forlimit14.008B = ebp-100	; internal variable
	mov	d[ebp-100],eax			;;; i670
align 8
for.008B.p2pfile:
	mov	eax,d[ebp-52]			;;; i665
	mov	ebx,d[ebp-100]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.008B.p2pfile			;;; i154
;
; [1181] setargv$[i] = argv$[i]
	mov	eax,d[ebp-52]			;;; i665
	mov	edx,d[ebp+12]			;;; i665
	mov	eax,[edx+eax*4]			;;; i464
	call	%_clone.a0			;;; i21
	mov	ebx,d[ebp-52]			;;; i665
	mov	ecx,d[%%%setargv$.p2pfile]			;;; i663a
	lea	ebx,[ecx+ebx*4]			;;; i464
	mov	esi,d[ebx]			;;; i26
	mov	d[ebx],eax			;;; i27
	call	%____free			;;; i28
;
; [1182] NEXT i
do.next.008B.p2pfile:
	inc	d[ebp-52]			;;; i229
	jmp	for.008B.p2pfile			;;; i231
end.for.008B.p2pfile:
;
; [1183] END IF
else.008A.p2pfile:
end.if.008A.p2pfile:
;
; [1184] END IF
else.0089.p2pfile:
end.if.0089.p2pfile:
;
; [1186] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.GetCommandLineArguments.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func14.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func14.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
free.func14.p2pfile:
	mov	esi,[ebp-68]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  GetCommandLineArguments ()  *****
;  *****
;
; [1188] FUNCTION LOCATE (row, col)
.code
;
#ifdef LOCATE.row
#undef LOCATE.row
#endif
#define LOCATE.row ebp+8	; exposes function argument 'row'
;
;
#ifdef LOCATE.col
#undef LOCATE.col
#endif
#define LOCATE.col ebp+12	; exposes function argument 'col'
;
align 16
_LOCATE.p2pfile@8:
;  *****
;  *****  FUNCTION  LOCATE ()  *****
;  *****
func19.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,200			;;; i114a
;
funcBody19.p2pfile:
;
; [1189] STATIC hConsole, entry
data section 'globals$statics'
align	4
%19%hConsole.p2pfile:	db 4 dup ?
.code
data section 'globals$statics'
align	4
%19%entry.p2pfile:	db 4 dup ?
.code
;
; [1192] IFZ entry THEN
	mov	eax,d[%19%entry.p2pfile]			;;; i663a
	test	eax,eax			;;; i194
	jnz	>> else.008C.p2pfile			;;; i195
;
; [1193] hConsole = GetStdHandle ($$STD_OUTPUT_HANDLE)
;
; [0] EXTERNAL FUNCTION GetStdHandle (nStdHandle)
	push	-11			;;; i656a
	call	_GetStdHandle@4			;;; i619
	mov	d[%19%hConsole.p2pfile],eax			;;; i668
;
; [1194] entry = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%19%entry.p2pfile],eax			;;; i668
;
; [1195] END IF
else.008C.p2pfile:
end.if.008C.p2pfile:
;
; [1197] DEC row: DEC col
	dec	d[ebp+8]			;;; i84
	dec	d[ebp+12]			;;; i84
;
; [1198] pos = (row << 16) + col
#ifdef LOCATE.pos
#undef LOCATE.pos
#endif
#define LOCATE.pos ebp-40	; exposes local variable 'pos'
;
	mov	eax,d[ebp+8]			;;; i665
	shl	eax,16			;;; i835
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-40],eax			;;; i670
;
; [1199] SetConsoleCursorPosition (hConsole,pos)
;
; [0] EXTERNAL FUNCTION SetConsoleCursorPosition (hConsoleOutput, dwCursorPosition)
	push	[ebp-40]			;;; i674a
	push	[%19%hConsole.p2pfile]			;;; i672a
	call	_SetConsoleCursorPosition@8			;;; i619
;
; [1201] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.LOCATE.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func19.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	8			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  LOCATE ()  *****
;  *****
;
; [1203] FUNCTION Inkey ()
.code
align 16
_Inkey.p2pfile@0:
;  *****
;  *****  FUNCTION  Inkey ()  *****
;  *****
func1A.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.183:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.183			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,144			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-44],eax			;;; i670
funcBody1A.p2pfile:
;
; [1204] INPUT_RECORD inputRecord
; .composites = ebp-40	; internal variable
#ifdef Inkey.inputRecord
#undef Inkey.inputRecord
#endif
#define Inkey.inputRecord ebp-44	; exposes local variable 'inputRecord'
;
;
; [1205] STATIC u$, l$
data section 'globals$statics'
align	4
%1A%u$.p2pfile:	db 4 dup ?
.code
data section 'globals$statics'
align	4
%1A%l$.p2pfile:	db 4 dup ?
.code
;
; [1206] STATIC entry
data section 'globals$statics'
align	4
%1A%entry.p2pfile:	db 4 dup ?
.code
;
; [1208] IFZ entry THEN GOSUB Initialize
	mov	eax,d[%1A%entry.p2pfile]			;;; i663a
	test	eax,eax			;;; i194
	jnz	>> else.008D.p2pfile			;;; i195
	call	%s%Initialize%1A			;;; i163
else.008D.p2pfile:
end.if.008D.p2pfile:
;
; [1209] count = 0
#ifdef Inkey.count
#undef Inkey.count
#endif
#define Inkey.count ebp-48	; exposes local variable 'count'
;
	mov	eax,0			;;; i659
	mov	d[ebp-48],eax			;;; i670
;
; [1210] ch = 0
#ifdef Inkey.ch
#undef Inkey.ch
#endif
#define Inkey.ch ebp-52	; exposes local variable 'ch'
;
	mov	eax,0			;;; i659
	mov	d[ebp-52],eax			;;; i670
;
; [1212] hStdIn = GetStdHandle ($$STD_INPUT_HANDLE)
#ifdef Inkey.hStdIn
#undef Inkey.hStdIn
#endif
#define Inkey.hStdIn ebp-56	; exposes local variable 'hStdIn'
;
	push	-10			;;; i656a
	call	_GetStdHandle@4			;;; i619
	mov	d[ebp-56],eax			;;; i670
;
; [1213] oldConsoleMode = 0
#ifdef Inkey.oldConsoleMode
#undef Inkey.oldConsoleMode
#endif
#define Inkey.oldConsoleMode ebp-60	; exposes local variable 'oldConsoleMode'
;
	mov	eax,0			;;; i659
	mov	d[ebp-60],eax			;;; i670
;
; [1214] GetConsoleMode (hStdIn, &oldConsoleMode)
;
; [0] EXTERNAL FUNCTION GetConsoleMode (hConsoleHandle, lpMode)
	lea	eax,[ebp-60]			;;; i642
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	_GetConsoleMode@8			;;; i619
;
; [1215] SetConsoleMode (hStdIn, 0)
;
; [0] EXTERNAL FUNCTION SetConsoleMode (hConsoleHandle, dwMode)
	push	0			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_SetConsoleMode@8			;;; i619
;
; [1216] PeekConsoleInputA (hStdIn, &inputRecord, 1, &count)
;
; [0] EXTERNAL FUNCTION PeekConsoleInputA (hConsoleInput, bufferAddr, length, numOfEventsReadAddr)
	mov	eax,d[ebp-44]			;;; i642
; .xstk1A.0000 = ebp-68	; internal variable
	mov	d[ebp-68],eax			;;; i670
	lea	eax,[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	1			;;; i656a
	push	[ebp-68]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	_PeekConsoleInputA@16			;;; i619
;
; [1217] IF ((count > 0) && (inputRecord.EventType == $$KEY_EVENT)) THEN
	mov	eax,d[ebp-48]			;;; i665
	cmp	eax,0			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jle	> A.174			;;; i467
	not	eax			;;; i468
A.174:
;+peep
	mov	ebx,d[ebp-44]			;;; i665
	movzx	ebx,w[ebx]			;;; i313b
	cmp	ebx,1			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jne	> A.175			;;; i467
	not	ebx			;;; i468
A.175:
;+peep
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.008E.p2pfile			;;; i221
;
; [1218] ReadConsoleInputA (hStdIn, &inputRecord, 1, &count)
;
; [0] EXTERNAL FUNCTION ReadConsoleInputA (hConsoleInput, lpBuffer, nNumberOfCharsToRead, lpNumberOfCharsRead)
	mov	eax,d[ebp-44]			;;; i642
	mov	d[ebp-68],eax			;;; i670
	lea	eax,[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	1			;;; i656a
	push	[ebp-68]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	_ReadConsoleInputA@16			;;; i619
;
; [1219] SetConsoleMode (hStdIn, oldConsoleMode)
	push	[ebp-60]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	_SetConsoleMode@8			;;; i619
;
; [1220] IF (count) && (inputRecord.EventType == $$KEY_EVENT) && (inputRecord.KeyEvent.bKeyDown) THEN
	mov	eax,d[ebp-44]			;;; i665
	movzx	eax,w[eax]			;;; i313b
	cmp	eax,1			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.176			;;; i467
	not	eax			;;; i468
A.176:
;+peep
	mov	ebx,d[ebp-48]			;;; i665
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	mov	ebx,d[ebp-44]			;;; i665
	mov	ebx,d[ebx+4]			;;; i313b
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.008F.p2pfile			;;; i221
;
; [1221] vkc = inputRecord.KeyEvent.wVirtualKeyCode
#ifdef Inkey.vkc
#undef Inkey.vkc
#endif
#define Inkey.vkc ebp-72	; exposes local variable 'vkc'
;
	mov	eax,d[ebp-44]			;;; i665
	movzx	eax,w[eax+10]			;;; i313b
	mov	d[ebp-72],eax			;;; i670
;
; [1222] vsc = inputRecord.KeyEvent.wVirtualScanCode
#ifdef Inkey.vsc
#undef Inkey.vsc
#endif
#define Inkey.vsc ebp-76	; exposes local variable 'vsc'
;
	mov	eax,d[ebp-44]			;;; i665
	movzx	eax,w[eax+12]			;;; i313b
	mov	d[ebp-76],eax			;;; i670
;
; [1223] ch  = inputRecord.KeyEvent.AsciiChar
	mov	eax,d[ebp-44]			;;; i665
	movzx	eax,b[eax+14]			;;; i313b
	mov	d[ebp-52],eax			;;; i670
;
; [1224] cks = inputRecord.KeyEvent.dwControlKeyState
#ifdef Inkey.cks
#undef Inkey.cks
#endif
#define Inkey.cks ebp-80	; exposes local variable 'cks'
;
	mov	eax,d[ebp-44]			;;; i665
	mov	eax,d[eax+16]			;;; i313b
	mov	d[ebp-80],eax			;;; i670
;
; [1225] '	PRINT vkc, vsc, ch, cks
;
; [1226] FlushConsoleInputBuffer (hStdIn)
;
; [0] EXTERNAL FUNCTION FlushConsoleInputBuffer (hConsoleInput)
	push	[ebp-56]			;;; i674a
	call	_FlushConsoleInputBuffer@4			;;; i619
;
; [1228] IF (!ch) && (vsc > 58) THEN
	mov	eax,d[ebp-52]			;;; i665
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	mov	ebx,d[ebp-76]			;;; i665
	cmp	ebx,58			;;; i684a
;>peep
	mov	ebx,0			;;; i466
	jle	> A.177			;;; i467
	not	ebx			;;; i468
A.177:
;+peep
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.0090.p2pfile			;;; i221
;
; [1229] IF (cks & 3) THEN RETURN (1000 + vsc) * (-1)
	mov	eax,d[ebp-80]			;;; i665
	and	eax,3			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0091.p2pfile			;;; i221
	mov	eax,1000			;;; i659
	mov	ebx,d[ebp-76]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,1			;;; i659
	neg	ebx			;;; i916
	imul	eax,ebx			;;; i805
	jmp	end.func1A.p2pfile			;;; i258
else.0091.p2pfile:
end.if.0091.p2pfile:
;
; [1230] IF (cks & 12) THEN RETURN (2000 + vsc) * (-1)
	mov	eax,d[ebp-80]			;;; i665
	and	eax,12			;;; i769
	test	eax,eax			;;; i220
	jz	>> else.0092.p2pfile			;;; i221
	mov	eax,2000			;;; i659
	mov	ebx,d[ebp-76]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,1			;;; i659
	neg	ebx			;;; i916
	imul	eax,ebx			;;; i805
	jmp	end.func1A.p2pfile			;;; i258
else.0092.p2pfile:
end.if.0092.p2pfile:
;
; [1231] RETURN vsc * (-1)
	mov	eax,1			;;; i659
	neg	eax			;;; i916
	mov	ebx,d[ebp-76]			;;; i665
	imul	eax,ebx			;;; i805
	jmp	end.func1A.p2pfile			;;; i258
;
; [1232] END IF
else.0090.p2pfile:
end.if.0090.p2pfile:
;
; [1234] IF (ch && (cks & 3)) THEN RETURN vkc + 1000
	mov	eax,d[ebp-80]			;;; i665
	and	eax,3			;;; i769
	mov	ebx,d[ebp-52]			;;; i665
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.0093.p2pfile			;;; i221
	mov	eax,d[ebp-72]			;;; i665
	add	eax,1000			;;; i775
	jmp	end.func1A.p2pfile			;;; i258
else.0093.p2pfile:
end.if.0093.p2pfile:
;
; [1235] IF ((vsc == 15) && (cks & 16)) THEN RETURN 15
	mov	eax,d[ebp-76]			;;; i665
	cmp	eax,15			;;; i684a
;>peep
	mov	eax,0			;;; i466
	jne	> A.178			;;; i467
	not	eax			;;; i468
A.178:
;+peep
	mov	ebx,d[ebp-80]			;;; i665
	and	ebx,16			;;; i769
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.0094.p2pfile			;;; i221
	mov	eax,15			;;; i659
	jmp	end.func1A.p2pfile			;;; i258
else.0094.p2pfile:
end.if.0094.p2pfile:
;
; [1236] IF (vkc == 27) THEN RETURN 27
	mov	eax,d[ebp-72]			;;; i665
	cmp	eax,27			;;; i684a
	jne	>> else.0095.p2pfile			;;; i219
	mov	eax,27			;;; i659
	jmp	end.func1A.p2pfile			;;; i258
else.0095.p2pfile:
end.if.0095.p2pfile:
;
; [1238] IF (ch && (cks & 128)) THEN
	mov	eax,d[ebp-80]			;;; i665
	and	eax,128			;;; i769
	mov	ebx,d[ebp-52]			;;; i665
	neg	eax			;;; i745
	rcr	eax,1			;;; i746
	sar	eax,31			;;; i747
	mov	edx,ebx			;;; i748
	neg	edx			;;; i749
	rcr	edx,1			;;; i750
	sar	edx,31			;;; i751
	and	eax,edx			;;; i752
	test	eax,eax			;;; i220
	jz	>> else.0096.p2pfile			;;; i221
;
; [1239] upper = LEN (u$) - 1
#ifdef Inkey.upper
#undef Inkey.upper
#endif
#define Inkey.upper ebp-84	; exposes local variable 'upper'
;
	mov	eax,d[%1A%u$.p2pfile]			;;; i663a
	test	eax,eax			;;; i593
	jz	> A.179			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.179:
	sub	eax,1			;;; i791
	mov	d[ebp-84],eax			;;; i670
;
; [1240] FOR i = 0 TO upper
#ifdef Inkey.i
#undef Inkey.i
#endif
#define Inkey.i ebp-88	; exposes local variable 'i'
;
	mov	eax,0			;;; i659
	mov	d[ebp-88],eax			;;; i670
	mov	eax,d[ebp-84]			;;; i665
; .forlimit1A.0097 = ebp-92	; internal variable
	mov	d[ebp-92],eax			;;; i670
align 8
for.0097.p2pfile:
	mov	eax,d[ebp-88]			;;; i665
	mov	ebx,d[ebp-92]			;;; i665
	cmp	eax,ebx			;;; i153
	jg	>> end.for.0097.p2pfile			;;; i154
;
; [1241] IF u${i} == ch THEN
	mov	eax,d[ebp-88]			;;; i665
	mov	edx,d[%1A%u$.p2pfile]			;;; i663a
	movzx	eax,b[edx+eax]			;;; i464
	mov	ebx,d[ebp-52]			;;; i665
	cmp	eax,ebx			;;; i684a
	jne	>> else.0098.p2pfile			;;; i219
;
; [1242] ch = l${i}
	mov	eax,d[ebp-88]			;;; i665
	mov	edx,d[%1A%l$.p2pfile]			;;; i663a
	movzx	eax,b[edx+eax]			;;; i464
	mov	d[ebp-52],eax			;;; i670
;
; [1243] RETURN ch
	mov	eax,d[ebp-52]			;;; i665
	jmp	end.func1A.p2pfile			;;; i258
;
; [1244] END IF
else.0098.p2pfile:
end.if.0098.p2pfile:
;
; [1245] NEXT i
do.next.0097.p2pfile:
	inc	d[ebp-88]			;;; i229
	jmp	for.0097.p2pfile			;;; i231
end.for.0097.p2pfile:
;
; [1246] END IF
else.0096.p2pfile:
end.if.0096.p2pfile:
;
; [1248] IF ch THEN RETURN ch
	mov	eax,d[ebp-52]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.0099.p2pfile			;;; i221
	mov	eax,d[ebp-52]			;;; i665
	jmp	end.func1A.p2pfile			;;; i258
else.0099.p2pfile:
end.if.0099.p2pfile:
;
; [1249] END IF
else.008F.p2pfile:
end.if.008F.p2pfile:
;
; [1250] END IF
else.008E.p2pfile:
end.if.008E.p2pfile:
;
; [1252] FlushConsoleInputBuffer (hStdIn)
	push	[ebp-56]			;;; i674a
	call	_FlushConsoleInputBuffer@4			;;; i619
;
; [1253] SetConsoleMode (hStdIn, oldConsoleMode)
	push	[ebp-60]			;;; i674a
	push	[ebp-56]			;;; i674a
	call	_SetConsoleMode@8			;;; i619
;
; [1254] RETURN ch
	mov	eax,d[ebp-52]			;;; i665
	jmp	end.func1A.p2pfile			;;; i258
;
; [1257] ' ***** Initialize *****
;
; [1258] SUB Initialize
	jmp	out.sub1A.0.p2pfile			;;; i262
align 16
%s%Initialize%1A:
; .sub1A.0000 = ebp-96	; internal variable
;
; [1259] '
;
; [1260] entry = $$TRUE
	mov	eax,-1			;;; i659
	mov	d[%1A%entry.p2pfile],eax			;;; i668
;
; [1261] '
;
; [1262] u$ = "\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x7C\x7B\x7D\x3A\x22\x3C\x3E\x3F\x60\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x2D\x3D\x5C\x5B\x5D\x3B\x27\x2C\x2E\x2F\x00"
	mov	eax,addr @_string.021E.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	mov	ebx,addr %1A%u$.p2pfile			;;; i4
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1263] l$ = "\x60\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x2D\x3D\x5C\x5B\x5D\x3B\x27\x2C\x2E\x2F\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x7C\x7B\x7D\x3A\x22\x3C\x3E\x3F\x00"
	mov	eax,addr @_string.021F.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	mov	ebx,addr %1A%l$.p2pfile			;;; i4
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1264] '
;
; [1265] END SUB
end.sub1A.0.p2pfile:
	ret				;;; i127
out.sub1A.0.p2pfile:
;
; [1266] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.Inkey.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func1A.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  Inkey ()  *****
;  *****
;
; [1269] FUNCTION decrypt_buffer (sbuffer, ssize, STRING password, STRING key)
.code
;
#ifdef decrypt_buffer.sbuffer
#undef decrypt_buffer.sbuffer
#endif
#define decrypt_buffer.sbuffer ebp+8	; exposes function argument 'sbuffer'
;
;
#ifdef decrypt_buffer.ssize
#undef decrypt_buffer.ssize
#endif
#define decrypt_buffer.ssize ebp+12	; exposes function argument 'ssize'
;
;
#ifdef decrypt_buffer.password
#undef decrypt_buffer.password
#endif
#define decrypt_buffer.password ebp+16	; exposes function argument 'password'
;
;
#ifdef decrypt_buffer.key
#undef decrypt_buffer.key
#endif
#define decrypt_buffer.key ebp+20	; exposes function argument 'key'
;
align 16
_decrypt_buffer.p2pfile@16:
;  *****
;  *****  FUNCTION  decrypt_buffer ()  *****
;  *****
func26.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func26.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.192:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.192			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,136			;;; i114a
;
funcBody26.p2pfile:
;
; [1270] FUNCADDR Decrypt (HCRYPTKEY, HCRYPTHASH, XLONG, ULONG, XLONG, XLONG)
#ifdef decrypt_buffer.Decrypt
#undef decrypt_buffer.Decrypt
#endif
#define decrypt_buffer.Decrypt ebp-40	; exposes local variable 'Decrypt'
;
;
; [1271] HCRYPTKEY hKey
#ifdef decrypt_buffer.hKey
#undef decrypt_buffer.hKey
#endif
#define decrypt_buffer.hKey ebp-44	; exposes local variable 'hKey'
;
;
; [1272] HCRYPTHASH hHash
#ifdef decrypt_buffer.hHash
#undef decrypt_buffer.hHash
#endif
#define decrypt_buffer.hHash ebp-48	; exposes local variable 'hHash'
;
;
; [1273] HCRYPTPROV hProv
#ifdef decrypt_buffer.hProv
#undef decrypt_buffer.hProv
#endif
#define decrypt_buffer.hProv ebp-52	; exposes local variable 'hProv'
;
;
; [1276] $KEYLENGTH = 0x00800000
;
; [1277] $ENCRYPT_ALGORITHM = $$CALG_RC4' stream encryption cipher, block size is 1 byte
;
; [1279] 'load advapi32.dll library
;
; [1280] hAdvapi = LoadLibraryA (&"advapi32.dll")
#ifdef decrypt_buffer.hAdvapi
#undef decrypt_buffer.hAdvapi
#endif
#define decrypt_buffer.hAdvapi ebp-56	; exposes local variable 'hAdvapi'
;
;
; [0] EXTERNAL FUNCTION LoadLibraryA (lpLibFileName)
	mov	eax,addr @_string.022D.p2pfile			;;; i642
	push	eax			;;; i667a
	call	_LoadLibraryA@4			;;; i619
	mov	d[ebp-56],eax			;;; i670
;
; [1281] IFZ hAdvapi THEN
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.009A.p2pfile			;;; i195
;
; [1282] error$ = "LoadLibraryA : advapi32.dll not found"
#ifdef decrypt_buffer.error$
#undef decrypt_buffer.error$
#endif
#define decrypt_buffer.error$ ebp-60	; exposes local variable 'error$'
;
	mov	eax,addr @_string.022F.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1283] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1284] END IF
else.009A.p2pfile:
end.if.009A.p2pfile:
;
; [1286] 'get function address for CryptDecrypt
;
; [1287] Decrypt = GetProcAddress (hAdvapi, &"CryptDecrypt")
;
; [0] EXTERNAL FUNCTION GetProcAddress (hModule, lpProcName)
	mov	eax,addr @_string.0230.p2pfile			;;; i642
	push	eax			;;; i667a
	push	[ebp-56]			;;; i674a
	call	_GetProcAddress@8			;;; i619
	mov	d[ebp-40],eax			;;; i670
;
; [1288] IFZ Decrypt THEN
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.009B.p2pfile			;;; i195
;
; [1289] error$ = "GetProcAddress(): CryptDecrypt Not Found"
	mov	eax,addr @_string.0231.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1290] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1291] END IF
else.009B.p2pfile:
end.if.009B.p2pfile:
;
; [1293] ' Get the handle to the default provider
;
; [1294] IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, 0)) THEN
;
; [0] EXTERNAL CFUNCTION CryptAcquireContextA (lphProv, lpszContainer, lpszProvider, dwProvType, dwFlags)
	lea	eax,[ebp-52]			;;; i642
; .xstk26.0000 = ebp-68	; internal variable
	mov	d[ebp-68],eax			;;; i670
#ifdef decrypt_buffer.NULL
#undef decrypt_buffer.NULL
#endif
#define decrypt_buffer.NULL ebp-72	; exposes local variable 'NULL'
;
	mov	eax,addr @_string.0F08.p2pfile			;;; i642
; .xstk26.0001 = ebp-80	; internal variable
	mov	d[ebp-80],eax			;;; i670
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-80]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-68]			;;; i674a
	call	_CryptAcquireContextA			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.009C.p2pfile			;;; i221
;
; [1295] IF (GetLastError () == $$NTE_BAD_KEYSET) THEN
;
; [0] EXTERNAL FUNCTION GetLastError ()
	call	_GetLastError@0			;;; i619
	cmp	eax,-2146893802			;;; i684a
	jne	>> else.009D.p2pfile			;;; i219
;
; [1296] IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, $$CRYPT_NEWKEYSET)) THEN
	lea	eax,[ebp-52]			;;; i642
	mov	d[ebp-68],eax			;;; i670
	mov	eax,addr @_string.0F08.p2pfile			;;; i642
	mov	d[ebp-80],eax			;;; i670
	push	8			;;; i656a
	push	1			;;; i656a
	push	[ebp-80]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-68]			;;; i674a
	call	_CryptAcquireContextA			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.009E.p2pfile			;;; i221
;
; [1297] error$ = "CryptAcquireContext()"
	mov	eax,addr @_string.0237.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1298] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1299] END IF
else.009E.p2pfile:
end.if.009E.p2pfile:
;
; [1300] ELSE
	jmp	end.if.009D.p2pfile			;;; i107
else.009D.p2pfile:
;
; [1301] error$ = "CryptAcquireContext()"
	mov	eax,addr @_string.0237.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1302] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1303] END IF
end.if.009D.p2pfile:
;
; [1304] END IF
else.009C.p2pfile:
end.if.009C.p2pfile:
;
; [1306] 'Check for the existence of a password.
;
; [1307] IFZ password THEN
	mov	eax,[ebp+16]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.185			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.009F.p2pfile			;;; i192
A.185:
;
; [1308] IFZ key THEN
	mov	eax,[ebp+20]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.186			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.00A0.p2pfile			;;; i192
A.186:
;
; [1309] error$ = "a password or key required for decryption"
	mov	eax,addr @_string.0238.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1310] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1311] END IF
else.00A0.p2pfile:
end.if.00A0.p2pfile:
;
; [1313] ' Decrypt the file with the saved session key.
;
; [1314] dwKeyBlobLen = SIZE(key)
#ifdef decrypt_buffer.dwKeyBlobLen
#undef decrypt_buffer.dwKeyBlobLen
#endif
#define decrypt_buffer.dwKeyBlobLen ebp-84	; exposes local variable 'dwKeyBlobLen'
;
	mov	eax,d[ebp+20]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.187			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.187:
	mov	d[ebp-84],eax			;;; i670
;
; [1315] IF (!dwKeyBlobLen) THEN
	mov	eax,d[ebp-84]			;;; i665
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A1.p2pfile			;;; i221
;
; [1316] error$ = "Key BLOB length error"
	mov	eax,addr @_string.023A.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1317] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1318] END IF
else.00A1.p2pfile:
end.if.00A1.p2pfile:
;
; [1320] ' Import key BLOB into CSP.
;
; [1321] IF (!CryptImportKey (hProv, &key, dwKeyBlobLen, 0, 0, &hKey)) THEN
;
; [0] EXTERNAL CFUNCTION CryptImportKey (HCRYPTPROV hProv, lpbData, dwDataLen, hImpKey, dwFlags, lphKey)
	mov	eax,d[ebp+20]			;;; i642
	mov	d[ebp-68],eax			;;; i670
	lea	eax,[ebp-44]			;;; i642
	push	eax			;;; i667a
	push	0			;;; i656a
	push	0			;;; i656a
	push	[ebp-84]			;;; i674a
	push	[ebp-68]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	_CryptImportKey			;;; i619
	add	esp,24			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A2.p2pfile			;;; i221
;
; [1322] error$ = "CryptImportKey()"
	mov	eax,addr @_string.023B.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1323] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1324] END IF
else.00A2.p2pfile:
end.if.00A2.p2pfile:
;
; [1326] ELSE
	jmp	end.if.009F.p2pfile			;;; i107
else.009F.p2pfile:
;
; [1328] ' Decrypt the file with a session key derived from a password.
;
; [1329] ' Create a hash object.
;
; [1330] IF (!CryptCreateHash (hProv, $$CALG_MD5, 0, 0, &hHash)) THEN
;
; [0] EXTERNAL CFUNCTION CryptCreateHash (HCRYPTPROV hProv, Algid, HCRYPTKEY hKey, dwFlags, lphHash)
	lea	eax,[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	0			;;; i656a
	push	0			;;; i656a
	push	32771			;;; i656a
	push	[ebp-52]			;;; i674a
	call	_CryptCreateHash			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A3.p2pfile			;;; i221
;
; [1331] error$ = "CryptCreateHash()"
	mov	eax,addr @_string.023D.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1332] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1333] END IF
else.00A3.p2pfile:
end.if.00A3.p2pfile:
;
; [1335] ' Hash in the password data.
;
; [1336] IF (!CryptHashData (hHash, &password, LEN (password), 0)) THEN
;
; [0] EXTERNAL CFUNCTION CryptHashData (HCRYPTHASH hHash, lpbData, dwDataLen, dwFlags)
	mov	eax,d[ebp+16]			;;; i642
	mov	d[ebp-68],eax			;;; i670
	mov	eax,d[ebp+16]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.188			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.188:
	mov	d[ebp-80],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-80]			;;; i674a
	push	[ebp-68]			;;; i674a
	push	[ebp-48]			;;; i674a
	call	_CryptHashData			;;; i619
	add	esp,16			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A4.p2pfile			;;; i221
;
; [1337] error$ = "CryptHashData()"
	mov	eax,addr @_string.023E.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1338] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1339] END IF
else.00A4.p2pfile:
end.if.00A4.p2pfile:
;
; [1341] ' Derive a session key from the hash object.
;
; [1342] IF (!CryptDeriveKey (hProv, $ENCRYPT_ALGORITHM, hHash, $KEYLENGTH, &hKey)) THEN
;
; [0] EXTERNAL CFUNCTION CryptDeriveKey (HCRYPTPROV hProv, Algid, hBaseData, dwFlags, lphKey)
	lea	eax,[ebp-44]			;;; i642
	push	eax			;;; i667a
	push	8388608			;;; i656a
	push	[ebp-48]			;;; i674a
	push	26625			;;; i656a
	push	[ebp-52]			;;; i674a
	call	_CryptDeriveKey			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A5.p2pfile			;;; i221
;
; [1343] error$ = "CryptDeriveKey()"
	mov	eax,addr @_string.023F.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1344] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1345] END IF
else.00A5.p2pfile:
end.if.00A5.p2pfile:
;
; [1347] ' Destroy the hash object.
;
; [1348] IF (!CryptDestroyHash (hHash)) THEN
;
; [0] EXTERNAL CFUNCTION CryptDestroyHash (HCRYPTHASH hHash)
	push	[ebp-48]			;;; i674a
	call	_CryptDestroyHash			;;; i619
	add	esp,4			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A6.p2pfile			;;; i221
;
; [1349] error$ = "CryptDeriveKey()"
	mov	eax,addr @_string.023F.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1350] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1351] END IF
else.00A6.p2pfile:
end.if.00A6.p2pfile:
;
; [1353] END IF
end.if.009F.p2pfile:
;
; [1355] ' The decryption key is now available
;
; [1356] ' for stream ciphers, buffer size can be equal to the block length
;
; [1357] dwBlockLen = 8192
#ifdef decrypt_buffer.dwBlockLen
#undef decrypt_buffer.dwBlockLen
#endif
#define decrypt_buffer.dwBlockLen ebp-88	; exposes local variable 'dwBlockLen'
;
	mov	eax,8192			;;; i659
	mov	d[ebp-88],eax			;;; i670
;
; [1358] lpBuffer = sbuffer
#ifdef decrypt_buffer.lpBuffer
#undef decrypt_buffer.lpBuffer
#endif
#define decrypt_buffer.lpBuffer ebp-92	; exposes local variable 'lpBuffer'
;
	mov	eax,d[ebp+8]			;;; i665
	mov	d[ebp-92],eax			;;; i670
;
; [1359] count = dwBlockLen
#ifdef decrypt_buffer.count
#undef decrypt_buffer.count
#endif
#define decrypt_buffer.count ebp-96	; exposes local variable 'count'
;
	mov	eax,d[ebp-88]			;;; i665
	mov	d[ebp-96],eax			;;; i670
;
; [1360] final = 0
#ifdef decrypt_buffer.final
#undef decrypt_buffer.final
#endif
#define decrypt_buffer.final ebp-100	; exposes local variable 'final'
;
	mov	eax,0			;;; i659
	mov	d[ebp-100],eax			;;; i670
;
; [1362] DO
align 8
do.00A7.p2pfile:
;
; [1363] IF (lpBuffer+count) >= (sbuffer+ssize) THEN
	mov	eax,d[ebp-92]			;;; i665
	mov	ebx,d[ebp-96]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-68],eax			;;; i670
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,d[ebp-68]			;;; i665
	cmp	eax,ebx			;;; i684a
	jg	>> else.00A8.p2pfile			;;; i219
;
; [1364] final = 1
	mov	eax,1			;;; i659
	mov	d[ebp-100],eax			;;; i670
;
; [1365] count = (sbuffer+ssize) - lpBuffer
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,d[ebp-92]			;;; i665
	sub	eax,ebx			;;; i791
	mov	d[ebp-96],eax			;;; i670
;
; [1366] END IF
else.00A8.p2pfile:
end.if.00A8.p2pfile:
;
; [1368] IF (!@Decrypt (hKey, 0, final, 0, lpBuffer, &count)) THEN
	mov	eax,d[ebp-40]			;;; i665
	xor	edx,edx			;;; i602
	test	eax,eax			;;; i603
	jz	>> A.189			;;; i604
	mov	d[ebp-68],eax			;;; i670
	lea	eax,[ebp-96]			;;; i642
	push	eax			;;; i667a
	push	[ebp-92]			;;; i674a
	push	0			;;; i656a
	push	[ebp-100]			;;; i674a
	push	0			;;; i656a
	push	[ebp-44]			;;; i674a
	mov	eax,d[ebp-68]			;;; i665
	call	eax			;;; i620
A.189:
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00A9.p2pfile			;;; i221
;
; [1369] error$ = "CryptDecrypt()"
	mov	eax,addr @_string.0245.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1370] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1371] END IF
else.00A9.p2pfile:
end.if.00A9.p2pfile:
;
; [1372] lpBuffer = lpBuffer + dwBlockLen
	mov	eax,d[ebp-92]			;;; i665
	mov	ebx,d[ebp-88]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-92],eax			;;; i670
;
; [1374] LOOP UNTIL final
do.loop.00A7.p2pfile:
	mov	eax,d[ebp-100]			;;; i665
	test	eax,eax			;;; i220
	jz	< do.00A7.p2pfile			;;; i221
end.do.00A7.p2pfile:
;
; [1376] ' Destroy the session key.
;
; [1377] IF (hKey) THEN
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00AA.p2pfile			;;; i221
;
; [1378] IF (!CryptDestroyKey (hKey)) THEN
;
; [0] EXTERNAL CFUNCTION CryptDestroyKey (HCRYPTKEY hKey)
	push	[ebp-44]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00AB.p2pfile			;;; i221
;
; [1379] error$ = "CryptDestroyKey error"
	mov	eax,addr @_string.0246.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1380] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1381] END IF
else.00AB.p2pfile:
end.if.00AB.p2pfile:
;
; [1382] END IF
else.00AA.p2pfile:
end.if.00AA.p2pfile:
;
; [1384] ' Release the provider handle.
;
; [1385] IF (hProv) THEN
	mov	eax,d[ebp-52]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00AC.p2pfile			;;; i221
;
; [1386] IF (!CryptReleaseContext (hProv, 0)) THEN
;
; [0] EXTERNAL CFUNCTION CryptReleaseContext (HCRYPTPROV hProv, dwFlags)
	push	0			;;; i656a
	push	[ebp-52]			;;; i674a
	call	_CryptReleaseContext			;;; i619
	add	esp,8			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00AD.p2pfile			;;; i221
;
; [1387] error$ = "CryptReleaseContext error"
	mov	eax,addr @_string.0247.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-60]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1388] GOSUB HandleError
	call	%s%HandleError%26			;;; i163
;
; [1389] END IF
else.00AD.p2pfile:
end.if.00AD.p2pfile:
;
; [1390] END IF
else.00AC.p2pfile:
end.if.00AC.p2pfile:
;
; [1392] RETURN 1
	mov	eax,1			;;; i659
	jmp	end.func26.p2pfile			;;; i258
;
; [1394] SUB HandleError
	jmp	out.sub26.0.p2pfile			;;; i262
align 16
%s%HandleError%26:
; .sub26.0000 = ebp-104	; internal variable
;
; [1396] IF error$ THEN
	mov	eax,[ebp-60]			;;; i665
	test	eax,eax			;;; i214
	jz	>> else.00AE.p2pfile			;;; i215
	mov	eax,d[eax-8]			;;; i216
	test	eax,eax			;;; i217
	jz	>> else.00AE.p2pfile			;;; i218
;
; [1397] printf (&"error: decrypt_buffer() %s\n",&error$)
	mov	eax,addr @_string.0248.p2pfile			;;; i642
	mov	d[ebp-68],eax			;;; i670
	mov	eax,d[ebp-60]			;;; i642
	mov	d[ebp-80],eax			;;; i670
	push	[ebp-80]			;;; i674a
	push	[ebp-68]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1398] ELSE
	jmp	end.if.00AE.p2pfile			;;; i107
else.00AE.p2pfile:
;
; [1399] printf (&"unknown error during decrypt_buffer()\n",0)
	mov	eax,addr @_string.0249.p2pfile			;;; i642
	mov	d[ebp-68],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-68]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1400] END IF
end.if.00AE.p2pfile:
;
; [1402] IF hKey THEN CryptDestroyKey(hKey)
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00AF.p2pfile			;;; i221
	push	[ebp-44]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
else.00AF.p2pfile:
end.if.00AF.p2pfile:
;
; [1403] IF hHash THEN CryptDestroyHash (hHash)
	mov	eax,d[ebp-48]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00B0.p2pfile			;;; i221
	push	[ebp-48]			;;; i674a
	call	_CryptDestroyHash			;;; i619
	add	esp,4			;;; i633
else.00B0.p2pfile:
end.if.00B0.p2pfile:
;
; [1404] IF hProv THEN CryptReleaseContext (hProv, 0)
	mov	eax,d[ebp-52]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00B1.p2pfile			;;; i221
	push	0			;;; i656a
	push	[ebp-52]			;;; i674a
	call	_CryptReleaseContext			;;; i619
	add	esp,8			;;; i633
else.00B1.p2pfile:
end.if.00B1.p2pfile:
;
; [1405] IF hAdvapi THEN FreeLibrary (hAdvapi)
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00B2.p2pfile			;;; i221
;
; [0] EXTERNAL FUNCTION FreeLibrary (hLibModule)
	push	[ebp-56]			;;; i674a
	call	_FreeLibrary@4			;;; i619
else.00B2.p2pfile:
end.if.00B2.p2pfile:
;
; [1407] RETURN 0
	mov	eax,0			;;; i659
	jmp	end.func26.p2pfile			;;; i258
;
; [1408] END SUB
end.sub26.0.p2pfile:
	ret				;;; i127
out.sub26.0.p2pfile:
;
; [1410] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.decrypt_buffer.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func26.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func26.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	16			;;; i111a
free.func26.p2pfile:
	mov	esi,[ebp-60]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  decrypt_buffer ()  *****
;  *****
;
; [1412] FUNCTION encrypt_buffer (sbuffer,ssize,STRING password)
.code
;
#ifdef encrypt_buffer.sbuffer
#undef encrypt_buffer.sbuffer
#endif
#define encrypt_buffer.sbuffer ebp+8	; exposes function argument 'sbuffer'
;
;
#ifdef encrypt_buffer.ssize
#undef encrypt_buffer.ssize
#endif
#define encrypt_buffer.ssize ebp+12	; exposes function argument 'ssize'
;
;
#ifdef encrypt_buffer.password
#undef encrypt_buffer.password
#endif
#define encrypt_buffer.password ebp+16	; exposes function argument 'password'
;
align 16
_encrypt_buffer.p2pfile@12:
;  *****
;  *****  FUNCTION  encrypt_buffer ()  *****
;  *****
func25.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  push addr free.func25.p2pfile
  push ebp
  push addr _XxxUnwinder
  fs push [0]
  fs mov [0],esp  ;;; install unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.200:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.200			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,128			;;; i114a
;
funcBody25.p2pfile:
;
; [1413] FUNCADDR Encrypt (HCRYPTKEY, HCRYPTHASH, XLONG, ULONG, XLONG, XLONG, ULONG)
#ifdef encrypt_buffer.Encrypt
#undef encrypt_buffer.Encrypt
#endif
#define encrypt_buffer.Encrypt ebp-40	; exposes local variable 'Encrypt'
;
;
; [1414] HCRYPTKEY hKey, hXchgKey
#ifdef encrypt_buffer.hKey
#undef encrypt_buffer.hKey
#endif
#define encrypt_buffer.hKey ebp-44	; exposes local variable 'hKey'
;
#ifdef encrypt_buffer.hXchgKey
#undef encrypt_buffer.hXchgKey
#endif
#define encrypt_buffer.hXchgKey ebp-48	; exposes local variable 'hXchgKey'
;
;
; [1415] HCRYPTHASH hHash
#ifdef encrypt_buffer.hHash
#undef encrypt_buffer.hHash
#endif
#define encrypt_buffer.hHash ebp-52	; exposes local variable 'hHash'
;
;
; [1416] HCRYPTPROV hProv
#ifdef encrypt_buffer.hProv
#undef encrypt_buffer.hProv
#endif
#define encrypt_buffer.hProv ebp-56	; exposes local variable 'hProv'
;
;
; [1419] $KEYLENGTH = 0x00800000
;
; [1420] $ENCRYPT_ALGORITHM = $$CALG_RC4' stream encryption cipher, block size is 1 byte
;
; [1422] hAdvapi = LoadLibraryA (&"advapi32.dll")
#ifdef encrypt_buffer.hAdvapi
#undef encrypt_buffer.hAdvapi
#endif
#define encrypt_buffer.hAdvapi ebp-60	; exposes local variable 'hAdvapi'
;
	mov	eax,addr @_string.022D.p2pfile			;;; i642
	push	eax			;;; i667a
	call	_LoadLibraryA@4			;;; i619
	mov	d[ebp-60],eax			;;; i670
;
; [1423] IFZ hAdvapi THEN
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.00B3.p2pfile			;;; i195
;
; [1424] error$ = "LoadLibraryA(): advapi32.dll not found"
#ifdef encrypt_buffer.error$
#undef encrypt_buffer.error$
#endif
#define encrypt_buffer.error$ ebp-64	; exposes local variable 'error$'
;
	mov	eax,addr @_string.0256.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1425] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1426] END IF
else.00B3.p2pfile:
end.if.00B3.p2pfile:
;
; [1428] Encrypt = GetProcAddress (hAdvapi, &"CryptEncrypt")
	mov	eax,addr @_string.0257.p2pfile			;;; i642
	push	eax			;;; i667a
	push	[ebp-60]			;;; i674a
	call	_GetProcAddress@8			;;; i619
	mov	d[ebp-40],eax			;;; i670
;
; [1429] IFZ Encrypt THEN
	mov	eax,d[ebp-40]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.00B4.p2pfile			;;; i195
;
; [1430] error$ = "GetProcAddress(): CryptEncrypt() Not Found"
	mov	eax,addr @_string.0258.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1431] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1432] END IF
else.00B4.p2pfile:
end.if.00B4.p2pfile:
;
; [1434] ' Get the handle to the default provider.
;
; [1435] IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, 0)) THEN
	lea	eax,[ebp-56]			;;; i642
; .xstk25.0000 = ebp-72	; internal variable
	mov	d[ebp-72],eax			;;; i670
#ifdef encrypt_buffer.NULL
#undef encrypt_buffer.NULL
#endif
#define encrypt_buffer.NULL ebp-76	; exposes local variable 'NULL'
;
	mov	eax,addr @_string.0F08.p2pfile			;;; i642
; .xstk25.0001 = ebp-84	; internal variable
	mov	d[ebp-84],eax			;;; i670
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-84]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	_CryptAcquireContextA			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00B5.p2pfile			;;; i221
;
; [1436] IF (GetLastError () == $$NTE_BAD_KEYSET) THEN
	call	_GetLastError@0			;;; i619
	cmp	eax,-2146893802			;;; i684a
	jne	>> else.00B6.p2pfile			;;; i219
;
; [1437] IF (!CryptAcquireContextA (&hProv, NULL, &$$MS_ENHANCED_PROV, $$PROV_RSA_FULL, $$CRYPT_NEWKEYSET)) THEN
	lea	eax,[ebp-56]			;;; i642
	mov	d[ebp-72],eax			;;; i670
	mov	eax,addr @_string.0F08.p2pfile			;;; i642
	mov	d[ebp-84],eax			;;; i670
	push	8			;;; i656a
	push	1			;;; i656a
	push	[ebp-84]			;;; i674a
	push	[ebp-76]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	_CryptAcquireContextA			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00B7.p2pfile			;;; i221
;
; [1438] error$ = "CryptAcquireContext()"
	mov	eax,addr @_string.0237.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1439] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1440] END IF
else.00B7.p2pfile:
end.if.00B7.p2pfile:
;
; [1441] ELSE
	jmp	end.if.00B6.p2pfile			;;; i107
else.00B6.p2pfile:
;
; [1442] error$ = "CryptAcquireContext()"
	mov	eax,addr @_string.0237.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1443] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1444] END IF
end.if.00B6.p2pfile:
;
; [1445] END IF
else.00B5.p2pfile:
end.if.00B5.p2pfile:
;
; [1447] ' Create the session key.
;
; [1448] IFZ password THEN
	mov	eax,[ebp+16]			;;; i665
	test	eax,eax			;;; i188
	jz	> A.193			;;; i189
	mov	eax,d[eax-8]			;;; i190
	test	eax,eax			;;; i191
	jnz	>> else.00B8.p2pfile			;;; i192
A.193:
;
; [1449] ' No password was passed.
;
; [1450] ' Encrypt the file with a random session key,
;
; [1451] ' and write the key to dest buffer
;
; [1452] ' create a random session key.
;
; [1453] IF (!CryptGenKey (hProv, $ENCRYPT_ALGORITHM, $KEYLENGTH | $$CRYPT_EXPORTABLE, &hKey)) THEN
;
; [0] EXTERNAL CFUNCTION CryptGenKey (HCRYPTPROV hProv, Algid, dwFlags, lphKey)
	mov	eax,8388608			;;; i657
	or	eax,1			;;; i763
	mov	d[ebp-72],eax			;;; i670
	lea	eax,[ebp-44]			;;; i642
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	push	26625			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptGenKey			;;; i619
	add	esp,16			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00B9.p2pfile			;;; i221
;
; [1454] error$ = "CryptGenKey error"
	mov	eax,addr @_string.025B.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1455] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1456] END IF
else.00B9.p2pfile:
end.if.00B9.p2pfile:
;
; [1458] ' Get the handle to the encrypter's exchange public key.
;
; [1459] IF (!CryptGetUserKey (hProv, $$AT_KEYEXCHANGE, &hXchgKey)) THEN
;
; [0] EXTERNAL CFUNCTION CryptGetUserKey (HCRYPTPROV hProv, dwKeySpec, lphUserKey)
	lea	eax,[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	1			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptGetUserKey			;;; i619
	add	esp,12			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00BA.p2pfile			;;; i221
;
; [1460] IF (GetLastError () == $$NTE_NO_KEY) THEN
	call	_GetLastError@0			;;; i619
	cmp	eax,-2146893811			;;; i684a
	jne	>> else.00BB.p2pfile			;;; i219
;
; [1461] IF (!CryptGenKey (hProv, $$AT_KEYEXCHANGE, 0, &hXchgKey)) THEN
	lea	eax,[ebp-48]			;;; i642
	push	eax			;;; i667a
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptGenKey			;;; i619
	add	esp,16			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00BC.p2pfile			;;; i221
;
; [1462] error$ = "CryptGenKey(): \nunable to create exchange public key"
	mov	eax,addr @_string.025E.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1463] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1464] END IF
else.00BC.p2pfile:
end.if.00BC.p2pfile:
;
; [1465] ELSE
	jmp	end.if.00BB.p2pfile			;;; i107
else.00BB.p2pfile:
;
; [1466] error$ = "CryptGetUserKey(): \nuser public key is not available and may not exist"
	mov	eax,addr @_string.025F.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1467] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1468] END IF
end.if.00BB.p2pfile:
;
; [1469] END IF
else.00BA.p2pfile:
end.if.00BA.p2pfile:
;
; [1471] ' Determine size of the key BLOB, and allocate memory.
;
; [1472] IF (!CryptExportKey (hKey, hXchgKey, $$SIMPLEBLOB, 0, NULL, &dwKeyBlobLen)) THEN
;
; [0] EXTERNAL CFUNCTION CryptExportKey (HCRYPTKEY hKey, HCRYPTKEY hExpKey, dwBlobType, dwFlags, lpbData, lpdwDataLen)
#ifdef encrypt_buffer.dwKeyBlobLen
#undef encrypt_buffer.dwKeyBlobLen
#endif
#define encrypt_buffer.dwKeyBlobLen ebp-88	; exposes local variable 'dwKeyBlobLen'
;
	lea	eax,[ebp-88]			;;; i642
	push	eax			;;; i667a
	push	[ebp-76]			;;; i674a
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-48]			;;; i674a
	push	[ebp-44]			;;; i674a
	call	_CryptExportKey			;;; i619
	add	esp,24			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00BD.p2pfile			;;; i221
;
; [1473] error$ = "CryptExportKey(): \nError computing BLOB length"
	mov	eax,addr @_string.0262.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1474] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1475] END IF
else.00BD.p2pfile:
end.if.00BD.p2pfile:
;
; [1477] IFZ dwKeyBlobLen THEN
	mov	eax,d[ebp-88]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.00BE.p2pfile			;;; i195
;
; [1478] error$ = "CryptExportKey(): BLOB length zero"
	mov	eax,addr @_string.0263.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1479] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1480] END IF
else.00BE.p2pfile:
end.if.00BE.p2pfile:
;
; [1482] password = NULL$(dwKeyBlobLen)
	sub	esp,64			;;; i487
	mov	eax,d[ebp-88]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_null.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1484] ' Encrypt and export the session key into a simple key BLOB.
;
; [1485] IF (!CryptExportKey (hKey, hXchgKey, $$SIMPLEBLOB, 0, &password, &dwKeyBlobLen)) THEN
	mov	eax,d[ebp+16]			;;; i642
	mov	d[ebp-72],eax			;;; i670
	lea	eax,[ebp-88]			;;; i642
	push	eax			;;; i667a
	push	[ebp-72]			;;; i674a
	push	0			;;; i656a
	push	1			;;; i656a
	push	[ebp-48]			;;; i674a
	push	[ebp-44]			;;; i674a
	call	_CryptExportKey			;;; i619
	add	esp,24			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00BF.p2pfile			;;; i221
;
; [1486] error$ = "CryptExportKey() error"
	mov	eax,addr @_string.0264.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1487] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1488] END IF
else.00BF.p2pfile:
end.if.00BF.p2pfile:
;
; [1490] ' Release the key exchange key handle.
;
; [1491] IF (hXchgKey) THEN
	mov	eax,d[ebp-48]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00C0.p2pfile			;;; i221
;
; [1492] IF (!CryptDestroyKey (hXchgKey)) THEN
	push	[ebp-48]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00C1.p2pfile			;;; i221
;
; [1493] error$ = "CryptDestroyKey error"
	mov	eax,addr @_string.0246.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1494] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1495] END IF
else.00C1.p2pfile:
end.if.00C1.p2pfile:
;
; [1496] hXchgKey = 0
	mov	eax,0			;;; i659
	or	eax,eax			;;; i366
	jns	> A.194			;;; i367
	call	%_eeeOverflow			;;; i368
A.194:
	mov	d[ebp-48],eax			;;; i670
;
; [1497] END IF
else.00C0.p2pfile:
end.if.00C0.p2pfile:
;
; [1499] ELSE
	jmp	end.if.00B8.p2pfile			;;; i107
else.00B8.p2pfile:
;
; [1500] ' the file will be encrypted with a session key derived from a password.
;
; [1501] ' the session key will be recreated when the file is decrypted
;
; [1502] ' only if the password used to create the key is available.
;
; [1504] ' create a hash object.
;
; [1505] IF (!CryptCreateHash (hProv, $$CALG_MD5, 0, 0, &hHash)) THEN
	lea	eax,[ebp-52]			;;; i642
	push	eax			;;; i667a
	push	0			;;; i656a
	push	0			;;; i656a
	push	32771			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptCreateHash			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00C2.p2pfile			;;; i221
;
; [1506] error$ = "CryptCreateHash() error"
	mov	eax,addr @_string.0265.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1507] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1508] END IF
else.00C2.p2pfile:
end.if.00C2.p2pfile:
;
; [1510] ' Hash the password.
;
; [1511] IF (!CryptHashData (hHash, &password, LEN(password), 0)) THEN
	mov	eax,d[ebp+16]			;;; i642
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp+16]			;;; i665
	test	eax,eax			;;; i593
	jz	> A.195			;;; i594
	mov	eax,d[eax-8]			;;; i595
A.195:
	mov	d[ebp-84],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-84]			;;; i674a
	push	[ebp-72]			;;; i674a
	push	[ebp-52]			;;; i674a
	call	_CryptHashData			;;; i619
	add	esp,16			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00C3.p2pfile			;;; i221
;
; [1512] error$ = "CryptHashData() error"
	mov	eax,addr @_string.0266.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1513] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1514] END IF
else.00C3.p2pfile:
end.if.00C3.p2pfile:
;
; [1516] ' Derive a session key from the password hash object.
;
; [1517] IF (!CryptDeriveKey (hProv, $ENCRYPT_ALGORITHM, hHash, $KEYLENGTH, &hKey)) THEN
	lea	eax,[ebp-44]			;;; i642
	push	eax			;;; i667a
	push	8388608			;;; i656a
	push	[ebp-52]			;;; i674a
	push	26625			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptDeriveKey			;;; i619
	add	esp,20			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00C4.p2pfile			;;; i221
;
; [1518] error$ = "CryptDeriveKey() error"
	mov	eax,addr @_string.0267.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1519] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1520] END IF
else.00C4.p2pfile:
end.if.00C4.p2pfile:
;
; [1522] ' Destroy hash object.
;
; [1523] IF (hHash) THEN
	mov	eax,d[ebp-52]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00C5.p2pfile			;;; i221
;
; [1524] IF (!CryptDestroyHash (hHash)) THEN
	push	[ebp-52]			;;; i674a
	call	_CryptDestroyHash			;;; i619
	add	esp,4			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00C6.p2pfile			;;; i221
;
; [1525] error$ = "CryptDestroyHash() error"
	mov	eax,addr @_string.0268.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1526] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1527] END IF
else.00C6.p2pfile:
end.if.00C6.p2pfile:
;
; [1528] END IF
else.00C5.p2pfile:
end.if.00C5.p2pfile:
;
; [1529] hHash = 0
	mov	eax,0			;;; i659
	or	eax,eax			;;; i366
	jns	> A.196			;;; i367
	call	%_eeeOverflow			;;; i368
A.196:
	mov	d[ebp-52],eax			;;; i670
;
; [1531] END IF
end.if.00B8.p2pfile:
;
; [1533] ' The session key is now ready
;
; [1534] ' for stream ciphers, buffer size can be equal to the block length
;
; [1535] dwBlockLen = 8192
#ifdef encrypt_buffer.dwBlockLen
#undef encrypt_buffer.dwBlockLen
#endif
#define encrypt_buffer.dwBlockLen ebp-92	; exposes local variable 'dwBlockLen'
;
	mov	eax,8192			;;; i659
	mov	d[ebp-92],eax			;;; i670
;
; [1536] lpBuffer = sbuffer
#ifdef encrypt_buffer.lpBuffer
#undef encrypt_buffer.lpBuffer
#endif
#define encrypt_buffer.lpBuffer ebp-96	; exposes local variable 'lpBuffer'
;
	mov	eax,d[ebp+8]			;;; i665
	mov	d[ebp-96],eax			;;; i670
;
; [1537] count = dwBlockLen
#ifdef encrypt_buffer.count
#undef encrypt_buffer.count
#endif
#define encrypt_buffer.count ebp-100	; exposes local variable 'count'
;
	mov	eax,d[ebp-92]			;;; i665
	mov	d[ebp-100],eax			;;; i670
;
; [1538] final = 0
#ifdef encrypt_buffer.final
#undef encrypt_buffer.final
#endif
#define encrypt_buffer.final ebp-104	; exposes local variable 'final'
;
	mov	eax,0			;;; i659
	mov	d[ebp-104],eax			;;; i670
;
; [1540] DO
align 8
do.00C7.p2pfile:
;
; [1541] IF (lpBuffer+count) >= (sbuffer+ssize) THEN
	mov	eax,d[ebp-96]			;;; i665
	mov	ebx,d[ebp-100]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,d[ebp-72]			;;; i665
	cmp	eax,ebx			;;; i684a
	jg	>> else.00C8.p2pfile			;;; i219
;
; [1542] final = 1
	mov	eax,1			;;; i659
	mov	d[ebp-104],eax			;;; i670
;
; [1543] count = (sbuffer+ssize) - lpBuffer
	mov	eax,d[ebp+8]			;;; i665
	mov	ebx,d[ebp+12]			;;; i665
	add	eax,ebx			;;; i775
	mov	ebx,d[ebp-96]			;;; i665
	sub	eax,ebx			;;; i791
	mov	d[ebp-100],eax			;;; i670
;
; [1544] END IF
else.00C8.p2pfile:
end.if.00C8.p2pfile:
;
; [1546] ret = @Encrypt (hKey, 0, final, 0, lpBuffer, &count, dwBlockLen)
#ifdef encrypt_buffer.ret
#undef encrypt_buffer.ret
#endif
#define encrypt_buffer.ret ebp-108	; exposes local variable 'ret'
;
	mov	eax,d[ebp-40]			;;; i665
	xor	edx,edx			;;; i602
	test	eax,eax			;;; i603
	jz	>> A.197			;;; i604
	mov	d[ebp-72],eax			;;; i670
	lea	eax,[ebp-100]			;;; i642
	mov	d[ebp-84],eax			;;; i670
	push	[ebp-92]			;;; i674a
	push	[ebp-84]			;;; i674a
	push	[ebp-96]			;;; i674a
	push	0			;;; i656a
	push	[ebp-104]			;;; i674a
	push	0			;;; i656a
	push	[ebp-44]			;;; i674a
	mov	eax,d[ebp-72]			;;; i665
	call	eax			;;; i620
A.197:
	mov	d[ebp-108],eax			;;; i670
;
; [1547] IFZ ret THEN error$ = "CryptEncrypt()": GOSUB HandleError
	mov	eax,d[ebp-108]			;;; i665
	test	eax,eax			;;; i194
	jnz	>> else.00C9.p2pfile			;;; i195
	mov	eax,addr @_string.026E.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
	call	%s%HandleError%25			;;; i163
else.00C9.p2pfile:
end.if.00C9.p2pfile:
;
; [1548] lpBuffer = lpBuffer + dwBlockLen
	mov	eax,d[ebp-96]			;;; i665
	mov	ebx,d[ebp-92]			;;; i665
	add	eax,ebx			;;; i775
	mov	d[ebp-96],eax			;;; i670
;
; [1550] LOOP UNTIL final
do.loop.00C7.p2pfile:
	mov	eax,d[ebp-104]			;;; i665
	test	eax,eax			;;; i220
	jz	< do.00C7.p2pfile			;;; i221
end.do.00C7.p2pfile:
;
; [1552] ' Destroy the session key.
;
; [1553] IF (hKey) THEN
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00CA.p2pfile			;;; i221
;
; [1554] IF (!CryptDestroyKey (hKey)) THEN
	push	[ebp-44]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00CB.p2pfile			;;; i221
;
; [1555] error$ = "CryptDestroyKey error"
	mov	eax,addr @_string.0246.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1556] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1557] END IF
else.00CB.p2pfile:
end.if.00CB.p2pfile:
;
; [1558] END IF
else.00CA.p2pfile:
end.if.00CA.p2pfile:
;
; [1560] ' Release the provider handle.
;
; [1561] IF (hProv) THEN
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00CC.p2pfile			;;; i221
;
; [1562] IF (!CryptReleaseContext (hProv, 0)) THEN
	push	0			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptReleaseContext			;;; i619
	add	esp,8			;;; i633
	neg	eax			;;; i888
	cmc				;;; i889
	rcr	eax,1			;;; i890
	sar	eax,31			;;; i891
	test	eax,eax			;;; i220
	jz	>> else.00CD.p2pfile			;;; i221
;
; [1563] error$ = "CryptReleaseContext error"
	mov	eax,addr @_string.0247.p2pfile			;;; i663
	call	%_clone.a0			;;; i3a
	lea	ebx,[ebp-64]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1564] GOSUB HandleError
	call	%s%HandleError%25			;;; i163
;
; [1565] END IF
else.00CD.p2pfile:
end.if.00CD.p2pfile:
;
; [1566] END IF
else.00CC.p2pfile:
end.if.00CC.p2pfile:
;
; [1568] 'free the dll
;
; [1569] IF hAdvapi THEN FreeLibrary (hAdvapi)
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00CE.p2pfile			;;; i221
	push	[ebp-60]			;;; i674a
	call	_FreeLibrary@4			;;; i619
else.00CE.p2pfile:
end.if.00CE.p2pfile:
;
; [1570] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func25.p2pfile			;;; i258
;
; [1572] SUB HandleError
	jmp	out.sub25.0.p2pfile			;;; i262
align 16
%s%HandleError%25:
; .sub25.0000 = ebp-112	; internal variable
;
; [1574] IF error$ THEN
	mov	eax,[ebp-64]			;;; i665
	test	eax,eax			;;; i214
	jz	>> else.00CF.p2pfile			;;; i215
	mov	eax,d[eax-8]			;;; i216
	test	eax,eax			;;; i217
	jz	>> else.00CF.p2pfile			;;; i218
;
; [1575] printf (&"error: encrypt_buffer() %s\n",&error$)
	mov	eax,addr @_string.026F.p2pfile			;;; i642
	mov	d[ebp-72],eax			;;; i670
	mov	eax,d[ebp-64]			;;; i642
	mov	d[ebp-84],eax			;;; i670
	push	[ebp-84]			;;; i674a
	push	[ebp-72]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1576] ELSE
	jmp	end.if.00CF.p2pfile			;;; i107
else.00CF.p2pfile:
;
; [1577] printf (&"unknown error during encrypt_buffer()\n",0)
	mov	eax,addr @_string.0270.p2pfile			;;; i642
	mov	d[ebp-72],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-72]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1578] END IF
end.if.00CF.p2pfile:
;
; [1580] IF hKey THEN CryptDestroyKey(hKey)
	mov	eax,d[ebp-44]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00D0.p2pfile			;;; i221
	push	[ebp-44]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
else.00D0.p2pfile:
end.if.00D0.p2pfile:
;
; [1581] IF hXchgKey THEN CryptDestroyKey (hXchgKey)
	mov	eax,d[ebp-48]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00D1.p2pfile			;;; i221
	push	[ebp-48]			;;; i674a
	call	_CryptDestroyKey			;;; i619
	add	esp,4			;;; i633
else.00D1.p2pfile:
end.if.00D1.p2pfile:
;
; [1582] IF hHash THEN CryptDestroyHash (hHash)
	mov	eax,d[ebp-52]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00D2.p2pfile			;;; i221
	push	[ebp-52]			;;; i674a
	call	_CryptDestroyHash			;;; i619
	add	esp,4			;;; i633
else.00D2.p2pfile:
end.if.00D2.p2pfile:
;
; [1583] IF hProv THEN CryptReleaseContext (hProv, 0)
	mov	eax,d[ebp-56]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00D3.p2pfile			;;; i221
	push	0			;;; i656a
	push	[ebp-56]			;;; i674a
	call	_CryptReleaseContext			;;; i619
	add	esp,8			;;; i633
else.00D3.p2pfile:
end.if.00D3.p2pfile:
;
; [1584] IF hAdvapi THEN FreeLibrary (hAdvapi)
	mov	eax,d[ebp-60]			;;; i665
	test	eax,eax			;;; i220
	jz	>> else.00D4.p2pfile			;;; i221
	push	[ebp-60]			;;; i674a
	call	_FreeLibrary@4			;;; i619
else.00D4.p2pfile:
end.if.00D4.p2pfile:
;
; [1586] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func25.p2pfile			;;; i258
;
; [1587] END SUB
end.sub25.0.p2pfile:
	ret				;;; i127
out.sub25.0.p2pfile:
;
; [1589] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.encrypt_buffer.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func25.p2pfile:
  mov ebx,[ebp-36]
  fs mov [0],ebx       ;;; remove unwind handler
  call free.func25.p2pfile
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
free.func25.p2pfile:
	mov	esi,[ebp-64]			;;; i665
	call	%____free			;;; i423
  ret
;-peep
;  *****
;  *****  END FUNCTION  encrypt_buffer ()  *****
;  *****
;
; [1591] FUNCTION zlib_decompress (source,ssize,dest,dsize)
.code
;
#ifdef zlib_decompress.source
#undef zlib_decompress.source
#endif
#define zlib_decompress.source ebp+8	; exposes function argument 'source'
;
;
#ifdef zlib_decompress.ssize
#undef zlib_decompress.ssize
#endif
#define zlib_decompress.ssize ebp+12	; exposes function argument 'ssize'
;
;
#ifdef zlib_decompress.dest
#undef zlib_decompress.dest
#endif
#define zlib_decompress.dest ebp+16	; exposes function argument 'dest'
;
;
#ifdef zlib_decompress.dsize
#undef zlib_decompress.dsize
#endif
#define zlib_decompress.dsize ebp+20	; exposes function argument 'dsize'
;
align 16
_zlib_decompress.p2pfile@16:
;  *****
;  *****  FUNCTION  zlib_decompress ()  *****
;  *****
func29.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,196			;;; i114a
;
funcBody29.p2pfile:
;
; [1593] IF (uncompress (dest,dsize,source,ssize) == $$Z_OK) THEN
;
; [0] EXTERNAL CFUNCTION uncompress (lpDestBuffer,lpDestBufferLen,lpSrcBuffer,SrcBufferLen)
	push	[ebp+12]			;;; i674a
	push	[ebp+8]			;;; i674a
	push	[ebp+20]			;;; i674a
	push	[ebp+16]			;;; i674a
	call	_uncompress			;;; i619
	add	esp,16			;;; i633
	cmp	eax,0			;;; i684a
	jne	>> else.00D5.p2pfile			;;; i219
;
; [1594] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func29.p2pfile			;;; i258
;
; [1595] ELSE
	jmp	end.if.00D5.p2pfile			;;; i107
else.00D5.p2pfile:
;
; [1596] printf(&"zlib_decompress(): unable to decompress buffer\n",$$NULL)
	mov	eax,addr @_string.0276.p2pfile			;;; i642
; .xstk29.0000 = ebp-44	; internal variable
	mov	d[ebp-44],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-44]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1597] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func29.p2pfile			;;; i258
;
; [1598] END IF
end.if.00D5.p2pfile:
;
; [1599] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.zlib_decompress.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func29.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	16			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  zlib_decompress ()  *****
;  *****
;
; [1601] FUNCTION zlib_compress (source,ssize,dest,dsize,level)
.code
;
#ifdef zlib_compress.source
#undef zlib_compress.source
#endif
#define zlib_compress.source ebp+8	; exposes function argument 'source'
;
;
#ifdef zlib_compress.ssize
#undef zlib_compress.ssize
#endif
#define zlib_compress.ssize ebp+12	; exposes function argument 'ssize'
;
;
#ifdef zlib_compress.dest
#undef zlib_compress.dest
#endif
#define zlib_compress.dest ebp+16	; exposes function argument 'dest'
;
;
#ifdef zlib_compress.dsize
#undef zlib_compress.dsize
#endif
#define zlib_compress.dsize ebp+20	; exposes function argument 'dsize'
;
;
#ifdef zlib_compress.level
#undef zlib_compress.level
#endif
#define zlib_compress.level ebp+24	; exposes function argument 'level'
;
align 16
_zlib_compress.p2pfile@20:
;  *****
;  *****  FUNCTION  zlib_compress ()  *****
;  *****
func27.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,196			;;; i114a
;
funcBody27.p2pfile:
;
; [1604] IF (compress2 (dest,dsize,source,ssize,level) < 0) THEN
;
; [0] EXTERNAL CFUNCTION compress2 (lpDestBuffer,lpDestBufferLen,lpSrcBuffer,SrcBufferLen,Compressionlevel)
	push	[ebp+24]			;;; i674a
	push	[ebp+12]			;;; i674a
	push	[ebp+8]			;;; i674a
	push	[ebp+20]			;;; i674a
	push	[ebp+16]			;;; i674a
	call	_compress2			;;; i619
	add	esp,20			;;; i633
	cmp	eax,0			;;; i684a
	jge	>> else.00D6.p2pfile			;;; i219
;
; [1605] printf(&"zlib_compress(): unable to compress buffer\n",$$NULL)
	mov	eax,addr @_string.027D.p2pfile			;;; i642
; .xstk27.0000 = ebp-44	; internal variable
	mov	d[ebp-44],eax			;;; i670
	push	0			;;; i656a
	push	[ebp-44]			;;; i674a
	call	_printf			;;; i619
	add	esp,8			;;; i633
;
; [1606] RETURN $$FALSE
	mov	eax,0			;;; i659
	jmp	end.func27.p2pfile			;;; i258
;
; [1607] ELSE
	jmp	end.if.00D6.p2pfile			;;; i107
else.00D6.p2pfile:
;
; [1608] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func27.p2pfile			;;; i258
;
; [1609] END IF
end.if.00D6.p2pfile:
;
; [1610] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.zlib_compress.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func27.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	20			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  zlib_compress ()  *****
;  *****
;
; [1612] FUNCTION zlib_compress2 (sbuffer,ssize,STRING dbuffer)
.code
;
#ifdef zlib_compress2.sbuffer
#undef zlib_compress2.sbuffer
#endif
#define zlib_compress2.sbuffer ebp+8	; exposes function argument 'sbuffer'
;
;
#ifdef zlib_compress2.ssize
#undef zlib_compress2.ssize
#endif
#define zlib_compress2.ssize ebp+12	; exposes function argument 'ssize'
;
;
#ifdef zlib_compress2.dbuffer
#undef zlib_compress2.dbuffer
#endif
#define zlib_compress2.dbuffer ebp+16	; exposes function argument 'dbuffer'
;
align 16
_zlib_compress2.p2pfile@12:
;  *****
;  *****  FUNCTION  zlib_compress2 ()  *****
;  *****
func28.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	mov	ecx,2				;;; ..
	xor	eax,eax			;;; ...
A.209:
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.209			;;; .....
	push	eax				;;; ......
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,184			;;; i114a
;
funcBody28.p2pfile:
;
; [1615] dsize = ssize+75
#ifdef zlib_compress2.dsize
#undef zlib_compress2.dsize
#endif
#define zlib_compress2.dsize ebp-40	; exposes local variable 'dsize'
;
	mov	eax,d[ebp+12]			;;; i665
	add	eax,75			;;; i775
	mov	d[ebp-40],eax			;;; i670
;
; [1616] dbuffer = NULL$(dsize)
	sub	esp,64			;;; i487
	mov	eax,d[ebp-40]			;;; i665
	mov	d[esp],eax			;;; i887
	call	%_null.d			;;; i573
	add	esp,64			;;; i600
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1617] IFT zlib_compress (sbuffer,ssize,&dbuffer,&dsize,$$Z_BEST_COMPRESSION) THEN
	mov	eax,d[ebp+16]			;;; i642
; .xstk28.0000 = ebp-48	; internal variable
	mov	d[ebp-48],eax			;;; i670
	lea	eax,[ebp-40]			;;; i642
; .xstk28.0001 = ebp-56	; internal variable
	mov	d[ebp-56],eax			;;; i670
	push	9			;;; i656a
	push	[ebp-56]			;;; i674a
	push	[ebp-48]			;;; i674a
	push	[ebp+12]			;;; i674a
	push	[ebp+8]			;;; i674a
	call	func27.p2pfile			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.00D7.p2pfile			;;; i221
;
; [1618] RETURN dsize
	mov	eax,d[ebp-40]			;;; i665
	jmp	end.func28.p2pfile			;;; i258
;
; [1619] ELSE
	jmp	end.if.00D7.p2pfile			;;; i107
else.00D7.p2pfile:
;
; [1620] dbuffer = ""
	xor	eax,eax			;;; i3
	lea	ebx,[ebp+16]			;;; i5
	mov	esi,d[ebx]			;;; i6a
	mov	d[ebx],eax			;;; i6b
	call	%____free			;;; i6c
;
; [1621] RETURN 0
	mov	eax,0			;;; i659
	jmp	end.func28.p2pfile			;;; i258
;
; [1622] END IF
end.if.00D7.p2pfile:
;
; [1623] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.zlib_compress2.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func28.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret	12			;;; i111a
;-peep
;  *****
;  *****  END FUNCTION  zlib_compress2 ()  *****
;  *****
;
; [1625] FUNCTION InitWSA ()
.code
align 16
_InitWSA.p2pfile@0:
;  *****
;  *****  FUNCTION  InitWSA ()  *****
;  *****
func2.p2pfile:
	push	ebp			;;; i112
	mov	ebp,esp		;;; i113
	sub	esp,8			;;; i114
	push	esi			;;; save esi
	push	edi			;;; save edi
	push	ebx			;;; save ebx
  sub esp,16      ;;; reserved for unwind handler
;
;	#### Begin Local Initialization Code ####
	xor	eax,eax		;;; .
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
	push	eax			;;; ..
;	#### End Local Initialization Code ####
;
;	################################################################################
;	### *** IMPORTANT *** - If hand-optimizing by eliminating the initialization ###
;	### code above, the first 'sub esp,____' line below must be uncommented      ###
;	### and the second must be either deleted or commented out.                  ###
;	### !!! Failure to do so will cause the resultant program to crash !!!       ###
;	################################################################################
;
;	sub esp,220
	sub	esp,192			;;; i114a
;
;	#### Begin Composite Initialization Code ####
	mov	ecx,12				;;; ..
	xor	eax,eax			;;; ...
A.213:
	push	eax, eax, eax, eax
	push	eax, eax, eax, eax
	dec	ecx					;;; ....
	jnz	< A.213			;;; .....
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
	push	eax				;;; ......
;	#### End Composite Initialization Code ####
;
	lea	eax,[esp]			;;; i125
	mov	d[ebp-44],eax			;;; i670
funcBody2.p2pfile:
;
; [1626] WSADATA wsadata
; .composites = ebp-40	; internal variable
#ifdef InitWSA.wsadata
#undef InitWSA.wsadata
#endif
#define InitWSA.wsadata ebp-44	; exposes local variable 'wsadata'
;
;
; [1629] version = 2 OR (2 << 8)
#ifdef InitWSA.version
#undef InitWSA.version
#endif
#define InitWSA.version ebp-48	; exposes local variable 'version'
;
	mov	eax,2			;;; i659
	shl	eax,8			;;; i835
	mov	ebx,2			;;; i659
	or	eax,ebx			;;; i763
	mov	d[ebp-48],eax			;;; i670
;
; [1630] IF WSAStartup (version, &wsadata) THEN RETURN $$FALSE
;
; [0] EXTERNAL SFUNCTION  WSAStartup       (version, addrWSADATA)
	mov	eax,d[ebp-44]			;;; i642
	push	eax			;;; i667a
	push	[ebp-48]			;;; i674a
	call	_WSAStartup@8			;;; i619
	test	eax,eax			;;; i220
	jz	>> else.00D8.p2pfile			;;; i221
	mov	eax,0			;;; i659
	jmp	end.func2.p2pfile			;;; i258
else.00D8.p2pfile:
end.if.00D8.p2pfile:
;
; [1631] IF wsadata.wVersion != version THEN RETURN $$FALSE
	mov	eax,d[ebp-44]			;;; i665
	movzx	eax,w[eax]			;;; i313b
	mov	ebx,d[ebp-48]			;;; i665
	cmp	eax,ebx			;;; i684a
	je	>> else.00D9.p2pfile			;;; i219
	mov	eax,0			;;; i659
	jmp	end.func2.p2pfile			;;; i258
else.00D9.p2pfile:
end.if.00D9.p2pfile:
;
; [1633] ResetSendTotal()
	call	func1C.p2pfile			;;; i619
;
; [1634] ResetListenTotal()
	call	func1D.p2pfile			;;; i619
;
; [1635] RETURN $$TRUE
	mov	eax,-1			;;; i659
	jmp	end.func2.p2pfile			;;; i258
;
; [1636] END FUNCTION
	xor	eax,eax			;;; i862
align 8
end.InitWSA.p2pfile:  ;;; Function end label for Assembly Programmers.
end.func2.p2pfile:
	lea	esp,[ebp-20]				;;; i110
	pop	ebx				;;; restore ebx
	pop	edi				;;; restore edi
	pop	esi				;;; restore esi
	leave					;;; replaces 'mov esp,ebp' 'pop ebp'
	ret						;;; i111d
;-peep
;  *****
;  *****  END FUNCTION  InitWSA ()  *****
;  *****
;
; [1637] END PROGRAM
;<peep
end_program.p2pfile:
	push	ebp			;;; i128
	mov	ebp,esp			;;; i129
	sub	esp,128			;;; i130
	mov	esi,d[%%%table.p2pfile]			;;; i663a
	call	%_FreeArray			;;; i424
	mov	esi,d[%%%setargv$.p2pfile]			;;; i663a
	call	%_FreeArray			;;; i424
	mov	esi,[%1A%u$.p2pfile]			;;; i663a
	call	%____free			;;; i423
	mov	esi,[%1A%l$.p2pfile]			;;; i663a
	call	%____free			;;; i423
	mov	esi,[%2A%buffer.p2pfile]			;;; i663a
	call	%____free			;;; i423
	call	_XxxTerminate@0
	mov	esp,ebp			;;; i132
	pop	ebp			;;; i133
	ret				;;; i134
;
InitSharedComposites.p2pfile:
	ret				;;; i143
;
.code
; ########################
; #####  WinMain ()  #####
; ########################
align 8
_main:												; C entry label
_WinMain:											; Windows entry label
_WinMain@16:									; Windows entry label
	push ebp
	mov ebp,esp
	push addr %_StartApplication
	call _Xit@4
	call _XxxTerminate@0
	mov esp,ebp
	pop ebp
	ret
;
;;;  *****  DEFINE '.bss' SECTION LIMITS  *****
;
align 8
data section 'p2pfile$aaaaa'
%_begin_external_data_p2pfile dd ?
;
align 8
data section 'p2pfile$zzzzz'
%_end_external_data_p2pfile dd ?
;
;
;;;  *****  DEFINE LITERAL STRINGS  *****
.const
align 8
;
dd 24, 0, 7, 0x80130001
@_string.0029.p2pfile:
db	"p2pfile"
db	1 dup 0
;
dd 24, 0, 3, 0x80130001
@_string.002A.p2pfile:
db	"301"
db	5 dup 0
;
dd 32, 0, 9, 0x80130001
@_string.002B.p2pfile:
db	"xst_s.lib"
db	7 dup 0
;
dd 32, 0, 8, 0x80130001
@_string.002C.p2pfile:
db	"kernel32"
db	8 dup 0
;
dd 24, 0, 7, 0x80130001
@_string.002D.p2pfile:
db	"wsock32"
db	1 dup 0
;
dd 24, 0, 4, 0x80130001
@_string.002E.p2pfile:
db	"zlib"
db	4 dup 0
;
dd 32, 0, 8, 0x80130001
@_string.002F.p2pfile:
db	"advapi32"
db	8 dup 0
;
dd 24, 0, 6, 0x80130001
@_string.0030.p2pfile:
db	"msvcrt"
db	2 dup 0
;
dd 32, 0, 12, 0x80130001
@_string.0031.p2pfile:
db	"p2pfiled.dec"
db	4 dup 0
;
dd 24, 0, 6, 0x80130001
@_string.0072.p2pfile:
db	"listen"
db	2 dup 0
;
dd 24, 0, 3, 0x80130001
@_string.0073.p2pfile:
db	"get"
db	5 dup 0
;
dd 24, 0, 4, 0x80130001
@_string.0078.p2pfile:
db	"send"
db	4 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.007F.p2pfile:
db	"* Shutting down.."
db	7 dup 0
;
dd 64, 0, 44, 0x80130001
@_string.0089.p2pfile:
db	"* authentication failed",0x0D,0x0A,"* connection closed"
db	4 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00A5.p2pfile:
db	"m"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00A6.p2pfile:
db	"l"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00A7.p2pfile:
db	"a"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00A8.p2pfile:
db	"p"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00A9.p2pfile:
db	"s"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00AA.p2pfile:
db	"d"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00AB.p2pfile:
db	"o"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00AC.p2pfile:
db	"e"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00AD.p2pfile:
db	"b"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00B0.p2pfile:
db	"h"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00B1.p2pfile:
db	"r"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00B3.p2pfile:
db	"c"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.00B5.p2pfile:
db	"z"
db	7 dup 0
;
dd 32, 0, 9, 0x80130001
@_string.00BF.p2pfile:
db	0x0D,0x0A,"Usage: "
db	7 dup 0
;
dd 56, 0, 39, 0x80130001
@_string.00C0.p2pfile:
db	" -m -l -a -p -s -d -o -e -c -b -z -r -h"
db	1 dup 0
;
dd 64, 0, 45, 0x80130001
@_string.00C1.p2pfile:
db	" -m mode  Operating mode. LISTEN, GET or SEND"
db	3 dup 0
;
dd 56, 0, 33, 0x80130001
@_string.00C2.p2pfile:
db	" -l pass  Authentication password"
db	7 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.00C3.p2pfile:
db	" -a ip    Host IP Address"
db	7 dup 0
;
dd 48, 0, 28, 0x80130001
@_string.00C4.p2pfile:
db	" -p n     Client/Server Port"
db	4 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.00C5.p2pfile:
db	" -s file  Source filename"
db	7 dup 0
;
dd 48, 0, 30, 0x80130001
@_string.00C6.p2pfile:
db	" -d file  Destination filename"
db	2 dup 0
;
dd 88, 0, 64, 0x80130001
@_string.00C7.p2pfile:
db	" -o n     Start Offset. Begin reading at this offset within file"
db	8 dup 0
;
dd 72, 0, 48, 0x80130001
@_string.00C8.p2pfile:
db	" -e n     End Offset. End reading at this offset"
db	8 dup 0
;
dd 64, 0, 47, 0x80130001
@_string.00C9.p2pfile:
db	" -c       Enable CRC32 verification on transfer"
db	1 dup 0
;
dd 56, 0, 35, 0x80130001
@_string.00CA.p2pfile:
db	" -r       Encrypt data, use with -l"
db	5 dup 0
;
dd 88, 0, 67, 0x80130001
@_string.00CB.p2pfile:
db	" -b mb    Block size per read->send, adjust to suit connection type"
db	5 dup 0
;
dd 64, 0, 43, 0x80130001
@_string.00CC.p2pfile:
db	" -z       Enable zlib compression per block"
db	5 dup 0
;
dd 48, 0, 27, 0x80130001
@_string.00CD.p2pfile:
db	" -h       Display this page"
db	5 dup 0
;
dd 48, 0, 27, 0x80130001
@_string.00D7.p2pfile:
db	0x0D,0x0A,"* unable to create socket"
db	5 dup 0
;
dd 40, 0, 23, 0x80130001
@_string.00D9.p2pfile:
db	0x0D,0x0A,"* Press 'Esc' to Quit"
db	1 dup 0
;
dd 40, 0, 19, 0x80130001
@_string.00DA.p2pfile:
db	0x0D,0x0A,"*** listening on "
db	5 dup 0
;
dd 24, 0, 6, 0x80130001
@_string.00DB.p2pfile:
db	" port "
db	2 dup 0
;
dd 24, 0, 4, 0x80130001
@_string.00DC.p2pfile:
db	" ***"
db	4 dup 0
;
dd 48, 0, 28, 0x80130001
@_string.00E0.p2pfile:
db	"* accepted connection from: "
db	4 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.00E1.p2pfile:
db	"* connection lost"
db	7 dup 0
;
dd 40, 0, 18, 0x80130001
@_string.00E7.p2pfile:
db	"* sending file to "
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.00E8.p2pfile:
db	": "
db	6 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.00EA.p2pfile:
db	"* transfer completed: "
db	2 dup 0
;
dd 40, 0, 19, 0x80130001
@_string.00EB.p2pfile:
db	"* transfer failed: "
db	5 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.00ED.p2pfile:
db	"* receiving file from "
db	2 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.00EF.p2pfile:
db	"* invalid transfer header"
db	7 dup 0
;
dd 40, 0, 16, 0x80130001
@_string.00F0.p2pfile:
db	"* invalid header"
db	8 dup 0
;
dd 48, 0, 29, 0x80130001
@_string.00F1.p2pfile:
db	"* attempted connection failed"
db	3 dup 0
;
dd 48, 0, 26, 0x80130001
@_string.00F9.p2pfile:
db	"* invalid transfer request"
db	6 dup 0
;
dd 32, 0, 13, 0x80130001
@_string.0105.p2pfile:
db	"* file size: "
db	3 dup 0
;
dd 24, 0, 6, 0x80130001
@_string.0106.p2pfile:
db	" bytes"
db	2 dup 0
;
dd 40, 0, 23, 0x80130001
@_string.0107.p2pfile:
db	"* total bytes to send: "
db	1 dup 0
;
dd 40, 0, 16, 0x80130001
@_string.0108.p2pfile:
db	"* transfer error"
db	8 dup 0
;
dd 40, 0, 16, 0x80130001
@_string.0112.p2pfile:
db	"* transfer rate:"
db	8 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.0113.p2pfile:
db	" bytes per second"
db	7 dup 0
;
dd 40, 0, 19, 0x80130001
@_string.0114.p2pfile:
db	"* total data sent: "
db	5 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0115.p2pfile:
db	"kb"
db	6 dup 0
;
dd 72, 0, 48, 0x80130001
@_string.0116.p2pfile:
db	"* access to file denied or file does not exist: "
db	8 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.011F.p2pfile:
db	"* transfer header invalid"
db	7 dup 0
;
dd 64, 0, 44, 0x80130001
@_string.0120.p2pfile:
db	"* unable to open file or file does not exist"
db	4 dup 0
;
dd 40, 0, 20, 0x80130001
@_string.0121.p2pfile:
db	"* no data to receive"
db	4 dup 0
;
dd 48, 0, 24, 0x80130001
@_string.0122.p2pfile:
db	"* total bytes to write: "
db	8 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0129.p2pfile:
db	"wb"
db	6 dup 0
;
dd 40, 0, 20, 0x80130001
@_string.012A.p2pfile:
db	"* transfer aborted *"
db	4 dup 0
;
dd 96, 0, 74, 0x80130001
@_string.012D.p2pfile:
db	"* decompression error: source blk size different from destination blk size"
db	6 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.0130.p2pfile:
db	"* crc error on transfer: "
db	7 dup 0
;
dd 32, 0, 11, 0x80130001
@_string.0131.p2pfile:
db	"*  offset: "
db	5 dup 0
;
dd 24, 0, 7, 0x80130001
@_string.0132.p2pfile:
db	" size: "
db	1 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.0133.p2pfile:
db	"*  remote data crc:   "
db	2 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.0134.p2pfile:
db	"*  received data crc: "
db	2 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.0135.p2pfile:
db	"* no data to receive on: "
db	7 dup 0
;
dd 48, 0, 24, 0x80130001
@_string.0136.p2pfile:
db	"* total bytes received: "
db	8 dup 0
;
dd 40, 0, 23, 0x80130001
@_string.0141.p2pfile:
db	"*** compression enabled"
db	1 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.0142.p2pfile:
db	"*** encryption enabled"
db	2 dup 0
;
dd 56, 0, 33, 0x80130001
@_string.0143.p2pfile:
db	"*** checksum verification enabled"
db	7 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.0144.p2pfile:
db	0x0D,0x0A,"* connecting..."
db	7 dup 0
;
dd 32, 0, 15, 0x80130001
@_string.0146.p2pfile:
db	"* connected to "
db	1 dup 0
;
dd 32, 0, 9, 0x80130001
@_string.0147.p2pfile:
db	" on port "
db	7 dup 0
;
dd 40, 0, 18, 0x80130001
@_string.0148.p2pfile:
db	0x0D,0x0A,"* transfering..."
db	6 dup 0
;
dd 40, 0, 19, 0x80130001
@_string.0149.p2pfile:
db	"* unable to connect"
db	5 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.014C.p2pfile:
db	"* connection to host lost"
db	7 dup 0
;
dd 32, 0, 8, 0x80130001
@_string.0158.p2pfile:
db	"* file: "
db	8 dup 0
;
dd 48, 0, 29, 0x80130001
@_string.017C.p2pfile:
db	"error writing buffer to file",0x0A
db	3 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0181.p2pfile:
db	"rb"
db	6 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.0183.p2pfile:
db	"unable to open file '%s'",0x0A
db	7 dup 0
;
dd 40, 0, 21, 0x80130001
@_string.0185.p2pfile:
db	0x0A,"unable to close file"
db	3 dup 0
;
dd 24, 0, 7, 0x80130001
@_string.01A7.p2pfile:
db	"* port "
db	1 dup 0
;
dd 48, 0, 31, 0x80130001
@_string.01A8.p2pfile:
db	" in use, waiting... (wsa error "
db	1 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.01A9.p2pfile:
db	")"
db	7 dup 0
;
dd 32, 0, 12, 0x80130001
@_string.01B0.p2pfile:
db	"* wsa error "
db	4 dup 0
;
dd 32, 0, 13, 0x80130001
@_string.01C1.p2pfile:
db	"* wsa error: "
db	3 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.01D8.p2pfile:
db	0x5C
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.01DA.p2pfile:
db	"/"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.01E4.p2pfile:
db	"."
db	7 dup 0
;
dd 64, 0, 43, 0x80130001
@_string.021E.p2pfile:
db	"~!@#$%^&*()_+|{}:",0x22,"<>?`1234567890-=",0x5C,"[];',./",0x00
db	5 dup 0
;
dd 64, 0, 43, 0x80130001
@_string.021F.p2pfile:
db	"`1234567890-=",0x5C,"[];',./~!@#$%^&*()_+|{}:",0x22,"<>?",0x00
db	5 dup 0
;
dd 32, 0, 12, 0x80130001
@_string.022D.p2pfile:
db	"advapi32.dll"
db	4 dup 0
;
dd 56, 0, 37, 0x80130001
@_string.022F.p2pfile:
db	"LoadLibraryA : advapi32.dll not found"
db	3 dup 0
;
dd 32, 0, 12, 0x80130001
@_string.0230.p2pfile:
db	"CryptDecrypt"
db	4 dup 0
;
dd 64, 0, 40, 0x80130001
@_string.0231.p2pfile:
db	"GetProcAddress(): CryptDecrypt Not Found"
db	8 dup 0
;
dd 40, 0, 21, 0x80130001
@_string.0237.p2pfile:
db	"CryptAcquireContext()"
db	3 dup 0
;
dd 64, 0, 41, 0x80130001
@_string.0238.p2pfile:
db	"a password or key required for decryption"
db	7 dup 0
;
dd 40, 0, 21, 0x80130001
@_string.023A.p2pfile:
db	"Key BLOB length error"
db	3 dup 0
;
dd 40, 0, 16, 0x80130001
@_string.023B.p2pfile:
db	"CryptImportKey()"
db	8 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.023D.p2pfile:
db	"CryptCreateHash()"
db	7 dup 0
;
dd 32, 0, 15, 0x80130001
@_string.023E.p2pfile:
db	"CryptHashData()"
db	1 dup 0
;
dd 40, 0, 16, 0x80130001
@_string.023F.p2pfile:
db	"CryptDeriveKey()"
db	8 dup 0
;
dd 32, 0, 14, 0x80130001
@_string.0245.p2pfile:
db	"CryptDecrypt()"
db	2 dup 0
;
dd 40, 0, 21, 0x80130001
@_string.0246.p2pfile:
db	"CryptDestroyKey error"
db	3 dup 0
;
dd 48, 0, 25, 0x80130001
@_string.0247.p2pfile:
db	"CryptReleaseContext error"
db	7 dup 0
;
dd 48, 0, 27, 0x80130001
@_string.0248.p2pfile:
db	"error: decrypt_buffer() %s",0x0A
db	5 dup 0
;
dd 56, 0, 38, 0x80130001
@_string.0249.p2pfile:
db	"unknown error during decrypt_buffer()",0x0A
db	2 dup 0
;
dd 56, 0, 38, 0x80130001
@_string.0256.p2pfile:
db	"LoadLibraryA(): advapi32.dll not found"
db	2 dup 0
;
dd 32, 0, 12, 0x80130001
@_string.0257.p2pfile:
db	"CryptEncrypt"
db	4 dup 0
;
dd 64, 0, 42, 0x80130001
@_string.0258.p2pfile:
db	"GetProcAddress(): CryptEncrypt() Not Found"
db	6 dup 0
;
dd 40, 0, 17, 0x80130001
@_string.025B.p2pfile:
db	"CryptGenKey error"
db	7 dup 0
;
dd 72, 0, 52, 0x80130001
@_string.025E.p2pfile:
db	"CryptGenKey(): ",0x0A,"unable to create exchange public key"
db	4 dup 0
;
dd 88, 0, 70, 0x80130001
@_string.025F.p2pfile:
db	"CryptGetUserKey(): ",0x0A,"user public key is not available and may not exist"
db	2 dup 0
;
dd 64, 0, 46, 0x80130001
@_string.0262.p2pfile:
db	"CryptExportKey(): ",0x0A,"Error computing BLOB length"
db	2 dup 0
;
dd 56, 0, 34, 0x80130001
@_string.0263.p2pfile:
db	"CryptExportKey(): BLOB length zero"
db	6 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.0264.p2pfile:
db	"CryptExportKey() error"
db	2 dup 0
;
dd 40, 0, 23, 0x80130001
@_string.0265.p2pfile:
db	"CryptCreateHash() error"
db	1 dup 0
;
dd 40, 0, 21, 0x80130001
@_string.0266.p2pfile:
db	"CryptHashData() error"
db	3 dup 0
;
dd 40, 0, 22, 0x80130001
@_string.0267.p2pfile:
db	"CryptDeriveKey() error"
db	2 dup 0
;
dd 48, 0, 24, 0x80130001
@_string.0268.p2pfile:
db	"CryptDestroyHash() error"
db	8 dup 0
;
dd 32, 0, 14, 0x80130001
@_string.026E.p2pfile:
db	"CryptEncrypt()"
db	2 dup 0
;
dd 48, 0, 27, 0x80130001
@_string.026F.p2pfile:
db	"error: encrypt_buffer() %s",0x0A
db	5 dup 0
;
dd 56, 0, 38, 0x80130001
@_string.0270.p2pfile:
db	"unknown error during encrypt_buffer()",0x0A
db	2 dup 0
;
dd 64, 0, 47, 0x80130001
@_string.0276.p2pfile:
db	"zlib_decompress(): unable to decompress buffer",0x0A
db	1 dup 0
;
dd 64, 0, 43, 0x80130001
@_string.027D.p2pfile:
db	"zlib_compress(): unable to compress buffer",0x0A
db	5 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0297.p2pfile:
db	";"
db	7 dup 0
;
dd 24, 0, 5, 0x80130001
@_string.0D56.p2pfile:
db	"1.2.1"
db	3 dup 0
;
dd 64, 0, 42, 0x80130001
@_string.0F04.p2pfile:
db	"Microsoft Base Cryptographic Provider v1.0"
db	6 dup 0
;
dd 64, 0, 46, 0x80130001
@_string.0F08.p2pfile:
db	"Microsoft Enhanced Cryptographic Provider v1.0"
db	2 dup 0
;
dd 64, 0, 46, 0x80130001
@_string.0F0B.p2pfile:
db	"Microsoft RSA Signature Cryptographic Provider"
db	2 dup 0
;
dd 64, 0, 45, 0x80130001
@_string.0F0F.p2pfile:
db	"Microsoft RSA SChannel Cryptographic Provider"
db	3 dup 0
;
dd 64, 0, 41, 0x80130001
@_string.0F13.p2pfile:
db	"Microsoft Base DSS Cryptographic Provider"
db	7 dup 0
;
dd 80, 0, 60, 0x80130001
@_string.0F17.p2pfile:
db	"Microsoft Base DSS and Diffie-Hellman Cryptographic Provider"
db	4 dup 0
;
dd 88, 0, 64, 0x80130001
@_string.0F1B.p2pfile:
db	"Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider"
db	8 dup 0
;
dd 64, 0, 44, 0x80130001
@_string.0F1F.p2pfile:
db	"Microsoft DH SChannel Cryptographic Provider"
db	4 dup 0
;
dd 64, 0, 41, 0x80130001
@_string.0F23.p2pfile:
db	"Microsoft Base Smart Card Crypto Provider"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FB5.p2pfile:
db	"O"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FB7.p2pfile:
db	"G"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FB9.p2pfile:
db	"D"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FBB.p2pfile:
db	"S"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FBD.p2pfile:
db	"P"
db	7 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FBF.p2pfile:
db	"AR"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FC1.p2pfile:
db	"AI"
db	6 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.0FC3.p2pfile:
db	"A"
db	7 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FC6.p2pfile:
db	"OA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FC8.p2pfile:
db	"OD"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FCA.p2pfile:
db	"AU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FCC.p2pfile:
db	"AL"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FCE.p2pfile:
db	"OU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FD0.p2pfile:
db	"OL"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FD2.p2pfile:
db	"CI"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FD4.p2pfile:
db	"OI"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FD6.p2pfile:
db	"NP"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FD8.p2pfile:
db	"IO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FDA.p2pfile:
db	"ID"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FDC.p2pfile:
db	"SA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FDE.p2pfile:
db	"FA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FE0.p2pfile:
db	"RP"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FE2.p2pfile:
db	"WP"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FE4.p2pfile:
db	"CC"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FE6.p2pfile:
db	"DC"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FE8.p2pfile:
db	"LC"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FEA.p2pfile:
db	"SW"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FEC.p2pfile:
db	"LO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FEE.p2pfile:
db	"DT"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FF0.p2pfile:
db	"CR"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FF2.p2pfile:
db	"RC"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FF4.p2pfile:
db	"WD"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FF6.p2pfile:
db	"WO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FF8.p2pfile:
db	"SD"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FFA.p2pfile:
db	"GA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FFC.p2pfile:
db	"GR"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.0FFE.p2pfile:
db	"GW"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1000.p2pfile:
db	"GX"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1003.p2pfile:
db	"FR"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1005.p2pfile:
db	"FW"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1007.p2pfile:
db	"FX"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1009.p2pfile:
db	"KA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.100B.p2pfile:
db	"KR"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.100D.p2pfile:
db	"KW"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.100F.p2pfile:
db	"KX"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1012.p2pfile:
db	"DA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1014.p2pfile:
db	"DG"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1016.p2pfile:
db	"DU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1018.p2pfile:
db	"ED"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.101A.p2pfile:
db	"DD"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.101D.p2pfile:
db	"BA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.101F.p2pfile:
db	"BG"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1021.p2pfile:
db	"BU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1023.p2pfile:
db	"LA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1025.p2pfile:
db	"LG"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1027.p2pfile:
db	"AO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1029.p2pfile:
db	"BO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.102B.p2pfile:
db	"PO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.102D.p2pfile:
db	"SO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1030.p2pfile:
db	"PS"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1032.p2pfile:
db	"CO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1034.p2pfile:
db	"CG"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1036.p2pfile:
db	"SY"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1038.p2pfile:
db	"PU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.103B.p2pfile:
db	"RE"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.103D.p2pfile:
db	"IU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.103F.p2pfile:
db	"NU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1041.p2pfile:
db	"SU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1044.p2pfile:
db	"AN"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1047.p2pfile:
db	"CA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1049.p2pfile:
db	"RS"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.104B.p2pfile:
db	"EA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.104D.p2pfile:
db	"PA"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.104F.p2pfile:
db	"RU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1051.p2pfile:
db	"LS"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1053.p2pfile:
db	"NS"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1055.p2pfile:
db	"RD"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1057.p2pfile:
db	"NO"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.1059.p2pfile:
db	"MU"
db	6 dup 0
;
dd 24, 0, 2, 0x80130001
@_string.105B.p2pfile:
db	"LU"
db	6 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.1065.p2pfile:
db	":"
db	7 dup 0
;
dd 24, 0, 1, 0x80130001
@_string.1067.p2pfile:
db	"("
db	7 dup 0
;
dd 24, 0, 4, 0x80130001
@_string.112E.p2pfile:
db	"none"
db	4 dup 0
;
dd 24, 0, 3, 0x80130001
@_string.1132.p2pfile:
db	"Rea"
db	5 dup 0
;
dd 32, 0, 15, 0x80130001
@_string.StartLibrary.p2pfile:
db	"%_StartLibrary_"
db	1 dup 0
