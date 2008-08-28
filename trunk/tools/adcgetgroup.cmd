/* --------------------------------------------------------------------- */
/* Title: ADCGetGroup.cmd - Rexx script to obtain ADC group PICmicro.    */
/*                                                                       */
/* Author: Rob Hamerling, Copyright (c) 2008..2008, all rights reserved. */
/*                                                                       */
/* Adapted-by:                                                           */
/*                                                                       */
/* Compiler: N/A                                                         */
/*                                                                       */
/* This file is part of jallib  http://jallib.googlecode.com             */
/* Released under the BSD license                                        */
/*              http://www.opensource.org/licenses/bsd-license.php       */
/*                                                                       */
/* Description: Rexx script to get the ADC group for a specific PIC.     */
/*              Input:   PicName                                         */
/*              Returns: ADCgroup ADDCV0..ADC_V11, or                    */
/*                       "-" when PIC has no ADC, or                     */
/*                       "?" when PICname not found.                     */
/*                                                                       */
/* Sources: - MCC18 header file pconfig.h                                */
/*          - Microchip datasheets                                       */
/*                                                                       */
/* Notes:                                                                */
/*  - Used by Dev2Jal script                                             */
/*                                                                       */
/* --------------------------------------------------------------------- */

parse upper arg PicName .           /* need PICname in upper case */
select
  when PicName = '10F200'     then return '-'
  when PicName = '10F202'     then return '-'
  when PicName = '10F204'     then return '-'
  when PicName = '10F206'     then return '-'
  when PicName = '10F220'     then return 'ADC_V0'
  when PicName = '10F222'     then return 'ADC_V0'
  when PicName = '12F508'     then return '-'
  when PicName = '12F509'     then return '-'
  when PicName = '12F510'     then return 'ADC_V0'
  when PicName = '12F519'     then return '-'
  when PicName = '12F609'     then return '-'
  when PicName = '12F615'     then return 'ADC_V0'
  when PicName = '12F629'     then return '-'
  when PicName = '12F635'     then return '-'
  when PicName = '12F675'     then return 'ADC_V0'
  when PicName = '12F683'     then return 'ADC_V0'
  when PicName = '12HV609'    then return '-'
  when PicName = '12HV615'    then return 'ADC_V0'
  when PicName = '16F505'     then return '-'
  when PicName = '16F506'     then return 'ADC_V0'
  when PicName = '16F526'     then return 'ADC_V0'
  when PicName = '16F54'      then return '-'
  when PicName = '16F57'      then return '-'
  when PicName = '16F59'      then return '-'
  when PicName = '16F610'     then return '-'
  when PicName = '16F616'     then return 'ADC_V0'
  when PicName = '16F627'     then return '-'
  when PicName = '16F627A'    then return '-'
  when PicName = '16F628'     then return '-'
  when PicName = '16F628A'    then return '-'
  when PicName = '16F630'     then return '-'
  when PicName = '16F631'     then return '-'
  when PicName = '16F636'     then return '-'
  when PicName = '16F639'     then return '-'
  when PicName = '16F648A'    then return '-'
  when PicName = '16F676'     then return 'ADC_V0'
  when PicName = '16F677'     then return 'ADC_V0'
  when PicName = '16F684'     then return 'ADC_V0'
  when PicName = '16F685'     then return 'ADC_V0'
  when PicName = '16F687'     then return 'ADC_V0'
  when PicName = '16F688'     then return 'ADC_V0'
  when PicName = '16F689'     then return 'ADC_V0'
  when PicName = '16F690'     then return 'ADC_V0'
  when PicName = '16F716'     then return 'ADC_V1'
  when PicName = '16F72'      then return 'ADC_V1'
  when PicName = '16F722'     then return 'ADC_V0'
  when PicName = '16F723'     then return 'ADC_V0'
  when PicName = '16F724'     then return 'ADC_V0'
  when PicName = '16F726'     then return 'ADC_V0'
  when PicName = '16F727'     then return 'ADC_V0'
  when PicName = '16F73'      then return 'ADC_V1'
  when PicName = '16F737'     then return 'ADC_V2'
  when PicName = '16F74'      then return 'ADC_V1'
  when PicName = '16F747'     then return 'ADC_V2'
  when PicName = '16F76'      then return 'ADC_V1'
  when PicName = '16F767'     then return 'ADC_V2'
  when PicName = '16F77'      then return 'ADC_V1'
  when PicName = '16F777'     then return 'ADC_V2'
  when PicName = '16F785'     then return 'ADC_V0'
  when PicName = '16F818'     then return 'ADC_V1'
  when PicName = '16F819'     then return 'ADC_V1'
  when PicName = '16F83'      then return '-'
  when PicName = '16F84'      then return '-'
  when PicName = '16F84A'     then return '-'
  when PicName = '16F87'      then return '-'
  when PicName = '16F870'     then return 'ADC_V1'
  when PicName = '16F871'     then return 'ADC_V1'
  when PicName = '16F872'     then return 'ADC_V1'
  when PicName = '16F873'     then return 'ADC_V1'
  when PicName = '16F873A'    then return 'ADC_V1'
  when PicName = '16F874'     then return 'ADC_V1'
  when PicName = '16F874A'    then return 'ADC_V1'
  when PicName = '16F876'     then return 'ADC_V1'
  when PicName = '16F876A'    then return 'ADC_V1'
  when PicName = '16F877'     then return 'ADC_V1'
  when PicName = '16F877A'    then return 'ADC_V1'
  when PicName = '16F88'      then return 'ADC_V0'
  when PicName = '16F882'     then return 'ADC_V0'
  when PicName = '16F883'     then return 'ADC_V0'
  when PicName = '16F884'     then return 'ADC_V0'
  when PicName = '16F886'     then return 'ADC_V0'
  when PicName = '16F887'     then return 'ADC_V0'
  when PicName = '16F913'     then return 'ADC_V0'
  when PicName = '16F914'     then return 'ADC_V0'
  when PicName = '16F916'     then return 'ADC_V0'
  when PicName = '16F917'     then return 'ADC_V0'
  when PicName = '16F946'     then return 'ADC_V0'
  when PicName = '16HV540'    then return '-'
  when PicName = '16HV610'    then return '-'
  when PicName = '16HV616'    then return 'ADC_V0'
  when PicName = '16HV785'    then return 'ADC_V0'
  when PicName = '16LF722'    then return 'ADC_V0'
  when PicName = '16LF723'    then return 'ADC_V0'
  when PicName = '16LF724'    then return 'ADC_V0'
  when PicName = '16LF726'    then return 'ADC_V0'
  when PicName = '16LF727'    then return 'ADC_V0'
  when PicName = '18F1220'    then return 'ADC_V3'
  when PicName = '18F1230'    then return 'ADC_V4'
  when PicName = '18F1320'    then return 'ADC_V3'
  when PicName = '18F1330'    then return 'ADC_V4'
  when PicName = '18F13K20'   then return 'ADC_V2'
  when PicName = '18F13K22'   then return 'ADC_V10'
  when PicName = '18F13K50'   then return 'ADC_V10'
  when PicName = '18F14K20'   then return 'ADC_V2'
  when PicName = '18F14K22'   then return 'ADC_V10'
  when PicName = '18F14K50'   then return 'ADC_V10'
  when PicName = '18F2220'    then return 'ADC_V5'
  when PicName = '18F2221'    then return 'ADC_V5'
  when PicName = '18F2320'    then return 'ADC_V5'
  when PicName = '18F2321'    then return 'ADC_V5'
  when PicName = '18F2331'    then return 'ADC_V7_1'
  when PicName = '18F2410'    then return 'ADC_V5'
  when PicName = '18F242'     then return 'ADC_V1'
  when PicName = '18F2420'    then return 'ADC_V5'
  when PicName = '18F2423'    then return 'ADC_V5'
  when PicName = '18F2431'    then return 'ADC_V7_1'
  when PicName = '18F2439'    then return 'ADC_V1'
  when PicName = '18F2450'    then return 'ADC_V5'
  when PicName = '18F2455'    then return 'ADC_V5'
  when PicName = '18F2458'    then return 'ADC_V5'
  when PicName = '18F248'     then return 'ADC_V1'
  when PicName = '18F2480'    then return 'ADC_V5'
  when PicName = '18F24J10'   then return 'ADC_V6'
  when PicName = '18F24J11'   then return 'ADC_V11'
  when PicName = '18F24J50'   then return 'ADC_V11'
  when PicName = '18F24K20'   then return 'ADC_V8'
  when PicName = '18F2510'    then return 'ADC_V5'
  when PicName = '18F2515'    then return 'ADC_V5'
  when PicName = '18F252'     then return 'ADC_V1'
  when PicName = '18F2520'    then return 'ADC_V5'
  when PicName = '18F2523'    then return 'ADC_V5'
  when PicName = '18F2525'    then return 'ADC_V5'
  when PicName = '18F2539'    then return 'ADC_V1'
  when PicName = '18F2550'    then return 'ADC_V5'
  when PicName = '18F2553'    then return 'ADC_V5'
  when PicName = '18F258'     then return 'ADC_V1'
  when PicName = '18F2580'    then return 'ADC_V5'
  when PicName = '18F2585'    then return 'ADC_V5'
  when PicName = '18F25J10'   then return 'ADC_V6'
  when PicName = '18F25J11'   then return 'ADC_V11'
  when PicName = '18F25J50'   then return 'ADC_V11'
  when PicName = '18F25K20'   then return 'ADC_V8'
  when PicName = '18F2610'    then return 'ADC_V5'
  when PicName = '18F2620'    then return 'ADC_V5'
  when PicName = '18F2680'    then return 'ADC_V5'
  when PicName = '18F2682'    then return 'ADC_V5'
  when PicName = '18F2685'    then return 'ADC_V5'
  when PicName = '18F26J11'   then return 'ADC_V11'
  when PicName = '18F26J50'   then return 'ADC_V11'
  when PicName = '18F26K20'   then return 'ADC_V8'
  when PicName = '18F4220'    then return 'ADC_V5'
  when PicName = '18F4221'    then return 'ADC_V5'
  when PicName = '18F4320'    then return 'ADC_V5'
  when PicName = '18F4321'    then return 'ADC_V5'
  when PicName = '18F4331'    then return 'ADC_V7'
  when PicName = '18F4410'    then return 'ADC_V5'
  when PicName = '18F442'     then return 'ADC_V1'
  when PicName = '18F4420'    then return 'ADC_V5'
  when PicName = '18F4423'    then return 'ADC_V5'
  when PicName = '18F4431'    then return 'ADC_V7'
  when PicName = '18F4439'    then return 'ADC_V1'
  when PicName = '18F4450'    then return 'ADC_V5'
  when PicName = '18F4455'    then return 'ADC_V5'
  when PicName = '18F4458'    then return 'ADC_V5'
  when PicName = '18F448'     then return 'ADC_V1'
  when PicName = '18F4480'    then return 'ADC_V5'
  when PicName = '18F44J10'   then return 'ADC_V6'
  when PicName = '18F44J11'   then return 'ADC_V11'
  when PicName = '18F44J50'   then return 'ADC_V11'
  when PicName = '18F44K20'   then return 'ADC_V8'
  when PicName = '18F4510'    then return 'ADC_V5'
  when PicName = '18F4515'    then return 'ADC_V5'
  when PicName = '18F452'     then return 'ADC_V1'
  when PicName = '18F4520'    then return 'ADC_V5'
  when PicName = '18F4523'    then return 'ADC_V5'
  when PicName = '18F4525'    then return 'ADC_V5'
  when PicName = '18F4539'    then return 'ADC_V1'
  when PicName = '18F4550'    then return 'ADC_V5'
  when PicName = '18F4553'    then return 'ADC_V5'
  when PicName = '18F458'     then return 'ADC_V1'
  when PicName = '18F4580'    then return 'ADC_V5'
  when PicName = '18F4585'    then return 'ADC_V5'
  when PicName = '18F45J10'   then return 'ADC_V6'
  when PicName = '18F45J11'   then return 'ADC_V11'
  when PicName = '18F45J50'   then return 'ADC_V11'
  when PicName = '18F45K20'   then return 'ADC_V8'
  when PicName = '18F4610'    then return 'ADC_V5'
  when PicName = '18F4620'    then return 'ADC_V5'
  when PicName = '18F4680'    then return 'ADC_V5'
  when PicName = '18F4682'    then return 'ADC_V5'
  when PicName = '18F4685'    then return 'ADC_V5'
  when PicName = '18F46J11'   then return 'ADC_V11'
  when PicName = '18F46J50'   then return 'ADC_V11'
  when PicName = '18F46K20'   then return 'ADC_V8'
  when PicName = '18F6310'    then return 'ADC_V5'
  when PicName = '18F6390'    then return 'ADC_V5'
  when PicName = '18F6393'    then return 'ADC_V5'
  when PicName = '18F63J11'   then return 'ADC_V6'
  when PicName = '18F63J90'   then return 'ADC_V6'
  when PicName = '18F6410'    then return 'ADC_V5'
  when PicName = '18F6490'    then return 'ADC_V5'
  when PicName = '18F6493'    then return 'ADC_V5'
  when PicName = '18F64J11'   then return 'ADC_V6'
  when PicName = '18F64J90'   then return 'ADC_V6'
  when PicName = '18F6520'    then return 'ADC_V2'
  when PicName = '18F6525'    then return 'ADC_V5'
  when PicName = '18F6527'    then return 'ADC_V5'
  when PicName = '18F6585'    then return 'ADC_V5'
  when PicName = '18F65J10'   then return 'ADC_V6'
  when PicName = '18F65J11'   then return 'ADC_V6'
  when PicName = '18F65J15'   then return 'ADC_V6'
  when PicName = '18F65J50'   then return 'ADC_V9'
  when PicName = '18F65J90'   then return 'ADC_V6'
  when PicName = '18F6620'    then return 'ADC_V2'
  when PicName = '18F6621'    then return 'ADC_V5'
  when PicName = '18F6622'    then return 'ADC_V5'
  when PicName = '18F6627'    then return 'ADC_V5'
  when PicName = '18F6628'    then return 'ADC_V5'
  when PicName = '18F6680'    then return 'ADC_V5'
  when PicName = '18F66J10'   then return 'ADC_V6'
  when PicName = '18F66J11'   then return 'ADC_V9'
  when PicName = '18F66J15'   then return 'ADC_V6'
  when PicName = '18F66J16'   then return 'ADC_V9'
  when PicName = '18F66J50'   then return 'ADC_V9'
  when PicName = '18F66J55'   then return 'ADC_V9'
  when PicName = '18F66J60'   then return 'ADC_V6'
  when PicName = '18F66J65'   then return 'ADC_V6'
  when PicName = '18F66J90'   then return 'ADC_V2'
  when PicName = '18F66J93'   then return 'ADC_V2'
  when PicName = '18F6720'    then return 'ADC_V2'
  when PicName = '18F6722'    then return 'ADC_V5'
  when PicName = '18F6723'    then return 'ADC_V5'
  when PicName = '18F67J10'   then return 'ADC_V6'
  when PicName = '18F67J11'   then return 'ADC_V9'
  when PicName = '18F67J50'   then return 'ADC_V9'
  when PicName = '18F67J60'   then return 'ADC_V6'
  when PicName = '18F67J90'   then return 'ADC_V2'
  when PicName = '18F67J93'   then return 'ADC_V2'
  when PicName = '18F8310'    then return 'ADC_V5'
  when PicName = '18F8390'    then return 'ADC_V5'
  when PicName = '18F8393'    then return 'ADC_V5'
  when PicName = '18F83J11'   then return 'ADC_V6'
  when PicName = '18F83J90'   then return 'ADC_V6'
  when PicName = '18F8410'    then return 'ADC_V5'
  when PicName = '18F8490'    then return 'ADC_V5'
  when PicName = '18F8493'    then return 'ADC_V5'
  when PicName = '18F84J11'   then return 'ADC_V6'
  when PicName = '18F84J90'   then return 'ADC_V6'
  when PicName = '18F8520'    then return 'ADC_V2'
  when PicName = '18F8525'    then return 'ADC_V5'
  when PicName = '18F8527'    then return 'ADC_V5'
  when PicName = '18F8585'    then return 'ADC_V5'
  when PicName = '18F85J10'   then return 'ADC_V6'
  when PicName = '18F85J11'   then return 'ADC_V6'
  when PicName = '18F85J15'   then return 'ADC_V6'
  when PicName = '18F85J50'   then return 'ADC_V9'
  when PicName = '18F85J90'   then return 'ADC_V6'
  when PicName = '18F8620'    then return 'ADC_V2'
  when PicName = '18F8621'    then return 'ADC_V5'
  when PicName = '18F8622'    then return 'ADC_V5'
  when PicName = '18F8627'    then return 'ADC_V5'
  when PicName = '18F8628'    then return 'ADC_V5'
  when PicName = '18F8680'    then return 'ADC_V5'
  when PicName = '18F86J10'   then return 'ADC_V6'
  when PicName = '18F86J11'   then return 'ADC_V9'
  when PicName = '18F86J15'   then return 'ADC_V6'
  when PicName = '18F86J16'   then return 'ADC_V9'
  when PicName = '18F86J50'   then return 'ADC_V9'
  when PicName = '18F86J55'   then return 'ADC_V9'
  when PicName = '18F86J60'   then return 'ADC_V6'
  when PicName = '18F86J65'   then return 'ADC_V6'
  when PicName = '18F86J90'   then return 'ADC_V2'
  when PicName = '18F86J93'   then return 'ADC_V2'
  when PicName = '18F8720'    then return 'ADC_V2'
  when PicName = '18F8722'    then return 'ADC_V5'
  when PicName = '18F8723'    then return 'ADC_V5'
  when PicName = '18F87J10'   then return 'ADC_V6'
  when PicName = '18F87J11'   then return 'ADC_V9'
  when PicName = '18F87J50'   then return 'ADC_V9'
  when PicName = '18F87J60'   then return 'ADC_V6'
  when PicName = '18F87J90'   then return 'ADC_V2'
  when PicName = '18F87J93'   then return 'ADC_V2'
  when PicName = '18F96J60'   then return 'ADC_V6'
  when PicName = '18F96J65'   then return 'ADC_V6'
  when PicName = '18F97J60'   then return 'ADC_V6'
  when PicName = '18LF13K50'  then return 'ADC_V10'
  when PicName = '18LF14K50'  then return 'ADC_V10'
  when PicName = '18LF24J10'  then return 'ADC_V6'
  when PicName = '18LF24J11'  then return 'ADC_V11'
  when PicName = '18LF24J50'  then return 'ADC_V11'
  when PicName = '18LF25J10'  then return 'ADC_V6'
  when PicName = '18LF25J11'  then return 'ADC_V11'
  when PicName = '18LF25J50'  then return 'ADC_V11'
  when PicName = '18LF26J11'  then return 'ADC_V11'
  when PicName = '18LF26J50'  then return 'ADC_V11'
  when PicName = '18LF44J10'  then return 'ADC_V6'
  when PicName = '18LF44J11'  then return 'ADC_V11'
  when PicName = '18LF44J50'  then return 'ADC_V11'
  when PicName = '18LF45J10'  then return 'ADC_V6'
  when PicName = '18LF45J11'  then return 'ADC_V11'
  when PicName = '18LF45J50'  then return 'ADC_V11'
  when PicName = '18LF46J11'  then return 'ADC_V11'
  when PicName = '18LF46J50'  then return 'ADC_V11'
  otherwise return '-'     /* for unknown PIC */
end

