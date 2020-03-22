{-# OPTIONS -O2 #-}

import XMonad

import XMonad.Config.Desktop

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import XMonad.Layout.NoBorders (noBorders, smartBorders)

import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig
import XMonad.Util.Run

import Data.Char (isNumber)
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86

myModMask = mod4Mask

myWorkspaces = zipWith number (named ++ repeat "") [1..5]
  where named = ["main", "internet", "local", "extra"]
        number str = if null str then show else \ num -> show num ++ (':' : ' ' : str)

myKeys conf = M.fromList
    -- using i3-like shortcuts
    [ entry [myModMask] xK_Return (XMonad.terminal conf)
    , entry [myModMask] xK_d "exe=$(dmenu_path | dmenu) && eval \" exec $exe \""
    -- remap normal mod-return to mod-shift-return
    , ((myModMask .|. shiftMask, xK_Return), windows W.swapMaster)
    -- print screen = screenshot
    , entry [] xK_Print "scrot -e 'mkdir -p ~/pics && mv $f ~/pics/'"
    -- audio controls
    , entry [] xF86XK_AudioLowerVolume (volumeDelta $ negate 5)
    , entry [] xF86XK_AudioRaiseVolume (volumeDelta 5)
    , entry [] xF86XK_AudioMute "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    ]
    where
      volumeDelta num = "pactl set-sink-mute @DEFAULT_SINK@ false; pactl set-sink-volume @DEFAULT_SINK@ " ++ withSign num ++ "% & "
      withSign val = (if val > 0 then '+' else '-') : filter isNumber (show val)
      entry mods key action = (( foldl (.|.) 0 mods, key), spawn action)

myWorkspaceKeys = [ ((m .|. myModMask, k), windows $ f i)
                  | (i, k) <- zip myWorkspaces [xK_1 .. xK_5]
                  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
                  ]

main = do
  bar <- spawnPipe "$HOME/.config/polybar/launch.sh"
  xmonad $ desktopConfig
    { borderWidth = 1
    , terminal = "alacritty"
    , modMask = myModMask
    , focusedBorderColor = "#90ee90"
    , keys = \ c -> M.union (myKeys c) $ keys XMonad.def c
    , workspaces = myWorkspaces
    , logHook = ewmhDesktopsLogHook
    , handleEventHook = fullscreenEventHook <+> handleEventHook desktopConfig
    , layoutHook = desktopLayoutModifiers $ noBorders $ layoutHook desktopConfig
    , manageHook = manageDocks <+> manageHook desktopConfig
    } `additionalKeys` myWorkspaceKeys
