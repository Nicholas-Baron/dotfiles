import XMonad

import XMonad.Config.Desktop

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import XMonad.Layout.NoBorders (smartBorders)

import XMonad.Util.Run

import Data.Char (isNumber)
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86

myModMask = mod4Mask

myWorkspaces = named ++ [ show s | s <- [1..9] , s > length named ]
  where named = map (\ (index, name) -> show index ++ (':' : ' ' : name)) 
              $ zip [1..] [ "main", "internet", "local", "extra" ]

myKeys conf = M.fromList
    -- using i3-like shortcuts
    [ entry [myModMask] xK_Return (XMonad.terminal conf)
    , entry [myModMask] xK_d "exe=$(dmenu_path | dmenu) && eval \" exec $exe \""
    -- print screen = screenshot
    , entry [] xK_Print "scrot"
    -- audio controls
    , entry [] xF86XK_AudioLowerVolume (volumeDelta $ negate 5)
    , entry [] xF86XK_AudioRaiseVolume (volumeDelta 5)
    , entry [] xF86XK_AudioMute "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    ]
    where
      volumeDelta num = "pactl set-sink-mute @DEFAULT_SINK@ false; pactl set-sink-volume @DEFAULT_SINK@ " ++ withSign num ++ "% & "
      withSign val = (if val > 0 then '+' else '-') : filter isNumber (show val)
      entry mods key action = (( foldl (.|.) 0 mods, key), spawn action)

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
    , layoutHook = desktopLayoutModifiers $ smartBorders $ layoutHook desktopConfig
    , manageHook = manageDocks <+> manageHook desktopConfig
    }
