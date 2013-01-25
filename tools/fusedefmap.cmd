/* ------------------------------------------------------------ */
/* Fuse_Def Translate Table                                     */
/* Contents to be read and to be INTERPRETed by Dev2jal.cmd     */
/* Based on MPLAB version 8.73a                                 */
/*                                                              */
/* Scripts using this file should contain a routine             */
/* as below to obtain Fuse_Def mapping                          */
/* FuseDefFile = "FuseDefMap.cmd"                               */
/* Fuse_Def. = "?"                                              */
/* if stream(FuseDefFile, "c", "open read") \= "READY:" then do */
/*   Say "Error: Open failed for fuse_map file" FuseDefFile     */
/*   exit 1                                                     */
/*  end                                                         */
/* do while lines(FuseDefFile) > 0                              */
/*   interpret linein(FuseDefFile)                              */
/* end                                                          */
/* call stream FuseDefFile, "c", "close"                        */
/* ------------------------------------------------------------ */
 Fuse_Def.Osc.0011_EXT_RC_CLKOUT_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.0110_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.101X_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.101X_EXTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.101X_EXT_RC_CLKOUT_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.111X_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.111X_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.11XX_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.11XX_EXTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.11XX_EXT_RC_CLKOUT_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.ECH_EXTERNAL_CLOCK_HIGH_POWER_MODE_4_20_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PIN = "ECH_NOCLKOUT"
 Fuse_Def.Osc.ECH_EXTERNAL_CLOCK_HIGH_POWER_MODE_4_20_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PINS = "ECH_NOCLKOUT"
 Fuse_Def.Osc.ECH_EXTERNAL_CLOCK_HIGH_POWER_MODE_4_32_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PIN = "ECH_NOCLKOUT"
 Fuse_Def.Osc.ECIO_PORT_I_O_FUNCTION_ON_RA6_OSC2_CLKO = "EC_NOCLKOUT"
 Fuse_Def.Osc.ECL_EXTERNAL_CLOCK_LOW_POWER_MODE_0_0_5_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PIN = "ECL_NOCLKOUT"
 Fuse_Def.Osc.ECL_EXTERNAL_CLOCK_LOW_POWER_MODE_0_0_5_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PINS = "ECL_NOCLKOUT"
 Fuse_Def.Osc.ECM_EXTERNAL_CLOCK_MEDIUM_POWER_MODE_0_5_4_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PIN = "ECM_NOCLKOUT"
 Fuse_Def.Osc.ECM_EXTERNAL_CLOCK_MEDIUM_POWER_MODE_0_5_4_MHZ_DEVICE_CLOCK_SUPPLIED_TO_CLKIN_PINS = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_CLKIN_FUNCTION_ENABLED = EC_NOCLKOUT
 Fuse_Def.Osc.EC_CLKOUT_FUNCTION_ON_OSC2_HIGH = "ECH_CLKOUT"
 Fuse_Def.Osc.EC_CLKOUT_FUNCTION_ON_OSC2_LOW = "ECL_CLKOUT"
 Fuse_Def.Osc.EC_CLKOUT_FUNCTION_ON_OSC2_MEDIUM = "ECM_CLKOUT"
 Fuse_Def.Osc.EC_CLKOUT_ON_RA6 = "EC-CLKOUT"
 Fuse_Def.Osc.EC_CLKO_RA6 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_CLKO_RA6_USB_EC = "EC_CLKOUT"
 Fuse_Def.Osc.EC_HIGH = "ECH"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_CLKIN_ON_GP5_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_RA4_AN3_T1G_OSC2_CLKOUT_CLKIN_ON_RA5_T1CKI_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_CLKIN_ON_RA5_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_RA4_T1G_OSC2_CLKOUT_CLKIN_ON_RA5_T1CKI_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_CLKIN_ON_RA7_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_T1OSO_PIN_CLKIN_ON_RA7_OSC1_CLKIN_T1OSI = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_LOW = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EC_MEDIUM = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_HIGH_POWER_16_MHZ = "ECH_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_HIGH_POWER_16_MHZ_64_MHZ = "ECH_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_LOW_POWER_DC_160_KHZ = "ECL_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_LOW_POWER_500_KHZ = "ECL_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_MEDIUM_POWER_160_KHZ_16_MHZ = "ECM_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_MEDIUM_POWER_160_KHZ_4_MHZ = "ECM_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2_MEDIUM_POWER_500_KHZ_16_MHZ = "ECM_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_ON_OSC2_LOW_POWER_4_MHZ = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKOUT_ON_OSC2_MEDIUM_POWER_4_16_MHZ = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKO_FUNCTION_ON_OSC2 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKO_FUNCTION_ON_RA4_CLKO_PIN_CLKI_ON_RA5_CLKI = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKO_FUNCTION_ON_RA6_EC = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_CLKO_ON_RA6 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_HIGH_POWER_16MHZ_TO_48MHZ = "ECH_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_HIGH_POWER_16MHZ_TO_48MHZ_CLOCK_OUTPUT_ON_OSC2 = "ECH_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_HIGH_POWER_16_MHZ = "ECH_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_HIGH_POWER_16_MHZ_64_MHZ = "ECH_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_I_O_FUNCTION_ON_RA4_CLKO_PIN_CLKI_ON_RA5_CLKI = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_CLKIN_ON_RA7_OSC1_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_LOW_POWER_4MHZ = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_LOW_POWER_4MHZ_CLOCK_OUTPUT_ON_OSC2 = "ECL_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_LOW_POWER_4_MHZ = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_LOW_POWER_DC_160_KHZ = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_LOW_POWER_500_KHZ = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_160_KHZ_16_MHZ = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_160_KHZ_4_MHZ = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_500_KHZ_16_MHZ = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_4MHZ_TO_16MHZ = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_4MHZ_TO_16MHZ_CLOCK_OUTPUT_ON_OSC2 = "ECM_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MEDIUM_POWER_4_16_MHZ = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_MODE_CLKIN_FUNCTION_ON_RA5_CLKIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_PLL_ENABLED_AND_UNDER_SOFTWARE_CONTROL_CLKO_FUNCTION_ON_OSC2 = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_PLL_ENABLED_AND_UNDER_SOFTWARE_CONTROL_CLK_FUNCTION_ON_OSC2 = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_PLL_ENABLED_CLKO_FUNCTION_ON_RA6_ECPLL = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_PLL_ENABLED_CLKO_ON_RA6 = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_PLL_ENABLED_PORT_FUNCTION_ON_RA6_ECPIO = "EC_NOCLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_PORT_FUNCTION_ON_RA6 = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_PORT_FUNCTION_ON_RA6_ECIO = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_PORT_FUNCTION_ON_RA6_HIGH_POWER_16_MHZ = "ECH_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_PIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_CLKO_ON_RA6_EC_USED_BY_USB = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_CLOCK_OUT_ON_RA6 = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_I_O_FUNCTION_ON_OSC2_CLKOUT_AND_10_US_STARTUP_TIME = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_DIVIDE_BY_4_CLOCK_OUTPUT = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_RA6 = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_RA6_AND_HW_ENABLED_4X_PLL = "EC_NOCLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_RA6_AND_SW_ENABLED_4X_PLL = "EC_NOCLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_PLL = "EC_NOCLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_PLL_CLKO_ON_RA6_ECPLL_USED_BY_USB = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_OSCILLATOR_WITH_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_AND_1_MS_DRT = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_W_OSC2_CONFIGURED_AS_DIVIDE_BY_4_CLOCK_OUTPUT = "EC_CLKOUT"
 Fuse_Def.Osc.EC_OSCILLATOR_W_OSC2_CONFIGURED_AS_RA6 = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_OSC_WITH_RB4_AND_1_125_MS_DRT = "EC_NOCLKOUT"
 Fuse_Def.Osc.EC_PLL_CLKO_RA6 = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_PLL_CLKO_RA6_USB_EC_PLL = "EC_CLKOUT_PLL"
 Fuse_Def.Osc.EC_PORT_ON_RA6 = "EC_NOCLKOUT"
 Fuse_Def.Osc.ER_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RESISTOR_ON_RA7_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.ER_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RESISTOR_ON_RA7_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTCLK_PORT_I_O_FUNCTION_ON_OSC2_CLKO_RA6 = "EC_NOCLKOUT"
 Fuse_Def.Osc.EXTCLK_PORT_I_O_FUNCTION_ON_RA6_OSC2_CLKO_PIN = "EC_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_CLOCK_HIGH_POWER_MODE = "ECH_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_CLOCK_LOW_POWER_MODE = "ECL_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_CLOCK_MEDIUM_POWER_MODE = "ECM_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_CLKOUT_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLOCK_OUTPUT_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RB4_OSC2_CLKOUT_PIN = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_CLOCK_OUTPUT_ON_OSC2 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_PORT_FUNCTION_ON_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTERNAL_RC_OSCILLATOR_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_PIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRCIO_OSCILLATOR_EXTERNAL_RC_ON_RA5_OSC1_CLKIN_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_AN3_T1G_OSC2_CLKOUT_RC_ON_RA5_T1CKI_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_AN3_T1G_OSC2_CLKOUT_RC_ON_RA5_T1CKI_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_CLKO_FUNCTION_ON_OSC2_CLKO_RA6 = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_CLKOUT_FUNCTION_ON_OSC2_CLKOUT_AND_10_US_STARTUP_TIME = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_CLKO_FUNCTION_ON_RA6_OSC2_CLKO = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_CLKO_FUNCTION_ON_RA6_OSC2_CLKO_PIN = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_EXTERNAL_RC_CIRCUIT_CONNECTED_TO_CLKIN_PIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_EXTERNAL_RC_ON_RA5_OSC1_CLKIN_CLKOUT_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_PORT_I_O_FUNCTION_ON_OSC2_CLKO_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_PORT_I_O_FUNCTION_ON_RA6_OSC2_CLKO = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_OSCILLATOR_PORT_I_O_FUNCTION_ON_RA6_OSC2_CLKO_PIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_1_125_MS_DRT = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_1_MS_DRT = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_CLKOUT_AND_1_125_MS_DRT = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_CLKOUT_FUNCTION_ON_RB4_OSC2_CLKOUT_AND_1_MS_DRT = "RC_CLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_I_O_FUNCTION_ON_OSC2_CLKOUT_AND_10_US_STARTUP_TIME = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_RB4_AND_1_125_MS_DRT = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXTRC_WITH_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_AND_1_MS_DRT = "RC_NOCLKOUT"
 Fuse_Def.Osc.EXT_RC_PORT_ON_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.FAST_RC_OSCILLATOR_DIVIDED_BY_16_500_KHZ = "RC_FAST_DIV16"
 Fuse_Def.Osc.FAST_RC_OSCILLATOR_FRC = "RC_FAST"
 Fuse_Def.Osc.FAST_RC_OSCILLATOR_WITH_PLL_MODULE_FRCPLL = "RC_FAST_PLL"
 Fuse_Def.Osc.FAST_RC_OSCILLATOR_WITH_POSTSCALER_FRCDIV = "RC_FAST_POST"
 Fuse_Def.Osc.HS = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_AND_AUTOMATIC_18_MS_DRT_DRTEN_IGNORED = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_AND_18_MS_DRT = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_POWER_16MHZ_TO_25MHZ = "HS_HIGH"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_POWER_16_MHZ = "HS_HIGH"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_POWER_16_MHZ_25_MHZ = "HS_HIGH"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_CONNECTED_BETWEEN_OSC1_AND_OSC2_PINS = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_GP4_OSC2_CLKOUT_AND_GP5_OSC1_CLKIN = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_RA4_OSC2_CLKOUT_AND_RA5_OSC1_CLKIN = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_AN3_T1G_OSC2_CLKOUT = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_T1G_OSC2_CLKOUT = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_RA6_OSC2_CLKOUT_AND_RA7_OSC1_CLKIN = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HIGH_SPEED_CRYSTAL_RESONATOR_ON_RA6_OSC2_CLKOUT_T1OSO_AND_RA7_OSC1_CLKIN_T1OSI = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HS = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_HS_USED_BY_USB = "HS"
 Fuse_Def.Osc.HS_OSCILLATOR_MEDIUM_POWER_4_16_MHZ = "HS_MEDIUM"
 Fuse_Def.Osc.HS_OSCILLATOR_MEDIUM_POWER_4MHZ_TO_16MHZ = "HS_MEDIUM"
 Fuse_Def.Osc.HS_OSCILLATOR_MEDIUM_POWER_4_MHZ_16_MHZ = "HS_MEDIUM"
 Fuse_Def.Osc.HS_OSCILLATOR_PLL_ENABLED = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_PLL_ENABLED_AND_UNDER_SOFTWARE_CONTROL = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_PLL_ENABLED_CLOCK_FREQUENCY_4_X_FOSC1 = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_PLL_ENABLED_HSPLL = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_PLL_ENABLED_HSPLL_USED_BY_USB = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_WITH_HW_ENABLED_4X_PLL = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_WITH_PLL_ENABLED_CLOCK_FREQUENCY_4_X_FOSC = "HS_PLL"
 Fuse_Def.Osc.HS_OSCILLATOR_WITH_SW_ENABLED_4X_PLL = "HS_PLL"
 Fuse_Def.Osc.HS_PLL = "HS_PLL"
 Fuse_Def.Osc.HS_PLL_ENABLED_FREQ_4XFOSC1 = "HS_PLL"
 Fuse_Def.Osc.HS_PLL_USB_HS_PLL = "HS_PLL"
 Fuse_Def.Osc.HS_USB_HS = "HS"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_CLKOUT_FUNCTION_ON_RA6_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_CLKOUT_FUNCTION_ON_OSC2 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_CLKO_FUNCTION_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_CLKO_FUNCTION_ON_RA6_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_PORT_FUNCTION_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_BLOCK_PORT_FUNCTION_ON_RA6_AND_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_CLKOUT_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_CLKO_FUNCTION_ON_RA6_EC_USED_BY_USB_INTCKO = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_CLKO_FUNCTION_ON_RA6_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_CLOCK_OUTPUT_ON_OSC2 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_HS_OSCILLATOR_USED_BY_USB_INTHS = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_I_O_FUNCTION_ON_OSC1 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_MODE_I_O_FUNCTION_ON_RA5_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_PORT_FUNCTION_ON_RA6_AND_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_PORT_FUNCTION_ON_RA6_EC_USED_BY_USB_INTIO = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_OSCILLATOR_XT_USED_BY_USB_INTXT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RB4_OSC2_CLKOUT_PIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR_PORT_FUNCTION_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTERNAL_RC_OSCILLATOR_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_PIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_GP5_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_AN3_T1G_OSC2_CLKOUT_I_O_FUNCTION_ON_RA5_T1CKI_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_CLKO_PIN_I_O_FUNCTION_ON_RA5_CLKI = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA5_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_T1G_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA5_T1CKI_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_AND_RA7_OSC1_CLKIN_PINS = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCIO_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_T1OSO_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN_T1OSI = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSCO_CLKO_RA6 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSCPLL = "INTOSC_NOCLKOUT_PLL"
 Fuse_Def.Osc.INTOSCPLLO_CLKO_RA6 = "INTOSC_CLKOUT_PLL"
 Fuse_Def.Osc.INTOSC_CLKO_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_NOCLKOUT_INTERNAL_OSCILLATOR_XT_USED_BY_USB_INTXT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_NOCLKOUT_INTERNAL_OSCILLATOR_PORT_FUNCTION_ON_RA6_EC_USED_BY_USB_INTIO = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_BLOCK = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_BLOCK_CLKOUT_FUNCTION_ON_OSC2 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKIN_FUNCTION_DISABLED = INTOSC_NOCLKOUT
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_GP5_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_AN3_T1G_OSC2_CLKOUT_I_O_FUNCTION_ON_RA5_T1CKI_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA5_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_T1G_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA5_T1CKI_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_T1OSO_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN_T1OSI = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_CLKO_FUNCTION_ON_RA4_CLKO_PIN_I_O_FUNCTION_ON_RA5_CLKI = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_I_O_FUNCTION_ON_CLKIN_PIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_I_O_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_GP5_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA5_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_PORT_FUNCTION_ON_RA6_AND_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_WITH_1_125_MS_DRT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTOSC_WITH_PLL_ENABLED_CLKOUT_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT_PLL"
 Fuse_Def.Osc.INTOSC_WITH_PLL_ENABLED_CLKO_ON_RA6_AND_PORT_FUNCTION_ON_RA7 = "INTOSC_CLKOUT_PLL"
 Fuse_Def.Osc.INTOSC_WITH_PLL_ENABLED_PORT_FUNCTION_ON_RA6_AND_RA7 = "INTOSC_NOCLKOUT_PLL"
 Fuse_Def.Osc.INTRC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_OSCILLATOR_CLKO_FUNCTION_ON_OSC2_CLKO_RA6_AND_PORT_I_O_FUNCTION_ON_OSC1_CLKI_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_OSCILLATOR_CLKO_FUNCTION_ON_RA6_OSC2_CLKO_PIN_AND_PORT_I_O_FUNCTION_ON_RA7_OSC1_CLKI_PIN = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_I_O_FUNCTION_ON_RA7_OSC1_CLKIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_OSCILLATOR_PORT_I_O_FUNCTION_ON_BOTH_RA6_OSC2_CLKO_PIN_AND_RA7_OSC1_CLKI_PIN = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_OSCILLATOR_PORT_I_O_FUNCTION_ON_OSC1_CLKI_RA7_AND_OSC2_CLKO_RA6 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_WITH_1_MS_DRT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_WITH_CLKOUT_AND_1_125_MS_DRT = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_WITH_CLKOUT_FUNCTION_ON_OSC2_CLKOUT_AND_10_US_STARTUP_TIME = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_WITH_CLKOUT_FUNCTION_ON_RB4_OSC2_CLKOUT_AND_1_MS_DRT = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INTRC_WITH_I_O_FUNCTION_ON_OSC2_CLKOUT_AND_10_US_STARTUP_TIME = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_WITH_RB4_AND_1_125_MS_DRT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INTRC_WITH_RB4_FUNCTION_ON_RB4_OSC2_CLKOUT_AND_1_MS_DRT = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.INT_RC_CLKOUT_ON_RA6_PORT_ON_RA7 = "INTOSC_CLKOUT"
 Fuse_Def.Osc.INT_RC_PORT_ON_RA6_PORT_ON_RA7 = "INTOSC_NOCLKOUT"
 Fuse_Def.Osc.LOW_POWER_RC_OSCILLATOR_LPRC = "LP"
 Fuse_Def.Osc.LP = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_AND_AUTOMATIC_18_MS_DRT_DRTEN_IGNORED = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_AND_18_MS_DRT = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_CONNECTED_BETWEEN_OSC1_AND_OSC2_PINS = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_GP4_OSC2_CLKOUT_AND_GP5_OSC1_CLKIN = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_RA4_OSC2_CLKOUT_AND_RA5_OSC1_CLKIN = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_AN3_T1G_OSC2_CLKOUT = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_T1G_OSC2_CLKOUT = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_RA6_OSC2_CLKOUT_AND_RA7_OSC1_CLKIN = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_LOW_POWER_CRYSTAL_ON_RA6_OSC2_CLKOUT_T1OSO_AND_RA7_OSC1_CLKIN_T1OSI = "LP"
 Fuse_Def.Osc.LP_OSCILLATOR_WITH_18_MS_DRT = "LP"
 Fuse_Def.Osc.LP_OSC_WITH_18_MS_DRT = "LP"
 Fuse_Def.Osc.PRIMARY_OSCILLATOR_WITH_PLL_MODULE_XTPLL_HSPLL_ECPLL = "PRIM_PLL"
 Fuse_Def.Osc.PRIMARY_OSCILLATOR_XT_HS_EC = "PRIM"
 Fuse_Def.Osc.RCIO_OSCILLATOR_I_O_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_RC_ON_GP5_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_RC_ON_RA5_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RCIO_OSCILLATOR_I_O_FUNCTION_ON_RA4_T1G_OSC2_CLKOUT_PIN_RC_ON_RA5_T1CKI_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RCIO_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RC_ON_RA7_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RCIO_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_T1OSO_PIN_RC_ON_RA7_OSC1_CLKIN_T1OSI = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_CLKOUT_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_OSC2 = RC_CLKOUT
 Fuse_Def.Osc.RC_CLKOUT_EXTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = RC_CLKOUT
 Fuse_Def.Osc.RC_CLKOUT_101X_EXTERNAL_RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6 = RC_CLKOUT
 Fuse_Def.Osc.RC_CLKOUT_101X_EXTERNAL_RC_OSCILLATOR_CLKO_FUNCTION_ON_RA6 = RC_CLKOUT
 Fuse_Def.Osc.RC_OSC2_AS_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_RC_ON_GP5_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_RC_ON_RA5_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA4_T1G_OSC2_CLKOUT_PIN_RC_ON_RA5_T1CKI_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RC_ON_RA7_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RESISTOR_AND_CAPACITOR_ON_RA7_OSC1_CLKIN = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_CLKOUT_FUNCTION_ON_RA6_OSC2_CLKOUT_T1OSO_PIN_RC_ON_RA7_OSC1_CLKIN_T1OSI = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_I_O_FUNCTION_ON_GP4_OSC2_CLKOUT_PIN_RC_ON_GP5_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_I_O_FUNCTION_ON_RA4_OSC2_CLKOUT_PIN_RC_ON_RA5_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_I_O_FUNCTION_ON_RA6_OSC2_CLKOUT_PIN_RESISTOR_AND_CAPACITOR_ON_RA7_OSC1_CLKIN = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_DIVIDE_BY_4_CLOCK_OUTPUT = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_WITH_OSC2_CONFIGURED_AS_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_W_OSC2_CONFIGURED_AS_DIVIDE_BY_4_CLOCK_OUTPUT = "RC_CLKOUT"
 Fuse_Def.Osc.RC_OSCILLATOR_W_OSC2_CONFIGURED_AS_RA6 = "RC_NOCLKOUT"
 Fuse_Def.Osc.SECONDARY_OSCILLATOR_SOSC = "SOCS"
 Fuse_Def.Osc.XT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_AND_AUTOMATIC_18_MS_DRT_DRTEN_IGNORED = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_AND_18_MS_DRT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_CONNECTED_BETWEEN_OSC1_AND_OSC2_PINS = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_GP4_OSC2_CLKOUT_AND_GP5_OSC1_CLKIN = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA4_OSC2_CLKOUT_AND_RA5_OSC1_CLKIN = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA4_OSC2_CLKOUT_AND_RA5_OSC1_CLKINT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_AN3_T1G_OSC2_CLKOUT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA5_T1CKI_OSC1_CLKIN_AND_RA4_T1G_OSC2_CLKOUT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA6_OSC2_CLKIN_AND_RA7_OSC1_CLKIN = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA6_OSC2_CLKOUT_AND_RA7_OSC1_CLKIN = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_CRYSTAL_RESONATOR_ON_RA6_OSC2_CLKOUT_T1OSO_AND_RA7_OSC1_CLKIN_T1OSI = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_PLL_ENABLED_XTPLL = "XT_PLL"
 Fuse_Def.Osc.XT_OSCILLATOR_WITH_18_MS_DRT = "XT"
 Fuse_Def.Osc.XT_OSCILLATOR_XT = "XT"
 Fuse_Def.Osc.XT_OSC_WITH_18_MS_DRT = "XT"
/* End of Fuse_Map script */
