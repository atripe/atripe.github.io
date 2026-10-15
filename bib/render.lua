-- Render each content/**/references.bib through citeproc: pandoc lua bib/render.lua
--
-- Writes references.json beside it: for every entry, the full note and the
-- short note a later citation gets, each also with a {loc} slot for the page.
-- Only the .bib goes in, so editing an article never needs a rerun; the cite
-- shortcode picks the form and fills in the page itself.

local path = pandoc.path
local root = path.directory(path.directory(arg[0]))
local csl = path.join { root, "bib", "chicago-notes-bibliography.csl" }

-- a page number no real citation uses, swapped for {loc} after rendering
local SLOT = "98765"

local function bib_files(dir, out)
  for _, name in ipairs(pandoc.system.list_directory(dir)) do
    local p = path.join { dir, name }
    if not pcall(bib_files, p, out) and name == "references.bib" then
      table.insert(out, p)
    end
  end
  return out
end

local function cite(key, loc)
  return loc and ("x[@%s, %s]"):format(key, loc) or ("x[@%s]"):format(key)
end

-- each key cited twice, so citeproc gives the first a full note and the
-- second a short one; the other run swaps which of the two carries a page.
local function notes(bib, keys, first_loc, then_loc)
  local md = {}
  for _, k in ipairs(keys) do table.insert(md, cite(k, first_loc)) end
  for _, k in ipairs(keys) do table.insert(md, cite(k, then_loc)) end
  local doc = pandoc.read(table.concat(md, " "), "markdown")
  doc.meta.bibliography = bib
  doc.meta.csl = csl
  doc.meta["suppress-bibliography"] = true
  doc = pandoc.utils.citeproc(doc)
  local out = {}
  doc:walk { Note = function(n)
    local html = pandoc.write(pandoc.Pandoc(n.content), "html", { wrap_text = "none" })
    table.insert(out, (html:gsub("^<p>(.*)</p>$", "%1")))
  end }
  assert(#out == 2 * #keys)
  return out
end

local function slot(html, key)
  local filled, n = html:gsub(SLOT, "{loc}")
  if n ~= 1 then io.stderr:write(("%s: no place for a page in its note\n"):format(key)) end
  return filled
end

for _, bib in ipairs(bib_files(path.join { root, "content" }, {})) do
  local f = assert(io.open(bib))
  local refs = pandoc.read(f:read "a", "biblatex").meta.references or {}
  f:close()
  local keys = {}
  for _, r in ipairs(refs) do table.insert(keys, pandoc.utils.stringify(r.id)) end

  local a = notes(bib, keys, nil, SLOT)
  local b = notes(bib, keys, SLOT, nil)
  local result = {}
  for i, k in ipairs(keys) do
    result[k] = {
      full = a[i], short_loc = slot(a[#keys + i], k),
      full_loc = slot(b[i], k), short = b[#keys + i],
    }
  end
  local out = assert(io.open(path.join { path.directory(bib), "references.json" }, "w"))
  out:write(pandoc.json.encode(result), "\n")
  out:close()
end
