--[[
Copyright (C) 2024 Martin Köhler and co-authors (martin.koehler@jku.at)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

--[[
To use this Quarto LUA filter, the qmd yaml section should contain:
   ...
   format: html
   filters: [inline-file-filter.lua]

Then, e.g. use 
  {{file:data/my-inlined-file.json}} 
to inline the JSON file
--]]

local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    io.stderr:write("Warning: Could not open file: " .. path .. "\n")
    return ""
  end
  local content = f:read("*all")
  f:close()
  return content
end

-- inline text like {{file:path}}
function Str(el)
  local text = el.text
  local path = text:match("{{file:([^}]+)}}")
  if path then
    local content = read_file(path)
    content = content:gsub("\\", "\\\\"):gsub("`", "\\`")
    return pandoc.Str(content)
  end
  return el
end

-- raw HTML blocks (e.g. <script> inside `{=html}`)
function RawBlock(el)
  if el.format == "html" then
    local replaced = el.text:gsub("{{file:([^}]+)}}", function(path)
      local content = read_file(path)
      return content:gsub("\\", "\\\\"):gsub("`", "\\`")
    end)
    return pandoc.RawBlock("html", replaced)
  end
  return el
end
