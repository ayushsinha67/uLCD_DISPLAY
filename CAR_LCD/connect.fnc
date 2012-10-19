/************************************************************************
 *    SERIAL INITIALIZATION
 */
 func Serial_Init()

    var stat;

    stat := com_SetBaud( COM1, BAUD_RATE );            /* Open Port */

    if (stat)
        print("Com1 set to BAUD");
        gfx_Cls();
    endif

    com1_Init( Buffer, BUFFER_SIZE, SERIAL_QFY );           /* Initialize Buffer */

 endfunc

 /************************************************************************
 *   CONNECTION CHECK
 */
func Connection()

    if( com1_Sync() )                                       /* Check if connected */
        sys_SetTimer(TIMER4, 1000);
        ConnectionState := CONNECTED;
    endif

    if( sys_GetTimer(TIMER4)  == 0 )                        /* Disconnect after 1 sec */
        ConnectionState := DISCONNECTED;
    endif

endfunc

 /************************************************************************
 *    READ DATA
 */
 func Read_Data()

    var i, ch;

    if( com1_Full() )                                       /* If Buffer Full */

        for( i:=0; i<BUFFER_SIZE; i++ )
            ReadBuffer[i] := serin1();                      /* Read line by line */
        next

        /* Read RPM */
        Rpm := ( ( ReadBuffer[0]<<8 ) | ReadBuffer[1] );

        /* KMPH */
        Kmph := ReadBuffer[2];

        /* Gear Position */
        GearPosition := ReadBuffer[3];

        /* Pneumatic Status */
        if( ReadBuffer[4] == 255 )
            PneumState := PNEUM_ON;
        else if ( ReadBuffer[4] == 0 )
            PneumState := PNEUM_OFF;
        endif

        /* TEMP (HOT) Warning */
        if( ReadBuffer[5] == 255 )
            TempWarningState := TEMP_WARNING_ON;
        else if ( ReadBuffer[5] == 0 )
            TempWarningState := TEMP_WARNING_OFF;
        endif

        /* OIL Warning */
        if( ReadBuffer[6] == 255 )
            OilWarningState := OIL_WARNING_ON;
        else if ( ReadBuffer[6] == 0 )
            OilWarningState := OIL_WARNING_OFF;
        endif

        com1_Init( Buffer, BUFFER_SIZE, SERIAL_QFY );        /* ReInitialize Buffer */
    endif
 endfunc


