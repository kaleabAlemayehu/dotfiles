local M = {}

local win_id = nil
local buf_id = nil
local current_file = nil

-- ✅ Create file if it does not exist
local function ensure_file(path)
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({}, path)
  end
end

-- ✅ Prompt only when buffer does not exist
local function prompt_for_file()
  local filepath = vim.fn.input("Floating file: ", "", "file")
  if filepath == "" then
    return nil
  end

  ensure_file(filepath)
  current_file = filepath

  -- ✅ Create a REAL file-backed buffer (not a scratch buffer)
  buf_id = vim.fn.bufadd(filepath)
  vim.fn.bufload(buf_id)

  -- ✅ prevent wipe on close
  vim.bo[buf_id].bufhidden = "hide"
  vim.bo[buf_id].swapfile = false
  vim.bo[buf_id].modifiable = true

  return buf_id
end

-- ✅ Open floating window using EXISTING buffer
local function open_window()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  win_id = vim.api.nvim_open_win(buf_id, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- ✅ Close window WITHOUT deleting buffer
  vim.keymap.set("n", "<Esc>", function()
    if win_id and vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_win_close(win_id, false)
      win_id = nil
    end
  end, { buffer = buf_id, silent = true })
end

-- ✅ TOGGLE (buffer ALWAYS persists)
function M.toggle()
  -- Close floating window if open
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(win_id, false)
    win_id = nil
    return
  end

  -- If buffer is gone, re-create
  if not buf_id or not vim.api.nvim_buf_is_valid(buf_id) then
    local ok = prompt_for_file()
    if not ok then
      return
    end
  end

  open_window()
end

-- ✅ CLEAR BUFFER + PROMPT AGAIN (manual reset)
function M.clear_and_prompt()
  if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
    vim.api.nvim_buf_delete(buf_id, { force = true })
  end

  buf_id = nil
  current_file = nil
  win_id = nil

  local ok = prompt_for_file()
  if ok then
    open_window()
  end
end

-- ✅ Optional helper
function M.current_file()
  return current_file
end

return M
