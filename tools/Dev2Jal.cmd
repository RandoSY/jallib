/* ------------------------------------------------------------------------ */
/* Title: Dev2Jal.cmd - Create JalV2 device include files for flash PICs    */
/*                                                                          */
/* Author: Rob Hamerling, Copyright (c) 2008..2008, all rights reserved.    */
/*                                                                          */
/* Adapted-by:                                                              */
/*                                                                          */
/* Compiler: >=2.4g                                                         */
/*                                                                          */
/* This file is part of jallib  http://jallib.googlecode.com                */
/* Released under the BSD license                                           */
/*              http://www.opensource.org/licenses/bsd-license.php          */
/*                                                                          */
/* Description: Rexx script to create device include files for JALV2,       */
/*              and the file Chipdef.Jal, included by each of these.        */
/*              Apart from declaration of all ports and pins of the chip    */
/*              the include files will contain shadowing procedures to      */
/*              prevent the 'read-modify-write' problems of midrange PICs   */
/*              and for the 18F force the use of LATx in stead of PORTx.    */
/*              In addition some device dependent procedures are provided   */
/*              for common operations, like 'enable-digital-io.             */
/*                                                                          */
/* Sources:  MPLAB .dev and .lkr files                                      */
/*                                                                          */
/* Notes:                                                                   */
/*  - Written in 'Classic Rexx' style, but requires 'Object Rexx' to run.   */
/*  - Summary of internal changes is kept in 'changes.txt' (not published). */
/*  - The script contains some test and debugging code.                     */
/*                                                                          */
/* ------------------------------------------------------------------------ */
   ScriptVersion   = '0.0.41'                   /*                          */
   ScriptAuthor    = 'Rob Hamerling'            /* global constants         */
   CompilerVersion = '>=2.4g'                   /*                          */
/* ------------------------------------------------------------------------ */

say 'Dev2Jal version' ScriptVersion '  -  ' ScriptAuthor
say 'Creating JALV2 include files for PIC specifications ...'

signal on syntax name syntax_catch              /* catch syntax error       */
signal on error  name error_catch               /* catch execution errors   */

parse upper arg destination                     /* where to store jal files */
if destination = 'PROD' then do
  dstdir = '/jallib/unvalidated/include/device/'  /* production base */
end
else if destination = 'TEST' then do
  dstdir = '/jallib/test/'                      /* test base */
end
else do
  say 'Error: Required parameter missing: "prod" or "test"'
  return 1
end

basedir  = 'x:/mplab814/'                       /* MPLAB base directory  */
devdir   = basedir'mplab_ide/device/'           /* dir with .dev files   */
lkrdir   = basedir'mpasm_suite/lkr/'            /* dir with .lkr files   */
wildcard = 'PIC1*.dev'                          /* selected device files */

call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs                               /* load Rexx utilities   */

ChipFile = dstdir'chipdef.jal'                  /* common file */

call SysFileTree devdir||wildcard, dir, 'FO'    /* get list of filespecs */
if dir.0 < 1 then do
  say 'No appropriate device files found in directory' devdir
  return 1
end

if stream(ChipFile, 'c', 'open write replace') \= 'READY:' then do
  Say 'Error: Could not create include file' ChipFile
  return 1
end
call list_chip_const                            /* hdr of common specs   */

ListCount = 0                                   /* # created .jal files */

do i=1 to dir.0                                 /* all entries */
                                                /* init for each new PIC */
  Dev.0       = 0                               /* .dev file contents    */
  Lkr.0       = 0                               /* .lkr file contents    */
  Ram.0       = 0                               /* sfr usage and mirroring */
  Name.       = '-'                             /* register and pin names */
  CfgAddr.0   = 0                               /* )          */
  IDAddr.0    = 0                               /* ) decimal! */

  parse lower var dir.i dir.i                   /* LOWER case !!!!*/
  parse value filespec('Name', dir.i) with 'pic' PicName '.dev'
  if PicName = '' then do
    Say 'Error: Could not derive PIC name from filespec: "'dir.i'"'
    iterate                                     /* next entry */
  end

/* ------- select appropriate processing procedure -------- */

  rx = 1                                        /* assume not processed */

  if left(PicName,3) = '10f' then do            /* 12-bit core */
    rx = dev2Jal12(dir.i, lkrdir)
  end

  else if left(PicName,3) = '12f'  |,
          left(PicName,4) = '12hv' |,
          left(PicName,3) = '16f'  |,
          left(PicName,4) = '16hv' |,
          left(PicName,4) = '16lf' then do      /* 14- (or 12)-bits core */
    rx = dev2Jal14(dir.i, lkrdir)
  end

  else if left(PicName,3) = '18f'  |,
          left(PicName,4) = '18lf' then do      /* 16 bit core */
    rx = dev2Jal16(dir.i, lkrdir)
  end

  if rx = 0 then do                             /* success */
    ListCount = ListCount + 1;                  /* count */
  end

end

if test = 'PROD' then do
  'del 16f1937.jal'                             /* do not distribute */
end

call lineout ChipFile, '--'
call stream  ChipFile, 'c', 'close'             /* release file */

say 'PIC device include files for JALV2 created:',
  listcount 'of' dir.0 '.dev files'
return 0


/* ==================================================================== */
/*                 1 2 - B I T S   C O R E                              */
/* ==================================================================== */
dev2jal12: procedure expose ScriptVersion ScriptAuthor CompilerVersion,
                            PicName DstDir,
                            Dev. Lkr. Ram. Name. ,
                            CfgAddr. IDAddr. ChipFile

MAXRAM     = 128                                /* range 0..127 */
BANKSIZE   = 32                                 /* 0x0020 */
PAGESIZE   = 512                                /* 0x0200 */
DataStart  = '0x400'                            /* default for 12-bit core */
Core       = 12                                 /* 12 bits */
NumBanks   = 1                                  /* default */
StackDepth = 2                                  /* default */

DevFile = arg(1)                                /* .dev file */
call File_read_dev                              /* read devfile */
if Dev.0 = 0 then do                            /* zero records */
  Say 'Error: file' DevFile 'not found'
  return 1                                      /* problem */
end

call load_config_info                           /* collect cfg info + core */

if Core \= 12 then do                           /* wrong core */
  say 'Script error: Wrong script for!' PicName
  return 1                                      /* done */
end

say PicName                                     /* progress signal */

call load_stackdepth                            /* check stack depth */

LkrFile = arg(2)||PicName'_g.lkr'               /* generic .lkr file */
call File_read_lkr                              /* read .lkr file */
if Lkr.0 = 0 then do                            /* zero records */
  Say 'Error: no .lkr file found'
  return 1
end

call load_sfr1x                                 /* load sfr + mirror info */
call load_IDAddr                                /* load ID addresses */

parse lower var PicName JalFile                 /* filename lower case */
JalFile = dstdir||Jalfile'.jal'                 /* .jal file */
if stream(JalFile, 'c', 'open write replace') \= 'READY:' then do
  Say 'Error: Could not create include file' JalFile
  return 1
end

call list_head                                  /* header */
call list_fuses_words1x                         /* config memory */
call list_IDmem                                 /* ID memory */
call list_sfr1x                                 /* register info */
call list_analog_functions                      /* register info */
call list_fuses_bits                            /* fuses details */
call stream JalFile, 'c', 'close'               /* done! */
return 0


/* ==================================================================== */
/*                       1 4 - B I T S   C O R E                        */
/* ==================================================================== */
dev2jal14: procedure expose ScriptVersion ScriptAuthor CompilerVersion,
                            PicName DstDir,
                            Dev. Lkr. Ram. Name. ,
                            CfgAddr. IDAddr. ChipFile

MAXRAM     = 512                                /* range 0..511 */
BANKSIZE   = 128                                /* 0x0080 */
PAGESIZE   = 2048                               /* 0x0800 */
DataStart  = '0x2100'                           /* default for 14-bit core */
Core       = 14                                 /* 14 bits */
NumBanks   = 1                                  /* default */
StackDepth = 8                                  /* default */

DevFile = arg(1)                                /* .dev file */
call File_read_dev                              /* read devfile */
if Dev.0 = 0 then do                            /* zero records */
  Say 'Error: file' DevFile 'not found'
  return 1                                      /* problem */
end

call load_config_info                           /* collect cfg info + core */
if Core = 12 then do                            /* 12-bits core */
  rx = Dev2Jal12(arg(1),arg(2))                 /* try other procedure */
  return rx                                     /* done */
end

if Core \= 14 then do                           /* wrong core */
  say 'Script error: Wrong script for this device!'
  return 1                                      /* done */
end

say PicName                                     /* progress signal */

call load_stackdepth                            /* check stack depth */

LkrFile = arg(2)||PicName'_g.lkr'               /* generic .lkr file */
call File_read_lkr                              /* read .lkr file */
if Lkr.0 = 0 then do                            /* zero records */
  Say 'Error: no .lkr file found'
  return 1
end

call load_sfr1x                                 /* load sfr + mirror info */
call load_IDAddr                                /* load ID addresses */

parse lower var PicName JalFile                 /* filename lower case */
JalFile = dstdir||Jalfile'.jal'                 /* .jal file */
if stream(JalFile, 'c', 'open write replace') \= 'READY:' then do
  Say 'Error: Could not create include file' JalFile
  return 1
end

call list_head                                  /* header */
call list_fuses_words1x                         /* config memory */
call list_IDmem                                 /* ID memory */
call list_sfr1x                                 /* register info */
call list_analog_functions                      /* register info */
call list_fuses_bits                            /* fuses details */
call stream JalFile, 'c', 'close'               /* done! */
return 0


/* ==================================================================== */
/*                      1 6 - B I T S   C O R E                         */
/* ==================================================================== */
dev2jal16: procedure expose ScriptVersion ScriptAuthor CompilerVersion,
                            PicName DstDir,
                            Dev. Lkr. Ram. Name. ,
                            CfgAddr. IDAddr. ChipFile

MAXRAM     = 4096                               /* 0x1000 */
BANKSIZE   = 256                                /* 0x0100 */
DataStart  = '0xF00000'                         /* default for 16-bit core */
Core       = 16                                 /* 16 bits */
NumBanks   = 1                                  /* default */
StackDepth = 31                                 /* default */

DevFile = arg(1)                                /* .dev file */
call File_read_dev                              /* read devfile */
if Dev.0 = 0 then do                            /* zero records */
  Say 'Error: file' DevFile 'not found'
  return 1                                      /* problem */
end

call load_config_info                           /* collect cfg info */

if Core \= 16 then do                           /* wrong core */
  say 'Script error: Wrong script for!' PicName
  return 1                                      /* done */
end

say PicName                                     /* progress signal */

LkrFile = arg(2)||PicName'_g.lkr'               /* generic .lkr file */
call File_read_lkr                              /* read .lkr file */
if Lkr.0 = 0 then do                            /* zero records */
  if pos('lf',PicName) > 0 then do              /* low voltage type */
    LkrFile = arg(2)||left(PicName,2)||substr(PicName,4)'_g.lkr'
    call File_read_lkr                          /* try 18Fxxxx.lkr */
    if Lkr.0 = 0 then do                        /* zero records */
      LkrFile = arg(2)||left(PicName,3)||substr(PicName,5)'_g.lkr'
      call File_read_lkr                        /* try 18Lxxxx.lkr */
    end
  end
  if Lkr.0 = 0 then do                          /* still zero rcds */
    Say 'Error: no .lkr file found'
    return 1
  end
end

call load_sfr16                                 /* load sfr */
call load_IDAddr                                /* load ID addresses */

parse lower var PicName JalFile                 /* filename lower case */
JalFile = dstdir||Jalfile'.jal'                 /* .jal file */
if stream(JalFile, 'c', 'open write replace') \= 'READY:' then do
  Say 'Error: Could not create include file' JalFile
  return 1
end

call list_head                                  /* header */
call list_fuses_bytes16                         /* config memory */
call list_IDmem                                 /* ID memory */
call list_sfr16                                 /* register info */
call list_analog_functions                      /* register info */
call list_fuses_bits                            /* fuses details */
call stream JalFile, 'c', 'close'               /* done! */
return 0


/* ==================================================================== */
/*          End of the 3 core-specific main scripts                     */
/* ==================================================================== */


/* ---------------------------------------------- */
/* script debugging                               */
/* ---------------------------------------------- */
error_catch:
Say 'Execution error, rc' rc 'at script line' SIGL
return rc

syntax_catch:
if rc = 4 then                                  /* interrupted */
  exit
Say 'Syntax error, rc' rc 'at script line' SIGL
return rc


/* ---------------------------------- */
/* Read .dev file into stem variable  */
/* input: - DevFile                   */
/*        - Dev.                      */
/*                                    */
/* Collect only relevant lines!       */
/* ---------------------------------- */
File_read_dev: procedure expose DevFile Dev.
DevFile = translate(DevFile, '/', '\')          /* enforce forward slashes */
Dev.0 = 0                                       /* no records read yet */
if stream(DevFile, 'c', 'open read') \= 'READY:' then
  return
i = 1                                           /* first record */
do while lines(DevFile) > 0
  parse upper value linein(DevFile) with Dev.i  /* store line in upper case */
  if length(Dev.i) \< 3 then do                 /* not empty */
    if left(word(Dev.i,1),1) \= '#' then        /* not comment */
      i = i + 1                                 /* keep this record */
    else do                                     /* comment */
      parse var Dev.i '#' val0 'S' val1         /* pgm spec */
      if (val0 = 'D' | val0 = 'P')  &,          /* 'PS' or 'DS' found */
          val1 \= '' then                       /* document number present */
        i = i + 1                               /* keep this record */
    end
  end
end
Dev.0 = i - 1                                   /* # of stored records */
call stream DevFile, 'c', 'close'               /* done */
return


/* ---------------------------------- */
/* Read .lkr file into stem variable  */
/* input: - LkrFile                   */
/*        - Lkr.                      */
/*                                    */
/* Collect only relevant lines!       */
/* ---------------------------------- */
File_read_lkr: procedure expose LkrFile Lkr.
LkrFile = translate(LkrFile, '/', '\')          /* enforce forward slashes */
Lkr.0 = 0                                       /* no records read */
if stream(LkrFile, 'c', 'open read') \= 'READY:' then
  return
i = 1                                           /* first record */
do while lines(LkrFile) > 0                     /* whole file */
  parse upper value linein(LkrFile) with Lkr.i  /* store line in upper case */
  if length(Lkr.i) \> 2           |,            /* empty */
     left(word(Lkr.i,1),2) = '//' |,            /* .lkr comment */
     word(Lkr.i,1) = '#FI'        |,            /* end if */
     word(Lkr.i,1) = '#DEFINE'    |,            /* const definition */
     word(Lkr.i,1) = 'LIBPATH' then             /* Library path */
    iterate                                     /* skip these lines */
  if word(Lkr.i,1) = '#IFDEF' then do           /* conditional part */
    if left(word(Lkr.i,2),6) = '_DEBUG'  |,     /* debugging */
       left(word(Lkr.i,2),6) = '_EXTEN' then do /* extended mode */
      do while lines(LkrFile) > 0               /* skip lines */
        parse upper value linein(LkrFile) with ln  /* read line */
        if word(ln,1) = '#ELSE' |,              /* other than debugging */
           word(ln,1) = '#FI' then do           /* end conditional part */
          leave                                 /* resume normal */
        end
      end
    end
  end
  else do                                       /* not skipped */
    i = i + 1                                   /* keep this record */
  end
end
Lkr.0 = i - 1                                  /* # non-comment records */
call stream LkrFile, 'c', 'close'              /* done */
return


/* ---------------------------------------------- */
/* procedure to collect Config (fuses) info       */
/* input:  - nothing                              */
/* ---------------------------------------------- */
load_config_info: procedure expose Dev. CfgAddr. Core

do i = 1 to Dev.0
  if word(Dev.i,1) \= 'CFGMEM' then             /* not appropriate */
    iterate
  parse var Dev.i 'CFGMEM' '(' 'REGION' '=' '0X' Val1 '-' '0X' Val2 ')' .
  if Val1 \= '' then do
    if Val1 = 'FFF' then                        /* 12-bits core */
      Core = 12
    else if Val1 = '2007' then                  /* 14-bits core */
      Core = 14
    else                                        /* presumably 16-bits core */
      Core = 16
    CfgAddr.0 = X2D(val2) - X2D(val1) + 1       /* number of config bytes */
    do j = 1 to CfgAddr.0                       /* all config bytes */
      CfgAddr.j = X2D(val1) + j - 1             /* address */
    end
    leave                                       /* 1st occurence */
  end
end
return


/* ---------------------------------------------- */
/* procedure to determine ID memory range         */
/* input:  - nothing                              */
/* ---------------------------------------------- */
load_IDAddr: procedure expose Dev. IDaddr.
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'USERID' then
    iterate
  parse var Dev.i 'USERID' '(' 'REGION' '=' Value ')' .
  if Value \= '' then do
    parse var Value '0X' val1 '-' '0X' val2 .
    if val1 \= '' then do
      IDaddr.0 = X2D(val2) - X2D(val1) + 1      /* count */
      do j = 1 to IDAddr.0
        IDaddr.j = X2D(val1) + j - 1            /* address */
      end
    end
    leave                                       /* 1st occurence */
  end
end
return


/* ---------------------------------------------- */
/* procedure to obtain hardware stack depth       */
/* input:  - nothing                              */
/* ---------------------------------------------- */
load_stackdepth: procedure expose Dev. StackDepth
do i = 1 to Dev.0
  parse var Dev.i 'HWSTACKDEPTH' '=' Val1 .
  if Val1 \= '' then do
    StackDepth = strip(val1)
    leave                                       /* 1st occurence */
  end
end
return


/* ---------------------------------------------------------- */
/* procedure to build special function register array         */
/* with mirror info and unused registers                      */
/* input:  - nothing                                          */
/* 12-bit and 14-bit core                                     */
/* ---------------------------------------------------------- */
load_sfr1x: procedure expose Dev. Name. Ram. MAXRAM NumBanks
do i = 0 to MAXRAM - 1                          /* whole range */
  Ram.i = 0                                     /* mark as unused */
end
do i = 1 to Dev.0
  ln = Dev.i                                    /* copy line */
  parse var ln 'NUMBANKS' '=' Value .           /* memory banks */
  if Value \= '' then do
    NumBanks = strip(Value)
    iterate
  end
  parse var ln 'MIRRORREGS' '(' '0X' low.1  '-' '0X' high.1,
                                '0X' low.2  '-' '0X' high.2,
                                '0X' low.3  '-' '0X' high.3,
                                '0X' low.4  '-' '0X' high.4,
                                '0X' low.5  '-' '0X' high.5,
                                '0X' low.6  '-' '0X' high.6,
                                '0X' low.7  '-' '0X' high.7,
                                '0X' low.8  '-' '0X' high.8,
                                '0X' low.9  '-' '0X' high.9,
                                '0X' low.10 '-' '0X' high.10,
                                '0X' low.11 '-' '0X' high.11,
                                '0X' low.12 '-' '0X' high.12,
                                '0X' low.13 '-' '0X' high.13,
                                '0X' low.14 '-' '0X' high.14,
                                '0X' low.15 '-' '0X' high.15,
                                '0X' low.16 '-' '0X' high.16 ')' .
  if low.1 \= '' & high.1 \= '' then do
    a = X2D(strip(low.1))
    b = X2D(strip(strip(high.1),'B',')'))
    do j = 2 to 16                              /* all possible banks */
      if low.j \= '' & high.j \= '' then do     /* specified bank */
        p = X2D(strip(low.j))                   /* mirror low bound */
        do k = a to b                           /* whole range */
          Ram.k = k                             /* mark 'used' */
          Ram.p = k                             /* mark as mirror */
          p = p + 1                             /* next mirrored reg. */
        end
      end
    end
    iterate
  end
  parse var ln 'UNUSEDREGS' '(' '0X' lo '-' '0X' hi ')' .
  if lo \= '' & hi \= '' then do
    a = X2D(strip(lo))
    b = X2D(strip(hi))
    do k = a to b                               /* whole range */
      Ram.k = -1                                /* mark 'unused' */
    end
    iterate
  end
end
return 0


/* ---------------------------------------------------------- */
/* procedure to build special function register array         */
/* with unused registers                                      */
/*                                                            */
/* input:  - nothing                                          */
/*                                                            */
/* 16-bit core                                                */
/* ---------------------------------------------------------- */
load_sfr16: procedure expose Dev. Ram. BankSize NumBanks
do i = 1 to Dev.0
  parse var Dev.i 'NUMBANKS' '=' Value .        /* memory banks */
  if Value \= '' then do
    NumBanks = strip(Value)                     /* feedback! */
    iterate
  end
  parse var Dev.i 'UNUSEDREGS' '(' '0X' lo '-' '0X' hi ')' .
  if lo \= '' & hi \= '' then do
    a = X2D(strip(lo))
    b = X2D(strip(hi))
    do k = a to b                               /* whole range */
      Ram.k = -1                                /* mark 'unused' */
    end
  end
end
return 0


/* --------------------------------------------------- */
/* procedure to obtain code memory size from .dev file */
/* input:  - nothing                                   */
/* --------------------------------------------------- */
list_code_size: procedure expose Dev. JalFile
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'PGMMEM' then             /* not appropriate */
    iterate
  parse var Dev.i 'PGMMEM' '(' 'REGION' '=' Value ')' .
  if Value \= '' then do
    parse var Value '0X' val1 '-' '0X' val2 .
    CodeSize = X2D(strip(Val2)) - X2D(strip(val1)) + 1
    call lineout JalFile, 'pragma  code    'CodeSize
    leave                                       /* only 1 expected */
  end
end
return


/* ---------------------------------------------------------- */
/* procedure to obtain EEPROM data memory size from .dev file */
/* input:  - nothing                                          */
/* ---------------------------------------------------------- */
list_data_size: procedure expose Dev. JalFile DataStart
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'EEDATA' then             /* not appropriate */
    iterate
  parse var Dev.i 'EEDATA' 'REGION' '=' Value ')' .
  if Value \= '' then do
    parse var Value '0X' val1 '-' '0X' val2 .
    DataSize = X2D(val2) - X2D(val1) + 1
    call lineout JalFile, 'pragma  eeprom  'DataStart','DataSize
    leave                                       /* only 1 expected */
  end
end
return


/* ---------------------------------------------- */
/* procedure to obtain Device ID from .dev file   */
/* input:  - nothing                              */
/* remarks: some corrections of errors in MPLAB   */
/* ---------------------------------------------- */
list_devid: procedure expose Dev. JalFile ChipFile Core PicName
DevID = '0000'                                  /* default (not found) */
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'DEVID' then              /* not appropriate */
    iterate
  parse var Dev.i 'DEVID' val0 'IDMASK' '=' Val1 'ID' '=' '0X' val2 ')' .
  if val2 \= '' then do
    DevID = right(strip(Val2),4,'0')            /* 4 hex chars */
    leave                                       /* only 1 expected */
  end
end
if DevId == '0000' then do                      /* DevID not found */
  if PicName = '16f627' then                    /* missing in MPLAB */
    Devid = '07A0'
  else if PicName = '16f628' then               /* missing in MPlab */
    Devid = '07C0'
  else if PicName = '16f84A' then               /* missing in MPlab */
    Devid = '0560'
end
parse upper var PicName PicNameUpper
if DevId \== '0000' then do                     /* not missing DevID */
  call lineout JalFile, '-- Device-ID: 0x'DevId
  call lineout ChipFile, left('const       PIC_'PicNameUpper,29) '= 0x_'Core'_'DevID
end
else do                                         /* unknown device ID */
  DevID = right(PicName,3)                      /* rightmost 3 chars */
  if datatype(Devid,'X') = 0 then do            /* not all hex digits */
    DevID = right(right(PicName,2),3,'F')       /* 'F' + rightmost 2 chars */
  end
  call lineout ChipFile, left('const       PIC_'PicNameUpper,29) '= 0x_'Core'_F'DevID
end
return


/* ---------------------------------------------- */
/* procedure to obtain VPP info from .dev file    */
/* input:  - nothing                              */
/* ---------------------------------------------- */
list_Vpp: procedure expose Dev. JalFile
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'VPP' then                /* not appropriate */
    iterate
  parse var Dev.i 'VPP' '(' 'RANGE' '=' Val1 'DFLT' '=' Val2 ')' .
  if Val1 \= '' then do
    call lineout JalFile, '-- Vpp',
         'Range:' strip(Val1) 'Default:' strip(Val2)
    leave                                       /* 1st occurence */
  end
end
return


/* ---------------------------------------------- */
/* procedure to obtain Vdd info from .dev file    */
/* input:  - nothing                              */
/* ---------------------------------------------- */
list_Vdd: procedure expose Dev. JalFile
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'VDD' then                /* not appropriate */
    iterate
  parse var Dev.i 'VDD' '(' 'RANGE' '=' Val1 'DFLTRANGE' '=' Val2 'NOMINAL' '=' Val3 ')' .
  if Val1 \= '' then do
    call lineout JalFile, '-- Vdd',
         'Range:' strip(Val1) 'Nominal:' strip(Val3)
    leave                                       /* 1st occurence */
  end
end
return


/* --------------------------------------------- */
/* procedure to obtain number of Dataheet number */
/* input:  - nothing                             */
/* --------------------------------------------- */
list_datasheet: procedure expose Dev. JalFile
do i = 1 to Dev.0
  if left(Dev.i,4) \= '# DS' then               /* not appropriate */
    iterate
  if Word(Dev.i,3) \= '' then do
    call lineout JalFile, '-- DataSheet:' word(Dev.i,3)
    leave                                       /* 1st occurence */
  end
end
return


/* -------------------------------------------------------- */
/* procedure to obtain number of Programming Specifications */
/* input:  - nothing                                        */
/* -------------------------------------------------------- */
list_pgmspec: procedure expose Dev. JalFile
do i = 1 to Dev.0
  if left(Dev.i,4) \= '# PS' then               /* not appropriate */
    iterate
  if Word(Dev.i,3) \= '' then do
    call lineout JalFile, '-- Programming Specifications:' word(Dev.i,3)
    leave                                       /* 1st occurence */
  end
end
return


/* --------------------------------------------------------------- */
/* procedure to obtain shared RAM (gpr) ranges from .dev file      */
/* input:  - nothing                                               */
/* returns - string with range of shared RAM                       */
/*           in MaxSharedRam highest shared RAM address  (decimal) */
/* Note: Some PICs are handled 'exceptionally'                     */
/* --------------------------------------------------------------- */
list_shared_data_range: procedure expose Lkr. JalFile Core MaxSharedRAM PicName
select                                          /* exceptions first */
  when PicName = '16f818' then do               /* exceptional PIC */
    DataRange = '0x40-0x7F'                     /* shared data range */
    MaxSharedRAM = X2D(7F)                      /* upper bound */
    end
  when PicName = '16f819'  |,
       PicName = '16f870'  |,
       PicName = '16f871'  |,
       PicName = '16f872' then do
    DataRange = '0x70-0x7F'
    MaxSharedRAM = X2D(7F)
    end
  when PicName = '16f873'  |,
       PicName = '16f873a' |,
       PicName = '16f874'  |,
       PicName = '16f874a' then do
    DataRange = ''                              /* no shared RAM */
    MaxSharedRAM = 0
    end
  otherwise                                     /* scan .lkr file */
    DataRange = ''                              /* set defaults */
    MaxSharedRAM = 0
    do i = 1 to Lkr.0
      ln = Lkr.i
      if pos('PROTECTED', ln) > 0 then          /* skip protected mem */
        iterate
      if Core = 12 | Core = 14 then
        parse var ln 'SHAREBANK' Val0 'START' '=' '0X' val1 'END' '=' '0X' val2 .
      else
        parse var Lkr.i 'ACCESSBANK' Val0 'START' '=' '0X' val1 'END' '=' '0X' val2 .
      if val1 \= '' then do
        if DataRange \= '' then                 /* not first range */
          DataRange = DataRange','              /* insert separator */
        val1 = strip(val1)
        val2 = strip(val2)
        if Val2 > MaxSharedRAM then
          MaxSharedRAM = X2D(Val2)              /* upper bound */
        DataRange = DataRange'0x'val1'-0x'val2  /* concatenate range */
      end
    end
end
if DataRange \= '' then
  call lineout JalFile, 'pragma  shared  'DataRange
return DataRange                                /* range */


/* ------------------------------------------------------------- */
/* procedure to obtain unshared RAM (gpr) ranges from .dev file  */
/* input:  - nothing                                             */
/* returns in MaxUnsharedRam highest unshared RAM addr. in bank0 */
/* Note: Some PICs are handled 'exceptionally'                   */
/* ------------------------------------------------------------- */
list_unshared_data_range: procedure expose Lkr. JalFile MaxUnsharedRAM PicName
select                                          /* exceptions first */
  when PicName = '16f818' then do               /* exceptional PIC */
    DataRange = '0x20-0x3F,0xA0-0xBF'           /* unshared RAM range */
    MaxUnsharedRAM = X2D(3F)                    /* upper bound */
    end
  when PicName = '16f819' then do
    DataRange = '0x20-0x6F,0xA0-0xEF,0x120-0x16F'
    MaxUnsharedRAM = X2D(6F)
    end
  when PicName = '16f870'  |,
       PicName = '16f871'  |,
       PicName = '16f872'  then do
    DataRange = '0x20-0x6F,0xA0-0xBF'
    MaxUnsharedRAM = X2D(6F)
    end
  when PicName = '16f873'  |,
       PicName = '16f873a' |,
       PicName = '16f874'  |,
       PicName = '16f874a' then do
    DataRange = '0x20-0x7F,0xA0-0xFF'
    MaxUnsharedRAM = X2D(7F)
    end
  otherwise                                     /* scan .lkr file */
    DataRange = ''                              /* set defaults  */
    MaxUnsharedRAM = 0
    do i = 1 to Lkr.0
      ln = Lkr.i
      if pos('PROTECTED', ln) > 0 then          /* skip protected mem */
        iterate
      parse var ln 'DATABANK' Val0 'START' '=' '0X' val1 'END' '=' '0X' val2 .
      if val1 \= '' & val2 \= '' then do        /* both found */
        if Length(DataRange) > 50 then do       /* long string */
          call lineout JalFile, 'pragma  data    'DataRange   /* 'flush' */
          DataRange = ''                        /* reset */
        end
        if DataRange \= '' then                 /* not first range */
          DataRange = DataRange','              /* insert separator */
        val1 = strip(val1)
        val2 = strip(val2)
        if MaxUnsharedRAM = 0 then              /* unassigned */
          MaxUnSharedRAM = X2D(Val2)            /* upper bound bank0 */
        DataRange = DataRange'0x'val1'-0x'val2  /* concatenate range */
      end
    end
end
if DataRange \= '' then
  call lineout JalFile, 'pragma  data    'DataRange
return


/* ---------------------------------------------- */
/* procedure to determine Config (fuses) setting  */
/* input:  - nothing                              */
/* 12-bit and 14-bit core                         */
/* ---------------------------------------------- */
list_fuses_words1x: procedure expose JalFile CfgAddr. Core
call lineout JalFile, 'const word  _FUSES_CT             =' CfgAddr.0
if CfgAddr.0 = 1 then do
  call lineout JalFile, 'const word  _FUSE_BASE            = 0x'D2X(CfgAddr.1)
end
else do
  call charout JalFile, 'const word  _FUSE_BASE[_FUSES_CT] = { '
  do  j = 1 to CfgAddr.0
    call charout JalFile, '0x'D2X(CfgAddr.j)
    if j < CfgAddr.0 then
      call charout JalFile, ','
  end
  call lineout JalFile, ' }'
end
if CfgAddr.0 = 1 then do
  call charout JalFile, 'const word  _FUSES                = '
  if Core = 12 then                             /* 12-bits code */
    call lineout JalFile, '0xFFF'
  else                                          /* 14-bits core */
    call lineout JalFile, '0x3FFF'
end
else do
  call charout JalFile, 'const word  _FUSES[_FUSES_CT]     = { '
  do  j = 1 to CfgAddr.0
    if Core = 12 then                           /* 12-bits code */
      call charout JalFile, '0xFFF'
    else                                        /* 14-bits core */
      call charout JalFile, '0x3FFF'
    if j < CfgAddr.0 then
      call charout JalFile, ','
  end
  call lineout JalFile, ' }'
end
call lineout JalFile, '--'
return


/* ---------------------------------------------- */
/* procedure to determine Config (fuses) setting  */
/* input:  - nothing                              */
/* 16-bit core                                    */
/* ---------------------------------------------- */
list_fuses_bytes16: procedure expose JalFile CfgAddr.
call lineout JalFile, 'const word  _FUSES_CT             =' CfgAddr.0
call charout JalFile, 'const dword _FUSE_BASE[_FUSES_CT] = { '
do  i = 1 to CfgAddr.0
  call charout JalFile, '0x'D2X(CfgAddr.i,6)
  if i < CfgAddr.0 then do
    call lineout JalFile, ','
    call charout JalFile, left('',38,' ')
  end
end
call lineout JalFile, ' }'
call charout JalFile, 'const byte  _FUSES[_FUSES_CT]     = { '
do  i = 1 to CfgAddr.0
  call charout JalFile, '0xFF'
  if i < CfgAddr.0 then do
    call lineout JalFile, ','
    call charout JalFile, left('',38,' ')
  end
end
call lineout JalFile, ' }'
call lineout JalFile, '--'
return


/* ---------------------------------------------- */
/* procedure to determine Config (fuses) setting  */
/* input:  - nothing                              */
/* ---------------------------------------------- */
list_IDmem: procedure expose JalFile IDaddr. Core
if IDaddr.0 > 0 then do
  call lineout JalFile, 'const word  _ID_CT                =' IDAddr.0
  if  core = 12 | core = 14 then
    call charout JalFile, 'const word  _ID_BASE[_ID_CT]      = { '
  else                                          /* 16-bits core */
    call charout JalFile, 'const dword _ID_BASE[_ID_CT]      = { '
  do  j = 1 to IDaddr.0
    if Core = 12 | Core = 14 then do
      call charout JalFile, '0x'D2X(IDaddr.j,4)  /* address */
      if j < IDaddr.0 then
        call charout JalFile, ','
    end
    else do                                     /* 16-bits core */
      call charout JalFile, '0x'D2X(IDaddr.j,6)   /* address */
      if j < IDaddr.0 then do
        call lineout JalFile, ','
        call charout JalFile, left('',38,' ')
      end
    end
  end
  call lineout JalFile, ' }'
  if Core = 12 | Core = 14 then
    call charout JalFile, 'const word  _ID[_ID_CT]           = { '
  else
    call charout JalFile, 'const byte  _ID[_ID_CT]           = { '
  do  j = 1 to IDaddr.0
    if Core = 12 | Core = 14 then
      call charout JalFile, '0x0000'              /* word */
    else
      call charout JalFile, '0x00'                /* byte */
    if j < IDaddr.0 then
      call charout JalFile, ','
  end
  call lineout JalFile, ' }'
  call lineout JalFile, '--'
end
return


/* -------------------------------------------------- */
/* procedure to list special function registers       */
/* input:  - nothing                                  */
/* Note: name is stored but not checked on duplicates */
/* 12-bit and 14-bit core                             */
/* -------------------------------------------------- */
list_sfr1x: procedure expose Dev. Ram. Name. JalFile BANKSIZE NumBanks
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'SFR' then                /* skip */
    iterate
  parse var Dev.i  v0 '(' 'KEY' '=' val1 'ADDR' '=' '0X' val2 'SIZE' '=' val3 .
  if val1 \= '' then do
    reg = strip(val1)                           /* register name */
    Name.reg = reg                              /* remember name */
    addr = X2D(strip(val2))                     /* decimal */
    Ram.addr = addr                             /* mark in use */
    addr = sfr_mirror(addr)                     /* add mirror addresses */
    size = strip(val3)                          /* field size */
    if size = 1 then
      field = 'byte '
    else if size = 2 then
      field = 'word '
    else
      field = 'dword'
    call lineout JalFile, '-- ------------------------------------------------'
    call lineout JalFile, 'var volatile' field left(reg,20) 'at' addr
    if left(reg,4) = 'PORT' then do             /* port */
      call list_port1x_shadow reg
    end
    else if reg = 'GPIO' | reg = 'GP' then do   /* port */
      call lineout JalFile, 'var volatile byte ' left('PORTA',20) 'at' reg
      call list_port1x_shadow 'PORTA'
    end
    else if reg = 'TRISIO' then do              /* tris */
      call lineout JalFile, 'var volatile byte ' left('TRISA',20) 'at' reg
      call lineout JalFile, 'var volatile byte ' left('PORTA_direction',20) 'at' reg
      call list_tris_shadow 'TRISA'             /* nibble direction */
    end
    else if left(reg,4) = 'TRIS' then do        /* TRISx */
      call lineout JalFile, 'var volatile byte ',
                           left('PORT'substr(reg,5)'_direction',20) 'at' reg
      call list_tris_shadow reg                 /* nibble direction */
    end

    call list_sfr_details1x i, reg              /* bit declarations */

    if reg = 'PCL' |,
       reg = 'FSR' |,
       reg = 'PCLATH' then do
      parse lower var reg reg                   /* to lower case */
      call lineout JalFile, 'var volatile byte ' left('_'reg,20) 'at' addr,
                            '     -- (compiler)'
    end
    else if reg = 'INDF' then do
      call lineout JalFile, 'var volatile byte ' left('_ind',20) 'at' addr,
                            '     -- (compiler)'
    end
    else if reg = 'STATUS' then do              /* status register */
      call list_status1x i, addr                /* extra for compiler */
    end
  end
end
return 0


/* -------------------------------------------------- */
/* procedure to list special function registers       */
/* input:  - nothing                                  */
/* Note: name is stored but not checked on duplicates */
/* 16-bit core                                        */
/* -------------------------------------------------- */
list_sfr16: procedure expose Dev. Ram. Name. JalFile BANKSIZE NumBanks
do i = 1 to Dev.0
  if word(Dev.i,1) \= 'SFR' & word(Dev.i,1) \= 'NMMR' then  /* skip */
    iterate
  parse var Dev.i 'SFR' 'KEY=' val1 'ADDR=0X' val2 'SIZE=' val3 .
  if val1 \= '' then do
    reg = strip(val1)                           /* register name */
    Name.reg = reg                              /* remember name */
    addr = strip(val2)
    k = X2D(addr)                               /* address decimal */
    size = strip(val3)                          /* # bytes */
    if size = 1 then                            /* single byte */
      field = 'byte  '
    else if size = 2 then                       /* two bytes */
      field = 'word  '
    else                                        /* three bytes */
      field = 'byte*3'
    Ram.k = k                                   /* mark in use */
    call lineout JalFile, '-- ------------------------------------------------'
    call lineout JalFile, 'var volatile' field left(reg,20),
                          'shared at 0x'addr
    if left(reg,3) = 'LAT' then do              /* LATx regsiter */
      call list_port16_shadow reg               /* force use of LATx */
                                                /* when accessing PORTx */
    end
    else if left(reg,4) = 'TRIS' then do        /* TRISx */
      call lineout JalFile, 'var volatile byte  ',
             left('PORT'substr(reg,5)'_direction',20) 'shared at' reg
      call list_tris_shadow reg                 /* nibble directions */
    end

    call list_sfr_details16 i, reg

    if  reg = 'FSR0'   |,
        reg = 'FSR0L'  |,
        reg = 'FSR0H'  |,
        reg = 'PCL'    |,
        reg = 'PCLATH' |,
        reg = 'PCLATU' |,
        reg = 'TABLAT' |,
        reg = 'TBLPTR'    then do
      parse lower var reg reg                   /* to lower case */
      call lineout JalFile, 'var volatile' field left('_'reg,20),
                            'shared at 0x'addr '     -- (compiler)'
    end
    else if  reg = 'INDF0'  then do
      call lineout JalFile, 'var volatile' field left('_ind0',20),
                            'shared at 0x'addr '     -- (compiler)'
    end
    else if reg = 'STATUS' then do              /* status register */
      call list_status16 i, addr                /* extra for compiler */
    end
  end
end
return 0


/* ---------------------------------------------- */
/* procedure to create port shadowing functions   */
/* for full byte, lower- and upper-nibbles        */
/* For 12- and 14-bit core                        */
/* input:  - Port register                        */
/* ---------------------------------------------- */
list_port1x_shadow: procedure expose JalFile
reg = arg(1)
shadow = '_PORT'substr(reg,5)'_SHADOW'
call lineout JalFile, '--'
call lineout JalFile, 'var          byte ' shadow '       = 'reg
call lineout JalFile, '--'
call lineout JalFile, 'procedure _port'substr(reg,5)'_flush is'
call lineout JalFile, '  pragma inline'
call lineout JalFile, ' ' reg '=' shadow
call lineout JalFile, 'end procedure'
call lineout JalFile, '--'
call lineout JalFile, 'procedure' reg"'put" '(byte in x) is'
call lineout JalFile, '  pragma inline'
call lineout JalFile, '  'shadow '= x'
call lineout JalFile, '  _port'substr(reg,5)'_flush'
call lineout JalFile, 'end procedure'
call lineout JalFile, '--'
half = 'PORT'substr(reg,5)'_low'
call lineout JalFile, 'var  byte' half
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'shadow '= ('shadow '& 0xF0) | (x & 0x0F)'
call lineout JalFile, '  _port'substr(reg,5)'_flush'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return' reg '& 0x0F'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
half = 'PORT'substr(reg,5)'_high'
call lineout JalFile, 'var  byte' half
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'shadow '= ('shadow '& 0x0F) | (x << 4)'
call lineout JalFile, '  _port'substr(reg,5)'_flush'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return' reg '>> 4'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
return


/* ------------------------------------------------ */
/* procedure to force use of LATx with 16-bits core */
/* for full byte, lower- and upper-nibbles          */
/* input:  - LATx register                          */
/* ------------------------------------------------ */
list_port16_shadow: procedure expose JalFile
lat  = arg(1)                                   /* LATx register */
port = 'PORT'substr(lat,4)                      /* corresponding port */
call lineout JalFile, '--'
call lineout JalFile, 'procedure' port"'put" '(byte in x) is'
call lineout JalFile, '--pragma inline   (temporary disabled)'
call lineout JalFile, '  'lat '= x'
call lineout JalFile, 'end procedure'
call lineout JalFile, '--'
half = 'PORT'substr(lat,4)'_low'
call lineout JalFile, 'var  byte' half
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'lat '= ('lat '& 0xF0) | (x & 0x0F)'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return' lat '& 0x0F'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
half = 'PORT'substr(lat,4)'_high'
call lineout JalFile, 'var  byte' half
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'lat '= ('lat '& 0x0F) | (x << 4)'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return' lat '>> 4'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
return


/* ---------------------------------------------- */
/* procedure to create TRIS functions             */
/* for lower- and upper-nibbles only              */
/* input:  - TRIS register                        */
/* ---------------------------------------------- */
list_tris_shadow: procedure expose JalFile
reg = arg(1)
call lineout JalFile, '--'
half = 'PORT'substr(reg,5)'_low_direction'
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'reg '= ('reg '& 0xF0) | (x & 0x0F)'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return' reg '& 0x0F'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
half = 'PORT'substr(reg,5)'_high_direction'
call lineout JalFile, 'procedure' half"'put"'(byte in x) is'
call lineout JalFile, '  'reg '= ('reg '& 0x0F) | (x << 4)'
call lineout JalFile, 'end procedure'
call lineout JalFile, 'function' half"'get" 'return byte is'
call lineout JalFile, '  return ('reg '>> 4)'
call lineout JalFile, 'end function'
call lineout JalFile, '--'
return


/* --------------------------------------- */
/* Formatting of special function register */
/* input:  - index in .dev                 */
/*         - register name                 */
/* Generates names for pins or bits        */
/* 12-bit and 14-bit core                  */
/* --------------------------------------- */
list_sfr_details1x: procedure expose Dev. Name. JalFile
i = arg(1) + 1                                          /* first after reg */
reg = arg(2)                                            /* register (name) */
do k = 0 to 8 while word(Dev.i,1) \= 'SFR'  &,          /* max # of records */
                    word(Dev.i,1) \= 'NMMR'             /* other type */
  parse var Dev.i 'BIT' val0 'NAMES' '=' val1 'WIDTH' '=' val2 ')' .
  if val1 \= ''  &  pos('SCL', val0) = 0 then do        /* found, not 'scl' */
    names = strip(strip(val1), 'B', "'")                /* strip blanks */
    sizes = strip(strip(val2), 'B', "'")                /*   and quotes */
    n. = '-'                                            /* reset */
    parse  var names n.1 n.2 n.3 n.4 n.5 n.6 n.7 n.8 .
    parse  var sizes s.1 s.2 s.3 s.4 s.5 s.6 s.7 s.8 .
    if s.1 = 8 | s.1 = 16 then do                       /* full byte/word */
      if n.1 \= reg then do                             /* different name */
        if s.1 = 8 then                                 /* single byte */
          field_type = 'byte '
        else                                            /* two bytes */
          field_type = 'word '
        field = reg'_'n.1
        if duplicate_name(field,reg) = 0 then         /* unique name */
          call lineout JalFile, 'var volatile' field_type left(field,20) 'at' reg,
                                '   -- alias'
      end
    end
    else do                                             /* subfields */
      offset = 7                                        /* MSbit first */
      do j = 1 to 8                                     /* 8 bits */
        if n.j = '-'  |  n.j = '' then do               /* bit not used */
          offset = offset - 1
        end
        else if datatype(s.j) = 'NUM' then do           /* numeric */
          if s.j = 1 then do                            /* single bit */
            if pos('/', n.j) \= 0 then do               /* twin name */
              parse var n.j val1'/'val2 .
              if val1 \= '' then do                     /* present */
                field = reg'_'val1                      /* new name */
                if duplicate_name(field,reg) = 0 then do  /* unique */
                  call lineout JalFile, 'var volatile bit  ',
                       left(field,20) 'at' reg ':' offset
                end
              end
              if val2 \= '' then do
                field = reg'_'val2
                if duplicate_name(field,reg) = 0 then do   /* unique */
                  call lineout JalFile, 'var volatile bit  ',
                       left(field,20) 'at' reg ':' offset
                end
              end
            end
            else do
              field = reg'_'n.j
              if duplicate_name(field,reg) = 0 then do  /* unique */
                call lineout JalFile, 'var volatile bit  ',
                               left(field,20) 'at' reg ':' offset
              end
              if reg = 'INTCON' then do
                if left(n.j,2) = 'T0' then
                  call lineout JalFile, 'var volatile bit  ',
                           left(reg'_TMR0'||substr(n.j,3),20) 'at' reg ':' offset
                else if left(n.j,4) = 'TMR0' then
                  call lineout JalFile, 'var volatile bit  ',
                           left(reg'_T0'||substr(n.j,5),20) 'at' reg ':' offset
              end
              else if left(reg,4) = 'PORT' then do
                if left(n.j,1) = 'R'  &,
                    substr(n.j,2,1) = right(reg,1) then do  /* prob. I/O pin */
                  shadow = '_PORT'right(reg,1)'_SHADOW'
                  pin = 'pin_'||substr(n.j,2)
                  call lineout JalFile, 'var volatile bit  ',
                                        left(pin,20) 'at' reg ':' offset
                  call lineout JalFile, 'procedure' pin"'put"'(bit in x) is'
                  call lineout JalFile, '  pragma inline'
                  call lineout JalFile, '  var bit _tmp_bit at' shadow ':' offset
                  call lineout JalFile, '  _tmp_bit = x'
                  call lineout JalFile, '  _port'substr(reg,5)'_flush'
                  call lineout JalFile, 'end procedure'
                  call lineout JalFile, '--'
                end
              end
              else if reg = 'GPIO' | reg = 'GP' then do
                shadow = '_PORTA_SHADOW'
                pin = 'pin_A'right(n.j,1)
                call lineout JalFile, 'var volatile bit  ',
                                      left(pin,20) 'at' reg ':' offset
                call lineout JalFile, 'procedure' pin"'put"'(bit in x) is'
                call lineout JalFile, '  pragma inline'
                call lineout JalFile, '  var bit _tmp_bit at' shadow ':' offset
                call lineout JalFile, '  _tmp_bit = x'
                call lineout JalFile, '  _portA_flush'
                call lineout JalFile, 'end procedure'
                call lineout JalFile, '--'
              end
              else if reg = 'TRISIO' then do
                call lineout JalFile, 'var volatile bit  ',
                    left('TRISA'right(n.j,1),20) 'at' reg ':' offset
                call lineout JalFile, 'var volatile bit  ',
                    left('pin_A'substr(n.j,7)'_direction',20) 'at' reg ':' offset
              end
              else if left(reg,4) = 'TRIS' then do
                if left(n.j,4) = 'TRIS' then
                  call lineout JalFile, 'var volatile bit  ',
                    left('pin_'substr(n.j,5)'_direction',20) 'at' reg ':' offset
              end
            end
            offset = offset - 1                         /* next bit */
          end
          else if s.j < 8 then do                       /* part of byte */
            if s.j > 1 then do                          /* multi-bit */
              if n.j \= reg then do                     /* not reg alias */
                field = reg'_'n.j
                if duplicate_name(field,reg) = 0 then do  /* unique */
                  call lineout JalFile, 'var volatile bit*'s.j,
                        left(field,20) 'at' reg ':' offset - s.j + 1
                end
              end
              offset = offset - s.j
            end
          end
          else if s.j > 8 then do                       /* multi-byte */
            field = reg'_'n.j
            if duplicate_name(field,reg) = 0 then do    /* unique */
              call lineout JalFile, 'var volatile bit  ',
                   left(field,20) 'at' reg ':' offset
            end
          end
        end
      end
    end
  end
  i = i + 1                                     /* next record */
end
return 0


/* --------------------------------------- */
/* Formatting of special function register */
/* input:  - index in .dev                 */
/*         - register name                 */
/* Generates names for pins or bits        */
/* 16-bit core                             */
/* --------------------------------------- */
list_sfr_details16: procedure expose Dev. Name. JalFile
i = arg(1) + 1                                          /* 1st after reg */
reg = arg(2)                                            /* register (name) */
do k = 0 to 8 while word(Dev.i,1) \= 'SFR'   &,         /* max # of records */
                    word(Dev.i,1) \= 'NMMR'             /* other register */
  parse var Dev.i 'BIT' val0 'NAMES=' val1 'WIDTH=' val2 ')' .
  if val1 \= ''  &,                                     /* found */
     pos('SCL', val0) = 0  &,                           /* not 'scl' */
     word(Dev.i,1) \= 'QBIT' then do                    /* not 'qbit' */
    names = strip(strip(val1), 'B', "'")                /* strip blanks */
    sizes = strip(strip(val2), 'B', "'")                /* strip quotes */
    parse  var names n.1 n.2 n.3 n.4 n.5 n.6 n.7 n.8 .
    parse  var sizes s.1 s.2 s.3 s.4 s.5 s.6 s.7 s.8 .
    if s.1 = 8 | s.1 = 16 | s.1 = 24 then do            /* (multi) byte */
      if n.1 \= reg then do                             /* other name */
        if s.1 = 8 then                                 /* single byte */
          field_type = 'byte  '
        else if s.1 = 16 then                           /* two bytes */
          field_type = 'word  '
        else                                            /* three bytes */
          field_type = 'byte*3'
        field = reg'_'n.1
        if duplicate_name(field,reg) = 0 then do        /* unique */
          call lineout JalFile, 'var volatile' field_type left(field,20) 'shared at' reg
        end
      end
    end
    else do                                             /* sub-div of reg */
      offset = 7                                        /* MSbit first */
      do j = 1 to 8                                     /* 8 bits */
        if n.j = '-' then do                            /* bit not used */
          offset = offset - 1
        end
        else if datatype(s.j) = 'NUM' then do           /* numeric */
          if s.j = 1 then do                            /* single bit */
            if pos('/', n.j) \= 0 then do               /* twin name */
              parse var n.j val1'/'val2 .
              if val1 \= '' then do
                field = reg'_'val1
                if duplicate_name(field,reg) = 0 then do  /* unique */
                  call lineout JalFile, 'var volatile bit   ',
                       left(field,20) 'shared at' reg ':' offset
                end
              end
              if val2 \= '' then do
                field = reg'_'val2
                if duplicate_name(field,reg) = 0 then do  /* unique */
                  call lineout JalFile, 'var volatile bit   ',
                       left(field,20) 'shared at' reg ':' offset
                end
              end
            end
            else do
              field = reg'_'n.j
              if duplicate_name(field,reg) = 0 then do  /* unique */
                call lineout JalFile, 'var volatile bit   ',
                     left(field,20) 'shared at' reg ':' offset
              end
              if reg = 'INTCON' then do
                if left(n.j,2) = 'T0' then
                  call lineout JalFile, 'var volatile bit   ',
                           left(reg'_TMR0'||substr(n.j,3),20) 'shared at' reg ':' offset
                else if left(n.j,4) = 'TMR0' then
                  call lineout JalFile, 'var volatile bit   ',
                           left(reg_'T0'||substr(n.j,5),20) 'shared at' reg ':' offset
              end
              else if left(reg,3) = 'LAT' then do       /* LATx register */
                if left(n.j,3) = 'LAT'   &,
                    substr(n.j,4,1) = right(reg,1) then do  /* prob. I/O pin */
                  pin = 'pin_'||substr(n.j,4)
                  call lineout JalFile, 'var volatile bit',
                                        pin 'shared at' reg ':' offset
                  call lineout JalFile, 'procedure' pin"'put"'(bit in x) is'
                  call lineout JalFile, '--pragma inline  (temporary disabled)'
                  call lineout JalFile, '  var bit _tmp_bit at' reg ':' offset
                  call lineout JalFile, '  _tmp_bit = x'
                  call lineout JalFile, 'end procedure'
                  call lineout JalFile, '--'
                end
              end
              else if left(reg,4) = 'TRIS' then do
                pin = 'pin_'||substr(n.j,5)'_direction'
                if  left(n.j,4) = 'TRIS' then           /* only TRIS bits */
                  call lineout JalFile, 'var volatile bit   ',
                               left(pin,20) 'shared at' reg ':' offset
              end
            end
            offset = offset - 1                         /* next bit */
          end
          else if s.j < 8 then do                       /* not full byte */
            if s.j > 1 then do                          /* multi-bit */
              field = reg'_'n.j
              if field \= reg then do                   /* not reg alias */
                if duplicate_name(field,reg) = 0 then do  /* unique */
                  call lineout JalFile, 'var volatile bit*'s.j' ',
                        left(field,20) 'shared at' reg ':' offset - s.j + 1
                end
              end
              offset = offset - s.j
            end
          end
        end
      end
    end
  end
  i = i + 1                                             /* next record */
end
return 0


/* -------------------------------------------------------- */
/* Special _extra_ formatting of STATUS register            */
/* input:  - index in .dev                                  */
/*         - register name (Status)                         */
/* remark: Is extra set of definitions for compiler only.   */
/*         Not intended for use by application programs.    */
/* 12-bit and 14-bit core                                   */
/* -------------------------------------------------------- */
list_status1x: procedure expose Dev. JalFile
i = arg(1) + 1                                  /* just after register */
reg = arg(2)                                    /* register (name) */
call lineout JalFile, 'var volatile byte ' left('_status',20) 'at' reg,
                            '     -- (compiler)'
do k = 0 to 4 while word(Dev.i, 1) \= 'SFR'     /* max 4 records */
  parse var Dev.i 'BIT' val0 'NAMES=' val1 'WIDTH=' val2 ')' .
  if val1 \= '' then do
    names = strip(strip(val1), 'B', "'")        /* strip blanks */
    sizes = strip(strip(val2), 'B', "'")        /* .. and quotes */
    parse  var names n.1 n.2 n.3 n.4 n.5 n.6 n.7 n.8 .
    parse  var sizes s.1 s.2 s.3 s.4 s.5 s.6 s.7 s.8 .
    offset = 7                                  /* MSbit */
    do i = 1 to 8                               /* all individual bits */
      if n.i = '-' then do                      /* bit not present */
        offset = offset - 1
      end
      else if datatype(s.i) = 'NUM' then do     /* field size */
        if s.i = 1 then do                      /* single bit */
          parse lower var n.i n.i               /* to lower case */
          if n.i = 'nto' then do
            call lineout JalFile, 'const        byte ',
                    left('_not_to',20) '= ' offset '     -- (compiler)'
          end
          else if n.i = 'npd' then do
            call lineout JalFile, 'const        byte ',
                    left('_not_pd',20) '= ' offset '     -- (compiler)'
          end
          else do
            call lineout JalFile, 'const        byte ',
                    left('_'n.i,20) '= ' offset '     -- (compiler)'
          end
          offset = offset - 1                   /* next bit */
        end
        else do j = s.i - 1  to  0  by  -1      /* enumerate */
          call lineout JalFile, 'const        byte ',
                  left('_'n.i||j,20) '= ' offset '     -- (compiler)'
          offset = offset - 1
        end
      end
    end
  end
  i = i + 1                                     /* next record */
end
return


/* -------------------------------------------------------- */
/* Special _extra_ formatting of STATUS register            */
/* input:  - index in .dev                                  */
/*         - register name (STATUS)                         */
/* remark: Is extra set of definitions for compiler only.   */
/*         Not intended for use by application programs.    */
/* 16-bit core                                              */
/* -------------------------------------------------------- */
list_status16: procedure expose Dev. JalFile
i = arg(1) + 1                                  /* just after register */
addr = arg(2)                                   /* register */
call lineout JalFile, 'var volatile byte  ' left('_status',20),
                                    'shared at 0x'addr '     -- (compiler)'
do k = 0 to 4 while word(Dev.i, 1) \= 'SFR'     /* max 4 records */
  parse var Dev.i 'BIT' val0 'NAMES=' val1 'WIDTH=' val2 ')' .
  if val1 \= '' then do
    names = strip(strip(val1), 'B', "'")        /* strip blanks */
    sizes = strip(strip(val2), 'B', "'")        /* .. and quotes */
    parse  var names n.1 n.2 n.3 n.4 n.5 n.6 n.7 n.8 .
    parse  var sizes s.1 s.2 s.3 s.4 s.5 s.6 s.7 s.8 .
    offset = 7                                  /* MSbit */
    do i = 1 to 8                               /* all individual bits */
      if n.i = '-' then do                      /* bit not present */
        offset = offset - 1                     /* skip */
      end
      else if datatype(s.i) = 'NUM' then do     /* field size */
        parse lower var n.i n.i                 /* to lowercase */
        call lineout JalFile, 'const        byte  ',
                    left('_'n.i,20) '= ' offset '     -- (compiler)'
        offset = offset - 1                   /* next bit */
      end
    end
  end
  i = i + 1                                     /* next record */
end
call lineout JalFile, 'const        byte  ' left('_banked',20) '=  1',
                              '     -- (compiler - use BSR)'
call lineout JalFile, 'const        byte  ' left('_access',20) '=  0',
                              '     -- (compiler - use ACCESS)'
return


/* -------------------------------------- */
/* Formatting of configuration bits       */
/* input:  - nothing                      */
/* -------------------------------------- */
list_fuses_bits:   procedure expose Dev. JalFile CfgAddr. Core
call lineout JalFile, '--'
call lineout JalFile, '-- =================================================='
call lineout JalFile, '--'
call lineout JalFile, '-- Symbolic Fuse definitions'
call lineout JalFile, '-- -------------------------'
k = 0                                           /* config word count */
do i = 1 to dev.0                               /* scan .dev file */
  if word(Dev.i,1) \= 'CFGBITS' then            /* appropriate record */
    iterate
  ln = Dev.i
  parse var ln 'CFGBITS' val0 'ADDR' '=' '0X' val1 'UNUSED' '=' '0X' val2 ')' .
  if val1 \= '' then do                         /* address found */
    k = k + 1                                   /* count fuse words */
    addr = strip(val1)                          /* hex addr */
    call lineout JalFile, '--'
    call lineout JalFile, '-- addr 0x'addr
    call lineout JalFile, '--'
    i = i + 1                                   /* next record */
    ln = dev.i                                  /* next line */
    do while i <= dev.0  &  word(ln, 1) \= 'CFGBITS'
      parse var ln 'FIELD' val0 'KEY=' val1 'MASK' '=' '0X' val2 .
      if val1 \= '' then do                     /* field found */
        key = strip(val1)
        if pos('RESERVED',key) > 0 then do      /* skip */
          i = i + 1
          ln = Dev.i
          iterate
        end
        if pos('OSC',key) > 0      &,           /* catches ...OSC... */
           pos('FOSC2',key) = 0    &,           /* excl FOSC2 */
           pos('OSCS',key) = 0     &,           /* excl OSCS */
           pos('IOSCFS',key) = 0   &,           /* excl IOSCFS */
           pos('LPT1OSC',key) = 0  &,           /* excl LPT1OSC */
           pos('DSWDTOSC',key) = 0 &,           /* excl deep sleep WDT osc */
           pos('RTCOSC',key) = 0   &,           /* excl RTC OSC */
           pos('T1OSC',key) = 0   then          /* excl T1 OSC mux */
          key = 'OSC'
        else if pos('DSWDTEN',key) > 0 then
          key = 'DSWDTEN'
        else if pos('DSWDTOSC',key) > 0 then
          key = 'DSWDTOSC'
        else if pos('DSWDTPS',key) > 0 then
          key = 'DSWDTPS'
        else if pos('WDTPS',key) > 0 then
          key = 'WDTPS'
        else if pos('WDTCS',key) > 0 then
          key = 'WDTCS'
        else if pos('WDT',key) > 0 then
          key = 'WDT'
        else if pos('BODENV',key) > 0 |,
                pos('BOR4V',key)  > 0 |,
                pos('BORV',key)   > 0 then
          key = 'VOLTAGE'
        else if pos('BODEN',key) > 0  | pos('BOREN',key) > 0 then
          key = 'BROWNOUT'
        else if pos('MCLR',key) > 0 then
          key = 'MCLR'
        else if pos('PUT',key) > 0 then
          key = 'PWRTE'
        if Core = 12  |  core = 14 then do
          if CfgAddr.0 > 1 then                 /* multi fuse bytes/words */
            call lineout JalFile, 'pragma fuse_def',
                                  key':'X2D(addr) - CfgAddr.1,
                                  '0x'strip(val2) '{'
          else
            call lineout JalFile, 'pragma fuse_def' key '0x'strip(val2) '{'
        end
        else do
          call lineout JalFile, 'pragma fuse_def',
                                key':'X2D(addr) - CfgAddr.1,
                                '0x'strip(val2) '{'
        end
        if key = 'OSC' then
          call list_fuse_def_osc i
        else if key = 'DSWDTPS' then
          call list_fuse_def_wdtps i
        else if key = 'WDTPS' then
          call list_fuse_def_wdtps i
        else if key = 'WDT' then
          call list_fuse_def_wdt i
        else if key = 'VOLTAGE' then
          call list_fuse_def_voltage i
        else if key = 'BROWNOUT' then
          call list_fuse_def_brownout i
        else if key = 'MCLR' then
          call list_fuse_def_mclr i
        else
          call list_fuse_def_other i
        call lineout JalFile, '       }'
      end
      i = i + 1
      ln = Dev.i
    end
  end
  i = i - 1                                     /* read one to many */
end
call lineout JalFile, '--'
return


/* ------------------------------------------- */
/* Generate fuse_defs for oscillator settings  */
/* - filter the oscillator type                */
/* - filter possible secundary effects         */
/* - check on duplicate names (filter fault!)  */
/* ------------------------------------------- */
list_fuse_def_osc: procedure expose Dev. JalFile PICname
aoscname. = '-'                                 /* empty name compound */
do i = arg(1) + 1 while i <= dev.0  &,
          (word(dev.i,1) = 'SETTING' | word(dev.i,1) = 'CHECKSUM')
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' .
  if val1 \= '' then do
    mask = strip(val1)                          /* bit mask (hex) */
    desc = translate(val2, '                 ', ' +-:;.,<>{}[]()=/')  /* to blanks */
    if wordpos('LP',desc) > 0 then              /* low power crystal */
      osctype = 'LP'
    else if wordpos('XT',desc) > 0 then         /* crystal */
      osctype = 'XT'
    else if wordpos('HS',desc) > 0 then         /* high speed crystal */
      osctype = 'HS'
    else if left(desc,3) = 'INT' then           /* internal osc */
      osctype = 'INTOSC'
    else if wordpos('EC',desc) > 0  |,          /* external clock */
            wordpos('EXTCLK',desc) > 0 then     /* external clock */
      osctype = 'EC'
    else if left(desc,3) = 'EXT'    |,          /* external osc */
            wordpos('ER',desc) > 0  |,
            wordpos('RC',desc) > 0 then
      osctype = 'EXTOSC'
    else do                                     /* fall through */
      osctype = translate(desc, '_', ' ')       /* blank -> underscore */
      if datatype(left(osctype,1)) = 'NUM' then    /* 1st char is digit */
        osctype = '_'osctype                    /* add prefix */
      say 'Warning: OSC='osctype                /* special! */
    end

    oscsub  = ''                                /* default no sub func */
    if pos('PLL',desc) > 0 then                 /* PLL */
      oscsub = '_PLL'
    else if pos('USB',desc) > 0 then            /* USB */
      oscsub = oscsub'_USB'
    if osctype = 'INTOSC' |,                    /* int osc */
       osctype = 'EXTOSC' |,                    /* ext osc */
       osctype = 'EC'     then do               /* ext clock */
      if pos('NO CL',val2) > 0      |,
         pos('INTRCIO',val2) > 0    |,
         pos('INTOSCIO',val2) > 0   |,
         pos('EXTRCIO',val2) > 0    |,
         pos('EXTOSCIO',val2) > 0   then
        oscsub = '_NOCLKOUT'
      else if pos(' CLKO',val2) > 0      |,
              pos('CLOCK OUT',val2) > 0  |,
              pos(' CLOCK',val2) > 0     then
        oscsub = '_CLKOUT'
      else
        oscsub = '_NOCLKOUT'
    end

    oscname = osctype||oscsub                   /* combine */
    if aoscname.oscname = '-' then do           /* not duplicate */
      aoscname.oscname = oscname                /* store name */
      call lineout JalFile, '       'oscname '= 0x'mask
    end
    else do
      say 'Duplicate OSC name:' oscname '('val2')'
    end
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for watchdog postscaler  */
/* ------------------------------------------- */
list_fuse_def_wdtps: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &  word(dev.i,1) = 'SETTING'
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)                  /* remove blanks */
    parse var val2 p0 ':' p1            /* split */
    p1 = translate(p1, '______','.,()=/')  /* to underscore */
    p1 = word(p1,1)
    offset = pos('_',p1)
    do while offset > 1                 /* remove underscores */
      p1 = substr(p1,1,offset-1)||substr(p1,offset+1)
      offset = pos('_',p1)
    end
    call lineout JalFile, '       P'p1 '= 0x'val1
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for watchdog settings    */
/* ------------------------------------------- */
list_fuse_def_wdt: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &  word(dev.i,1) = 'SETTING'
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)                  /* remove blanks */
    if val2 = 'ON' | pos('ENABLE', val2) > 0  then      /* replace */
      val2 = 'ENABLED'
    else if val2 = 'OFF' | pos('DISABLE',val2) > 0 then   /* replace */
      val2 = 'DISABLED'
    else
      val2 = translate(val2, '_________________',' +-:;.,<>{}[]()=/')  /* undersc. */
    call lineout JalFile, '       'val2 '= 0x'val1
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for /MCLR settings       */
/* ------------------------------------------- */
list_fuse_def_mclr: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &  word(dev.i,1) = 'SETTING'
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)
    val2 = strip(val2)
    if pos('EXTERN',val2) > 0       |,
       pos('MCLR ENABLED',val2) > 0 |,
       pos('MASTER',val2) > 0       |,
       pos('AS MCLR',val2) > 0      |,
       val2 = 'MCLR'                |,
       val2 = 'ENABLED'  then
      Val2 = 'EXTERNAL'
    else
      Val2 = 'INTERNAL'
    call lineout JalFile, '       'val2 '= 0x'val1
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for brownout voltage     */
/* ------------------------------------------- */
list_fuse_def_voltage: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &  word(dev.i,1) = 'SETTING'
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)                          /* remove blanks */
    val2 = word(val2, words(val2))              /* only last word */
    parse var val2 p1 '.' p2 'V'                /* select digits */
    call lineout JalFile, '       V'p1||p2 '= 0x'val1
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for brownout settings    */
/* ------------------------------------------- */
list_fuse_def_brownout: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &  word(dev.i,1) = 'SETTING'
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)                  /* remove blanks */
    if pos('SLEEP',val2) > 0  &  pos('DEEP SLEEP',val2) = 0 then
      Val2 = 'RUNONLY'
    else if pos('ENABLE',val2) \= 0  |,
            val2 = 'ON' then
      val2 = 'ENABLED'
    else if pos('CONTROL',val2) \= 0 then
      Val2 = 'CONTROL'
    else
      Val2 = 'DISABLED'
    call lineout JalFile, '       'val2 '= 0x'val1
  end
end
return


/* ------------------------------------------- */
/* Generate fuse_defs for 'other' settings     */
/* ------------------------------------------- */
list_fuse_def_other: procedure expose Dev. JalFile
do i = arg(1) + 1 while i <= dev.0  &,
       (word(dev.i,1) = 'SETTING' | word(dev.i,1) = 'CHECKSUM')
  parse var Dev.i 'SETTING' val0 'VALUE' '=' '0X',
                         val1 'DESC' '=' '"' val2 '"' ')' .
  if val1 \= '' then do
    val1 = strip(val1)                          /* remove blanks */
    if val2 = 'ON' then                         /* replace */
      val2 = 'ENABLED'
    else if val2 = 'OFF' then                   /* replace */
      val2 = 'DISABLED'
    else if pos('ANALOG',val2) > 0 then
      val2 = 'ANALOG'
    else if pos('DIGITAL',val2) > 0 then
      val2 = 'DIGITAL'
    else do
      val2 = translate(val2, '_________________',' +-:;.,<>{}[]()=/')  /* to blanks */
      if left(val2,1) >= '0' & left(val2,1) <= '9' then
        val2 = '_'val2                  /* prefix when numeric */
      end
    call lineout JalFile, '       'val2 '= 0x'val1

  end
end
return


/* -------------------------------------------------------- */
/* Generate functions w.r.t. analog modules.                */
/* First individual procedures for different analog modules */
/* then a procedure to invoke these procedures              */
/*                                                          */
/* Possible combinations for the different PICS:            */
/* ANSEL   [ANSELH]                                         */
/* ANSEL0  [ANSEL1]                                         */
/* ANSELA   ANSELB [ANSELD  ANSELE]                         */
/* ADCON0  [ADCON1 [ADCON2 [ADCON3]]]                       */
/* ANCON0   ANCON1                                          */
/* CMCON                                                    */
/* CMCON0  [CMCON1]                                         */
/* Between brackets optional, otherwise always together.    */
/* -------------------------------------------------------- */
list_analog_functions: procedure expose JalFile Name.
call lineout JalFile, '--'
call lineout JalFile, '-- ==================================================='
call lineout JalFile, '--'
call lineout JalFile, '-- Special device dependent procedures'
call lineout JalFile, '--'

analog. = '-'                                           /* no analog modules */

if Name.ANSEL  \= '-' | Name.ANSEL1 \= '-' |,
   Name.ANSELA \= '-' | Name.ANCON0 \= '-'  then do
  analog.ANSEL = 'analog'                       /* analog functions present */
  call lineout JalFile, '-- ---------------------------------------------------'
  call lineout JalFile, '-- Change analog I/O pins into digital I/O pins.'
  call lineout JalFile, '--'
  call lineout JalFile, 'procedure analog_off() is'
  call lineout JalFile, '  pragma inline'
  if Name.ANSEL \= '-' then do                          /* ANSEL declared */
    call lineout JalFile, '  ANSEL  = 0b0000_0000        -- all digital'
    if Name.ANSELH \= '-' then
      call lineout JalFile, '  ANSELH = 0b0000_0000        -- all digital'
  end
  if Name.ANSEL0 \= '-' then do                         /* ANSEL0 declared */
    suffix = '0123456789'                               /* suffix numbers */
    do i = 1 to length(suffix)
      qname = 'ANSEL'substr(suffix,i,1)                 /* qualified name */
      if Name.qname \= '-' then                         /* ANSELx declared */
        call lineout JalFile, '  'qname '= 0b0000_0000        -- all digital'
    end
  end
  if Name.ANSELA \= '-' then do                         /* ANSELA declared */
    suffix = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'               /* suffix letters */
    do i = 1 to length(suffix)
      qname = 'ANSEL'substr(suffix,i,1)                 /* qualified name */
      if Name.qname \= '-' then                         /* ANSELx declared */
        call lineout JalFile, '  'qname '= 0b0000_0000        -- all digital'
    end
  end
  if Name.ANCON0 \= '-' then do                         /* ANCON0 declared */
    if Name.WDTCON_ADSHR \= '-' then
      call lineout JalFile, '  WDTCON_ADSHR = TRUE         -- make ADCONx addressable'
    call lineout JalFile, '  ANCON0 = 0b1111_1111        -- all digital'
    call lineout JalFile, '  ANCON1 = 0b1111_1111        -- all digital'
    if Name.WDTCON_ADSHR \= '-' then
      call lineout JalFile, '  WDTCON_ADSHR = FALSE        -- release ADCONx'
  end
  call lineout JalFile, 'end procedure'
  call lineout JalFile, '--'
end

if Name.ADCON0 \= '-' then do
  analog.ADC = 'adc'                                    /* ADC module present */
  call lineout JalFile, '-- ---------------------------------------------------'
  call lineout JalFile, '-- Disable ADC module.'
  call lineout JalFile, '--'
  call lineout JalFile, 'procedure adc_off() is'
  call lineout JalFile, '  pragma inline'
  call lineout JalFile, '  ADCON0_ADON = FALSE        -- disable ADC'
  if Name.ADCON1 \= '-' then do
    call lineout JalFile, '  ADCON1 = 0b1111_1111       -- digital I/O'
  end
/* temporary(?) disabled code: no more selective setting with all-ones in ADCON1 above
  if Name.ADCON1 \= '-' then do
    if PicName = '16F737' | PicName == '16F747' |,
       PicName = '16F767' | PicName == '16F777' then
      call lineout JalFile, '  ADCON1 = 0b0000_1111        -- digital I/O'
    else
      call lineout JalFile, '  ADCON1 = 0b0000_0111        -- digital I/O'
  end
*/
  call lineout JalFile, 'end procedure'
  call lineout JalFile, '--'
end

if Name.CMCON \= '-' | Name.CMCON0 \= '-' then do
  analog.CMCON = 'comparator'                           /* Comparator present */
  call lineout JalFile, '-- ---------------------------------------------------'
  call lineout JalFile, '-- Disable comparator module'
  call lineout JalFile, '--'
  call lineout JalFile, 'procedure comparator_off() is'
  call lineout JalFile, '  pragma inline'
  if Name.CMCON \= '-' then do
    call lineout JalFile, '  CMCON  = 0b0000_0111        -- disable comparators'
  end
  else if Name.CMCON0 \= '-' then do
    call lineout JalFile, '  CMCON0 = 0b0000_0111        -- disable comparators'
  end
  call lineout JalFile, 'end procedure'
  call lineout JalFile, '--'
end

call lineout JalFile, '-- ---------------------------------------------------'
call lineout JalFile, '-- Change ports which have analog function by default'
call lineout JalFile, '-- into digital I/O.'
call lineout JalFile, '--'
call lineout JalFile, 'procedure enable_digital_io() is'
call lineout JalFile, '  pragma inline'
do k over analog.
  call lineout JalFile, '  'analog.k'_off()'
end
call lineout JalFile, 'end procedure'
call lineout JalFile, '--'

return


/* --------------------------------------- */
/* Generate common header                  */
/* --------------------------------------- */
list_head:
call lineout JalFile, '-- ==================================================='
call lineout JalFile, '-- Title: JalV2 device include file for pic'PicName
call list_copyright_etc JalFile
call lineout JalFile, '-- Description:' 'Device include file for pic'PicName', containing:'
call lineout JalFile, '--                - Declaration of ports and pins of the chip.'
if core \= 16 then do                           /* for the baseline and midrange */
  call lineout JalFile, '--                - Procedures for shadowing of ports and pins'
  call lineout JalFile, '--                  to circumvent the read-modify-write problem.'
end
else do                                         /* for the 18F series */
  call lineout JalFile, '--                - Procedures to force the use of the LATx register'
  call lineout JalFile, '--                  when PORTx is addressed.'
end
call lineout JalFile, '--                - Symbolic definitions for config bits (fuses)'
call lineout JalFile, '--                - Some device dependent procedures for common'
call lineout JalFile, '--                  operations, like:'
call lineout JalFile, '--                   . enable-digital-io.'
call lineout JalFile, '--'
call lineout JalFile, '-- Sources:'
call lineout JalFile, '--  -' DevFile
call lineout JalFile, '--  -' LkrFile
call lineout JalFile, '--'
call lineout JalFile, '-- Notes:'
call lineout JalFile, '--  - Created with Dev2Jal Rexx script version' ScriptVersion
call lineout JalFile, '--  - File creation date/time:' date('N') time('N')'.'
call lineout JalFile, '--'
call lineout JalFile, '-- ==================================================='
call lineout JalFile, '--'
call list_devID
call list_datasheet
call list_pgmspec
call list_Vdd
call list_Vpp

call lineout JalFile, '--'
call lineout JalFile, '-- ---------------------------------------------------'
call lineout JalFile, '--'
call lineout JalFile, 'include chipdef                     -- common constants'
call lineout JalFile, '--'
call lineout JalFile, 'pragma  target  cpu   PIC_'Core '   -- (banks = 'Numbanks')'
call lineout JalFile, 'pragma  target  chip  'PicName
call lineout JalFile, 'pragma  target  bank  0x'D2X(BANKSIZE,4)
if core = 12  then do
  call lineout JalFile, 'pragma  target  page  0x'D2X(PAGESIZE,4)
  call lineout JalFile, 'pragma  stack   'StackDepth
end
else if core = 14  then do
  call lineout JalFile, 'pragma  target  page  0x'D2X(PAGESIZE,4)
  call lineout JalFile, 'pragma  stack   'StackDepth
end
else if Core = 16  then do
  call lineout JalFile, 'pragma  stack   'StackDepth
end
call list_code_size
call list_data_size
MaxUnsharedRAM = 0                              /* no unshared RAM */
call list_unshared_data_range
MaxSharedRAM = 0                                /* no shared RAM */
x = list_shared_data_range()                    /* returns range string */
/* - - - - - - - -  temporary? - - - - - - - - - - - - - - - - - */
if MaxUnsharedRAM = 0  &  MaxSharedRAM > 0 then do      /* no unshared RAM */
  if PicName \= '12f629' & PicName \= '12f675'  &,      /* known as 'OK' */
     PicName \= '16f630' & PicName \= '16f676'   ,
  then do
    say 'Warning:' PicName 'has only shared, no unshared RAM!'
    Say '         May have to be handled as exceptional chip!'
  end
end
else if MaxSharedRAM = 0 then do                        /* no shared RAM */
  if Core \= 12                                 &,      /* known as 'OK' */
     PicName \= '16f73'                         &,
     PicName \= '16f74'                         &,
     PicName \= '16f83'                         &,
     PicName \= '16f84'  & PicName \= '16f84a'  &,
     PicName \= '16f873' & PicName \= '16f873a' &,
     PicName \= '16f874' & PicName \= '16f874a' &,
     PicName \= '16hv540'                        ,
  then do
    say 'Warning:' PicName 'has no shared RAM!'
    Say '         May have to be handled as exceptional chip!'
  end
end
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
call lineout JalFile, '--'
if Core = 12  | Core = 14 then do
  if x \= '' then do                            /* with shared RAM */
    call lineout JalFile, 'var volatile byte _pic_accum shared at',
                          sfr_mirror(MaxSharedRAM-1)'   -- (compiler)'
    call lineout JalFile, 'var volatile byte _pic_isr_w shared at',
                          sfr_mirror(MaxSharedRAM)'   -- (compiler)'
  end
  else do                                       /* no shared RAM */
    call lineout JalFile, 'var volatile byte _pic_accum at',
                          sfr_mirror(MaxUnsharedRAM-1)'   -- (compiler)'
    call lineout JalFile, 'var volatile byte _pic_isr_w at',
                          sfr_mirror(MaxUnSharedRAM)'   -- (compiler)'
  end
end
else if Core = 16 then do                       /* 16-bits core */
  call lineout JalFile, 'var volatile byte _pic_accum shared at',
                                 '0x'D2X(MaxSharedRAM-1)'   -- (compiler)'
  call lineout JalFile, 'var volatile byte _pic_isr_w shared at',
                                 '0x'D2X(MaxSharedRAM)'   -- (compiler)'
end
call lineout JalFile, '--'
return


/* ------------------------------------------------- */
/* List common constants in ChipDef.Jal              */
/* input:  - nothing                                 */
/* ------------------------------------------------- */
list_chip_const:
call lineout ChipFile, '-- =================================================================='
call lineout ChipFile, '-- Title: Common JalV2 compiler include file'
call list_copyright_etc ChipFile
call lineout ChipFile, '-- Sources:'
call lineout ChipFile, '--'
call lineout ChipFile, '-- Description: Common JalV2 compiler include file'
call lineout ChipFile, '--'
call lineout ChipFile, '-- Notes:'
call lineout ChipFile, '--  - Created with Dev2Jal Rexx script version' ScriptVersion
call lineout ChipFile, '--  - File creation date/time:' date('N') time('N')'.'
call lineout ChipFile, '--'
call lineout ChipFile, '-- ---------------------------------------------------'
call lineout ChipFile, 'const       PIC_12            = 1'
call lineout ChipFile, 'const       PIC_14            = 2'
call lineout ChipFile, 'const       PIC_16            = 3'
call lineout ChipFile, 'const       SX_12             = 4'
call lineout ChipFile, '--'
call lineout ChipFile, 'const bit   PJAL              = 1'
call lineout ChipFile, '--'
call lineout ChipFile, 'const byte  W                 = 0'
call lineout ChipFile, 'const byte  F                 = 1'
call lineout ChipFile, '--'
call lineout ChipFile, 'const bit   TRUE              = 1'
call lineout ChipFile, 'const bit   FALSE             = 0'
call lineout ChipFile, 'const bit   HIGH              = TRUE'
call lineout ChipFile, 'const bit   LOW               = FALSE'
call lineout ChipFile, 'const bit   ON                = TRUE'
call lineout ChipFile, 'const bit   OFF               = FALSE'
call lineout ChipFile, 'const bit   ENABLED           = TRUE'
call lineout ChipFile, 'const bit   DISABLED          = FALSE'
call lineout ChipFile, 'const bit   INPUT             = TRUE'
call lineout ChipFile, 'const bit   OUTPUT            = FALSE'
call lineout ChipFile, 'const byte  ALL_INPUT         = 0b_1111_1111'
call lineout ChipFile, 'const byte  ALL_OUTPUT        = 0b_0000_0000'
call lineout ChipFile, '--'
call lineout ChipFile, '-- =================================================================='
call lineout ChipFile, '--'
call lineout ChipFile, '-- Values assigned to const "target_chip" by'
call lineout ChipFile, '-- "pragma target chip" in device include files.'
call lineout ChipFile, '-- Can be used for conditional compilation,',
                       'for example:'
call lineout ChipFile, '--    if (target_chip = PIC_16F88) then'
call lineout ChipFile, '--      ....                                  -- for 16F88 only'
call lineout ChipFile, '--    endif'
call lineout ChipFile, '--'
return


/* ------------------------------------------------- */
/* Add copyright, etc to header in all created files */
/* input: filespec of destination file               */
/* returns: nothing                                  */
/* ------------------------------------------------- */
list_copyright_etc:
ListFile = arg(1)                               /* destination filespec */
call lineout ListFile, '--'
call lineout ListFile, '-- Author:' ScriptAuthor', Copyright (c) 2008..2008,',
                       'all rights reserved.'
call lineout ListFile, '--'
call lineout ListFile, '-- Adapted-by:'
call lineout ListFile, '--'
call lineout ListFile, '-- Compiler:' CompilerVersion
call lineout ListFile, '--'
call lineout ListFile, '-- This file is part of jallib',
                       ' (http://jallib.googlecode.com)'
call lineout ListFile, '-- Released under the BSD license',
                       '(http://www.opensource.org/licenses/bsd-license.php)'
call lineout ListFile, '--'
return

/* --------------------------------------------------------- */
/* procedure to extend address with mirrored addresses       */
/* input:  - register number (decimal)                       */
/* returns string of addresses between {}                    */
/* (not used for 16-bit core)                                */
/* --------------------------------------------------------- */
sfr_mirror: procedure expose Ram. BANKSIZE NumBanks
addr = arg(1)
addr_list = '{ 0x'D2X(addr)                     /* open bracket, orig. addr */
do i = addr + BANKSIZE to NumBanks * BANKSIZE - 1 by BANKSIZE   /* avail ram */
  if addr = Ram.i then                          /* matching reg number */
    addr_list = addr_list',0x'D2X(i)            /* concatenate to string */
end
return addr_list' }'                            /* complete string */


/* --------------------------------------------- */
/* Signal duplicates name.                       */
/* Collect all names in Name. compound var       */
/* Return - 0 when name is unique                */
/*        - 1 when name is dumplicate            */
/* --------------------------------------------- */
duplicate_name: procedure expose Name.
newname = arg(1)
if newname = '' then                            /* no name specified */
  return 1                                      /* not acceptable */
reg = arg(2)                                    /* register */
if Name.newname = '-' then do                   /* name not in use yet */
  Name.newname = reg                            /* mark in use by which reg */
  return 0                                      /* unique */
end
if reg \= newname then do                       /* not alias of register */
  Say 'Duplicate name:' newname 'in' reg'. First occurence:' Name.newname
  return 1                                      /* duplicate */
end


