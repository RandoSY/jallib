/* ------------------------------------------------------------------------ *
 * Title: Pic2edc.cmd - expand .pic files to '.edc' files                   *
 *                                                                          *
 * Author: Rob Hamerling, Copyright (c) 2013..2014, all rights reserved.    *
 *                                                                          *
 * Adapted-by:                                                              *
 *                                                                          *
 * Revision: $Revision$                                                     *
 *                                                                          *
 * Compiler: N/A                                                            *
 *                                                                          *
 * This file is part of jallib  http://jallib.googlecode.com                *
 * Released under the BSD license                                           *
 *              http://www.opensource.org/licenses/bsd-license.php          *
 *                                                                          *
 * Description:                                                             *
 *   Rexx script to expand MPlab-X .pic files.                              *
 *   This includes:                                                         *
 *   - translate tab chars to blanks                                        *
 *   - remove module import section(s)                                      *
 *   - handle multiple xml nodes on one line                                *
 *   The resulting files are targets for the edc2jal script.                *
 *                                                                          *
 * Sources:  MPLAB-X .pic files, which can be found in:                     *
 * Program Files (x86)\Microchip\mplabx\mplab_ide\bin\lib\crownking.edc.jar *
 * and after unZIPping this file in .\content\edc\*                         *
 *                                                                          *
 * Notes:                                                                   *
 *   - This script is written in 'classic' Rexx executed on eComStation     *
 *     See Notes with Edc2jal script for running it on other platforms.     *
 *   - Old .edc files are not deleted (new files will overwrite old ones).  *
 *                                                                          *
 * ------------------------------------------------------------------------ */
   ScriptVersion   = '0.0.24'
   ScriptAuthor    = 'Rob Hamerling'
   mplabxversion   = '200'

MPLABXbase = 'k:/MPLAB-X_'mplabxversion'/'         /* base directory of MPLAB-X */
picdir     = MPLABXbase'crownking.edc.jar/content/edc'          /* dir with MPLAB .pic  */

/* wildcard = 'PIC1*.pic' */
wildcard = 'PIC16*f1788.pic'

call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs                                           /* load Rexx utilities */

say 'Expanding .pic files of  MPLAB-X version' mplabxversion/100

call SysFileTree picdir'/'wildcard, dir, 'FOS'              /* get list of matching files */
if dir.0 = 0 then do
   say 'No .pic files found matching <'wildcard'> in' picdir
   return 0                                                 /* nothing to do */
end

call SysStemSort 'dir.', 'A', 'I'                           /* sort on name */

do i = 1 to dir.0                                           /* all relevant .pic files */
                                                            /* init for each new PIC */
   PicFile = tolower(translate(dir.i,'/','\'))              /* lower case + forward slashes */
   parse value filespec('Name', PicFile) with 'pic' PicName '.pic'
   if PicName = '' then do
      say 'Could not derive PIC name from filespec: "'PicFile'"'
      leave                                                 /* setup error: terminate */
   end

   if \(substr(PicName,3,1) = 'f'    |,                     /* not flash PIC or */
        substr(PicName,3,2) = 'lf'   |,                     /*     low power flash PIC or */
        substr(PicName,3,2) = 'hv')  |,                     /*     high voltage flash PIC */
      PicName = '16hv540'     then do                       /* OTP */
      iterate                                               /* skip */
   end

   say PicName                                              /* progress signal */

   PicNameCaps = toupper(PicName)                           /* name of PIC in upper case */

   Pic. = ''                                                /* reset .pic file contents */
   Pic.0 = 0
   do while lines(PicFile)
      ln = translate(linein(PicFile), ' ', '09'x)
      j = Pic.0 + 1
      k = j
      indent = pos('<', ln) - 1
      do while pos('><', ln) > 0
         parse var ln part1 '><' ln
         Pic.j = part1'>'
         ln = copies(' ', indent)'<'ln
         Pic.0 = j
         j = j + 1
      end
      Pic.j = ln
      Pic.0 = j
   end
   call stream PicFile, 'c', 'close'

   do j = 0 to Pic.0
      if word(pic.j,1) = '<edc:Import>' then do
         do while word(pic.j, 1) \= '</edc:Import>'
            pic.j = ''
            j = j + 1
         end
         pic.j = ''
         leave
      end
   end

   edcfile = 'edc_'mplabxversion'\'Picname'.edc'            /* expanded .pic file */
   call SysFileDelete edcfile                               /* delete existing file */
   do j = 1 to Pic.0
      if length(Pic.j) > 0 then                             /* skip empty lines */
         call lineout edcfile, Pic.j
   end
   call stream edcfile, 'c', close                          /* done with .edc file */

end

signal off error
signal off syntax                                           /* restore to default */

call SysDropFuncs                                           /* release Rexxutil */

return 0


/* ---------------------------------------------- */
/* translate string to lower or upper case        */
/* ---------------------------------------------- */

tolower:
return translate(arg(1), xrange('a','z'), xrange('A','Z'))

toupper:
return translate(arg(1), xrange('A','Z'), xrange('a','z'))


