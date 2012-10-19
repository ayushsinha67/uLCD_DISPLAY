/************************************************************************
 *    RPM BAR
 */
func RPM_Meter( var val )

    gfx_PenSize( SOLID );

    var i;
    var counter:=0;                                             /* match counter */
    var targetX1, targetY1;                                     /* Orbit targets */
    var targetX2, targetY2;
    gfx_OrbitInit( &targetX1, &targetY1 );
    gfx_MoveTo( 90, 90);

    for( i:=90; i<=270; i:= i + 2 )                             /* Snail */

        gfx_Orbit( i, 90 );
        targetX2 := targetX1;
        targetY2 := targetY1;
        gfx_Orbit( i, 135 - ( i>>1 ) );                         /* Coil */

        if( counter < val )                                     /* Printing Ranges */

            if( counter < RPM_RANGE1 )
                gfx_Line( targetX2, targetY2, targetX1, targetY1, RPM_COL_RANGE1 );
            else if ( ( counter >= RPM_RANGE1 ) && ( counter <= RPM_RANGE2 ) )
                gfx_Line( targetX2, targetY2, targetX1, targetY1, RPM_COL_RANGE2 );
            else
                gfx_Line( targetX2, targetY2, targetX1, targetY1, RPM_COL_RANGE3 );
            endif

        else
            gfx_Line( targetX2, targetY2, targetX1, targetY1, BLACK );
        endif

        counter += 58;
    next

    for( i:=90; i<=320; i := i+4 )                              /* Straight Lane */

        if( counter < val )

            if ( counter < RPM_RANGE1 )
                gfx_Vline( i, 0, 90, RPM_COL_RANGE1 );
            else if ( ( counter >= RPM_RANGE1 ) && ( counter <= RPM_RANGE2 ) )
                gfx_Vline( i, 0, 90, RPM_COL_RANGE2 );
            else
                 gfx_Vline( i, 0, 90, RPM_COL_RANGE3 );
            endif
        else
            gfx_Vline( i, 0, 90, BLACK );
        endif

        counter += 116;                                           /* Lines */
    next

    gfx_MoveTo( RPM_X, RPM_Y );                                 /* RPM Value */
    txt_FontID(FONT4);
    txt_Bold(1);
    txt_Width(3);
    txt_Height(3);

    var private gear_pos :=0;

    if( gear_pos != GearPosition )                              /* Flash When Gear Changes */
        txt_FGcolour( BLUE );
        gear_pos := GearPosition;
    else
        txt_FGcolour( YELLOW );
    endif

    print(val);                                                 /* Numeric Value */
    print(" ");

    gfx_MoveTo( RPM_X + 185, RPM_Y + 25 );                      /* RPM */
    txt_FontID(FONT2);
    txt_FGcolour( WHITE );
    txt_Bold(0);
    txt_Width(1);
    txt_Height(2);
    print("RPM");
endfunc

/************************************************************************
 *    SPEED VALUE
 */
func Speed_Disp( var kmph )

    gfx_MoveTo( SPEED_X, SPEED_Y );                             /* RPM */
    txt_FontID(FONT4);
    txt_FGcolour( CYAN );
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);
    print(kmph);
    print(" ");

    gfx_MoveTo( SPEED_X + 90, SPEED_Y + 15 );                   /* RPM */
    txt_FontID(FONT2);
    txt_FGcolour( WHITE );
    txt_Bold(0);
    txt_Width(1);
    txt_Height(2);
    print("KMPH");
endfunc

/************************************************************************
 *    GEAR DISPLAY
 */
 func Gear_Disp( var val )

    gfx_MoveTo( NEUTRAL_X, NEUTRAL_Y );
    txt_FontID(FONT4);
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);

    if( ( val >= 0 ) && ( val <= 5 ) )                          /* Change colour */

        txt_FGcolour( WHITE );
        if( val  == 0 )
            print("N");
        else
            print(val);
        endif
    else
        txt_FGcolour( BLACK );
        print("N");
    endif

 endfunc

/************************************************************************
 *    PNEUMATIC DISPLAY
 */
func Pneumatic_Disp()

    txt_FontID(FONT1);
    txt_FGcolour( RED );
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);

    if( ( PneumState == PNEUM_OFF ) && ( PneumFlashState == PNEUM_FLASH_OFF ) && ( sys_GetTimer(TIMER3) == 0 ) )
        gfx_MoveTo( 190, 215 );
        print ( "PNEUM OFF" );
        PneumFlashState := PNEUM_FLASH_ON;
        sys_SetTimer(TIMER3, 500);
    endif

    if( ( PneumState == PNEUM_OFF ) && ( PneumFlashState == PNEUM_FLASH_ON ) && ( sys_GetTimer(TIMER3) == 0 ) )
        gfx_MoveTo( 190, 215 );
        print ( "         " );
        PneumFlashState := PNEUM_FLASH_OFF;
        sys_SetTimer(TIMER3, 500);
    endif

    if( PneumState == PNEUM_ON )
         gfx_MoveTo( 190, 215 );
         txt_FGcolour( LIME );
         print ( "PNEUM ON " );
    endif

endfunc

/************************************************************************
 *    WARNINGS
 */
 func Warnings_Disp()

     /* OIL WARNING */
    txt_FontID(FONT4);
    txt_FGcolour( SKYBLUE );
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);

    if( ( OilWarningState == OIL_WARNING_ON ) && ( OilFlashState == OIL_WARNING_FLASH_OFF ) && ( sys_GetTimer(TIMER0) == 0 ) )
        gfx_MoveTo( 190, 150 );
        print ( "OIL" );
        OilFlashState := OIL_WARNING_FLASH_ON;
        sys_SetTimer(TIMER0, 100);
    endif

    if( ( OilWarningState == OIL_WARNING_ON ) && ( OilFlashState == OIL_WARNING_FLASH_ON ) && ( sys_GetTimer(TIMER0) == 0 ) )
        gfx_MoveTo( 190, 150 );
        print ( "   " );
        OilFlashState := OIL_WARNING_FLASH_OFF;
        sys_SetTimer(TIMER0, 100);
    endif

    if( OilWarningState == OIL_WARNING_OFF )
         gfx_MoveTo( 190, 150 );
         print ( "   " );
    endif

    /* ENGINE TEMPERATURE WARNING */
    txt_FontID(FONT4);
    txt_FGcolour( RED );
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);

    if( ( TempWarningState == TEMP_WARNING_ON ) && ( TempFlashState == TEMP_WARNING_FLASH_OFF ) && ( sys_GetTimer(TIMER1) == 0 ) )
        gfx_MoveTo( 100, 150 );
        print ( "HOT" );
        TempFlashState := TEMP_WARNING_FLASH_ON;
        sys_SetTimer(TIMER1, 100);
    endif

    if( ( TempWarningState == TEMP_WARNING_ON ) && ( TempFlashState == TEMP_WARNING_FLASH_ON ) && ( sys_GetTimer(TIMER1) == 0 ) )
        gfx_MoveTo( 100, 150 );
        print ( "   " );
        TempFlashState := TEMP_WARNING_FLASH_OFF;
        sys_SetTimer(TIMER1, 100);
    endif

    if( TempWarningState == TEMP_WARNING_OFF )
         gfx_MoveTo( 100, 150 );
         print ( "   " );
    endif
 endfunc

/************************************************************************
 *    NO CONNECTION DISPLAY
 */
func NoConnection_Disp()

    txt_FontID(FONT4);
    txt_FGcolour( RED );
    txt_Bold(1);
    txt_Width(2);
    txt_Height(2);

    if( ( ConnectionFlashState == CON_FLASH_ON ) && ( sys_GetTimer(TIMER5) == 0 ) )
        gfx_Cls();
        ConnectionFlashState := CON_FLASH_OFF;
        sys_SetTimer(TIMER5, 500);
    endif

    if( ( ConnectionFlashState == CON_FLASH_OFF ) && ( sys_GetTimer(TIMER5) == 0 ) )
        gfx_MoveTo( 15, 110 );
        print ( "DISCONNECTED" );
        ConnectionFlashState := CON_FLASH_ON;
        sys_SetTimer(TIMER5, 500);
    endif
endfunc

 /************************************************************************
 *    FM LOGO
 */
 func FM_LOGO()

    txt_Set(FONT_SIZE, FONT1);
    var count := 0;
    putstr("Mounting");

    if (!(D:=file_Mount()))                                         /* MOUNT DRIVE */
        while( !( D:=file_Mount() ) && ( count<=5) )
            count++;
        wend
    endif

    gfx_Cls();
    if ( (D:=file_Mount()) )                                        /* Check Mounted */
        putstr("Mounted");
    else
        putstr("Mounting FAILED");
    endif

    pause(500);
    gfx_Cls();                                                      /* Clear Screen */

    Ihndl := file_LoadImageControl("fm.dat", "fm.gci",1);           /* use fast mode 1 for this type of work */
    img_Show(Ihndl, ALL);                                           /* Show Logo */

    var i;
    for( i:= 0; i<=320; i++ )                                       /* Fill with Bars */

        if( i%2 == 0 )
            gfx_Vline( i, 180, 220, RED );
            gfx_Vline( 320 - i, 20, 60, RED );
        endif
    next

    for( i:= 0; i<=320; i++ )                                       /* Slide out Bars */

        if( i%2 == 0 )
            gfx_Vline( i, 180, 220, BLACK );
            gfx_Vline( 320 - i, 20, 60, BLACK );
        endif
        pause(7);
    next

endfunc

