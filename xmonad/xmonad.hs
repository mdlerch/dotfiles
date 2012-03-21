import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import Graphics.X11.Xlib
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Loggers
import System.IO
import System.Exit
--import IO (Handle, hPutStrLn)
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.Magnifier
import XMonad.Layout.LayoutHints
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.CycleWS


main = do
  xmbar1 <- spawnPipe xmobar1
  xmonad $ defaultConfig 
    {  focusFollowsMouse = True
    ,  terminal = terminal'
    ,  borderWidth = 3
    ,  focusedBorderColor = "#3299cd"
    ,  normalBorderColor = "#060000"
    ,  keys = keys'
    ,  manageHook = manageHook'
    ,  layoutHook = layoutHook'
    ,  workspaces = workspaces'
    ,  logHook = logHook' xmbar1
    }

terminal' :: String
terminal' = "urxvtc"
--terminal' = "roxterm"

xmobar1 = "xmobar"

logHook' h = dynamicLogWithPP $ xmobarPP { 
     ppOutput = hPutStrLn h
  ,  ppCurrent = xmobarColor "white" "#111111" . wrap "[" "]"
  ,  ppHidden = xmobarColor "#ADD8E6" "#020202"
  ,  ppHiddenNoWindows = xmobarColor "gray" "#020202"
  ,  ppUrgent = xmobarColor "red" "yellow" . xmobarStrip
  , ppLayout = (
               \x -> case x of
                "Magnifier (off) Hinted Spacing 6 Tall" -> " tile "
                "Magnifier Hinted Spacing 6 Tall" -> " tile "
                "Magnifier (off) Hinted Spacing 6 Mirror Tall" -> " horizontal "
                "Magnifier Hinted Spacing 6 Mirror Tall" -> " horizontal "
                "Magnifier (off) Hinted Spacing 6 Grid" -> " grid "
                "Magnifier Hinted Spacing 6 Grid" -> " grid "
                "Magnifier (off) Hinted Spacing 6 Full" -> " full "
                "Magnifier Hinted Spacing 6 Full" -> " full "
                "Magnifier (off) Hinted Spacing 6 Simple Float" -> " float "
                "Magnifier Hinted Spacing 6 Simple Float" -> " float "
                )

  }

layoutHook' = avoidStruts $ smartBorders  $ magnifierOff $ layoutHints $ spacing 6 $
 onWorkspace "1:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "2:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "3:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "4:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "5:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "6:t" (tile ||| Mirror tile ||| Grid) $
 onWorkspace "7:f" (Full ||| simpleFloat) $
 onWorkspace "8:f" (Full ||| simpleFloat) $
 (tile ||| Grid ||| Full)
    where 
      tile = Tall nmaster delta ratio
      t2 = Tall n2 delta ratio
      nmaster = 1
      n2 = 2
      delta = 3/100
      ratio = 1/2

workspaces' = ["1:t","2:t","3:t","4:t","5:t","6:t","7:f","8:f","9:d"]
	
manageHook' :: ManageHook
manageHook' =  composeAll
  [ className =? "XTerm" --> doFloat
  , className =? "MPlayer" --> doFloat  
  , title =? "gnome-terminal_small" --> doFloat 
  ]
  <+>
  composeOne
  [ transience
  , isFullscreen -?> doFullFloat
  ]
  <+>
  manageDocks
  -- <+>
  -- doF W.swapDown

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
     -- Launchers/Prompts
     ((mod1Mask .|. controlMask, xK_t), spawn "urxvtc")
--     ((mod1Mask .|. controlMask, xK_t), spawn "gnome-terminal --hide-menubar")
--  ,  ((mod1Mask .|. controlMask, xK_a), spawn "gnome-terminal --hide-menubar --title=gnome-terminal_small --geometry=90x8+980+750")
  ,  ((mod1Mask .|. controlMask, xK_f), spawn "chromium > /dev/null")
  ,  ((mod1Mask .|. controlMask, xK_c), spawn "xcalc > /dev/null")
  ,  ((mod1Mask, xK_F2), spawn "gmrun")
  ,  ((mod1Mask .|. controlMask, xK_r), shellPrompt defaultXPConfig)
     -- MPD/Audio
  ,  ((controlMask .|. mod4Mask, xK_p), spawn "mpc toggle > /dev/null")
  ,  ((controlMask .|. mod4Mask, xK_n), spawn "mpc next > /dev/null")
  ,  ((controlMask .|. mod4Mask, xK_b), spawn "mpcback-prev > /dev/null")
  ,  ((0,xK_F11), spawn "mpc toggle > /dev/null")
  ,  ((0, xK_F12), spawn "mpc next > /dev/null")
  ,  ((0, xK_F10), spawn "mpcback-prev > /dev/null")
  ,  ((controlMask .|. mod4Mask, xK_k), spawn "amixer set Master 2dB- > /dev/null")
  ,  ((controlMask .|. mod4Mask, xK_l), spawn "amixer set Master 2dB+ > /dev/null")
  ,  ((controlMask .|. mod4Mask, xK_m), spawn "amixer set Master toggle > /dev/null")
  ,  ((0, 0x1008ff13), spawn "amixer set Master 2dB+ > /dev/null")
  ,  ((0, 0x1008ff11), spawn "amixer set Master 2dB- > /dev/null")
  ,  ((0, 0x1008ff12), spawn "amixer set Master toggle > /dev/null")
     -- Client 
  ,  ((mod1Mask, xK_Tab), windows W.focusDown)
  ,  ((mod1Mask .|. shiftMask, xK_Tab), windows W.focusUp)
  ,  ((mod1Mask .|. mod4Mask, xK_Return), windows W.swapMaster)
  ,  ((mod1Mask .|. mod4Mask, xK_l), sendMessage Expand)
  ,  ((mod1Mask .|. mod4Mask, xK_h), sendMessage Shrink)
  ,  ((mod1Mask .|. mod4Mask, xK_t), withFocused $ windows . W.sink)
  ,  ((mod1Mask .|. mod4Mask, xK_j), windows W.swapDown)
  ,  ((mod1Mask .|. mod4Mask, xK_k), windows W.swapUp)
  ,  ((mod1Mask .|. mod4Mask, xK_c), kill)
     -- XMONAD
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_space ), sendMessage NextLayout)
  ,  ((controlMask .|. mod1Mask, xK_Right), nextWS)
  ,  ((controlMask .|. mod1Mask, xK_Left), prevWS)
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_r), restart "xmonad" True)
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_q), io (exitWith ExitSuccess))
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_n), sendMessage Toggle )
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_m), spawn "dualmon")
  ,  ((mod1Mask .|. mod4Mask .|. controlMask, xK_s), spawn "singlemon")
  ]
    ++
    [((m .|. controlMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. controlMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_p, xK_o] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
