-- Search/Grep within a specific folder using Telescope with a fuzzy folder picker
vim.keymap.set('n', '<leader>fs', function()
  local builtin = require 'telescope.builtin'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local Path = require 'plenary.path'

  local current_dir = vim.fn.expand '%:p:h' -- folder of current buffer

  -- Step 1: Fuzzy folder picker
  local handle = io.popen('fd --type d . "' .. current_dir .. '"')
  if not handle then
    return
  end

  local dirs = {}
  for line in handle:lines() do
    table.insert(dirs, Path:new(line):absolute())
  end
  handle:close()

  pickers
    .new({}, {
      prompt_title = 'Select folder to search',
      finder = finders.new_table {
        results = dirs,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local function on_select()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          -- Step 2: Launch live_grep scoped to selected folder
          builtin.live_grep {
            prompt_title = 'Searching in ' .. selection[1],
            search_dirs = { selection[1] },
          }
        end

        map('i', '<CR>', on_select)
        map('n', '<CR>', on_select)
        return true
      end,
    })
    :find()
end, { desc = '[F]older [S]earch - pick the folder to search first, then search for string in the folder' })
