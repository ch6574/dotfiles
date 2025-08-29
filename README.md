# dotfiles
Personal dotfiles for home directory. Use `dotfiles-install` function in .bashrc / .zshrc to install.

# MacBook settings
- General -> Date & Time -> 24hr, using location
- General -> Language -> ISO date format
- Appearance -> Auto
- Control Center -> Show/Dont, Clock show seconds, Autohide menu never
- Desktop & Dock -> Size, double click to fill, show indicators, tiled margins off, drag to edges on, mission control separate spaces on, group by app on, hot corners
- Wallpaper
- Notifications -> silence the noisy ones
- Lock screen -> 24hr clock, require password 5sec
- Keyboard -> repeat to max, delay shortest, caps as ctrl

Need to logout to trigger these:
- `default write -globalDomain NSStatusItemSpacing -int 8`
- `default write -globalDomain NSWindowShouldDragOnGesture -bool true`

Dock spacer
- `defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}' && killall Dock`
