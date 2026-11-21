-- move-watched.lua
-- Automatically moves completed/watched movies from ~/Videos/Movies to ~/Videos/Movies/watched
local utils = require 'mp.utils'
local msg = require 'mp.msg'
local opt = require 'mp.options'

local opts = {
    movies_dir = os.getenv("HOME") .. "/Videos/Movies",
    watched_dir = os.getenv("HOME") .. "/Videos/Movies/watched",
    threshold_percent = 90,
    min_duration = 300, -- 5 minutes (avoids moving test clips)
    notify = true,
}
opt.read_options(opts, "move_watched")

local is_eligible = false
local was_watched = false
local current_file_path = nil

local function normalize_path(path)
    if not path or path == "" then return nil end
    if path:sub(1, 1) == "~" then
        path = os.getenv("HOME") .. path:sub(2)
    end
    if not path:match("^/") then
        local cwd = mp.get_property("working-directory", "")
        path = utils.join_path(cwd, path)
    end
    path = path:gsub("/+", "/")
    return path
end

local function is_in_movies_dir(path)
    if not path then return false end
    local dir, _ = utils.split_path(path)
    dir = dir:gsub("/$", "")
    local target = opts.movies_dir:gsub("/$", "")
    -- Must be directly in Movies/ (not in subdirectories like watched/)
    return dir == target
end

local function on_start_file()
    is_eligible = false
    was_watched = false
    current_file_path = normalize_path(mp.get_property("path"))
    
    if is_in_movies_dir(current_file_path) then
        is_eligible = true
        msg.info("Tracking movie for watched auto-move: " .. current_file_path)
    end
end

local function check_progress()
    if not is_eligible or was_watched then return end
    
    local percent = mp.get_property_number("percent-pos", 0)
    local duration = mp.get_property_number("duration", 0)
    local eof = mp.get_property_bool("eof-reached", false)
    
    if duration >= opts.min_duration then
        if eof or percent >= opts.threshold_percent then
            was_watched = true
            msg.info(string.format("Movie marked as watched (%.1f%%, eof=%s): %s", percent, tostring(eof), current_file_path or ""))
        end
    end
end

local function move_file_and_subs(src_path)
    if not src_path then return end
    
    -- Ensure destination exists
    utils.subprocess({args = {"mkdir", "-p", opts.watched_dir}, cancellable = false})
    
    local dir, filename = utils.split_path(src_path)
    local dest_path = utils.join_path(opts.watched_dir, filename)
    
    -- Prevent overwriting if already exists
    if utils.file_info(dest_path) then
        msg.warn("Destination file already exists, skipping move: " .. dest_path)
        return false
    end
    
    msg.info("Moving watched movie: " .. src_path .. " -> " .. dest_path)
    local res = utils.subprocess({args = {"mv", src_path, dest_path}, cancellable = false})
    if res.status ~= 0 then
        msg.error("Failed to move movie: " .. (res.stderr or "unknown error"))
        return false
    end
    
    -- Move companion subtitles if present
    local basename = filename:match("(.+)%..+$") or filename
    local scan_res = utils.subprocess({
        args = {"find", dir, "-maxdepth", "1", "-type", "f", "-name", basename .. "*"},
        cancellable = false
    })
    
    if scan_res.status == 0 and scan_res.stdout then
        for line in scan_res.stdout:gmatch("[^\r\n]+") do
            if line ~= src_path and (
                line:match("%.[sS][rR][tT]$") or
                line:match("%.[vV][tT][tT]$") or
                line:match("%.[sS][uU][bB]$") or
                line:match("%.[aA][sS][sS]$")
            ) then
                local _, sub_name = utils.split_path(line)
                local sub_dest = utils.join_path(opts.watched_dir, sub_name)
                utils.subprocess({args = {"mv", line, sub_dest}, cancellable = false})
                msg.info("Moved companion subtitle: " .. line .. " -> " .. sub_dest)
            end
        end
    end
    
    -- Desktop notification
    if opts.notify then
        utils.subprocess({
            args = {
                "notify-send",
                "-a", "mpv",
                "-i", "multimedia-video-player",
                "Movie Watched",
                "Moved '" .. filename .. "' to watched/"
            },
            cancellable = false
        })
    end
    
    return true
end

local function on_end_file(event)
    if is_eligible and was_watched and current_file_path then
        move_file_and_subs(current_file_path)
    end
    is_eligible = false
    was_watched = false
    current_file_path = nil
end

mp.register_event("start-file", on_start_file)
mp.observe_property("percent-pos", "number", check_progress)
mp.observe_property("eof-reached", "bool", check_progress)
mp.register_event("end-file", on_end_file)
