-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- File manipulation hotkeys
-- vim.keymap.set('n', '<leader>o', vim.cmd.Ex, { desc = 'Switch to file expl[O]rer' })
vim.keymap.set('n', '<leader>i', vim.cmd.write, { desc = 'Save current f[I]le' })
-- vim.keymap.set('n', '<C-b>', vim.cmd('MiniFiles.open()'))
vim.keymap.set('n', '<leader>o', function()
  local files = require 'mini.files'
  if vim.bo.filetype == 'minifiles' then
    files.close()
  else
    local current_file = vim.api.nvim_buf_get_name(0)
    local is_file = not vim.bo.buftype or vim.bo.buftype == ''
    files.open(vim.loop.cwd(), true)
    -- reveal current buffer in file tree
    if is_file then
      vim.schedule(function()
        local line = 1
        local entry = files.get_fs_entry(0, line)
        while entry do
          if not entry then
            return
          end
          -- if path matches exactly, we found the file, just set cursor to the right line
          if current_file == entry.path then
            vim.api.nvim_win_set_cursor(0, { line, 1 })
            return
            -- if buffer file name has the entry path as a prefix, open the directory
          elseif
            current_file:find(
              -- add trailing slash on directory path to avoid matching substrings
              -- like `directory` matching `directory_other`;
              -- we make it so `directory/` doesn't match `directory_other/`
              string.format('%s/', entry.path),
              1,
              true
            ) == 1
          then
            vim.api.nvim_win_set_cursor(0, { line, 1 })
            require('mini.files').go_in()
            line = 1
          else
            line = line + 1
          end
          entry = files.get_fs_entry(0, line)
        end
      end)
    end
  end
end, { desc = '[O]pen file explorer' })

-- Jumping to context
vim.keymap.set('n', '<leader>j', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true, desc = '[J]ump to upper context' })

-- Create new tab hotkey
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<cr>')
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Vertical navigation hotkeys
vim.keymap.set('n', '<M-left>', '5<left>')
vim.keymap.set('n', '<M-right>', '5<right>')
vim.keymap.set('n', '<M-down>', '5<down>')
vim.keymap.set('n', '<M-up>', '5<up>')
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
