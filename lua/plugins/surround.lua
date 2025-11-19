return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})

    ---------------------------------------------------------------------------
    -- Simple modal / cheatsheet for nvim-surround
    ---------------------------------------------------------------------------
    local function open_surround_cheatsheet()
      -- Create scratch buffer
      local buf = vim.api.nvim_create_buf(false, true)

      local lines = {
        "nvim-surround cheatsheet",
        "─────────────────────────",
        "",
        "Add surround:",
        "  ysiw)    -> (surround_word)",
        "  ys$\"    -> \"make strings\"",
        "",
        "Delete surround:",
        "  ds]     -> delete [around me!]",
        "  dst     -> remove <b>HTML tags</b>",
        "",
        "Change surround:",
        "  cs'\"    -> 'change quotes' -> \"change quotes\"",
        "  csth1   -> <b>or tag types</b> -> <h1>or tag types</h1>",
        "",
        "Misc:",
        "  dsf     -> delete(function calls)",
        "",
        "Press q or <Esc> to close",
      }

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Size & position
      local width  = 60
      local height = #lines
      local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
      }

      local win = vim.api.nvim_open_win(buf, true, opts)

      -- Keymaps to close the modal
      local close = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end

      vim.keymap.set("n", "q", close,   { buffer = buf, nowait = true, noremap = true, silent = true })
      vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true, noremap = true, silent = true })
    end

    -- <leader>ss opens the “modal”
    vim.keymap.set("n", "<leader>ss", open_surround_cheatsheet, {
      desc = "nvim-surround cheatsheet",
    })
  end,
}
