-- Needed for linemode in yazi.toml to show size and modified time next to file list
function Linemode:size_and_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    time = os.date("%b %d %H:%M", time)
  else
    time = os.date("%b %d  %Y", time)
  end

  local size = self._file:size()
  return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- Show user/group of files in status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if h == nil or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line({
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    " ",
  })
end, 500, Status.RIGHT)

-- https://github.com/h-hg/yamb.yazi
-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
  table.insert(bookmarks, {
    tag = "Scoop Local",

    path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
    key = "p",
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
    key = "P",
  })
end

table.insert(bookmarks, {
  tag = "Home",
  path = home_path .. path_sep,
  key = "h",
})

table.insert(bookmarks, {
  tag = "projects",
  path = home_path .. path_sep .. "projects" .. path_sep,
  key = "p",
})

table.insert(bookmarks, {
  tag = "Screenshots",
  path = home_path .. path_sep .. "Screenshots" .. path_sep,
  key = "s",
})

table.insert(bookmarks, {
  tag = "temp",
  path = home_path .. path_sep .. "temp" .. path_sep,
  key = "t",
})

table.insert(bookmarks, {
  tag = "Downloads",
  path = home_path .. path_sep .. "Downloads" .. path_sep,
  key = "d",
})

table.insert(bookmarks, {
  tag = "notes",
  path = home_path .. path_sep .. "notes" .. path_sep,
  key = "n",
})

table.insert(bookmarks, {
  tag = "Backup",
  path = home_path .. path_sep .. "Backup" .. path_sep,
  key = "b",
})

require("yamb"):setup({
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
      or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})
