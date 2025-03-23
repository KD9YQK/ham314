-- ~/.config/conky/conky.lua
ardop = {min_x = 20, min_y = 70, max_x= 110, max_y = 90, start = 'bash /home/kd9yqk/ham314/launchers/ardopmodem.sh &', kill = 'killall ardop', app = 'ardop'}
rigctld = {min_x = 160, min_y = 70, max_x= 250, max_y = 90, start = 'zenity --title "rigctld" --question &', kill = 'killall rigctld', app = 'rigctld'}

direwolf = {min_x = 20, min_y = 110, max_x= 110, max_y = 130, start = 'direwolf -t 0 -c /home/kd9yqk/direwolf.conf > /tmp/direwolf.log &', kill = 'bash /home/kd9yqk/ham314/launchers/ax25stop.sh', app = 'direwolf'}
kissattach = {min_x = 160, min_y = 110, max_x= 250, max_y = 130, start = 'bash /home/kd9yqk/ham314/launchers/ax25start.sh &', kill = 'bash /home/kd9yqk/ham314/launchers/ax25stop.sh', app = 'kissattach'}

varahf = {min_x = 20, min_y = 150, max_x= 110, max_y = 170, start = 'env WINEPREFIX="/home/kd9yqk/.wine" WINEDEBUG=-all wine "/home/kd9yqk/.wine/drive_c/VARA/VARA.exe" &', kill = 'killall VARA.exe', app = 'VARA.exe'}
varafm = {min_x = 160, min_y = 150, max_x= 250, max_y = 170, start = 'env WINEPREFIX="/home/kd9yqk/.wine" WINEDEBUG=-all wine "/home/kd9yqk/.wine/drive_c/VARAFM/VARAFM.exe" &', kill = 'killall VARAFM.exe', app = 'VARAFM.exe'}

flrig = {min_x = 20, min_y = 190, max_x= 110, max_y = 210, start = 'flrig &', kill = 'killall flrig', app = 'flrig'}
soundmodem = {min_x = 160, min_y = 190, max_x= 250, max_y = 210, start = 'cd /home/kd9yqk/apps/QtSoundModem/ && ./QtSoundModem &', kill = 'killall QtSoundModem', app = 'QtSoundModem'}

js8call = {min_x = 20, min_y = 260, max_x= 110, max_y = 280, start = 'js8call &', kill = 'killall js8call', app = 'js8call'}
wsjtx = {min_x = 160, min_y = 260, max_x= 250, max_y = 280, start = 'wsjtx &', kill = 'killall wsjtx', app = 'wsjtx'}

fldigi = {min_x = 20, min_y = 300, max_x= 110, max_y = 320, start = 'fldigi &', kill = 'killall fldigi', app = 'fldigi'}
pat = {min_x = 160, min_y = 300, max_x= 250, max_y = 320, start = 'pat http &', kill = 'killall pat', app = 'pat'}

pulse = {min_x = 20, min_y = 340, max_x= 110, max_y = 360, start = 'pavucontrol &', kill = 'killall pavucontrol', app = 'pavucontrol'}
xastir = {min_x = 160, min_y = 340, max_x= 250, max_y = 360, start = 'xastir &', kill = 'killall xastir', app = 'xastir'}

apps = {ardop, rigctld, direwolf, kissattach, varahf, varafm, flrig, soundmodem, js8call, wsjtx, fldigi, pat, pulse, xastir}

function conky_mouse_handler (event)
    if (event.type ~= "button_up") then
        return false
    end
    for _, app in ipairs(apps) do
        if (event.x >= app.min_x and event.x <= app.max_x and event.y >= app.min_y and event.y <= app.max_y) then
            local f = assert(io.popen('ps -ax | grep ' .. app.app .. ' | grep -v grep | grep -v conky', 'r'))
            local s = assert(f:read('*a'))
            f:close()
            if (s ~= "") then
                os.execute(app.kill)
            else
                os.execute(app.start)
            end
            return false
        end
    end
    os.execute('zenity --title "' .. event.x .. ' ' .. event.y .. '" --question &')
    return false
end
