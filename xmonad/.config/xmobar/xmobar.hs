Config { overrideRedirect = False
       , font         = "FiraCode Nerd Font Mono 14"
	   , additionalFonts = [ "FiraCode Nerd Font Mono 20" ]
       , bgColor      = "#161616"
       , fgColor      = "#ffffff"
       , position     = Static { xpos = 0 , ypos = 0, width = 2400, height = 44 }

    
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , pickBroadest = False
       , persistent   = True
    
       , commands = [ Run Battery
                        [ "--template" , "<left>% <acstatus>"
                        , "--Low"      , "10"
                        , "--High"     , "80"
                        , "--low"      , "#ee5396"
                        , "--normal"   , "#ffffff"
                        , "--high"     , "#ffffff"
                        , "--"
                            , "-o"     , "<fc=#ffffff><fn=1>󰂀</fn></fc>"
                            , "-O"     , "<fc=#33b1ff><fn=1>󱐋</fn></fc>"
                            , "-i"     , "<fc=#42be65><fn=1>󰁹</fn></fc>"
                        ] 50
                    , Run Date "%b %d %Y - %H:%M" "date" 50
                    , Run Kbd
                        [ ("us", "US")
                        , ("cz", "CZ")
                        ]
                    , Run UnsafeStdinReader
					]
       , sepChar  = "%"
       , alignSep = "}{"
       , template = "<fc=#33b1ff><fn=1>  </fn></fc>  %UnsafeStdinReader%}{%battery%   %kbd%   %date%  <action=`__tirea_powermenu.sh`><fc=#ee5396><fn=1>  </fn></fc></action>"
       }
