# 打印菜单
call_menu() {
    echo ' set wallpaper'
    echo '艹update statusbar'
    echo ' open idea'
    echo ' open sql'
    echo ' open cachekit'
    echo ' open api'
    [ "$(ps aux | grep clash)" ] && echo ' close clash' || echo ' open clash'
    [ "$(ps aux | grep picom | grep -v 'grep\|rofi\|nvim')" ] && echo ' close picom' || echo ' open picom'
}

# 执行菜单
execute_menu() {
    case $1 in
        ' set wallpaper')
            feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
            ;;
        '艹update statusbar')
            coproc ($DWM/statusbar/statusbar.sh updateall > /dev/null 2>&1)
            ;;
        ' open v2raya')
            coproc (sudo docker restart v2raya > /dev/null && $DWM/statusbar/statusbar.sh updateall > /dev/null)
            ;;
        ' close v2raya')
            coproc (sudo docker stop v2raya > /dev/null && $DWM/statusbar/statusbar.sh updateall > /dev/null)
            ;;
        ' open idea')
            coproc (/opt/intellij-ultimate/bin/idea.sh > /dev/null 2>&1 &)
            ;;
        ' open sql')
            coproc (/opt/datagrip/bin/datagrip.sh > /dev/null 2>&1 &)
            ;;
        ' open cachekit')
            coproc (/opt/redis-assistant/RedisAssistant >/dev/null 2>&1 &)
            ;;
        ' open api')
            coproc (cd /opt/postcat-v0.5.1 && yarn start:electron >/dev/null 2>&1 &)
            ;;
    esac
}

execute_menu "$(call_menu | rofi -dmenu -p "")"
