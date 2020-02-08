import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

-- Actions
-- import XMonad.Actions.Minimize (minimizeWindow)

import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), shiftNextScreen, shiftPrevScreen) 
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize as Sqr

-- Layouts modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing) 
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
    
-- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))

-- Prompts
import XMonad.Prompt (defaultXPConfig, XPConfig(..), XPPosition(Top), Direction1D(..))



-- CONFIG
modKey       = mod4Mask
myTerminal   = "gnome-terminal"
myTextEditor = "vim"
-- windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

main = do
    -- Launching xmobars
    xmproc0 <- spawnPipe "xmobar -x 0 /home/alex/.config/xmobar/xmobarrc0"
    -- xmproc1 <- spawnPipe "xmobar -x 1 /home/alex/.config/xmobar/xmobarrc1"

    xmonad $ ewmh desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        , terminal              = myTerminal
        , modMask               = modKey
        , borderWidth           = 2
        , normalBorderColor     = "#93A1A1"
        , focusedBorderColor    = "#859900"
        , workspaces            = myWorkspaces
        , startupHook           = myStartupHook
        , layoutHook            = myLayoutHook 
        , logHook               = dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x -- >> hPutStrLn xmproc1 x --  >> hPutStrLn xmproc2 x
                        , ppCurrent = xmobarColor "#F9EE98" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#7587A6" "" . wrap "" "*"   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#5F5A60" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 80     -- Title of active window in xmobar
                        , ppSep =  "<fc=#9AEDFE> : </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#CF6A4C" "" . wrap "!" "!"  -- Urgent workspace
--                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }

        } `additionalKeysP`     myKeys 


xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ ["1","2","3","4","5","6","7","8","9"]
    where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                         (i,ws) <- zip [1..9] l,
                         let n = i ]

--myWorkspaces =  map show [1..9]

------------------------------------------------------------------------
---- Window rules
---- Execute arbitrary actions and WindowSet manipulations when managing
---- a new window. You can use this to, for example, always float a
---- particular program, or have a client always appear on a particular
---- workspace.
----
---- To find the property name associated with a program, use
---- > xprop | grep WM_CLASS
---- and click on the client you're interested in.
----
---- To match on the WM_NAME, you can use 'title' in the same way that
---- 'className' and 'resource' are used below.
----
myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [
        className =? "Firefox"     --> doShift "<action=xdotool key super+1>1</action>"
      , className =? "Chromium"    --> doShift "<action=xdotool key super+1>1</action>"
      , className =? "cmus"        --> doShift "<action=xdotool key super+8>8</action>"
      , className =? "vlc"         --> doShift "<action=xdotool key super+8>8</action>"
      , className =? "Virtualbox"  --> doFloat
      , className =? "Gimp"        --> doFloat
      , className =? "Gimp"        --> doShift "<action=xdotool key super+7>7</action>"
      , className =? "telegram"    --> doShift "<action=xdotool key super+9>9</action>"
      , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ] <+> namedScratchpadManageHook myScratchPads


------------------------------------------------------------------------
---- Layouts
---- You can specify and transform your layouts by modifying these values.
---- If you change layout bindings be sure to use 'mod-shift-space' after
---- restarting (with 'mod-q') to reset your layout state to the new
---- defaults, as xmonad preserves your old layout settings by default.
----
---- The available layouts. Note that each layout is separated by |||,
---- which denotes layout choice.
----
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where 
                 myDefaultLayout = tall ||| 
                                   grid ||| 
                                   threeCol ||| 
                                   threeRow ||| 
                                   oneBig ||| 
                                   noBorders monocle ||| 
                                   space ||| 
                                   floats


tall       = renamed [Replace "tall"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) []
grid       = renamed [Replace "grid"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) $ Grid (16/10)
threeCol   = renamed [Replace "threeCol"] $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2) 
threeRow   = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig     = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ 
             mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
monocle    = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
space      = renamed [Replace "space"]    $ limitWindows 4  $ spacing 12 $ Mirror $ mkToggle (single MIRROR) $ 
             mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat

------------------------------------------------------------------------
-----SCRATCHPADS
--------------------------------------------------------------------------

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "cmus" spawnCmus findCmus manageCmus  
                ]

    where
    spawnTerm  = myTerminal ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCmus  = myTerminal ++  " -n cmus 'cmus'"
    findCmus   = resource =? "cmus"
    manageCmus = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w



myStartupHook = do
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 200 --transparent true --alpha 100 --tint 0x000000 --height 20 --monitor 0 &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "compton --config /home/alex/.config/compton/compton.conf &"
    spawnOnce "conky &"
    spawnOnce "telegram &"
    spawnOnce "dropbox start &"
    spawnOnce "nextcloud &"
    spawnOnce "chromium &"
    setWMName "LG3D"

myKeys = --- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                  -- Quits xmonad

        --- Scratchpads
        , ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
        , ("M-C-c", namedScratchpadAction myScratchPads "cmus")

        --- DMenu
        , ("M-d", spawn "dmenu_run -p 'run:'")

        --- Open Terminal
        , ("M-<Return>", spawn myTerminal)

        --- Volume controls
        , ("<XF86AudioMute>" , spawn "amixer -q sset Master toggle") --Toggle Volume
        , ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%- unmute") -- lower volume
        , ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+ unmute") -- raise volume

        --- Screenshot
        , ("<Print>", spawn "scrot ~/Pictures/scrot_`date '+%Y%m%d-%H%M%S'`.png") -- screenshot of focused window
        , ("M-<Print>", spawn "scrot -u ~/Pictures/scrot_`date '+%Y%m%d-%H%M%S'`.png") -- screenshot of focused window
        ]

-- vim: ft=haskell:foldmethod=marker:expandtab:ts=4:shiftwidth=4
