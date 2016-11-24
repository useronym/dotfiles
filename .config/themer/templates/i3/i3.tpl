set $mod Mod4

set $background {{ black }}
set $foreground {{ white }}
set $gray       {{ alt_black }}
set $primary    {{ primary }}
set $secondary  {{ secondary }}
set $tertiary   {{ tertiary }}
set $warning    {{ special }}

set $ws1  "1:  I  "
set $ws2  "2:  II  "
set $ws3  "3:  III  "
set $ws4  "4:  IV  "
set $ws5  "5:  V  "
set $ws6  "6:  VI  "
set $ws7  "7:  VII  "
set $ws8  "8:  VIII  "
set $ws9  "9:  IX  "
set $ws10 "10:  X  "

font pango:DejaVu Sans Mono 8

exec_always feh --bg-scale ~/.config/themer/current/wallpaper.png

floating_modifier $mod

for_window [class="^.*"] border pixel 3
gaps inner 5
gaps outer 5
smart_gaps on
smart_borders on

bindsym $mod+q kill

bindsym $mod+Return exec i3-sensible-terminal
bindsym F2 exec rofi -font 'Mononoki 16' -show combi

bindsym XF86AudioRaiseVolume exec amixer sset Master 5%+ unmute
bindsym XF86AudioLowerVolume exec amixer sset Master 5%- unmute
bindsym XF86AudioMute exec amixer sset Master toggle
bindsym $mod+F11 exec xbacklight -dec 4
bindsym $mod+F12 exec xbacklight -inc 4

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+b split h
bindsym $mod+v split v

bindsym $mod+f fullscreen

bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

bindsym $mod+space focus mode_toggle
bindsym $mod+Shift+space floating toggle

bindsym $mod+a focus parent
#bindsym $mod+d focus child

bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10
bindsym $mod+Tab workspace back_and_forth

workspace_auto_back_and_forth yes

bindsym $mod+Control+Shift+Left move window to workspace prev
bindsym $mod+m move window to workspace next

bindsym $mod+Control+Shift+Prior move container to output left
bindsym $mod+Control+Shift+Next move container to output right

bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10


# colors                BORDER      BACKGROUND TEXT        INDICATOR
client.focused          $primary    $primary   $background $primary
client.focused_inactive $background $primary   $foreground $background
client.unfocused        $background $gray      $background $secondary
client.urgent           $warning    $warning   $foreground $warning

bar {
    output HDMI2
    output DP1
    status_command    tail -f /dev/null
    position          bottom
    workspace_buttons yes
    mode hide
 
    colors {
        background $background
        statusline $primary
        
        # Colors go <border> <background> <text> <indicator>
        focused_workspace $secondary $background $foreground
        active_workspace $primary $background $foreground
        inactive_workspace $primary $background $foreground
        urgent_workspace $foreground $warning
    }
}

bar {
    output eDP1
    status_command    i3status
    position          top
    workspace_buttons yes
 
    colors {
        background $background
        statusline $primary
        
        # Colors go <border> <background> <text> <indicator>
        focused_workspace $secondary $background $foreground
        active_workspace $primary $background $foreground
        inactive_workspace $primary $background $foreground
        urgent_workspace $foreground $warning
    }
}

for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [instance="float"] floating enable

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

mode "resize" {
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym odiaeresis resize grow width 10 px or 10 ppt

        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

bindsym $mod+shift+minus move scratchpad
bindsym $mod+minus scratchpad show