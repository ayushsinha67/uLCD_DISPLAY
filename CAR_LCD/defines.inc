
/************************************************************************
 *    DEFINES
 */
#CONST
    /* INITIALIZATIONS */
    BAUD_RATE       3840                    /* Baud rate / 10 */
    BUFFER_SIZE     7
    SERIAL_QFY      ':'

    /* RPM */
    RPM_MAX         12000
    RPM_RANGE1      2000
    RPM_RANGE2      4500
    RPM_COL_RANGE1  LIME
    RPM_COL_RANGE2  YELLOW
    RPM_COL_RANGE3  RED
    RPM_X           100
    RPM_Y           100

    /* Neutral */
    NEUTRAL_X       60
    NEUTRAL_Y       100

    /* Speedometer */
    SPEED_X         10
    SPEED_Y         205
#END

/************************************************************************
 *    ENUMERATIONS
 */
#CONST
    /* CONNECTION */
    CONNECTED
    DISCONNECTED
    CON_FLASH_ON
    CON_FLASH_OFF

    /* OIL WARNING */
    OIL_WARNING_ON
    OIL_WARNING_OFF
    OIL_WARNING_FLASH_ON
    OIL_WARNING_FLASH_OFF

    /* TEMP WARNING */
    TEMP_WARNING_ON
    TEMP_WARNING_OFF
    TEMP_WARNING_FLASH_ON
    TEMP_WARNING_FLASH_OFF

    /* PNEUMATIC STATE */
    PNEUM_ON
    PNEUM_OFF
    PNEUM_FLASH_ON
    PNEUM_FLASH_OFF
#END

/************************************************************************
 *    CODE SPACE
 */
#DATA

#END

