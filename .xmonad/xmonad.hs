import XMonad

myTerminal = "alacritty"

main = xmonad $ def
    {
    terminal = myTerminal
    , modMask = mod4Mask
    }
