-- ~/.config/conky/conky.lua

function conky_mouse_handler (event)
    if (event.type ~= "button_up") then
        return false
    end
    os.execute('zenity --question &')
    return false
end
