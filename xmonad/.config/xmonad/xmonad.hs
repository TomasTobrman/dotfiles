------------------------------------------------------------------------
--                      Tirea's XMonad Config                         --
------------------------------------------------------------------------

---- Imports -----------------------------------------------------------
import           XMonad

import           Data.Monoid
import qualified Data.Map                   as M
import           Data.Maybe                 (fromJust)

import           System.Exit

import           XMonad.Hooks.DynamicLog    (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import           XMonad.Hooks.ManageDocks   (avoidStruts, docks, manageDocks, ToggleStruts(..))
import           XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)

import           XMonad.Layout.NoBorders
import           XMonad.Layout.Renamed
import           XMonad.Layout.Spacing

import qualified XMonad.StackSet            as W

import           XMonad.Util.EZConfig       (mkKeymap)
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

---- General -----------------------------------------------------------
myTerminal = "st"

myBorderWidth = 4
mySpacing = 8

myModMask = mod4Mask

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myWorkspaces = wsWrapper $ ["dev", "www", "3", "4"]
    where wsWrapper l = [ "<action=xdotool key super+"++(show i)++">"
                        ++"<icon=.config/icons/workspaces/"++ws++".xbm/>"
                        ++"</action>" | (i,ws) <- zip [1..] l
                        ]

myNormalBorderColor  = "#262626"
myFocusedBorderColor = "#393939"

---- Key bindings ------------------------------------------------------
myKeys = \c -> mkKeymap c $
    [ ("M-S-/"       , spawn "xmonad_keys.sh")                              -- Show help
    , ("M-<Escape>"  , spawn "xmonad --recompile; xmonad --restart")        -- Recompile and Restart XMonad
    , ("M-S-<Escape>", io (exitWith ExitSuccess))                           -- Quit XMonad
    ]
    ++
    [ ("M-<Space>"   , spawn "dmenu_run -c")                                -- Launch dmenu
    , ("M-S-<Return>", spawn $ terminal c)                                  -- Launch terminal
    , ("M-s f"       , spawn "firefox")                                     -- Launch Firefox
    , ("M-q"         , kill)                                                -- Kill focused window
    ]
    ++
    [ ("M-<Tab>"   , sendMessage NextLayout)                                -- Switch to next layout
    , ("M-h"       , sendMessage Shrink)                                    -- Shrink focused window
    , ("M-l"       , sendMessage Expand)                                    -- Expand focused window
    , ("M-j"       , windows W.focusDown)                                   -- Move focus down the stack
    , ("M-k"       , windows W.focusUp)                                     -- Move focus up the stack
    , ("M-m"       , windows W.focusMaster)                                 -- Focus master window
    , ("M-<Return>", windows W.swapMaster)                                  -- Swap focused window to master
    , ("M-S-j"     , windows W.swapDown)                                    -- Swap focused window down the stack
    , ("M-S-k"     , windows W.swapUp)                                      -- Swap focused window up the stack
    , ("M-t"       , withFocused $ windows . W.sink)                        -- Reset focused window to tiling
    ]
    ++
    [ ("M-1", windows $ W.greedyView $ myWorkspaces !! 0)                   -- Switch to workspace 1
    , ("M-2", windows $ W.greedyView $ myWorkspaces !! 1)                   -- Switch to workspace 2
    , ("M-3", windows $ W.greedyView $ myWorkspaces !! 2)                   -- Switch to workspace 3
    , ("M-4", windows $ W.greedyView $ myWorkspaces !! 3)                   -- Switch to workspace 4
    , ("M-5", windows $ W.greedyView $ myWorkspaces !! 4)                   -- Switch to workspace 5
    , ("M-6", windows $ W.greedyView $ myWorkspaces !! 5)                   -- Switch to workspace 6
    , ("M-7", windows $ W.greedyView $ myWorkspaces !! 6)                   -- Switch to workspace 7
    , ("M-8", windows $ W.greedyView $ myWorkspaces !! 7)                   -- Switch to workspace 8
    , ("M-9", windows $ W.greedyView $ myWorkspaces !! 8)                   -- Switch to workspace 9
    ]
    ++
    [ ("M-S-1", windows $ W.shift $ myWorkspaces !! 0)                      -- Move focused window to workspace 1
    , ("M-S-2", windows $ W.shift $ myWorkspaces !! 1)                      -- Move focused window to workspace 2
    , ("M-S-3", windows $ W.shift $ myWorkspaces !! 2)                      -- Move focused window to workspace 3
    , ("M-S-4", windows $ W.shift $ myWorkspaces !! 3)                      -- Move focused window to workspace 4
    , ("M-S-5", windows $ W.shift $ myWorkspaces !! 4)                      -- Move focused window to workspace 5
    , ("M-S-6", windows $ W.shift $ myWorkspaces !! 5)                      -- Move focused window to workspace 6
    , ("M-S-7", windows $ W.shift $ myWorkspaces !! 6)                      -- Move focused window to workspace 7
    , ("M-S-8", windows $ W.shift $ myWorkspaces !! 7)                      -- Move focused window to workspace 8
    , ("M-S-9", windows $ W.shift $ myWorkspaces !! 8)                      -- Move focused window to workspace 9
    ]
    ++
    [ ("<XF86MonBrightnessDown>", spawn "__tirea_backlight.sh mon down")    -- Decrease monitor brightness
    , ("<XF86MonBrightnessUp>"  , spawn "__tirea_backlight.sh mon up")      -- Increase monitor brightness
    --
    , ("<XF86LaunchB>"          , spawn "dmenu_run -c")                     -- Launch dmenu
    , ("<XF86KbdBrightnessDown>", spawn "__tirea_backlight.sh kbd down")    -- Decrease keyboard brightness
    , ("<XF86KbdBrightnessUp>"  , spawn "__tirea_backlight.sh kbd up")      -- Increase keyboard brightness
    --
    --
    --
    , ("<XF86AudioMute>"        , spawn "__tirea_volume.sh mute")           -- Mute volume
    , ("<XF86AudioLowerVolume>" , spawn "__tirea_volume.sh down")           -- Decrease volume
    , ("<XF86AudioRaiseVolume>" , spawn "__tirea_volume.sh up")             -- Increase volume
    , ("<XF86PowerOff>"         , spawn "__tirea_powermenu.sh")             -- Open power menu
    , ("C-<Space>"              , spawn "__tirea_kblayout.sh")              -- Switch keyboard layout
    ]

---- Mouse bindings ----------------------------------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

---- Layouts -----------------------------------------------------------
myLayout = avoidStruts(myLayoutTallSpaced ||| myLayoutTall ||| myLayoutFull)
    where
        myLayoutFull = noBorders Full
        myLayoutTall = named "Tall" $ Tall 1 (3/100) (1/2)
        myLayoutTallSpaced = named "Tall Spaced"
            $ spacingRaw False spacing True spacing True
            $ myLayoutTall
        spacing = (Border mySpacing mySpacing mySpacing mySpacing)

---- Window rules ------------------------------------------------------
myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
    [ className =? "firefox" --> doShift ( myWorkspaces !! 1 )
    , className =? "discord" --> doShift ( myWorkspaces !! 2 )
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "xmessage" --> doFloat
    , className =? "Yad" --> doCenterFloat
    ]

---- Event handling ----------------------------------------------------
myEventHook = mempty

---- Status ------------------------------------------------------------
myLogHook = return ()

---- Startup -----------------------------------------------------------
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "xautolock -time 10 -locker slock &"
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 160 --transparent true --alpha 0 --tint 0x161616 --height 44 &"
    spawnOnce "nm-applet"

---- Run XMonad --------------------------------------------------------
main = do
    xmproc <- spawnPipe "xmobar -x 0 '/home/tirea/.config/xmobar/xmobar.hs'"
    xmonad $ docks def
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

        , keys               = myKeys
        , mouseBindings      = myMouseBindings

        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , startupHook        = myStartupHook
        , logHook            = myLogHook <+> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor "#33b1ff" ""
            , ppVisible = xmobarColor "#33b1ff" ""
            , ppHidden = xmobarColor "#08dbda" ""
            , ppHiddenNoWindows = xmobarColor "#595959" ""
            , ppTitle = xmobarColor "#dde1e6" "" . shorten 60
            , ppSep = "   "
            , ppUrgent = xmobarColor "#ee5396" ""
            , ppExtras = []
            , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
            }
        }
