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
    if (event.type ~= "mouse_move") then
        echo("type: " .. event.type .. ",\n")
    end
    
    if (event.type == "button_down") then
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. ",\n")
        print_mods(event.mods)
        echo("button: " .. tostring(event.button) .. "\n")
    elseif (event.type == "button_up") then
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. "\n")
        print_mods(event.mods)
        echo("button: " .. tostring(event.button) .. "\n")
    elseif (event.type == "mouse_scroll") then
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. ",\n")
        print_mods(event.mods)
        echo("direction: " .. tostring(event.direction) .. "\n")
    elseif (event.type == "mouse_move") then
        -- This will spam out everything else
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. ",\n")
        print_mods(event.mods)
    elseif (event.type == "mouse_enter") then
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. "\n")
    elseif (event.type == "mouse_leave") then
        echo("x: " .. tostring(event.x) .. ", ")
        echo("y: " .. tostring(event.y) .. ", ")
        echo("x_abs: " .. tostring(event.x_abs) .. ", ")
        echo("y_abs: " .. tostring(event.y_abs) .. ",\n")
        echo("time: " .. tostring(event.time) .. "\n")
    elseif (event.type == "err") then
        echo("This currently can't happen.")
    end
    return false
end
