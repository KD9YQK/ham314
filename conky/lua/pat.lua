function echo (what)
    os.execute("echo -n '" .. what .. "'")
end

local function print_mods (mods)
    echo("mods:\n")
    for k,v in pairs(mods) do
        if (v) then
            echo("\t- " .. k .. "\n")
        end
    end
end

function conky_mouse_handler (event)
    if (event.type ~= "button_up") then
       return false
    end
--    echo("x: " .. tostring(event.x) .. ", ")
--    echo("y: " .. tostring(event.y) .. ", ")
--    echo("x_abs: " .. tostring(event.x_abs) .. ", ")
--    echo("y_abs: " .. tostring(event.y_abs) .. ",\n")

--  Lil grey circle clicked
    if (event.x >= 480 and event.x <= 600) then
        if (event.y >= 0 and event.y <= 25) then
            os.execute('bash ~/ham314/launchers/settings_loc.sh')
        end
    end
--  Title Clicked
    if (event.x >= 210 and event.x <= 300) then
        if (event.y >= 20 and event.y <= 40) then
            os.execute('bash ~/ham314/launchers/settings_loc.sh')
        end
    end
    return false

end

local function get_line_count(str)
    local lines = 1
    for i = 1, #str do
        local c = str:sub(i, i)
        if c == '\n' then lines = lines + 1 end
    end

    return lines
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function conky_log_parse(log, maxlen)
    local t = os.capture('tail -n '.. maxlen .. ' ' .. log, true)
    local c = 0
    for line in t:gmatch("([^\n]*)\n?") do c = c + 1 end
    for _ = c+1, maxlen do t = t .. '\n' end
    return t
end
