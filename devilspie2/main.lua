debug_print("Window name: " .. get_window_name())
debug_print("Window class: " .. get_window_class())

local full_screen_apps = {
    "kitty",
    "Spotify",
    "Google-chrome",
    "DBeaver",
    "gnome-control-center",
}

local window_class = get_window_class()
local window_name = get_window_name()

-- Check if the application class matches any in the full_screen_apps list
for _, app in ipairs(full_screen_apps) do
    if window_class == app and window_name ~= 'Google Chrome' then
        maximize()
        return
    end
end
