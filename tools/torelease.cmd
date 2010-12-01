/* ------------------------------------------------------------------------ *
 * Title: Process TORELEASE file to check consistency with Jallib           *
 *                                                                          *
 * Author: Rob Hamerling, Copyright (c) 2008..2010, all rights reserved.    *
 *                                                                          *
 * Adapted-by:                                                              *
 *                                                                          *
 * Compiler: N/A                                                            *
 *                                                                          *
 * This file is part of jallib  http://jallib.googlecode.com                *
 * Released under the BSD license                                           *
 *              http://www.opensource.org/licenses/bsd-license.php          *
 *                                                                          *
 * Description:                                                             *
 * - read TORELEASE and                                                     *
 *   check if file exists and is also in SVN tree                           *
 *   collect Picnames used in names of samples                              *
 * - collect entries into compound variable f.                              *
 *   on a per-directory basis (1st level subdirectory)                      *
 *   collect PICnames used in names of samples                              *
 * - check if there is a basic blink-a-led sample for every device file     *
 * - check if there is a device file for every sample                       *
 *   (based on name of PIC in filename)                                     *
 * - collect some statistics for every main library group                   *
 * - list these statistics                                                  *
 * - collect Jallib contents (directory tree) and                           *
 *    - list if unreleased                                                  *
 *    - list if sample released but device file not                         *
 * - sort each of the parts (on first level directory)                      *
 *   and create new TORELEASE                                               *
 *                                                                          *
 * Sources: none                                                            *
 *                                                                          *
 * Notes:                                                                   *
 *  - When a commandline argument 'runtype' is specified a more extensive   *
 *    listing is produced: ALL unrelease files are listed,                  *
 *    (by default unreleased device files and unreleased basic blink-a-led  *
 *     samples are not listed, only counted).                               *
 *                                                                          *
 * ------------------------------------------------------------------------ */

parse upper arg runtype .                                   /* any: list all unreleased files */

base       = 'k:/jallib'                                    /* base Jallib directory */
libdir     = base'/include'                                 /* libraries */
smpdir     = base'/sample'                                  /* samples */
projdir    = base'/project'                                 /* project files */
torelease  = base'/TORELEASE'                               /* TORELEASE file */
newrelease = 'TORELEASE.NEW'                                /* release list */
list       = 'torelease.lst'                                /* script output */
svnpath    = '.svn/text-base/'                              /* svn path insert */

count.     = 0                                              /* zero all file counts */
dev.       = '-'                                            /* PIC names in device files */
smppic.    = '-'                                            /* PIC names in sample files */
blinkpic.  = '-'                                            /* PIC names in blink sample files */

f.                 = 0                                      /* common counpund variable */
f.device.0         = 0
f.doc.0            = 0
f.external.0       = 0
f.filesystem.0     = 0
f.jal.0            = 0
f.peripheral.0     = 0
f.protocol.0       = 0
f.project.0        = 0
f.sample.0         = 0

blink_sample_count = 0

say 'Checking contents of' torelease 'against' base

call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs                                   /* load Rexx utilities */

if stream(list,'c','query exists') \= '' then
  call SysFileDelete list
call stream  list, 'c', 'open write'
call lineout list, ''
call lineout list, 'Analysis of' filespec('N', torelease) 'dd' date('N')  time('N')
call lineout list, ''

linenumber = 0
call stream torelease, 'c', 'open read'
do while lines(torelease)                                   /* collect files */
  ln = linein(torelease)
  linenumber = linenumber + 1
  if length(ln) = 0  |  left(word(ln,1),1) = '#' then
    iterate                                                 /* skip line */
  ln = translate(ln, xrange('a','z'), xrange('A','Z'))      /* ensure lower case */
  if stream(base'/'ln, 'c', 'query exists') = '' then do
    call lineout list, format(linenumber,4)'. File <'ln'> missing in' base
    svnspec = base'/'filespec('P',ln)||svnpath||filespec('N',ln)'.svn-base'
    if stream(svnspec, 'c', 'query exists') = '' then
      call lineout list, format(linenumber,4)'. File <'ln'> not in in SVN!'
  end
  select
    when left(ln,15) = 'include/device/' then
      part = 'device'
    when left(ln,4) = 'doc/' then
      part = 'doc'
    when left(ln,17) = 'include/external/' then
      part = 'external'
    when left(ln,19) = 'include/filesystem/' then
      part = 'filesystem'
    when left(ln,12) = 'include/jal/' then
      part = 'jal'
    when left(ln,19) = 'include/peripheral/' then
      part = 'peripheral'
    when left(ln,17) = 'include/protocol/' then
      part = 'protocol'
    when left(ln,8) = 'project/' then
      part = 'project'
    when left(ln,7) = 'sample/' then do
      part = 'sample'
      parse var ln 'sample/' PicName '_' .                  /* isolate name of PIC */
      if PicName \= '' then do                              /* picname found */
        PicNameUpper = translate(PicName,xrange('A','Z'),xrange('a','z'))
        smppic.PicNameUpper = PicName                       /* PIC with at least 1 sample */
        if ln = 'sample/'PicName'_blink.jal' then do                 /* basic blink sample */
          blink_sample_count = blink_sample_count + 1       /* count 'm */
          blinkpic.PicNameUpper = PicName                   /* blink sample found for this PIC */
        end
      end
    end
    otherwise
      say 'Unrecognised entry:' ln
      iterate
  end
  part = translate(part,xrange('A','Z'),xrange('a','z'))    /* upper case required */
  k = f.part.0 + 1
  f.part.k = ln
  f.part.0 = k
end
call stream torelease, 'c', 'close'

do i = 1 to f.device.0                                      /* all device files */
  if f.device.i = 'include/device/chipdef_jallib.jal' then
    iterate                                                 /* skip */
  parse value filespec('n',f.device.i) with PicName '.jal' .   /* PIC name */
  PicNameUpper = translate(PicName,xrange('A','Z'),xrange('a','z'))
  if blinkpic.PicNameUpper \= PicName then
    call lineout list, 'No blink sample for' PicName
  dev.PicNameUpper = PicName                                /* remember device file */
end

do i = 1 to f.sample.0                                      /* all samples */
  parse var f.sample.i 'sample/' PicSamp '.jal' .           /* sample filename */
  parse var PicSamp PicName '_' .                           /* name of PIC */
  PicNameUpper = translate(PicName,xrange('A','Z'),xrange('a','z'))
  if PicName \= dev.PicNameUpper then                       /* not released device file */
     call lineout list, 'Device file' PicName'.jal',
                        'for sample' PicSamp'.jal not released'
  select
    when pos(PicName'_adc',PicSamp) > 0 then                /* check for ADC sample */
      count.adc = count.adc + 1
    when pos(PicName'_blink',PicSamp) > 0 then              /* check for BLINK sample */
      count.blink = count.blink + 1
    when pos(PicName'_i2c_',PicSamp) > 0 then               /* check for I2C sample */
      count.i2c = count.i2c + 1
    when pos(PicName'_lcd_',PicSamp) > 0 then               /* check for LCD sample */
      count.lcd = count.lcd + 1
    when pos(PicName'_pwm_',PicSamp) > 0 then               /* check for PWM sample */
      count.pwm = count.pwm + 1
    when pos(PicName'_serial_',PicSamp) > 0 then            /* check for SERIAL sample */
      count.serial = count.serial + 1
    when pos(PicName'_usb_',PicSamp) > 0 then               /* check for USB sample */
      count.usb = count.usb + 1
    otherwise
      count.othersamples = count.othersamples + 1             /* other sample */
      if left(PicSamp,2) \= '10' &,
         left(PicSamp,2) \= '12' &,
         left(PicSamp,2) \= '16' &,
         left(PicSamp,2) \= '18' then do
         call lineout list, 'Sample' PicSamp 'may have to be renamed!'
      end
  end
end

total_libraries = f.external.0 + f.filesystem.0 + f.jal.0 + f.peripheral.0 + f.protocol.0
total_samples = count.adc + count.blink  + count.i2c + count.lcd +,
                count.pwm + count.serial + count.usb + count.othersamples

call lineout list, ''
call lineout list, 'TORELEASE contains' format(f.device.0 - 1,4) 'device files'
call lineout list, '                  ' format(total_libraries,4) 'function libraries'
call lineout list, '                  ' format(total_samples,4) 'samples in following categories:',
                                          '(based on primary library)'
call lineout list, '                      ' format(count.adc,4) 'ADC samples'
call lineout list, '                      ' format(count.blink,4) 'blink samples'
call lineout list, '                      ' format(count.i2c,4) 'I2C samples'
call lineout list, '                      ' format(count.lcd,4) 'LCD samples'
call lineout list, '                      ' format(count.pwm,4) 'PWM samples'
call lineout list, '                      ' format(count.serial,4) 'Serial samples'
call lineout list, '                      ' format(count.usb,4) 'USB samples'
call lineout list, '                      ' format(count.othersamples,4) 'Other samples'
call lineout list, '                  ' format(f.project.0,4) 'project files'
call lineout list, '                  ' format(count.misc,4) 'other files'
call lineout list, ''

call lineout list, ''
call charout list, 'Unreleased libraries'
if runtype = '' then
  call charout list, ' (excluding unreleased device files)'
else
  call charout list, ' and device files'
call lineout list, ''
call lineout list, '--------------------------------------------------------'

call SysFileTree libdir'/*.jal', 'fls', 'FSO'        /* libraries */
if fls.0 = 0 then do
   call lineout list, "Found no libraries in '"libdir"'"
  return 1
end
unlisted = 0
unlisteddevice = 0
do i=1 to fls.0
  fls.i = translate(fls.i, '/', '\')                        /* backward to forward slash */
  filespec = substr(fls.i, length(base) + 2)                /* remove base prefix */
  call SysFileSearch filespec, torelease, x.                /* search file in list */
  if x.0 = 0 then do                                        /* file not found */
    unlisted = unlisted + 1
    parse var filespec 'include/device/' PicName .          /* if devicename: get name of PIC */
    if PicName \= '' then do                                /* unreleased device file */
      unlisteddevice = unlisteddevice + 1
      if runtype \= '' then
        call lineout list, filespec
      if smppic.PicName \= '-' then                         /* sample present! */
        call lineout list, filespec '(unreleased device file, but sample program released)'
    end
    else                                                    /* not device file */
      call lineout list, filespec                           /* not released lib */
  end
end
call lineout list, ''
if runtype \= '' then
  call lineout list, unlisted 'unreleased include files'
else
  call lineout list, unlisted - unlisteddevice 'unreleased libraries',
                     '+' unlisteddevice 'unreleased device files'
call lineout list, ''
call lineout list, ''


call charout list, 'Unreleased samples'
if runtype = '' then
  call charout list, ' (excluding unreleased basic blink samples)'
else
  call charout list, ' (including basic blink samples)'
call lineout list, ''
call lineout list, '-------------------------------------------------------'

call SysFileTree smpdir'/*.jal', 'fls', 'FSO'        /* samples */
if fls.0 = 0 then do
   call lineout list, "Found no samples in '"libdir"'"
  return 1
end
unlisted = 0
unlistedblink = 0
do i=1 to fls.0
  fls.i = translate(fls.i, '/', '\')
  filespec = substr(fls.i, length(base) + 2)        /* remove base prefix */
  call SysFileSearch filespec, torelease, x.
  if x.0 = 0 then do                                /* not found */
    unlisted = unlisted + 1
    if right(filespec,10) = '_blink.jal' then do    /* original blink sample */
      unlistedblink = unlistedblink + 1
      if runtype \= '' then                         /* to be listed */
        call lineout list, filespec                 /* list not released blink sample */
    end
    else                                            /* not blink sample */
      call lineout list, filespec                   /* list not released sample */
  end
end
call stream torelease, 'c', 'close'
call lineout list, ''
if runtype \= '' then
  call lineout list, unlisted 'unreleased sample files'
else
  call lineout list, unlisted - unlistedblink 'unreleased sample files',
                     '+' unlistedblink 'unreleased basic blink samples'
call lineout list, ''
call lineout list, ''


call lineout list, 'Unreleased Project files'
call lineout list, '------------------------'
call SysFileTree projdir'/*', 'fls', 'FSO'         /* project files */
unlisted = 0
do i=1 to fls.0
  if pos('.svn', fls.i) > 0 then                   /* svn file */
    iterate                                        /* ignore */
  fls.i = translate(fls.i, '/', '\')
  filespec = substr(fls.i, length(base) + 2)       /* remove base prefix */
  call SysFileSearch filespec, torelease, x.
  if x.0 = 0 then do                               /* not found */
    unlisted = unlisted + 1
    call lineout list, filespec                    /* list not released lib */
  end
end
call lineout list, ''
call lineout list, unlisted 'unreleased project files'
call lineout list, ''
call stream list, 'c', 'close'

say 'See' list 'for the results'

/* write new 'torelease' */

if stream(newrelease,'c','query exists') \= '' then
  call SysFileDelete newrelease
call stream newrelease, 'c', 'open write'
call listpart 'device', 'Device files'
call listpart 'external', 'Externals'
call listpart 'filesystem', 'FileSystems'
call listpart 'jal', 'JAL extensions'
call listpart 'peripheral', 'Peripherals'
call listpart 'protocol', 'Protocols'
call listpart 'project', 'Projects'
call listpart 'sample', 'Samples'
call listpart 'doc', 'Static documentation (only in jallib-pack)'
call stream newrelease, 'c', 'close'

return 0     /* all done */


/* ----------------------------------------------- */
/* Write members of subdirectory to new torelease  */
/* after being sorted on name                      */
/* ----------------------------------------------- */
listpart: procedure expose f. newrelease
parse arg part, title
part = translate(part, xrange('A','Z'), xrange('a','z'))    /* make upper case */
parse upper var part part
call sortpart part                                          /* sort this part of collection */
call lineout newrelease, '#' title
do k = 1 to f.part.0
  call lineout newrelease, f.part.k
end
call lineout newrelease, ''
return

/* --------------------------------------------- */
/* Sorting members of 1st level subdirectory     */
/* '_' in name for sort changed into '/'         */
/* such that 16f72_xxx comes before 16f722_xxx   */
/* --------------------------------------------- */
sortpart: procedure expose f. newrelease
parse arg part .
do i = 1 to f.part.0 - 1
  lo = translate(f.part.i,'/','_')                          /* underscore higher than ASCII digit */
  do j = i + 1 to f.part.0
    hi = translate(f.part.j,'/','_')
    if lo > hi then do                                      /* desc. sequence */
      tmp = f.part.i
      f.part.i = f.part.j
      f.part.j = tmp
    end
    else if lo = hi then do                                 /* equal */
      call lineout newrelease, '#' f.part.j '     (duplicate)'
    end
  end
end
return

