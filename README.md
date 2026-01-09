# dotfiles
Personal dotfiles for home directory. Use `dotfiles-install` function in .bashrc / .zshrc to install.

# MacBook settings
- General -> Date & Time -> 24hr, using location
- General -> Language -> ISO date format
- Appearance -> Auto
- Desktop & Dock -> Size, double click to fill, show indicators, tiled margins off, drag to edges on, mission control separate spaces on, group by app on, hot corners
- Menu Bar -> Show/Dont, Clock, Autohide menu never
- Wallpaper -> Clock on lock screen
- Notifications -> Silence noisy ones
- Lock screen -> Require password 5sec
- Keyboard -> Repeat to max, delay shortest, CAPS as CTRL

Need to logout to trigger these:
- `defaults write -globalDomain NSStatusItemSpacing -int 8`
- `defaults write -globalDomain NSStatusItemSelectionPadding -int 8`
- `defaults write -globalDomain NSWindowShouldDragOnGesture -bool true`

Dock spacer
- `defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}' && killall Dock`
